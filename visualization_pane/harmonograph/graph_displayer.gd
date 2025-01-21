extends Container


var margin = 50  # Margin from edges
var scale_factor = 80  # Scale the harmonograph pattern

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	
func draw_self(points: Array[Vector2], color: Color, num_freq: int) -> void:
	var grid_color = Color(0.2, 0.2, 0.2, 0.3)
	var grid_spacing = 50
	
	var canvas_size = size
	
	# Vertical grid lines
	for x in range(margin, canvas_size.x - margin, grid_spacing):
		draw_line(Vector2(x, margin), Vector2(x, canvas_size.y - margin), grid_color)
	
	# Horizontal grid lines
	for y in range(margin, canvas_size.y - margin, grid_spacing):
		draw_line(Vector2(margin, y), Vector2(canvas_size.x - margin, y), grid_color)
	
	# Draw axes
	var axis_color = Color(0.4, 0.4, 0.4, 0.8)
	var center = Vector2(canvas_size.x/2, canvas_size.y/2)
	draw_line(Vector2(margin, center.y), Vector2(canvas_size.x - margin, center.y), axis_color, 2.0)
	draw_line(Vector2(center.x, margin), Vector2(center.x, canvas_size.y - margin), axis_color, 2.0)
	
	# Draw harmonograph if there are frequencies selected
	if points.size() < 2:
		return
		
	# Draw the harmonograph with gradual color change

	for i in range(points.size() - 1):
		var progress = float(i) / float(points.size() - 1)
		var current_color = color
		current_color.a = 0.8 - progress * 0.6  # Fade out towards the end
		
		draw_line(
			(points[i] - center)/num_freq + center,
			(points[i + 1] - center)/num_freq + center,
			current_color,
			6.0/num_freq  # Line width
		)
