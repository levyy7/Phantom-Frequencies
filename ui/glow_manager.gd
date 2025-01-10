# glow_manager.gd
class_name GlowManager
extends Node

const GLOW_BASE_COLOR := Color(0.11764, 0.11764, 0.11764, 1)  # Original dark brown
const GLOW_HIGHLIGHT_COLOR := Color(0.18, 0.14, 0.06, 1)  # Subtle dark orange
const GLOW_DURATION := 1.25
const GLOW_TRANS_TYPE := Tween.TRANS_SINE
const GLOW_EASE_TYPE := Tween.EASE_IN_OUT

var _glow_tween: Tween
var _target_rect: ColorRect

func _init(target: ColorRect) -> void:
	_target_rect = target
	_target_rect.color = GLOW_BASE_COLOR

func start_glow() -> void:
	if _glow_tween:
		_glow_tween.kill()
	
	_glow_tween = create_tween().set_loops()
	_glow_tween.tween_property(
		_target_rect,
		"color",
		GLOW_HIGHLIGHT_COLOR,
		GLOW_DURATION / 2
	).set_trans(GLOW_TRANS_TYPE).set_ease(GLOW_EASE_TYPE)
	
	_glow_tween.tween_property(
		_target_rect,
		"color",
		GLOW_BASE_COLOR,
		GLOW_DURATION / 2
	).set_trans(GLOW_TRANS_TYPE).set_ease(GLOW_EASE_TYPE)

func stop_glow() -> void:
	if _glow_tween:
		_glow_tween.kill()
	_target_rect.color = GLOW_BASE_COLOR
