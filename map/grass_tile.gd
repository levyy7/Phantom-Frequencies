class_name GrassTile
extends Node2D

@onready var tower_slot_group = $TowerSlots

var pref: PathwayPreference = null

func setPref(preference: PathwayPreference) -> void:
	pref = preference
	$"ShortLabel/DescriptionText".set_meta("original_text", pref.text)
	$"ShortLabel/DescriptionText".text = "[center]%s[/center]" % pref.text
	$"ShortLabel".visible = true
	_recheck_chord_satisfied(null)

var is_mouse_inside = false

func _ready():
	$"DescriptionPanel/DescriptionText".text = ""
	$"ShortLabel/DescriptionText".text = ""
	$ShortLabel.visible = false
	$DescriptionPanel.visible = false
	
	$TowerSlots.hovered.connect(_on_hovered)
	$TowerSlots.unhovered.connect(_on_unhovered)
	
	$ShortLabel.mouse_entered.connect(_on_hovered)
	$ShortLabel.mouse_exited.connect(_on_unhovered)
	
	$TowerSlots.shooter_frequency_updated.connect(_recheck_chord_satisfied)
	

func _recheck_chord_satisfied(_child: TowerSlot):
	var rich_text: RichTextLabel = $"ShortLabel/DescriptionText"
	var original_text = rich_text.get_meta("original_text")
	if _child != null && pathwayPreferenceFulfilled():
		rich_text.clear()
		rich_text.push_color(Color.GREEN)
		rich_text.add_text(original_text)
		rich_text.pop()
		rich_text.tooltip_text = "%s not satisfied" % original_text
	else:
		var bad_color = Color(1, 0.35, 0.36)
		rich_text.clear()
		rich_text.push_color(bad_color)
		rich_text.add_text(original_text)
		rich_text.pop()
		rich_text.tooltip_text = "%s satisfied" % original_text
		
		
			
func _on_hovered():
	if pref:
		$DescriptionPanel.visible = true
		$"DescriptionPanel/DescriptionText".text = pref.description

func _on_unhovered():
	$DescriptionPanel.visible = false
	

func pathwayPreferenceFulfilled() -> bool:
	if pref == null:
		return true
	elif pref is ChordPreference:
		return pref.fulfilled(tower_slot_group.getGroupNoteNames())
	else:
		return pref.fulfilled(tower_slot_group.getGroupFrequencies())
		
