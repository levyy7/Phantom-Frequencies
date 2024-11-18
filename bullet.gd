@tool
extends Node2D

@export var length: float = 12.5
var width: float = 12.5

var velocity: Vector2

func _ready():
	var rect_size = Vector2(length, width)
	$VisibleOnScreen.rect = Rect2(-rect_size / 2, rect_size)
	
	# Get velocity from meta if it exists
	if has_meta("velocity"):
		velocity = get_meta("velocity")
		remove_meta("velocity")  # Clean up meta data

func _process(delta: float) -> void:
	position += velocity * delta

func _draw():
	var rect_size = Vector2(length, width)
	draw_rect(Rect2(-rect_size / 2, rect_size), Color.GREEN_YELLOW, true)


func _on_screen_exited() -> void:
	print("Screen exited")
	queue_free()
