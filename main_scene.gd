class_name MainScene
extends Node2D

var is_paused: bool = true

func play_one_round():
	# reset the enemy's bullet
	print("Playing one round")
	$Map/TileManager.end_turn()

	var newEnemy = Enemy.create_enemy(HighFrequencyEnemy.new())

	$Map/TileManager.ini_turn(newEnemy)
	

func _ready() -> void:
	# TODO: make better default enemies
	var enemy1 = Enemy.create_enemy(HighFrequencyEnemy.new())
	var enemy2 = Enemy.create_enemy(HighFrequencyEnemy.new())

	var newEnemy = Enemy.create_enemy(HighFrequencyEnemy.new())
	var enemyList = [enemy1, enemy2, null, null]
	$Map/TileManager.fill_with_enemies(enemyList)
	$Map/TileManager.ini_turn(newEnemy)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_next_round_button_toggled(toggled_on: bool) -> void:
	#play_one_round()


func _on_next_round_button_pressed() -> void:
	play_one_round()
