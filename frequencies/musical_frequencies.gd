class_name MusicalFrequencies

# Constants for music theory calculations
const BASE_FREQUENCIES = [220.0, 440.0, 880.0] # A4 note in Hz

# Just intonation ratios based on harmonic series
const JUST_RATIOS = {
	"perfect_unison": 1.0, # 1:1    - A
	"minor_second": 16.0 / 15, # 16:15  - Bb
	"major_second": 9.0 / 8, # 9:8    - B
	"minor_third": 6.0 / 5, # 6:5    - C
	"major_third": 5.0 / 4, # 5:4    - C#
	"perfect_fourth": 4.0 / 3, # 4:3    - D
	"tritone": 45.0 / 32, # 45:32  - Eb
	"perfect_fifth": 3.0 / 2, # 3:2    - E
	"minor_sixth": 8.0 / 5, # 8:5    - F
	"major_sixth": 5.0 / 3, # 5:3    - F#
	"minor_seventh": 16.0 / 9, # 16:9    - G
	"major_seventh": 15.0 / 8, # 15:8   - G#
}

const RAINBOW_12 = {
	"red": Color(1, 0.6, 0.6),
	"orange": Color(1, 0.8, 0.4),
	"yellow": Color(0.8, 0.95, 0.1),
	"lime green": Color(0.5, 1, 0),
	"green": Color(0.5, 1, 0.5),
	"spring green": Color(0.4, 1, 0.7),
	"cyan": Color(0, 1, 1),
	"azure blue": Color(0.5, 0.8, 1),
	"blue": Color(0.6, 0.6, 1),
	"violet": Color(0.8, 0.5, 1),
	"magenta": Color(1, 0.5, 1),
	"rose": Color(1, 0.5, 0.8)
}

static var FREQUENCIES: Array[Frequency] = _generate_frequencies()

static func _generate_frequencies() -> Array[Frequency]:
	var frequencies: Array[Frequency] = []
	
	# Generate frequencies using just intonation ratios
	for octave_index in range(BASE_FREQUENCIES.size()):
		var base_freq = BASE_FREQUENCIES[octave_index]
		
		# Calculate brightness modifier based on octave
		# Lower octaves are darker, higher octaves are brighter
		var brightness = 0.6 + (0.2 * octave_index) # Ranges from 0.6 to 1.0
		
		for i in range(12):
			var ratio = JUST_RATIOS.values()[i]
			var baseColor = RAINBOW_12.values()[i]
			
			var freq = base_freq * ratio
			var col = Color(
				baseColor.r * brightness,
				baseColor.g * brightness,
				baseColor.b * brightness
			)
			
			print("gen", i, " ", ratio, " ", freq)
			frequencies.append(Frequency.new(freq, col))
	return frequencies
