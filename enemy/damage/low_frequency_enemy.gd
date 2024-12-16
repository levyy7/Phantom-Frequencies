class_name LowFrequencyPreference extends Preference

var cutoff = 660.0 # 7/12 and bove pass (perfect fifth)
var color = Color.ROSY_BROWN
var text = "Lo"
func fulfilled(frequencies) -> bool:
	var highfreqfound = false
	for freq in frequencies:
		if(freq.frequency<cutoff):
			highfreqfound = true
	return highfreqfound
