class_name TowerUI
extends Control


var currentSlot: TowerSlot = null
var currentTower: Shooter = null
var changeButtons = []

var _glow_manager: GlowManager

var octave_offset: int = 0
@onready var infoPanel = $"PanelContainer/Panel/PanelContainer/Information Panel"
@onready var mainScene = get_tree().get_root().get_node("MainScene")
@onready var TowerChangePanel: TowerChangePanel = $"PanelContainer/Panel/PanelContainer2/Tower Change Panel"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var towerChangePanel = $"PanelContainer/Panel/PanelContainer2/Tower Change Panel/NoteButtonsContainer"
	
	for i in range(1, 13):
		changeButtons.append(towerChangePanel.get_node("Button%d" % i))

	# Connect each button's "pressed" signal
	for button in changeButtons:
		button.pressed.connect(_on_change_button_pressed.bind(button))

	var colorRect = $"PanelContainer/Panel/PanelContainer2/Tower Change Panel/ColorRect"
	_glow_manager = GlowManager.new(colorRect)
	add_child(_glow_manager) # Important: add as child to ensure proper cleanup
	

func slot_selected(slot: TowerSlot) -> void:
	_glow_manager.start_glow()

	if currentSlot != null:
		currentSlot.get_node("Outline").visible = false
	currentSlot = slot
	currentSlot.get_node("Outline").visible = true

	currentTower = null

	if slot.has_shooter():
		load_tower_info(slot.current_shooter)
	else:
		load_default_info()

#TODO: doesnt show octave of current slot when clicked
func load_tower_info(tower: Shooter) -> void:
	currentTower = tower
	var index = tower.current_frequency_index % 12
	var octave = int(floor(tower.current_frequency_index / 12)) - 1
	
	infoPanel.get_node("Tower Name").text = tower.current_name
	#draw_tower(tower.current_name, tower.FREQUENCIES[index])
	infoPanel.get_node("Frequency").text = str(tower.FREQUENCIES[index].frequency) + " Hz"
	infoPanel.get_node("Octave").text = str(octave + 4) + "th Octave"
	
	changeButtons[index].button_pressed = true


func draw_tower(name: String, freq: Frequency) -> void:
	# Draw a circle at the spawner's position
	var radius = 20 # Adjust size as needed
	draw_circle(Vector2.ZERO, radius, freq.color)
	#draw_line(Vector2.ZERO, Vector2(radius, 0), Color.BLACK, 2.5)
	
	
	var font = ThemeDB.fallback_font
	# Draw the note on top of the circle
	if font:
		var text_size = font.get_string_size(name)
		draw_string(font, Vector2(-text_size.x, text_size.y / 2) / 2, name, HORIZONTAL_ALIGNMENT_CENTER, -1, 20, Color.BLACK)


func load_default_info() -> void:
	infoPanel.get_node("Tower Name").text = "Empty Slot"
	infoPanel.get_node("Frequency").text = "<frequency>"
	infoPanel.get_node("Octave").text = "<octave>"
	
	for button in changeButtons:
		button.button_pressed = false


# returns if out of moves
func _on_change_button_pressed(pressed_button):
	_glow_manager.stop_glow()
	# Reset all buttons except the one pressed
	for button in changeButtons:
		if button != pressed_button:
			button.button_pressed = false

	if currentSlot != null:
		var note: Note = TowerChangePanel.toNote(pressed_button)

		if currentTower != null:
			currentTower.update_frequency(note)
		else:
			if (mainScene.moves_remaining == 0):
				print("out of moves for this round")
				return
			mainScene.moves_remaining -= 1
			currentSlot.add_shooter(note)
			currentTower = currentSlot.current_shooter
			assert(currentTower != null)
		load_tower_info(currentTower)
		currentTower.find_parent("TowerSlots")._on_hovered()


func _on_play_button_pressed():
	# TODO: show an error instead of crashing here
	assert(currentTower != null)
	
	currentTower.play_current_note()


func _on_delete_button_pressed():
	assert(currentTower != null)
	
	currentSlot.remove_shooter()
	currentTower = null
	load_default_info()
