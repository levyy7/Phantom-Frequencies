class_name ChordQualityPref extends PathwayPreference

var color = Color.GREEN_YELLOW
var semitones: Array[int]

func fulfilled(frequencies) -> bool:
	if len(frequencies) != 3:
		return false
	frequencies.sort()
	var root = frequencies[0]
	for i in range(1, len(frequencies)):
		if round(12 * log((frequencies[i] / root)) / log(2.0)) != semitones[i]:
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
		description = "A " + text + ": a chord of form" + ", ".join(semitones)
