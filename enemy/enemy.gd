class_name Enemy
extends Node2D

var hp: int = 100
@onready var health_bar: ProgressBar = $ProgressBar

# When the enemy is moving from one track square to the next, keeps track of the progress along this path
# The enemy is "done" moving when the progress is 1.0, then we emit a "is_done_moving" signal which is picked up
# by the tile manager 
var _path_progress: float
var current_path: Curve2D

var damage_handler: DamageHandler

static var enemy_scene = preload("res://enemy/Enemy.tscn")


signal is_done_moving
signal enemy_clicked(enemy: Enemy)

static func create_enemy(dmg: DamageHandler) -> Enemy:
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.damage_handler = dmg
	enemy.color = enemy.damage_handler.color
	return enemy


func set_advance_to(node: Node2D):
	# Create a Curve2D resource to define the path
	var curve = Curve2D.new()
	
	# Add points to the curve - starting from current position to target position
	curve.add_point(global_position)  # Start point
	curve.add_point(node.global_position)  # End point
	
	current_path = curve

	_path_progress = 0.0

var color: Color = Color.BLACK:
	set(new_color):
		color=new_color
		$ColorRect.color = new_color


func _ready() -> void:
	health_bar.max_value = hp
	health_bar.value = hp
	#$ColorRect.color = color

	#damage_handler = HighFrequencyEnemy.new()
	

func take_damage(_amount: Damage) -> void:
	hp = damage_handler.take_damage(hp, _amount)
	health_bar.value = hp
	if hp <= 0:
		die()

	
func _process(delta: float) -> void:
	if current_path != null:
		_path_progress += delta * 2.5
		
		var progress_len = _path_progress * current_path.get_baked_length()
		global_position = current_path.sample_baked(progress_len)
		if _path_progress >= 1.0:
			current_path = null
			is_done_moving.emit()
			


func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.is_released():
			enemy_clicked.emit(self)
			

func die():
	queue_free()
