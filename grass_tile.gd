extends Node2D


func compute_damage():
	var tower_slots = get_child(0)
	return tower_slots.chord_damage()
