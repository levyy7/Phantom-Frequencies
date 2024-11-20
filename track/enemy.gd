class_name Enemy
extends Node2D

@export var speed: float = 100.0  # Speed in pixels per second
@export var loop_path: bool = true  # Whether to loop the path or stop at the end


var enemy_identifier: String = "I am an enemy"
var path_follow: PathFollow2D
var is_moving: bool = true

var color: Color = Color.BLACK:
	set(new_color):
		$ColorRect.color = new_color

signal enemy_clicked(enemy)

func _ready() -> void:
	$ColorRect.color = color

func initialize_path_follow(pf: PathFollow2D) -> void:
	path_follow = pf
	# Configure the PathFollow2D
	path_follow.loop = loop_path
	path_follow.rotates = true  # Make the enemy rotate with the path

func _process(delta: float) -> void:
	if not is_moving:
		return
		
	# Move along the path
	path_follow.progress += speed * delta
	
	# Update our position to match the PathFollow2D
	global_position = path_follow.global_position
	global_rotation = path_follow.global_rotation
	
	# Check if we've reached the end of a non-looping path
	if not loop_path and path_follow.progress_ratio >= 1.0:
		is_moving = false


func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.is_released():
			enemy_clicked.emit(self)
			
