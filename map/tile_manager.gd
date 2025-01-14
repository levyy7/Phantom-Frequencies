class_name TileManager
extends Node2D

var grassTiles: Array[GrassTile] = []
var pathTiles: Array[PathTile] = []

var nextEnemy = null

var soundOn = true

signal turn_finished

enum State {
	Paused, # Waiting for user to end the current turn and advance to next turn
	Advancing, # Enemies advancing
	Shooting, # Bullets shooting at the current enemy
}


var state: State = State.Paused

func _ready() -> void:
	initialize_tiles()


func _process(_delta: float):
	pass


func initialize_tiles():
	# Loop through children to populate tiles
	for child in get_children():
		if child.name.begins_with("GrassTile"):
			grassTiles.append(child)
		elif child.name.begins_with("PathTile"):
			pathTiles.append(child)
	print("initializing tiles")
			

func ini_turn(nEnemy = null):
	nextEnemy = nEnemy


func end_turn():
	if state == State.Paused:
		state = State.Shooting
		towers_set_shoot()
	else:
		print("Cannot end turn while in state: ", state)


func towers_set_shoot():
	assert(state == State.Shooting)
	
	# We use a timer to delay the time between each shot, so that
	# the music played doesn`t overlap, creating a melody.
	var shotTimer = Timer.new()
	var glowTimer = Timer.new()

	glowTimer.one_shot = true

	add_child(glowTimer)
	add_child(shotTimer)
	
	shotTimer.start(0.6)
	
	for i in range(grassTiles.size()):
		glowTimer.start(0.5)
		var currentGT: GrassTile = grassTiles[i]
		var currentPT = pathTiles[i]
		
		# If there are no active towers in group, no waiting
		if not currentGT.tower_slot_group.any_tower_active():
			continue
		currentGT.tower_slot_group.shoot_bullets(currentPT, soundOn, glowTimer)
		if currentGT.pathwayPreferenceFulfilled():
			currentGT.tower_slot_group.affectEnemies(currentPT)

		# Wait for the timer's timeout signal (2 seconds)
		await (shotTimer.timeout)
	
	# After the loop finishes, you can safely remove the timer if needed
	shotTimer.queue_free()
	
	state = State.Advancing
	
	enemies_set_advance()
	

func _enemy_done_moving():
	turn_finished.emit()
	

func enemies_set_advance():
	assert(state == State.Advancing)
	var prevEnemy: Enemy = nextEnemy
	for pt in pathTiles:
		var currentEnemy = pt.get_enemy()
		
		if prevEnemy:
			var prevGlobalPos = prevEnemy.global_position
			
			if prevEnemy.get_parent():
				prevEnemy.get_parent().remove_child(prevEnemy)
			pt.add_child(prevEnemy)
			prevEnemy.global_position = prevGlobalPos
			
			prevEnemy.set_advance_to(pt)
			prevEnemy.is_done_moving.connect(_enemy_done_moving, CONNECT_ONE_SHOT)
		prevEnemy = currentEnemy
	
	if prevEnemy != null:
		enemy_reached(prevEnemy)
	
	turn_finished.emit()
	state = State.Paused

func fill_with_enemies(enemyList):
	for i in range(min(pathTiles.size(), enemyList.size())):
		pathTiles[i].add_enemy(enemyList[i])

func setPathwayPreferences(preferences: Dictionary):
	for i in preferences.keys():
		grassTiles[i].setPref(preferences[i])

func enemyCount():
	var count = 0
	for tile in pathTiles:
		if tile.get_enemy():
			count += 1
	return count
func enemy_reached(enemy):
	print("Enemy has reached base")
	Global.lives -= 1
	enemy.queue_free()
