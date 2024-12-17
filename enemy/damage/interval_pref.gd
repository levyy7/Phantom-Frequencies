class_name IntervalPreference extends Preference

var color = Color.GREEN_YELLOW
var text = "I"
var interval = 0
var description=""
func fulfilled(frequencies) -> bool:
	if len(frequencies)==2:
		var bigger=max(frequencies[0].frequency,frequencies[1].frequency)
		var smaller=min(frequencies[0].frequency,frequencies[1].frequency)
		return round(12*log((bigger/smaller))/log(2.0))==interval
		
	return false



func init(intervalSize):
	description="A interval of "+str(intervalSize)+" semitones"
	interval=intervalSize
	text="I"+str(interval)
	
