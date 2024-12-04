class_name GrassTile
extends Node2D

@onready var tower_slot_group = $TowerSlots


func compute_damage():
	var tower_slots = get_child(0)
	return tower_slots.chord_damage()
