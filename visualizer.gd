extends Node2D


@export var frequency1: float = 440.0 # Hz
@export var frequency2: float = 550.0 # Hz
@export var frequency3: float = 660.0 # Hz
# can you export a list?

var stream = preload("res://TowerRecording.wav")


var t = 0;
var waveformPoints = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sampler.play_note("C")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t+=delta
	#print("process")
	var frequencies = [frequency1,frequency2,frequency3]
	waveformPoints = updateWaveForm(frequencies,500,t)

func _playing_music():
	AudioEffectCapture

#func FFT() -> PackedVector3Array: #frequency, amplitude and phase
	#var spectrum = AudioServer.get_bus_effect_instance(0, 0)
	#magnitudes = spectrum.get_magnitude()
	##for i in range(1, VU_COUNT + 1):
		##var hz = i * FREQ_MAX / VU_COUNT
		##var magnitude = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		##var energy = clampf((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
		##var height = energy * HEIGHT * HEIGHT_SCALE
		##data.append(height)
		##prev_hz = hz
	#return spectrum



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
	#_draw_preview()

#Herebelow we will handle recording tower sounds
var effect #global variable so that the stopping function can also access
var recording_data #global variable s.t. visualisations can be applied
func _start_recording_tower_audio() -> void:
	print("start recording")
	# We get the index of the "TowerMusic" bus.
	var idx = AudioServer.get_bus_index("TowerMusic")
	# And use it to retrieve its first effect, which has been defined
	# as an "AudioEffectRecord" resource.
	effect = AudioServer.get_bus_effect(idx, 0)
	effect.set_format(0) #corresponds to 8-bit format
	effect.set_recording_active(true)	


func _on_sampler_finished() -> void:
	print("stop recording")
	effect.set_recording_active(false)
	var recording = effect.get_recording() # gets AudioStreamWAV from bus 'record' effect
	recording.save_to_wav('TowerRecording') # saves as .wav file at specified path
	recording_data = recording.data() #creates packedbytearray from audio
	print_rich("[b]Data:[/b] %s bytes" % recording_data)
