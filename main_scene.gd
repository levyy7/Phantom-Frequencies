class_name MainScene
extends Node2D

var is_paused: bool = true
var upcomingGhosts = []

var moves_remaining: int = 2:
	set(new_moves_remaining):
		moves_remaining=new_moves_remaining
		$"UI frame/Actions_text".text="Remaining placements: "+str(moves_remaining) 

func init_level(level):
	print("initializing level")
	$Map/TileManager.setPathwayPreferences(level.getPathwayPreference())

	var initalGhosts = level.getInitialGhosts()
	upcomingGhosts = level.getUpcomingGhosts()
	Global.lives = 3
	$Map/TileManager.fill_with_enemies(initalGhosts)
	$"UI frame/TowerUI".createButtons(level.notes)
	popNextGhost()

func popNextGhost():
	var next_ghost = upcomingGhosts.pop_front()
	if (next_ghost):
		$Map/TileManager.ini_turn(next_ghost)
		$EnemyPreview.add_child(next_ghost)
		for child in $EnemyPreview.get_children():
			if child is Enemy:
				$EnemyPreview.remove_child(child)
	
		# Add the new child
		$EnemyPreview.add_child(next_ghost)
	else:
		$Map/TileManager.ini_turn(null)
	
	
func play_one_round():
	# reset the enemy's bullet
	var next_round_button := $"UI frame/NextRoundButton" as Button
	var tile_manager := $Map/TileManager as TileManager
	print("Playing one round", "moves remaining ", moves_remaining)
	
	# TODO: change the button logic to be inside a script in button
	next_round_button.disabled = true
	next_round_button.text = "Round in progress..."
	
	
	tile_manager.end_turn()
	popNextGhost()
	checkWinLoseCriteria()
	
	await tile_manager.turn_finished
	print("Turn finished")
	
	next_round_button.disabled = false
	next_round_button.text = "Next Round"
	
	moves_remaining = 2
	
func checkWinLoseCriteria():
	var enemyCount = $Map/TileManager.enemyCount()
	print(enemyCount)
	if (Global.lives < 1):
		print("lose")
		Global.win = false
		get_tree().change_scene_to_file("res://ui/game_over.tscn")
	if (len(upcomingGhosts) == 0 and enemyCount == 0):
		Global.win = true
		get_tree().change_scene_to_file("res://ui/game_over.tscn")
		print("win")

func _ready() -> void:
	# TODO: make better default enemies
	setup_ui_connections()
	if (Global.currentLevel):
		init_level(Global.currentLevel)
	else:
		get_tree().change_scene_to_file("res://level/level_select.tscn")

func setup_ui_connections() -> void:
	var slots = get_tree().get_nodes_in_group("tower_slot")
	print("Enter setup UI")
	for slot in slots:
		slot.shooter_changed.connect($"UI frame/TowerUI".slot_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_next_round_button_pressed() -> void:
	play_one_round()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level/level_select.tscn")
