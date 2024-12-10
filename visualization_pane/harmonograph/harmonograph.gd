extends Container

var selected_frequencies: Array[Frequency] = []
var margin = 50  # Margin from edges
var scale_factor = 100  # Scale the harmonograph pattern
var cached_homonograph_points: Array[Vector2] = []
var animation_progress: float = 0.0

func build_harmonograph_points(freqs: Array[Frequency]) -> Array[Vector2]:
	var NUM_POINTS = 600
	var points: Array[Vector2] = []
	var canvas_size = $Harmonograph2.size
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
		
	$Harmonograph2.draw.connect(draw_on_child)


func draw_on_child():
	var color = Color.BLACK
	
	if len(selected_frequencies) > 0:
		color = selected_frequencies[0].color
	$Harmonograph2.draw_self(cached_homonograph_points, color)

func _on_tower_slot_hovered(f: Array[Frequency]) -> void:
	if f != selected_frequencies:
		selected_frequencies = f
		cached_homonograph_points = build_harmonograph_points(selected_frequencies)
		animation_progress = 0.0


func _process(delta: float) -> void:
	animation_progress += delta * 0.25

	if animation_progress > 1.0:
		animation_progress = 1.0

func _draw() -> void:
	pass
