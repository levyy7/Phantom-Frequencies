class_name HighFrequencyPreference extends Preference

var cutoff = 660.0 # 7/12 and bove pass (perfect fifth)
var color = Color.NAVY_BLUE
var text = "Hi"
func fulfilled(frequencies) -> bool:
	var highfreqfound = false
	for freq in frequencies:
		if(freq.frequency>=cutoff):
			highfreqfound = true
	return highfreqfound
