class_name Level
var name: String
var description:String
var tiles:int
var inital_preferences
var upcoming_preferences
func fromTextToPreferenceList(text):
	var preferences = []
	for pref in text.split("->"):
		if pref == "Hi":
			preferences.append(HighFrequencyPreference.new())
		if pref == "Lo":
			preferences.append(LowFrequencyPreference.new())
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
	
static func create_level(name,description,tiles,inital_preferences,upcoming_preferences) -> Level:
	var level: Level = Level.new()
	level.name = name
	level.description = description
	level.tiles = tiles
	level.inital_preferences = inital_preferences
	level.upcoming_preferences = upcoming_preferences
	return level
