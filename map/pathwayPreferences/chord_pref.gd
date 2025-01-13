class_name ChordPreference extends PathwayPreference

var color = Color.GREEN_YELLOW
var chord: Array[String]
func fulfilled(note_names) -> bool:
	for name in note_names:
		if !chord.has(name):
			return false
	return true


func _init(chord_notes: Array[String]) -> void:
	chord = chord_notes
