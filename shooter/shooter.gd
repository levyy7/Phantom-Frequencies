class_name Shooter
extends Node2D

const bullet_scene = preload("res://enemy/Bullet.tscn")
var spawn_timer: float = 0.0
const SPAWN_INTERVAL: float = 0.5
const BULLET_SPEED: float = 1400.0

var damage = 50

static var FREQUENCIES: Array[Frequency] = [
	# TODO: replace with actual musical frequencies
	Frequency.new(0.1),
	Frequency.new(0.2),
	Frequency.new(0.3),
	Frequency.new(0.4),
	Frequency.new(0.5),
]

var current_frequency_index = 0

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()  # Ensure the circle is always drawn

func _draw() -> void:
	var freq = FREQUENCIES[current_frequency_index]

	# Draw a circle at the spawner's position
	var radius = 20  # Adjust size as needed
	draw_circle(Vector2.ZERO, radius, freq.color)
	draw_line(Vector2.ZERO, Vector2(radius, 0), Color.BLACK, 2.5)


func spawn_bullet(target: Node2D) -> void:
	var bullet = bullet_scene.instantiate()
	
	var angle = global_position.angle_to_point(target.global_position)
	
	# TODO: actually make sure that the parent rotation is 0, else this doesn't work since angle is in global coordinates
	# angle only equals local rotation if parent rotation is 0
	bullet.global_rotation = angle
	
	var velocity = Vector2(1, 0) * BULLET_SPEED
	bullet.set_meta("velocity", velocity)
	
	rotation = angle
	
	add_child(bullet)

func next_frequency() -> bool:
	# Sets the current frequency to the next frequency in the list
	# If no more frequencies to set, returns False to signal that the shooter should be removed
	# Otherwise, returns True to signal that the shooter should remain
	if current_frequency_index < FREQUENCIES.size() - 1:
		current_frequency_index += 1
		return true
	else:
		return false
