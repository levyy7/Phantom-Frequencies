class_name MainScene
extends Node2D

var is_paused: bool = true
var upcomingGhosts = []
var level0 = Level.create_level("level0","introduces pitches",8,["Hi","Lo","Lo"],["Hi","Lo->Hi->Hi","Lo->Lo->Hi","Lo->Hi->Hi","Lo->Lo->Hi"])
var levelTest = Level.create_level("levelT","",8,["A","A#","E"],["Hi","Oc->Hi->Hi","Lo->Lo->Hi","Lo->Hi->Hi","Lo->Lo->Hi"])

var levels = [level0,levelTest]
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
	init_level(levels[1])



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_next_round_button_toggled(toggled_on: bool) -> void:
	#play_one_round()


func _on_next_round_button_pressed() -> void:
	play_one_round()
