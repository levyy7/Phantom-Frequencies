@tool
extends Node2D

@export var spawn_test_bullet: bool = false:
	set(value):
		spawn_test_bullet = value
		if Engine.is_editor_hint() and value:
			spawn_bullet()
			spawn_test_bullet = false

const bullet_scene = preload("res://Bullet.tscn")
var spawn_timer: float = 0.0
const SPAWN_INTERVAL: float = 0.5
const BULLET_SPEED: float = 600.0

func _process(delta: float) -> void:
	if not Engine.is_editor_hint():  # Only spawn bullets in game mode
		spawn_timer += delta
		
		if spawn_timer >= SPAWN_INTERVAL:
			spawn_bullet()
			spawn_timer = 0.0
	
	

func spawn_bullet() -> void:
	var bullet = bullet_scene.instantiate()
	
	var random_angle = randf_range(0, PI * 2.0)
	bullet.rotation = random_angle
	bullet.position = Vector2(cos(random_angle), sin(random_angle)) * (bullet.length / 2 + 10.0)
	
	var velocity = Vector2(cos(random_angle), sin(random_angle)) * BULLET_SPEED
	bullet.set_meta("velocity", velocity)
	print("Velocity", velocity)
	
	$shooter_circle.rotation = random_angle
	
	#rotation += random_angle
	
	add_child(bullet)
