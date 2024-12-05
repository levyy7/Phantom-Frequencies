extends Node2D

var waveform = []  # Store normalized data here
var size = Vector2(800, 600)  # Define canvas size manually

func set_waveform(data):
	waveform = data
	queue_redraw()  # Request a redraw

func _draw():
	if waveform == null:
		return
	
	var width = size.x  # Canvas width
	var height = size.y  # Canvas height
	var center_y = height / 2
	var step = width / waveform.size()

	# Draw the waveform
	for i in range(waveform.size() - 1):
		var x1 = i * step
		var y1 = center_y - waveform[i] * center_y
		var x2 = (i + 1) * step
		var y2 = center_y - waveform[i + 1] * center_y
		draw_line(Vector2(x1, y1), Vector2(x2, y2), Color(0, 1, 0))
