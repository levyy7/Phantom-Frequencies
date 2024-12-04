class_name TowerSlotGroup
extends Node2D


func chord_damage():
	print("Playing")
	var total_damage = 0
	
	for node: TowerSlot in get_children():
		total_damage += node.tower_damage()
	
	return total_damage
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func shoot_bullets(target: PathTile):
	for node: TowerSlot in get_children():
		node.shoot_bullet(target)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
