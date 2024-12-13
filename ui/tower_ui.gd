class_name TowerUI
extends Control


var currentSlot = null
var currentTower = null
var changeButtons = []

@onready var infoPanel = $"PanelContainer/Panel/PanelContainer3/Visualization Panel"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var towerChangePanel = $"PanelContainer/Panel/PanelContainer2/Tower Change Panel"
	
	for i in range(1, 13):
		changeButtons.append(towerChangePanel.get_node("Button%d" % i))

	# Connect each button's "pressed" signal
	for button in changeButtons:
		button.pressed.connect(_on_change_button_pressed.bind(button))


func slot_selected(slot: TowerSlot) -> void:
	currentSlot = slot
	
	if slot.has_shooter():
		load_tower_info(slot.current_shooter)


func load_tower_info(tower: Shooter) -> void:
	currentTower = tower
	var index = tower.current_frequency_index
	
	infoPanel.get_node("Tower Name").text = tower.current_name
	infoPanel.get_node("Frequency").text  = str(tower.FREQUENCIES[index].frequency) + " Hz"
	infoPanel.get_node("Octave").text     = "4th Octave"
	
	changeButtons[index].button_pressed = true


func load_default_info() -> void:
	pass


func _on_change_button_pressed(pressed_button):
	# Reset all buttons except the one pressed
	for button in changeButtons:
		if button != pressed_button:
			button.button_pressed = false
	
	
	if currentSlot != null:
		if currentTower != null:
			currentTower.update_frequency(pressed_button.text)
		else:
			currentSlot.add_shooter(pressed_button.text)
			currentTower = currentSlot.current_shooter
		
		load_tower_info(currentTower)


func _on_play_button_pressed(pressed_button):
	assert(currentTower != null)
	
	currentTower.play_current_note()


func _on_delete_button_pressed(pressed_button):
	assert(currentTower != null)
	
	currentSlot.remove_shooter()
	currentTower = null
	load_default_info()
