extends GridContainer

var main_scene_path = "res://main_scene.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var y_offset = 0
	for level in Global.levels:
		var button = Button.new()
		button.text = level.name
		button.name = level.name
		button.custom_minimum_size = Vector2(400, 200)
		
		button.connect("pressed", Callable(self, "_on_button_pressed").bind(level))
		add_child(button)

# Callback for button press
func _on_button_pressed(level):
	print("Button pressed for item: %s" % level)
	var main_scene = load(main_scene_path)
	Global.currentLevel=level
	get_tree().change_scene_to_packed(main_scene)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
