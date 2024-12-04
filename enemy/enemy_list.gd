class_name EnemyList
extends Node2D

var _path: Path2D
var selected: Enemy

func set_path(new_path: Path2D) -> void:
	assert(_path == null, "EnemyList.Path is already set")
	self._path = new_path

	var children = get_children()
	
	for child in children:
		if child is not Enemy:
			assert(false, "Child %s is not an instance of Enemy" % str(child))
		
	var index = 0
	for child in children:
		child.enemy_clicked.connect(_on_enemy_clicked)
		var path2d_follow = PathFollow2D.new()
		_path.add_child(path2d_follow)
		
		path2d_follow.progress_ratio = index * 0.2
		child.initialize_path_follow(path2d_follow)
		
		index += 1

func _on_enemy_clicked(enemy: Enemy):
	if self.selected != null:
		self.selected.color = Color.BLACK
		
	self.selected = enemy
	self.selected.color = Color.RED
	
func _ready() -> void:
	pass
	
func get_target() -> Enemy:
	if self.selected != null:
		return self.selected
	else:
		return first_child()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#for child in get_children():
		#child._process(delta)

	
func first_child() -> Enemy:
	# TODO: actually find the first enemy along a track
	return get_child(0) as Enemy
