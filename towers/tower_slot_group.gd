class_name TowerSlotGroup
extends Node2D

var glowing: bool = false:
	set(glow):
		glowing = glow
		$GlowRect.visible = glowing
signal hovered_frequency_change(f: Array[Frequency])
signal tower_slot_group_selected(tower_slot_group: TowerSlotGroup)

func tower_slot_children() -> Array[TowerSlot]:
	var tower_slots: Array[TowerSlot] = []
	for node in get_children():
		if node is TowerSlot:
			tower_slots.append(node)
	return tower_slots
	

func _on_control_gui_input(mouse_event: InputEvent) -> void:
	if mouse_event is InputEventMouseButton:
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.is_released():
			print("Click recieved")
			tower_slot_group_selected.emit(self)

func _on_hovered():
	hovered_frequency_change.emit(selected_frequencies())

func _on_unhovered():
	# Necessary to specify the type of empty or else Godot won't work...
	# https://github.com/godotengine/godot/issues/53847
	var empty: Array[Frequency] = []
	hovered_frequency_change.emit(empty)
	
func selected_frequencies():
	var freqs: Array[Frequency] = []
	for ts in tower_slot_children():
		if ts.current_shooter:
			freqs.append(ts.current_shooter.current_frequency())

	return freqs
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.hovered.connect(_on_hovered)
	$ColorRect.unhovered.connect(_on_unhovered)
	
	for child in get_children():
		if child is TowerSlot:
			child.shooter_changed.connect(_on_hovered.unbind(1))
			

func shoot_bullets(target: PathTile, soundOn: bool, timer: Timer):
	# Enable the glowing effect
	assert(glowing == false, "Must not have been glowing when we begin shooting")
	glowing = true

	for node: TowerSlot in tower_slot_children():
		node.shoot_bullet(target, soundOn)

	timer.timeout.connect(disable_glow)

func disable_glow():
	glowing = false	

func any_tower_active() -> bool:
	for node: TowerSlot in tower_slot_children():
		if node.current_shooter != null:
			return true
	
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
