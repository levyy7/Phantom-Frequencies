extends  Control

@export var left_channel = []
var waveform_color = Color(0.5, 0.8, 1.0)

signal _waveform_drawn


func _draw():
	#drawWaveForm(recording_data)
	if left_channel.size() == 0:
		print("was null")
		return
	# Canvas dimensions
	var size = get_viewport_rect().size  # Plot dimensions
	var canvas_width = size.x
	var canvas_height = size.y
	var center_y = canvas_height / 2
	
	# Simplify data
	var step = max(1, left_channel.size() / canvas_width)  # Downsample for performance
	var points = []
	for i in range(0, left_channel.size(), step):
		var x = i / float(left_channel.size()) * canvas_width
		var y = center_y - (left_channel[i] * (canvas_height / 2))
		points.append(Vector2(x, y))
	# Draw waveform
	draw_polyline(points, waveform_color, 2)
	_waveform_drawn.emit()
