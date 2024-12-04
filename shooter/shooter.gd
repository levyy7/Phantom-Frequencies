class_name Shooter
extends Node2D


const bullet_scene = preload("res://enemy/Bullet.tscn")
var spawn_timer: float = 0.0
const SPAWN_INTERVAL: float = 0.5
const BULLET_SPEED: float = 1400.0

var damage = 50

func _process(delta: float) -> void:
	pass

func spawn_bullet(target: Node2D) -> void:
	var bullet = bullet_scene.instantiate()
	
	var angle = global_position.angle_to_point(target.global_position)

	# TODO: actually make sure that the parent rotation is 0, else this doesn't work since angle is in global coordinates
	# angle only equals local rotation if parent rotation is 0
	bullet.global_rotation = angle
	bullet.position = Vector2(cos(angle), sin(angle)) * (bullet.length / 2 + 10.0)
	
	var velocity = Vector2(cos(angle), sin(angle)) * BULLET_SPEED
	bullet.set_meta("velocity", velocity)
	
	$shooter_circle.rotation = angle
	
	#rotation += angle
	
	add_child(bullet)
