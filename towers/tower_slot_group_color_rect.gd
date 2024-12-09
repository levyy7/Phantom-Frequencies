extends ColorRect

var default_color := Color(0.2, 0.2, 0.2, 1.0)  # Similar to Godot's default grey
var hover_color := Color(0.6, 0.4, 0.8, 1.0)    # Light purple

signal hovered()
signal unhovered()

var is_hovering = false

func _ready() -> void:
	# Set initial color
	color = default_color

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		var mouse_pos = get_global_mouse_position()
		var rect = get_global_rect()
		
		if rect.has_point(mouse_pos):
			color = hover_color
			is_hovering = true
			hovered.emit()
		else:
			color = default_color
			if is_hovering:
				is_hovering = false
				unhovered.emit()
			
