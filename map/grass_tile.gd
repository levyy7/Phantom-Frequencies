class_name GrassTile
extends Node2D

@onready var tower_slot_group = $TowerSlots

var pref: PathwayPreference = null
func setPref(preference: PathwayPreference) -> void:
	pref = preference

func pathwayPreferenceFulfilled() -> bool:
	if pref == null:
		return true
	elif pref is IntervalQualityPreference:
		return pref.fulfilled(tower_slot_group.getGroupFrequencies())
	else:
		return pref.fulfilled(tower_slot_group.getGroupNoteNames())
