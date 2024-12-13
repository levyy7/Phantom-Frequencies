class_name TowerSlot
extends ColorRect

const ShooterScene = preload("res://shooter/Shooter.tscn")
var targeting: EnemyList

signal shooter_changed(t: TowerSlot)

var current_shooter: Shooter = null

	
func add_shooter(note: String) -> void:
	var shooter = ShooterScene.instantiate()
	shooter.position = self.size / 2
	shooter.visible = true
	shooter.update_frequency(note)
	current_shooter = shooter
	add_child(shooter)

func has_shooter() -> bool:
	return current_shooter is Shooter
	
func remove_shooter():
	current_shooter.queue_free()
	current_shooter = null

func tower_damage():
	var damage = 0
	if has_shooter():
		damage = current_shooter.damage
	return damage
	
func _on_control_gui_input(mouse_event: InputEvent) -> void:
	if mouse_event is InputEventMouseButton:
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.is_released():
			if has_shooter():
				var should_remain = current_shooter.next_frequency()

				if not should_remain:
					remove_shooter()
				shooter_changed.emit(self)
			else:
				add_shooter("A")
				shooter_changed.emit(self)

func shoot_bullet(target: PathTile, soundOn: bool):
	if has_shooter():
		current_shooter.spawn_bullet(target)
		if soundOn:
			current_shooter.play_current_note()
