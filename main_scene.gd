class_name MainScene
extends Node2D

@onready var targeting: EnemyList = $Track/EnemyList

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tower_slots = find_children("*", "TowerSlotGroup", false)
	
	for tower_slot in tower_slots:
		tower_slot.targeting = self.targeting
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
