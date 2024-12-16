extends Container

var selected_frequencies: Array[Frequency] = []
var margin = 50
var scale_factor = 80
var cached_oscilloscope_points: Array[Vector2] = []
var animation_progress: float = 0.0

func build_oscilloscope_points(freqs: Array[Frequency]) -> Array[Vector2]:
	var NUM_POINTS = 200
	var points: Array[Vector2] = []
	var canvas_size = $GraphDisplay.size
	var center = Vector2(canvas_size.x/2, canvas_size.y/2)

	
	for i in range(NUM_POINTS):
		var t = float(i) / 1200.0
		var y = 0.0
		
		for freq in freqs:
			y += cos(t * freq.frequency)
		
		var screen_point = Vector2(
			t * 100 * scale_factor,
			center.y + y * scale_factor
		)
		
		if screen_point.x >= canvas_size.x:
			break
		points.append(screen_point)
	
	return points

func _ready() -> void:
	var tower_slots = get_tree().get_nodes_in_group("tower_slot_group") as Array[TowerSlotGroup]
	
	for ts in tower_slots:
		ts.hovered_frequency_change.connect(_on_tower_slot_hovered)
		
	$GraphDisplay.draw.connect(draw_on_child)
	$Label.text = ""


func draw_on_child():
	var color = Color.BLACK
	
	if len(selected_frequencies) > 0:
		color = selected_frequencies[0].color
	
	var end_index = int(animation_progress * (len(cached_oscilloscope_points) - 1))
	var selected_points = cached_oscilloscope_points.slice(0, end_index)
	$GraphDisplay.draw_self(selected_points, color, selected_frequencies.size())

func _on_tower_slot_hovered(f: Array[Frequency]) -> void:
	if f != selected_frequencies:
		selected_frequencies = f
		cached_oscilloscope_points = build_oscilloscope_points(selected_frequencies)
		animation_progress = 0.0


func frequencies_descriptor(frequencies: Array[Frequency]) -> String:
	var descriptor = ""
	for freq in frequencies:
		descriptor += str(roundi(freq.frequency)) + ", "
		
	var ratio_descriptor = ""
	if frequencies.size() > 1:
		for freq in frequencies:
			# TODO (Karen): 
			# 1. lookup the proper ratio and express it as a fraction
			# 2. show the user if the chord is "bad" or "good" based on this ratio, show it on the game with colors etc.
			ratio_descriptor += "%.2f" % (freq.frequency / frequencies[0].frequency) + ", "

	return descriptor + "\n" + ratio_descriptor

func _process(delta: float) -> void:
	animation_progress += delta * 1.25

	if animation_progress > 1.0:
		animation_progress = 1.0
		
	if len(selected_frequencies) > 0:
		$Label.text = frequencies_descriptor(selected_frequencies)

func _draw() -> void:
	# Draw a border around self
	var canvas_size = size
	var border_color = Color(0.8, 0.8, 0.8, 0.8)
	var border_width = 2.0

	# Draw the rectangle border using draw_rect
	draw_rect(Rect2(Vector2.ZERO, canvas_size), border_color, false, border_width)
