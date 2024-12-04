class_name TowerSlot
extends ColorRect

const ShooterScene = preload("res://shooter/Shooter.tscn")
var targeting: EnemyList

var current_shooter: Shooter = null


	
func add_shooter() -> void:
	var shooter = ShooterScene.instantiate()
	shooter.position = self.size / 2
	shooter.visible = true
	current_shooter = shooter
	add_child(shooter)

func has_shooter() -> bool:
	return current_shooter is Shooter
	
func remove_shooter():
	current_shooter.queue_free()

func tower_damage():
	var damage = 0
	if has_shooter():
		damage = current_shooter.damage
	return damage
	
func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.is_released():
			if not has_shooter():
				add_shooter()
			else:
				remove_shooter()

func shoot_bullet(target: PathTile):
	if has_shooter():
		current_shooter.spawn_bullet(target)
