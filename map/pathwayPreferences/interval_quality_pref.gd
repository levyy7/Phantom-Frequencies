class_name IntervalQualityPreference extends PathwayPreference

var color = Color.GREEN_YELLOW
var intervalSizes: Array[int]
func fulfilled(frequencies: Array[Frequency]) -> bool:
	if len(frequencies) == 2:
		var bigger = max(frequencies[0].frequency, frequencies[1].frequency)
		var smaller = min(frequencies[0].frequency, frequencies[1].frequency)
		var diff = int(round(12 * log((bigger / smaller)) / log(2.0))) 
		return intervalSizes.has(diff)
	return false


func _init(consonance: bool) -> void:
	if consonance:
		text = "Con"
		description = "A consonant interval with a simple harmonograph. Exactly two notes 5, 7, or 12 semitones apart. These form ratios 3:4, 2:3, 1:2."
		intervalSizes = [5, 7, 12]
	else:
		text = "Dis"
		description = "A dissonant interval with a complex harmonograph. Exactly two notes 6 or 11 semitones apart. These form ratios [insert #TODO]."
		intervalSizes = [6, 11]
