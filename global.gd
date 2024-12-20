extends Node

var level0 = Level.create_level("level0","introduces pitches",8,["Hi","Lo","Lo"],["Hi","Lo->Hi->Hi","Lo->Lo->Hi","Lo->Hi->Hi","Lo->Lo->Hi"])
var levelTest = Level.create_level("levelT","",8,["A","A#","E"],["Hi","Oc->Hi->Hi","Lo->Lo->Hi","Lo->Hi->Hi","Lo->Lo->Hi"])
var levelTest2 = Level.create_level("levelT","",8,["Lo"],["Hi","Lo->Hi","Hi->Lo->Lo","A","A->E","A->C","A->C->E","I3","I7","I3->C->Hi"])

var levels = [level0,levelTest,levelTest2]

var currentLevel = null
var lives = 3
var win = false
