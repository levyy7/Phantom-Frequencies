class_name GlowManager
extends Node

const GLOW_BRIGHTNESS_FACTOR := 1.5  # Multiplier for the highlight color
const GLOW_DURATION := 1.25
const GLOW_TRANS_TYPE := Tween.TRANS_SINE
const GLOW_EASE_TYPE := Tween.EASE_IN_OUT

var _glow_tween: Tween
var _target_rect: ColorRect
var _base_color: Color
var _highlight_color: Color

func _init(target: ColorRect) -> void:
	_target_rect = target
	# Store the original color as base
	_base_color = target.color
	# Create highlight color by brightening the base color
	_highlight_color = _base_color * GLOW_BRIGHTNESS_FACTOR
	# Ensure alpha remains unchanged
	_highlight_color.a = _base_color.a

func start_glow() -> void:
	if _glow_tween:
		_glow_tween.kill()
	
	_glow_tween = create_tween().set_loops()
	_glow_tween.tween_property(
		_target_rect,
		"color",
		_highlight_color,
		GLOW_DURATION / 2
	).set_trans(GLOW_TRANS_TYPE).set_ease(GLOW_EASE_TYPE)
	
	_glow_tween.tween_property(
		_target_rect,
		"color",
		_base_color,
		GLOW_DURATION / 2
	).set_trans(GLOW_TRANS_TYPE).set_ease(GLOW_EASE_TYPE)

func stop_glow() -> void:
	if _glow_tween:
		_glow_tween.kill()
	_target_rect.color = _base_color
