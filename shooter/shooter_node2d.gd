@tool
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()  # Ensure the circle is always drawn

func _draw() -> void:
	# Draw a circle at the spawner's position
	var radius = 20  # Adjust size as needed
	draw_circle(Vector2.ZERO, radius, Color.BLUE_VIOLET)
	draw_line(Vector2.ZERO, Vector2(radius, 0), Color.BLACK, 2.0)
