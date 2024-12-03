extends Node2D

var grassTiles = []
var pathTiles  = []

var nextEnemy = null

func _ready() -> void:
	initialize_tiles()


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
	towers_shoot()
	enemies_advance()

func towers_shoot():
	for i in range(grassTiles.size()):
		var currentGT = grassTiles[i]
		var currentPT = pathTiles[i]
		
		var totalDamage = currentGT.compute_damage()
		currentPT.enemies_take_damage(totalDamage)
	

func enemies_advance():
	var prevEnemy = nextEnemy
	for pt in pathTiles:
		var currentEnemy = pt.get_enemy()
		pt.remove_enemies()
		pt.add_enemy(prevEnemy)
		
		prevEnemy = currentEnemy
	
	if prevEnemy != null:
		enemy_reached(prevEnemy)

func fill_with_enemies(enemyList):
	for i in range(min(pathTiles.size(), enemyList.size())):
		pathTiles[i].add_enemy(enemyList[i])

func enemy_reached(enemy):
	print("Enemy has reached base")
	enemy.queue_free()
