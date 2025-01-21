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
	$"Control/MarginContainer".visible = true

func _on_mouse_exited() -> void:
	$"Control/MarginContainer".visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	print("Button pressed!")
