extends Container

var selected_frequencies: Array[Frequency] = []
var margin = 20
var scale_factor = 80
var cached_oscilloscope_points: Array[Vector2] = []
var animation_progress: float = 0.0

func gcd(a: int, b: int) -> int:
	return a if b == 0.0 else gcd(b, a % b)
	
func build_oscilloscope_points(freqs: Array[Frequency]) -> Array[Vector2]:
	var NUM_POINTS = 400
	var points: Array[Vector2] = []
	var canvas_size = $GraphDisplay.size
	var center = Vector2(canvas_size.x/2, canvas_size.y/2)
	
	var lcm_of_all_denominators = 440.0*(64*5*3)
	var totalTime = 2*PI*1/440
	var periods = []
	for freq in freqs:
		periods.append(1.0/freq.frequency)
	if(len(periods)==1):
		totalTime = 2*PI*periods[0]
	if(len(periods)>=2): 
		var T1 = round(lcm_of_all_denominators*periods[0])
		var T2 = round(lcm_of_all_denominators*periods[1])
		var lcm_12 = T1*T2/gcd(T1,T2)
		totalTime = 2*PI*lcm_12/(lcm_of_all_denominators)
		if(len(periods)==3):
			var T3 = round(lcm_of_all_denominators*periods[2])
			var lcm_123 = T3*lcm_12/gcd(lcm_12,T3)
			totalTime = 2*PI*lcm_123/(lcm_of_all_denominators)
		
	
	for i in range(NUM_POINTS):
		var t = float(i) / NUM_POINTS * totalTime
		var y = 0.0
		
		for freq in freqs:
			y += cos(t * freq.frequency)
		
		var screen_point = Vector2(
			t /totalTime *canvas_size.x,
			center.y + y * scale_factor
		)
		
		#if screen_point.x >= canvas_size.x:
		#	break
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
	var min_freq = frequencies[0].frequency
	for freq in frequencies:
		if freq.frequency < min_freq:
			min_freq = freq.frequency
	
	if frequencies.size() > 1:
		for freq in frequencies:
			# TODO (Karen): 
			# 1. lookup the proper ratio and express it as a fraction
			# 2. show the user if the chord is "bad" or "good" based on this ratio, show it on the game with colors etc.
			
			ratio_descriptor += "%.2f" % (freq.frequency / min_freq) + ", "

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
