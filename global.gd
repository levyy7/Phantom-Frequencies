extends Node

var note_names: Array[String] = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]
func maj(root: String, ct: int):
  var base = note_names.find(root)
  return note_names[base] + "," + note_names[(base + 4) % 12] + "," + note_names[(base + 7) % 12] + "," + str(ct)

var level0 = Level.create_level("level0", "Level 0: Pitches as frequencies
As you might already know, musical pitches correspond to frequencies of sound vibrations. Try to place notes such that all ghosts hear what they want to hear. 
Tip - Hover over ghosts to see their preference", ["A", "B", "C", "E", "G", ], ["Hi", "Lo", "Lo"], ["Hi", "Lo->Hi->Hi", "Lo->Lo->Hi", "Lo->Hi->Hi", "Lo->Lo->Hi"]) \
	.with_moves_per_round(4)
	
var level1 = Level.create_level("level1", "octaves are 2^n times frequency", ["A", "G"], ["Oc", "Oc", "2Oc"], ["Oc", "Oc", "2Oc", "Oc", "Oc", "2Oc"]) \
	.with_moves_per_round(3)
var level2 = Level.create_level("level2", "notes are roughly 440*2^(k/12)", note_names, ["A*2^(0/12)", "A*2^(4/12)", "A*2^(7/12)"], ["A*2^(0/12)", "A*2^(2/12)", "A*2^(4/12)", "A*2^(5/12)", "A*2^(7/12)"]) \
	.with_moves_per_round(3)

var level3 = Level.create_advanced_level("level3", "consonance, dissonance",
["C", "F", "G", "B"], ["Hi", "Lo", "Lo"], ["Hi", "Lo->Hi->Hi", "Lo->Lo->Hi", "Lo->Hi->Hi", "Lo->Lo->Hi"],
["Con", "Con", "Con", "Con", "Dis", "Dis", "Con", "Con"])
var level4 = Level.create_level("level4", "(X, X+k) is X and the note k semitones above it, eg 07 can be CG", note_names, ["I12", "I7", "I12"], ["I5", "I3->I8", "I9", "I11->I6", "I7", "I12"])

var level5 = Level.create_advanced_level("level5", "chords: >= 3 notes at a time. simple->complex = intensify, complex->simple = resolve",
  ["A", "B", "C", "D", "E", "F", "G"], ["C", "E", "F", "F"], ["C", "E", "G", "D"],
  [maj("C", 3), maj("C", 3), "F,A,C,3", "F,A,C,3", maj("G", 3), maj("G", 3), maj("C", 3), maj("C", 3)])
var level6 = Level.create_advanced_level("level6", "major vs minor chords",
  ["A", "B", "C", "D", "E", "F#", "G"], ["G", "B", "C", "E"], ["D", "F#", "A", "E"],
  ["maj", "maj", "maj", "maj", "min", "min", "maj", "maj"])
var level7 = Level.create_advanced_level("level7", "a sad song",
  ["A", "B", "C", "D", "E", "F", "G#"], ["A", "A", "A", "A"], ["A", "A", "A", "A"],
  ["min", "min", "min", "min", "maj", "maj", "min", "min"])

var level8 = Level.create_advanced_level("level8", "A major (is it happy?)",
  ["C#", "A", "B", "D", "E", "F#", "G#"], ["A", "Hi", "Lo", "Lo->Hi"], ["Oc", "Hi", "E->G#", "E"],
  ["", "", "A,C#,E,1", "E,G#,B,1", "", "", "E,G#,B,1", "A,C#,E,1"])
var level9 = Level.create_advanced_level("level9", "A minor (is it sad?)",
  ["A", "B", "C", "D", "E", "F", "G#"], ["A", "Hi", "Lo", "Lo->Hi"], ["Oc", "Hi", "E->G#", "E"],
  ["", "", "A,C,E,1", "E,G#,B,1", "", "", "E,G#,B,1", "A,C,E,1"])
var level10 = Level.create_advanced_level("level10", "G major",
  ["A", "B", "C", "D", "E", "F#", "G"], ["A", "Hi", "A*2^(7/12)", "Lo->Hi"], ["Oc", "I6", "D->C", "Hi"],
  ["Con", "Con", maj("G", 1), "D,F#,A,1", "Dis", "Dis", "D,F#,A,C,1", maj("G", 1)])
var level11 = Level.create_advanced_level("level11", "G major again",
  ["A", "B", "C", "D", "E", "F#", "G"], ["Hi", "Hi", "Lo", "Lo->Hi"], ["Lo", "Hi", "Lo", "Lo"],
  ["Con", "Con", "Con", "Con", "Dis", "Dis", maj("C", 3), maj("G", 3)])
var level12 = Level.create_advanced_level("level12", "E minor",
  ["A", "B", "C", "D#", "E", "F#", "G"], ["Hi", "Hi", "Lo", "Lo->Hi"], ["Lo", "Hi", "Lo", "Lo"],
  ["Con", "Con", "Con", "Con", "Dis", "Dis", "B,D#,F#,3", "E,G,B,3"])

var levelTest = Level.create_level("levelT", "", note_names, ["A", "A#", "E"], ["Hi", "Oc->Hi->Hi", "Lo->Lo->Hi", "Lo->Hi->Hi", "Lo->Lo->Hi"])
var levelTest2 = Level.create_level("levelT", "", note_names, ["Lo"], ["Hi", "Lo->Hi", "Hi->Lo->Lo", "A", "A->E", "A->C", "A->C->E", "I3", "I7", "I3->C->Hi"])

var levels = [level0, level1, level2, level3, level4, level5, level6, level7, level8, level9, level10, level11]

var currentLevel = null
var lives = 3
var win = false
var hovered_tower_group = null
