class_name TowerSlot
extends ColorRect

const ShooterScene = preload("res://Shooter.tscn")
var targeting: EnemyList

var current_shooter: Shooter = null


func play_one_round():
	print("Tower slot playing one round")
	if current_shooter is Shooter:
		current_shooter.shoot_once()
	
func add_shooter() -> void:
	var shooter = ShooterScene.instantiate()
	shooter.targeting = self.targeting
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
			print("Left mouse button released", event)
