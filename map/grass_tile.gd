class_name GrassTile
extends Node2D

@onready var tower_slot_group = $TowerSlots

var pref: PathwayPreference = null
func setPref(preference: PathwayPreference) -> void:
	pref = preference

var is_mouse_inside = false

func _ready():
	$"DescriptionPanel/DescriptionText".text = ""
	$TowerSlots.hovered.connect(_on_hovered)
	$TowerSlots.unhovered.connect(_on_unhovered)
	
			
func _on_hovered():
	if pref:
		$DescriptionPanel.visible=true
		$"DescriptionPanel/DescriptionText".text = pref.description
		print(pref.description)

func _on_unhovered():
	$DescriptionPanel.visible=false
	

func pathwayPreferenceFulfilled() -> bool:
	if pref == null:
		return true
	elif pref is IntervalQualityPreference:
		return pref.fulfilled(tower_slot_group.getGroupFrequencies())
	else:
		return pref.fulfilled(tower_slot_group.getGroupNoteNames())
