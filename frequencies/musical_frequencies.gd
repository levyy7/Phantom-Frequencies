class_name MusicalFrequencies

# Constants for music theory calculations
const BASE_FREQUENCIES = [220.0, 440.0, 880.0] # A4 note in Hz

# Just intonation ratios based on harmonic series
# These represent the purest mathematical ratios between notes
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
	"minor_seventh": 9.0 / 5, # 9:5    - G
	"major_seventh": 15.0 / 8, # 15:8   - G#
	# "perfect_octave": 2.0 # 2:1    - A
}

static var FREQUENCIES: Array[Frequency] = _generate_frequencies()

static func _generate_frequencies() -> Array[Frequency]:
	var frequencies: Array[Frequency] = []
	
	# Generate frequencies using just intonation ratios
	for BASE_FREQUENCY in BASE_FREQUENCIES:
		for ratio in JUST_RATIOS.values():
			var freq = BASE_FREQUENCY * ratio
			frequencies.append(Frequency.new(freq))
	
	return frequencies

# below not used atm
# Optional: Add method to get frequency by interval name
# static func get_frequency_by_interval(interval_name: String) -> float:
# 	if JUST_RATIOS.has(interval_name):
# 		return BASE_FREQUENCY * JUST_RATIOS[interval_name]
# 	return 0.0
