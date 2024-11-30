extends Node2D

@export var frequency1: float = 440.0 # Hz
@export var frequency2: float = 550.0 # Hz
@export var frequency3: float = 660.0 # Hz
# can you export a list?


var t = 0;
var waveformPoints = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t+=delta
	print("process")
	var frequencies = [frequency1,frequency2,frequency3]
	waveformPoints = updateWaveForm(frequencies,500,t)
	
func updateWaveForm(frequencies,numpoints:int,t:float) -> PackedVector2Array:
	var width = 1000
	var height = 50 
	var wavelength = 1/frequencies[0] # should average maybe
	var length = 10*wavelength # length of of wave for calculation

	var dx = length/numpoints # for calculation
	var points = []
	var xoffset = 100 # for drawing
	var yoffset = 200 # for drawing
	var speed = 1.0/200.0
	for i in range(numpoints):
		var x = dx*i
		var y = 0
		for frequency in frequencies:
			y+=height*sin(2*PI*frequency*(x+t*speed))	
		points.append(Vector2(width*x/length+xoffset, y+yoffset))
	points = PackedVector2Array(points)
	queue_redraw()
	return points

func drawWaveForm(points):
	draw_polyline(points, Color.GREEN_YELLOW, 1, true)
	
func _draw():
	drawWaveForm(waveformPoints)
