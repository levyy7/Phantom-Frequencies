extends Panel

var text1 = "You cannot place more notes this turn 
(0 placements remaining)."
var text2 = "Please select a empty instrument to 
start adding notes!"
@onready var mainScene = get_tree().get_root().get_node("MainScene")
@onready var towerui = get_tree().get_root().get_node("MainScene").get_node("UI frame").get_node("TowerUI")
@onready var label = $Label

var actions_remaing = true
var is_tower_slot_selected = false
var is_tower_slot_empty = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.visible = false
	if(not towerui.currentSlot):
		self.visible = true
		label.text=text2
	elif(mainScene.moves_remaining==0 and not towerui.currentSlot.has_shooter()):
		self.visible = true
		label.text=text1
