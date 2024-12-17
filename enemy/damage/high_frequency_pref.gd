class_name HighFrequencyPreference extends Preference

var cutoff = 660.0 # 7/12 and bove pass (perfect fifth)
var color = Color.NAVY_BLUE
var text = "Hi"
var description="A high frequency (>=660hz)"
func fulfilled(frequencies) -> bool:
	for freq in frequencies:
		if(freq.frequency>=cutoff):
			return true
	return false
