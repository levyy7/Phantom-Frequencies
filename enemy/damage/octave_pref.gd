class_name OctavePreference extends Preference

var color = Color.GREEN_YELLOW
var text: String
var description: String
var dist: int
func _init(dist_val: int) -> void:
	dist = dist_val
	text = str(dist) + "Oc"
	description = "Two notes " + str(dist) + " octaves apart"

func fulfilled(frequencies) -> bool:
	if len(frequencies) == 2:
		if frequencies[0].frequency / frequencies[1].frequency == pow(2, dist) or frequencies[1].frequency / frequencies[0].frequency == pow(2, dist):
			return true
	return false