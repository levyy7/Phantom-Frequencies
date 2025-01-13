class_name PathwayPreference

var text: String
var description: String

# values is either an array of frequencies or an array of note names
func fulfilled(values) -> bool:
	assert(false, "Preference should implement fulfilled")

	return false
