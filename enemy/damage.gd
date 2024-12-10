class_name Damage
extends RefCounted

var damage: int
var freq: Frequency

func _init(d: int, f: Frequency):
    damage = d
    freq = f

