class_name MainScene
extends Node2D

@onready var targeting: EnemyList = $Track/EnemyList

var tower_slots: Array[TowerSlotGroup]

var is_paused: bool = true

func play_one_round():
	# reset the enemy's bullet
	print("Playing one round")
	for tower_slot in tower_slots:
		tower_slot.play_one_round()
		
	$Track.advance_enemies()
	

func _ready() -> void:
	var tower_slots_unchecked = find_children("*", "TowerSlotGroup", false)
	
	for tower_slot in tower_slots_unchecked:
		assert (tower_slot is TowerSlotGroup)
		tower_slot.targeting = self.targeting
		tower_slots.append(tower_slot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_round_button_toggled(toggled_on: bool) -> void:
	play_one_round()


func _on_next_round_button_pressed() -> void:
	play_one_round()
