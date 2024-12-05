extends Node2D

#signals below
signal _wav_data_read


#global variables below
@export var frequency1: float = 440.0 # Hz
@export var frequency2: float = 550.0 # Hz
@export var frequency3: float = 660.0 # Hz
# can you export a list?

var stream = preload("res://TowerRecording.wav")
var t = 0;

var effect #global variable so that the stopping function can also access
var recording_data #global variable s.t. visualisations can be applied

@export var left_channel = [0]
var right_channel
var sample_rate

var result


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$Sampler.play_note("C")
	read_wav_data()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t+=delta
	#print("process")
	#var frequencies = [frequency1,frequency2,frequency3]
	#waveformPoints = updateWaveForm(frequencies,500,t)



#func updateWaveForm(frequencies,numpoints:int,t:float) -> PackedVector2Array:
	#var width = 1000
	#var height = 50 
	#var wavelength = 1/frequencies[0] # should average maybe
	#var length = 10*wavelength # length of of wave for calculation
#
	#var dx = length/numpoints # for calculation
	#var points = []
	#var xoffset = 100 # for drawing
	#var yoffset = 200 # for drawing
	#var speed = 1.0/200.0
	#for i in range(numpoints):
		#var x = dx*i
		#var y = 0
		#for frequency in frequencies:
			#y+=height*sin(2*PI*frequency*(x+t*speed))	
		#points.append(Vector2(width*x/length+xoffset, y+yoffset))
	#points = PackedVector2Array(points)
	#queue_redraw()
	#return points

#func drawWaveForm(points):
	#draw_polyline(points, Color.GREEN_YELLOW, 1, true)



	


#Herebelow we will handle recording tower sounds
func _start_recording_tower_audio() -> void:
	print("start recording")
	# We get the index of the "TowerMusic" bus.
	var idx = AudioServer.get_bus_index("TowerMusic")
	# And use it to retrieve its first effect, which has been defined
	# as an "AudioEffectRecord" resource.
	effect = AudioServer.get_bus_effect(idx, 0)
	effect.set_format(1) #corresponds to 16-bit format
	effect.set_recording_active(true)	


func _on_sampler_finished() -> void:
	print("stop recording")
	effect.set_recording_active(false)
	var recording = effect.get_recording() # gets AudioStreamWAV from bus 'record' effect
	recording.save_to_wav('TowerRecording') # saves as .wav file at specified path
	recording_data = recording.get_data() #creates packedbytearray from audio
	print_rich("[b]Size:[/b] %s bytes" % recording_data.size())
	#recording_data = recording_data / 32768.0
	#print(recording_data)



func read_wav_data():
	var wav_data: Dictionary = $WavReader.read_wav('TowerRecording.wav')
	if wav_data["success"]:
		print('succes')
		left_channel = wav_data["L"]
		right_channel = wav_data["R"]
		sample_rate = 44100  # Or use the actual sample rate from the WAV file
		_wav_data_read.emit()
	else:
		print("Failed to load WAV file.")


func _on__wav_data_read() -> void:
	$WaveformPlot.set("left_channel", left_channel)
	$WaveformPlot._draw()
	#await get_tree().create_timer(5).timeout
	#$FFTPlot.set("left_channel", left_channel)
	#$FFTPlot.plot_fft()


#func _on_waveform_plot__waveform_drawn() -> void:
	#$FFTPlot.set("left_channel", left_channel)
	#$FFTPlot.plot_fft()
