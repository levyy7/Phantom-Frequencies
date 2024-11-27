class_name TowerSlotGroup
extends Node2D

@onready var targeting: EnemyList = %Track/EnemyList:
	set(v):
		# Have to propagate the change to all the children
		targeting = v
		for child in get_children():
			child.targeting = v

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(targeting != null)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
