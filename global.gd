extends Node

var note_names: Array[String] = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]

var level0 = Level.create_level("level0", "introduces pitches", ["A", "C", "E", "G", "B"], ["Hi", "Lo", "Lo"], ["Hi", "Lo->Hi->Hi", "Lo->Lo->Hi", "Lo->Hi->Hi", "Lo->Lo->Hi"])
var level1 = Level.create_level("level1", "octaves are 2^n times frequency", ["A", "G"], ["Oc", "Oc", "2Oc"], ["Oc", "Oc", "2Oc", "Oc", "Oc", "2Oc"])
var level2 = Level.create_level("level2", "notes are roughly 440*2^(k/12)", note_names, ["A*2^(0/12)", "A*2^(4/12)", "A*2^(7/12)"], ["A*2^(0/12)", "A*2^(2/12)", "A*2^(4/12)", "A*2^(5/12)", "A*2^(7/12)"])

var level3 = Level.create_advanced_level("level3", "consonance, dissonance", ["C", "F", "G", "B"], ["Hi", "Lo", "Lo"], ["Hi", "Lo->Hi->Hi", "Lo->Lo->Hi", "Lo->Hi->Hi", "Lo->Lo->Hi"], ["Con", "Con", "Dis", "Con"])
var level4 = Level.create_level("level4", "(X, X+k) is X and the note k semitones above it, eg 07 can be CG", note_names, ["I12", "I7", "I12"], ["I5", "I3->I8", "I9", "I11->I6", "I7", "I12"])

var level5 = Level.create_advanced_level("level5", "chords: 3 notes at a time", note_names, ["C", "C", "C", "C"], ["C", "C", "C", "C"], ["C,E,G,3", "F,A,C,3", "D,B,G,3", "C,E,G,3"])
var level6 = Level.create_advanced_level("level6", "major vs minor chords", note_names, ["C", "C", "C", "C"], ["C", "C", "C", "C"], ["maj", "maj", "min", "maj"])
var level7 = Level.create_advanced_level("level7", "a sad song", note_names, ["C", "C", "C", "C"], ["C", "C", "C", "C"], ["min", "min", "maj", "min"])

var levelTest = Level.create_level("levelT", "", note_names, ["A", "A#", "E"], ["Hi", "Oc->Hi->Hi", "Lo->Lo->Hi", "Lo->Hi->Hi", "Lo->Lo->Hi"])
var levelTest2 = Level.create_level("levelT", "", note_names, ["Lo"], ["Hi", "Lo->Hi", "Hi->Lo->Lo", "A", "A->E", "A->C", "A->C->E", "I3", "I7", "I3->C->Hi"])

var levels = [levelTest, levelTest2, level0, level1, level2, level3, level4, level5, level6, level7]

var currentLevel = null
var lives = 3
var win = false
var hovered_tower_group = null
