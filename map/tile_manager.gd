extends Node2D

var grassTiles = []
var pathTiles: Array[PathTile] = []

var nextEnemy = null

var soundOn = true

enum State {
	Paused, # Waiting for user to end the current turn and advance to next turn
	Advancing, # Enemies advancing
	Shooting, # Bullets shooting at the current enemy
}


var state: State = State.Paused

func _ready() -> void:
	initialize_tiles()


func _process(delta: float):
	if state == State.Shooting:
		# Check if all the bullets are done
		if get_tree().get_nodes_in_group("bullets").size() == 0:
			state = State.Paused



func initialize_tiles():
	# Loop through children to populate tiles
	for child in get_children():
		if child.name.begins_with("GrassTile"):
			grassTiles.append(child)
		elif child.name.begins_with("PathTile"):
			pathTiles.append(child)
			

func ini_turn(nEnemy = null):
	nextEnemy = nEnemy


func end_turn():
	if state == State.Paused:
		state = State.Advancing
		enemies_set_advance()
	else:
		print("Cannot end turn while in state: ", state)


func towers_set_shoot():
	assert(state == State.Shooting)
	
	var timer = Timer.new()
	add_child(timer)
	
	timer.start(1.0)
	
	for i in range(grassTiles.size()):
		var currentGT: GrassTile = grassTiles[i]
		var currentPT = pathTiles[i]
		
		currentGT.tower_slot_group.shoot_bullets(currentPT, soundOn)
		
		# Wait for the timer's timeout signal (2 seconds)
		await(timer.timeout)
	
	# After the loop finishes, you can safely remove the timer if needed
	timer.queue_free()
	

func _enemy_done_moving():
	if state == State.Advancing:
		state = State.Shooting
		towers_set_shoot()
	

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

func fill_with_enemies(enemyList):
	for i in range(min(pathTiles.size(), enemyList.size())):
		pathTiles[i].add_enemy(enemyList[i])

func enemy_reached(enemy):
	print("Enemy has reached base")
	enemy.queue_free()
