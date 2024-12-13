class_name Ghost
extends Node2D

static var ghost_scene: PackedScene = preload("res://enemy/Ghost.tscn")

# Animation parameters
const ANIMATION_DURATION: float = 0.65
const FLOAT_HEIGHT: float = 150.0
const FLOAT_X_VARIANCE: float = 50.0
const ROTATION_VARIANCE: float = 0.5
const SCALE_EFFECT: float = 1.2

signal done_animation

static func new_with_color(enemy_color: Color) -> Ghost:
	var ghost = ghost_scene.instantiate() as Ghost
	
	# Use a slightly lighter version of the enemy color for ghostly effect
	var ghost_color = enemy_color
	ghost_color.a = 0.7  # Make it slightly transparent
	ghost.get_node("GhostShape").color = ghost_color
	
	return ghost
	
func start_animation() -> void:
	# Create new tween
	var current_tween := create_tween()
	current_tween.set_parallel(true)
	
	# Calculate final position with random X offset
	var random_x = randf_range(-FLOAT_X_VARIANCE, FLOAT_X_VARIANCE)
	var final_position = position + Vector2(random_x, -FLOAT_HEIGHT)
	
	# Move up and fade out
	current_tween.tween_property(self, "position", final_position, ANIMATION_DURATION)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUAD)
	
	# Fade out with scale effect
	current_tween.tween_property(self, "modulate:a", 0.0, ANIMATION_DURATION)\
		.set_ease(Tween.EASE_IN)
	current_tween.tween_property(self, "scale", Vector2(SCALE_EFFECT, SCALE_EFFECT), ANIMATION_DURATION)\
		.set_ease(Tween.EASE_IN)
	
	# Add slight rotation
	var random_rotation = randf_range(-ROTATION_VARIANCE, ROTATION_VARIANCE)
	current_tween.tween_property(self, "rotation", random_rotation, ANIMATION_DURATION)\
		.set_ease(Tween.EASE_IN_OUT)
	
	# Cleanup
	current_tween.finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
	done_animation.emit()
	queue_free()
