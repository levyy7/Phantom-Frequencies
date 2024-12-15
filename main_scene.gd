class_name MainScene
extends Node2D

var is_paused: bool = true
var upcomingGhosts = []
var level0 = Level.create_level("level0","introduces pitches",8,["Lo","Lo","Hi"],["Lo->Hi","Hi->Hi","Lo->Lo"])

var levels = [level0]
func init_level(level):
	var initalGhosts = level.getInitialGhosts()
	upcomingGhosts = level.getUpcomingGhosts()
	
	$Map/TileManager.fill_with_enemies(initalGhosts)
	popNextGhost()

func popNextGhost():
	var next_ghost = upcomingGhosts.pop_front()
	if (next_ghost):
		$Map/TileManager.ini_turn(next_ghost)
	else:
		$Map/TileManager.ini_turn(null)
func play_one_round():
	# reset the enemy's bullet
	print("Playing one round")
	$Map/TileManager.end_turn()
	popNextGhost()
	
	

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
