class_name TowerSlot
extends ColorRect

const ShooterScene = preload("res://Shooter.tscn")
var targeting: EnemyList

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_shooter() -> void:
	var shooter = ShooterScene.instantiate()
	shooter.targeting = self.targeting
	shooter.position = self.size / 2
	shooter.visible = true
	add_child(shooter)

func has_shooter() -> bool:
	return get_children().any(func(child): return child is Shooter)
	
func remove_shooter():
	for child in get_children():
		if child is Shooter:
			child.queue_free()
func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.is_released():
			if not has_shooter():
				add_shooter()
			else:
				remove_shooter()
			print("Left mouse button released", event)
