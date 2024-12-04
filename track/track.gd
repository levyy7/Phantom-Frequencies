class_name Track
extends ColorRect

@onready var enemy_list = $EnemyList


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rect_size = size
	var rect_position = Vector2.ZERO
	
	# Create a new curve for the Path2D
	var curve = Curve2D.new()
	
	# Add points to follow the rectangle's perimeter
	# Starting from top-left, going clockwise
	curve.add_point(Vector2(rect_position.x, rect_position.y + rect_size.y / 2))  # Top-right
	curve.add_point(Vector2(rect_position.x + rect_size.x, rect_position.y + rect_size.y / 2))  # Bottom-right
	
	var path = Path2D.new()
	path.curve = curve

	add_child(path)
	enemy_list.set_path(path)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
