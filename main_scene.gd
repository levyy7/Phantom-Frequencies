class_name MainScene
extends Node2D

@onready var targeting: EnemyList = $Track/EnemyList


func _on_paused():
	$SlotGroup1.get_tree().paused = true
	$"UI frame/PauseButton".text = "Resume"
	#for child in get_children():
		#if child.is_in_group("pausable"):
			#print("Setting", child, "paused")
			#child.get_tree().paused = true

func _on_unpaused():
	$"UI frame/PauseButton".text = "Pause"
	
	for child in get_children():
		if child.is_in_group("pausable"):
			child.get_tree().paused = false

func _ready() -> void:
	var tower_slots = find_children("*", "TowerSlotGroup", false)
	
	for tower_slot in tower_slots:
		tower_slot.targeting = self.targeting


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pause_button_toggled(toggled_on: bool) -> void:
	print(toggled_on)
	if toggled_on:
		_on_paused()
	else:
		_on_unpaused()
