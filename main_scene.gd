class_name MainScene
extends Node2D

var is_paused: bool = true


var level0 = {
	"name": "level0",
	"description": "introduces pitches",
	"tiles":8,
	"startingGhosts":[LowFrequencyEnemy,LowFrequencyEnemy],
	"startingTowers":[],
	"upcomingGhosts":[LowFrequencyEnemy,HighFrequencyEnemy,HighFrequencyEnemy,HighFrequencyEnemy],
	}
var levels = [level0]
func init_level(level):
	var damage_handlers = level["startingGhosts"]
	var ghosts = []
	for damage_handler in damage_handlers:
		var newEnemy = Enemy.create_enemy(damage_handler.new())
		ghosts.append(newEnemy)
	$Map/TileManager.fill_with_enemies(ghosts)
	popNextGhost(level)

func popNextGhost(level):
	var next_damage_handler = level["upcomingGhosts"].pop_front()
	if (next_damage_handler):
		var newEnemy = Enemy.create_enemy(next_damage_handler.new())
		$Map/TileManager.ini_turn(newEnemy)
	else:
		$Map/TileManager.ini_turn(null)
func play_one_round():
	# reset the enemy's bullet
	print("Playing one round")
	$Map/TileManager.end_turn()
	var level = levels[0]
	popNextGhost(level)
	
	

func _ready() -> void:
	# TODO: make better default enemies
	init_level(levels[0])



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_next_round_button_toggled(toggled_on: bool) -> void:
	#play_one_round()


func _on_next_round_button_pressed() -> void:
	play_one_round()
