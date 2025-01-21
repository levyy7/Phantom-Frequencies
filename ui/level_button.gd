extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect mouse signals
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	# Make Control node ignore mouse events
	$Control.mouse_filter = Control.MOUSE_FILTER_IGNORE

func set_level(level_name: String):
	$"Control/LevelText".text = level_name
	#$"Control/MarginContainer".visible = false

# Mouse hover handlers
func _on_mouse_entered() -> void:
	# Make BackHint visible and use brighter color
	$"Control/MarginContainer".visible = true
	$"Control/MarginContainer/BackHint".add_theme_color_override("font_color", Color(0.95, 0.65, 0.45, 1))

func _on_mouse_exited() -> void:
	# Return to original color
	$"Control/MarginContainer".visible = true
	$"Control/MarginContainer/BackHint".add_theme_color_override("font_color", Color(0.705, 0.478, 0.349, 1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	print("Button pressed!")
