class_name MainScene
extends Node2D

var enemy = preload("res://enemy/Enemy.tscn")

var is_paused: bool = true

func play_one_round():
	# reset the enemy's bullet
	print("Playing one round")
	$Map/TileManager.end_turn()
	$Map/TileManager.ini_turn(enemy.instantiate())
	

func _ready() -> void:
	var enemyList = [enemy.instantiate(), enemy.instantiate(), null, null]
	$Map/TileManager.fill_with_enemies(enemyList)
	$Map/TileManager.ini_turn(enemy.instantiate())



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_next_round_button_toggled(toggled_on: bool) -> void:
	#play_one_round()


func _on_next_round_button_pressed() -> void:
	play_one_round()
