extends Panel

var text1 = "[center]You cannot place more notes this turn 
(0 placements remaining).[/center]"
var text2 = "[center]Please select a empty instrument to 
start adding notes![/center]"
@onready var label = $Label
var current_slot: TowerSlot = null

var actions_remaing = true
var is_tower_slot_selected = false
var is_tower_slot_empty = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = text2


func current_slot_updated(slot: TowerSlot, moves_remaining: int, usedSlotsRound: Array[TowerSlot]) -> void:
	self.current_slot = slot
	if slot == null:
		self.visible = true
		label.text=text2
	else:
		moves_remaining_updated(moves_remaining, usedSlotsRound)
		
func moves_remaining_updated(moves_remaining: int, usedSlotsRound: Array[TowerSlot]) -> void:
	if moves_remaining == 0 and not (current_slot in usedSlotsRound):
		self.visible = true
		label.text=text1
	else:
		self.visible = false
