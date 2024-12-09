extends Container

var selected_frequencies: Array[Frequency] = []
var margin = 50  # Margin from edges
var scale_factor = 100  # Scale the harmonograph pattern

func build_harmonograph_points() -> Array[Vector2]:
	var NUM_POINTS = 1000
	var points: Array[Vector2] = []
	
	for i in range(NUM_POINTS):
		var t = float(i) / 10.0  # Adjust time scale for smoother curves
		var x = 0.0
		var y = 0.0
		
		for freq in selected_frequencies:
			# Add decay factor for more interesting patterns
			var decay = exp(-0.001 * t)
			x += decay * sin(t * freq.frequency)
			y += decay * cos(t * freq.frequency)
		
		points.append(Vector2(x, y))
	
	return points

func _ready() -> void:
	var tower_slots = get_tree().get_nodes_in_group("tower_slot_group") as Array[TowerSlotGroup]
	
	for ts in tower_slots:
		ts.hovered_frequency_change.connect(_on_tower_slot_hovered)

func _on_tower_slot_hovered(f: Array[Frequency]) -> void:
	print("On tower slot hovered", len(f))
	selected_frequencies = f


func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	# # Draw the frequency circles at the top
	# var offset = margin
	# for freq in selected_frequencies:
	# 	var radius = 20
	# 	draw_circle(Vector2(offset, margin), radius, freq.color)
	# 	offset += radius * 2 + 10  # Add spacing between circles
	
	# Draw grid
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
	if selected_frequencies.size() > 0:
		var points = build_harmonograph_points()
		if points.size() < 2:
			return
			
		# Transform points to screen space
		var transformed_points = []
		for point in points:
			var screen_point = Vector2(
				center.x + point.x * scale_factor,
				center.y + point.y * scale_factor
			)
			transformed_points.append(screen_point)
		
		# Draw the harmonograph with gradual color change
		var base_color = selected_frequencies[0].color
		for i in range(transformed_points.size() - 1):
			var progress = float(i) / float(transformed_points.size() - 1)
			var current_color = base_color
			current_color.a = 0.8 - progress * 0.6  # Fade out towards the end
			
			draw_line(
				transformed_points[i],
				transformed_points[i + 1],
				current_color,
				6.0  # Line width
			)
