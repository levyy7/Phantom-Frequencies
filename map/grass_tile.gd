class_name GrassTile
extends Node2D

@onready var tower_slot_group = $TowerSlots

var pref: PathwayPreference = null

func setPref(preference: PathwayPreference) -> void:
	print("Setting preference")
	pref = preference
	$"ShortLabel/DescriptionText".text = pref.text
	$"ShortLabel".visible = true

var is_mouse_inside = false

func _ready():
	$"DescriptionPanel/DescriptionText".text = ""
	$"ShortLabel/DescriptionText".text = ""
	$TowerSlots.hovered.connect(_on_hovered)
	$TowerSlots.unhovered.connect(_on_unhovered)
	
	$TowerSlots.shooter_frequency_updated.connect(_recheck_chord_satisfied)

func _recheck_chord_satisfied(_child: TowerSlot):
	var rich_text: RichTextLabel = $"ShortLabel/DescriptionText"
	var original_text = rich_text.text
	if pathwayPreferenceFulfilled():
		rich_text.clear()
		rich_text.push_color(Color.GREEN)
		rich_text.add_text(original_text)
		rich_text.pop()
	else:
		rich_text.clear()
		rich_text.push_color(Color.WHITE)
		rich_text.add_text(original_text)
		rich_text.pop()
		
			
func _on_hovered():
	if pref:
		$DescriptionPanel.visible = true
		$"DescriptionPanel/DescriptionText".text = pref.description
		print(pref.description)

func _on_unhovered():
	$DescriptionPanel.visible = false
	

func pathwayPreferenceFulfilled() -> bool:
	print("preference", pref, tower_slot_group.getGroupNoteNames())
	if pref == null:
		return true
	elif pref is IntervalQualityPreference:
		return pref.fulfilled(tower_slot_group.getGroupFrequencies())
	else:
		return pref.fulfilled(tower_slot_group.getGroupNoteNames())
