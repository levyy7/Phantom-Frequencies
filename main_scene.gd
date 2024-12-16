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
	var next_round_button := $"UI frame/NextRoundButton" as Button
	var tile_manager := $Map/TileManager as TileManager
	print("Playing one round")
	
	# TODO: change the button logic to be inside a script in button
	next_round_button.disabled = true
	next_round_button.text = "Round in progress..."
	
	
	tile_manager.end_turn()
	var level = levels[0]
	popNextGhost()
	
	await tile_manager.turn_finished
	print("Turn finished")
	
	next_round_button.disabled = false
	next_round_button.text = "Next Round"
	

func _ready() -> void:
	# TODO: make better default enemies
	setup_ui_connections()
	init_level(levels[0])

func setup_ui_connections() -> void:
	var slots = get_tree().get_nodes_in_group("tower_slot")
	
	print("Enter setup UI")
	for slot in slots:
		print("Cycle slot")
		slot.shooter_changed.connect($"UI frame/TowerUI".slot_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_next_round_button_pressed() -> void:
	play_one_round()
