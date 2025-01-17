class_name MainScene
extends Node2D

var is_paused: bool = true
var upcomingGhosts = []

var moves_remaining: int = 2:
	set(new_moves_remaining):
		moves_remaining=new_moves_remaining
		$"UI frame/Actions_text".text="Remaining placements: "+str(moves_remaining)

var lives: int = 3:
	set(newLives):
		lives=newLives
		$"UI frame/Lives_text".text=str(lives)+" ghosts away from being haunted"

func init_level(level: Level):
	print("initializing level")
	$Map/TileManager.setPathwayPreferences(level.getPathwayPreference())

	var initalGhosts = level.getInitialGhosts()
	upcomingGhosts = level.getUpcomingGhosts()
	$"UI frame/TutorialPanel/TutorialText".text = level.description
	Global.lives = 3
	lives = Global.lives
	$Map/TileManager.fill_with_enemies(initalGhosts)
	$"UI frame/TowerUI".initializeNoteButtons(level.note_names, level.notes)
	popNextGhost()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			# Click was not handled by any other control
			print("Unhandled click detected at: ", mouse_event.position)
			$"UI frame/TowerUI".slot_unselected()

			
func popNextGhost():
	var enemyPreview = $EnemyPreviewPanel/EnemyPreview
	var next_ghost = upcomingGhosts.pop_front()
	if (next_ghost):
		$Map/TileManager.ini_turn(next_ghost)
		enemyPreview.add_child(next_ghost)
		for child in enemyPreview.get_children():
			if child is Enemy:
				enemyPreview.remove_child(child)
	
		# Add the new child
		enemyPreview.add_child(next_ghost)
	else:
		$Map/TileManager.ini_turn(null)
	
	
func play_one_round():
	# reset the enemy's bullet
	$"UI frame/TowerUI/Action_overlay".moves_remaining_updated(moves_remaining, [] as Array[TowerSlot])
	var next_round_button := $"UI frame/NextRoundButton" as Button
	var tile_manager := $Map/TileManager as TileManager
	print("Playing one round", "moves remaining ", moves_remaining)
	
	# TODO: change the button logic to be inside a script in button
	next_round_button.disabled = true
	#next_round_button.text = "Round in progress..."
	
	
	tile_manager.end_turn()
	popNextGhost()
	
	await tile_manager.turn_finished
	checkWinLoseCriteria()
	print("Turn finished")
	
	next_round_button.disabled = false
	#next_round_button.text = "Next Round"
	
	get_node("UI frame/TowerUI").usedSlotsRound = [] as Array[TowerSlot]
	moves_remaining = 2
	$"UI frame/TowerUI/Action_overlay".moves_remaining_updated(moves_remaining, [] as Array[TowerSlot])
	
func checkWinLoseCriteria():
	var enemyCount = $Map/TileManager.enemyCount()
	print("Enemy Count", enemyCount)
	lives = Global.lives
	if (Global.lives < 1):
		print("lose")
		Global.win = false
		get_tree().change_scene_to_file("res://ui/game_over.tscn")
	elif (len(upcomingGhosts) == 0 and enemyCount == 0):
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
		slot.shooter_selected.connect($"UI frame/TowerUI".slot_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_next_round_button_pressed() -> void:
	play_one_round()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level/level_select.tscn")
