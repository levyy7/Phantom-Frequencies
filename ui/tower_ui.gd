class_name TowerUI
extends Control


var _currentSlot: TowerSlot = null:
	set(new_slot):
		print("Setting new slot")
		_currentSlot = new_slot
		$Action_overlay.current_slot_updated(_currentSlot, mainScene.moves_remaining, usedSlotsRound)

var _currentTower: Shooter = null
var _changeButtons = []
var _deleteButton: Button = null

var octave_offset: int = 0
var usedSlotsRound: Array[TowerSlot] = []
@onready var mainScene = get_tree().get_root().get_node("MainScene")
@onready var towerChangePanel: TowerChangePanel = $"NoteSelectorPanel"


func initializeNoteButtons(notes: Array[String], enabled_notes: Array[String]) -> void:
	var noteButtons = towerChangePanel.createNoteButtons(notes, enabled_notes)
	_changeButtons = noteButtons
	
	var deleteButton = towerChangePanel.createDeleteButton(notes)
	_deleteButton = deleteButton

	for button in noteButtons:
		button.pressed.connect(_on_change_button_pressed.bind(button))
	
	deleteButton.pressed.connect(_on_delete_button_pressed.bind())
	
func _ready() -> void:
	pass


func slot_unselected() -> void:
	if _currentSlot != null:
		_currentSlot.get_node("Outline").visible = false
	_currentSlot = null
	_currentTower = null
	load_default_info()
	towerChangePanel.stop_glows()


func slot_selected(slot: TowerSlot) -> void:
	towerChangePanel.start_glows()

	if _currentSlot != null:
		_currentSlot.get_node("Outline").visible = false
	_currentSlot = slot
	_currentSlot.get_node("Outline").visible = true

	_currentTower = null

	if slot.has_shooter():
		load_tower_info(slot.current_shooter)
	else:
		load_default_info()

#TODO: doesnt show octave of current slot when clicked
func load_tower_info(tower: Shooter) -> void:
	_currentTower = tower
	var index = tower.current_frequency_index % 12
	var octave = int(floor(tower.current_frequency_index / 12)) - 1
	

func load_default_info() -> void:
	for button in _changeButtons:
		button.button_pressed = false

# returns if out of moves
func _on_change_button_pressed(pressed_button):
	towerChangePanel.stop_glows()
	# Reset all buttons except the one pressed
	for button in _changeButtons:
		if button != pressed_button:
			button.button_pressed = false

	if _currentSlot != null:
		var note: Note = towerChangePanel.toNote(pressed_button)
			
		if _currentTower == null:
			if (mainScene.moves_remaining == 0):
				print("out of moves for this round")
				return
			mainScene.moves_remaining -= 1
			usedSlotsRound.append(_currentSlot)
			$Action_overlay.current_slot_updated(_currentSlot, mainScene.moves_remaining, usedSlotsRound)
			_currentSlot.add_shooter(note)
			_currentTower = _currentSlot.current_shooter
			print(usedSlotsRound)
			assert(_currentTower != null)
		else:
			if not _currentSlot in usedSlotsRound:
				if (mainScene.moves_remaining == 0):
					print("out of moves for this round")
					return
				mainScene.moves_remaining -= 1
				usedSlotsRound.append(_currentSlot)
				$Action_overlay.current_slot_updated(_currentSlot, mainScene.moves_remaining, usedSlotsRound)
				_currentSlot.add_shooter(note)
			
			_currentSlot.update_frequency(note)
		
		load_tower_info(_currentTower)
		_currentTower.find_parent("TowerSlots")._on_hovered()
		
	else:
		print("No slot selected!")

func _on_play_button_pressed():
	# TODO: show an error instead of crashing here
	if (_currentTower != null):
		_currentTower.play_current_note()


func _on_delete_button_pressed():
	if (_currentTower != null):
		if _currentSlot in usedSlotsRound:
			mainScene.moves_remaining += 1
			usedSlotsRound.erase(_currentSlot)
			$Action_overlay.current_slot_updated(_currentSlot, mainScene.moves_remaining, usedSlotsRound)
			
		_currentSlot.remove_shooter()
		_currentTower = null
		load_default_info()
