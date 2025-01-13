class_name Level
var name: String
var description: String
var notes: Array[String]
var inital_preferences
var upcoming_preferences
static var note_names = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]
func fromTextToPreferenceList(text: String) -> Array[Preference]:
	var preferences: Array[Preference] = []
	for pref in text.split("->"):
		if pref == "Hi":
			preferences.append(HighFrequencyPreference.new())
		elif pref == "Lo":
			preferences.append(LowFrequencyPreference.new())
		elif pref == "Oc":
			preferences.append(OctavePreference.new(1))
		elif pref == "2Oc":
			preferences.append(OctavePreference.new(2))
		elif pref in note_names:
			var notePref = NotePreference.new()
			notePref.init(pref)
			preferences.append(notePref)
		elif pref[0] == "I":
			var interval = int(pref.right(-1))
			var intPref = IntervalPreference.new()
			intPref.init(interval)
			preferences.append(intPref)
		elif pref.begins_with("A*2^("):
			var notePref = NotePreference.new()
			var semitones_above = pref.substr(5, pref.find("/") - 5)
			notePref.initWithTxt(note_names[int(semitones_above)], pref)
			preferences.append(notePref)

	return preferences

func getInitialGhosts():
	var ghosts = []
	for preferences in inital_preferences:
		preferences = fromTextToPreferenceList(preferences)
		var newEnemy = Enemy.create_enemy(preferences)
		ghosts.append(newEnemy)
	return ghosts

func getUpcomingGhosts():
	var ghosts = []
	for preferences in upcoming_preferences:
		preferences = fromTextToPreferenceList(preferences)
		var newEnemy = Enemy.create_enemy(preferences)
		ghosts.append(newEnemy)
	return ghosts
	
static func create_level(name: String, description: String, notes: Array[String],
						inital_preferences: Array[String], upcoming_preferences: Array[String]) -> Level:
	var level: Level = Level.new()
	level.name = name
	level.description = description
	level.notes = notes
	level.inital_preferences = inital_preferences
	level.upcoming_preferences = upcoming_preferences
	return level
