extends Node

var note_names: Array[String] = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]

var level0 = Level.create_level("level0", "introduces pitches", ["A", "C", "E", "G", "B"], ["Hi", "Lo", "Lo"], ["Hi", "Lo->Hi->Hi", "Lo->Lo->Hi", "Lo->Hi->Hi", "Lo->Lo->Hi"])
var level1 = Level.create_level("level1", "octaves are 2^n times frequency", ["A", "G"], ["Oc", "Oc", "2Oc"], ["Oc", "Oc", "2Oc", "Oc", "Oc", "2Oc"])
var level2 = Level.create_level("level2", "notes are roughly 440*2^(k/12)", note_names, ["A*2^(0/12)", "A*2^(4/12)", "A*2^(7/12)"], ["A*2^(0/12)", "A*2^(2/12)", "A*2^(4/12)", "A*2^(5/12)", "A*2^(7/12)"])
# var level3 = Level.create_level("level0", "introduces pitches", 8, ["Hi", "Lo", "Lo"], ["Hi", "Lo->Hi->Hi", "Lo->Lo->Hi", "Lo->Hi->Hi", "Lo->Lo->Hi"])

var levelTest = Level.create_level("levelT", "", note_names, ["A", "A#", "E"], ["Hi", "Oc->Hi->Hi", "Lo->Lo->Hi", "Lo->Hi->Hi", "Lo->Lo->Hi"])
var levelTest2 = Level.create_level("levelT", "", note_names, ["Lo"], ["Hi", "Lo->Hi", "Hi->Lo->Lo", "A", "A->E", "A->C", "A->C->E", "I3", "I7", "I3->C->Hi"])

var levels = [levelTest, levelTest2, level0, level1, level2]

var currentLevel = null
var lives = 3
var win = false
