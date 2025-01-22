class_name ChordQualityPref extends PathwayPreference

var color = Color.GREEN_YELLOW
var semitones: Array[int]

func fulfilled(frequencies: Array[Frequency]) -> bool:
	if len(frequencies) != 3:
		return false

	frequencies.sort_custom(Frequency.custom_sort)
	var root = frequencies[0].frequency
	for i in range(1, len(frequencies)):
		var freq = frequencies[i].frequency
		if round(12 * log((freq / root)) / log(2.0)) != semitones[i]:
			return false
	return true

func _init(kind: String) -> void:
	semitones = []
	if kind == "maj":
		text = "Major Triad"
		semitones = [0, 4, 7]
	elif kind == "min":
		text = "Minor Triad"
		semitones = [0, 3, 7]
	description = "A " + text + ": a chord of form " + ", ".join(semitones)
