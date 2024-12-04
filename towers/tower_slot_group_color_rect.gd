extends ColorRect

var default_color := Color(0.2, 0.2, 0.2, 1.0)  # Similar to Godot's default grey
var hover_color := Color(0.6, 0.4, 0.8, 1.0)    # Light purple

func _ready() -> void:
	# Set initial color
	color = default_color

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		var mouse_pos = get_global_mouse_position()
		var rect = get_global_rect()
		
		if rect.has_point(mouse_pos):
			color = hover_color
		else:
			color = default_color
