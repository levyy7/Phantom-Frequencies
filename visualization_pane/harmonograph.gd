extends Container

var selected_frequencies: Array[Frequency] = []
var margin = 50  # Margin from edges
var scale_factor = 100  # Scale the harmonograph pattern
var cached_homonograph_points: Array[Vector2] = []
var animation_progress: float = 0.0

func build_harmonograph_points(freqs: Array[Frequency]) -> Array[Vector2]:
	var NUM_POINTS = 600
	var points: Array[Vector2] = []
	var canvas_size = size
	var center = Vector2(canvas_size.x/2, canvas_size.y/2)

	
	for i in range(NUM_POINTS):
		var t = float(i) / 8000.0
		var x = 0.0
		var y = 0.0
		
		for freq in freqs:
			x += sin(t * freq.frequency)
			y += cos(t * freq.frequency)
		
		var screen_point = Vector2(
			center.x + x * scale_factor,
			center.y + y * scale_factor
		)
		points.append(screen_point)
	
	return points

func _ready() -> void:
	var tower_slots = get_tree().get_nodes_in_group("tower_slot_group") as Array[TowerSlotGroup]
	
	for ts in tower_slots:
		ts.hovered_frequency_change.connect(_on_tower_slot_hovered)

func _on_tower_slot_hovered(f: Array[Frequency]) -> void:
	if f != selected_frequencies:
		selected_frequencies = f
		cached_homonograph_points = build_harmonograph_points(selected_frequencies)
		animation_progress = 0.0


func _process(delta: float) -> void:
	animation_progress += delta * 0.25

	if animation_progress > 1.0:
		animation_progress = 1.0
	queue_redraw()

func _draw() -> void:
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
		var screen_points = cached_homonograph_points
		if screen_points.size() < 2:
			return
			
		# Draw the harmonograph with gradual color change
		var base_color = selected_frequencies[0].color

		var end_index = int(animation_progress * (screen_points.size() - 1))
		for i in range(end_index):
			var progress = float(i) / float(screen_points.size() - 1)
			var current_color = base_color
			current_color.a = 0.8 - progress * 0.6  # Fade out towards the end
			
			draw_line(
				screen_points[i],
				screen_points[i + 1],
				current_color,
				6.0  # Line width
			)
