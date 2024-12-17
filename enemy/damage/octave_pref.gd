class_name OctavePreference extends Preference

var color = Color.GREEN_YELLOW
var text = "Oc"
var description="Two notes one octave apart"
func fulfilled(frequencies) -> bool:
	if len(frequencies)==2:
		if frequencies[0].frequency/frequencies[1].frequency==2 or frequencies[1].frequency/frequencies[0].frequency==2:
			return true
	return false
