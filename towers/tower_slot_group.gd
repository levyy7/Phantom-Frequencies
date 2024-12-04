class_name TowerSlotGroup
extends Node2D

func tower_slot_children() -> Array[TowerSlot]:
	var tower_slots: Array[TowerSlot] = []
	for node in get_children():
		if node is TowerSlot:
			tower_slots.append(node)
	return tower_slots
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func shoot_bullets(target: PathTile):
	for node: TowerSlot in tower_slot_children():
		node.shoot_bullet(target)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
