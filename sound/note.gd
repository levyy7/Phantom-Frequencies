class_name Note
extends RefCounted

var name: String
var octave: int

func _init(name: String, octave: int) -> void:
	self.name = name
	self.octave = octave
