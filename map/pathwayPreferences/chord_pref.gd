class_name ChordPreference extends PathwayPreference

var color = Color.GREEN_YELLOW
var chord: Array[String]
var minSize = 0
func fulfilled(note_names) -> bool:
	if len(note_names) < minSize:
		return false
	for name in note_names:
		if !chord.has(name):
			return false
	return true


func _init(chord_notes: Array[String], size: int) -> void:
	chord = chord_notes
	minSize = size
	text = "Chord"
	description = ">= " + str(size) + " notes of this chord: " + ", ".join(chord_notes)
