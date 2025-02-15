class_name Enemy
extends Node2D

var dead: bool = false
var hp: int = 100
@onready var health_bar: ProgressBar = $ProgressBar

# When the enemy is moving from one track square to the next, keeps track of the progress along this path
# The enemy is "done" moving when the progress is 1.0, then we emit a "is_done_moving" signal which is picked up
# by the tile manager 
var _path_progress: float
var current_path: Curve2D

var damage_handler: DamageHandler
var preferences = []

static var enemy_scene = preload("res://enemy/Enemy.tscn")


signal is_done_moving
signal enemy_clicked(enemy: Enemy)

static func prefToText(preferences):
	var texts=[]
	for pref in preferences:
		texts.append(pref.text)
	return "[center]" + "".join(texts) + "[/center]"

static func prefToDesc(preferences):
	var texts=["I want to hear these in order:\n"]
	for pref in preferences:
		texts.append("-"+pref.description+"\n")
	return "".join(texts)
	
static func create_enemy(preferences) -> Enemy:
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.preferences = preferences
	enemy.prefText = prefToText(preferences)
	enemy.descriptionText = prefToDesc(preferences)
	enemy.color = enemy.preferences[0].color # should be better 
	return enemy


func set_advance_to(node: Node2D):
	# Create a Curve2D resource to define the path
	var curve = Curve2D.new()
	
	# Add points to the curve - starting from current position to target position
	curve.add_point(global_position)  # Start point
	curve.add_point(node.global_position)  # End point
	
	current_path = curve

	_path_progress = 0.0

var prefText: String = "NoText":
	set(new_text):
		prefText=new_text
		$PrefText.text=new_text

var descriptionText: String = "NoText":
	set(new_text):
		descriptionText=new_text
		$DescriptionPanel/DescriptionText.text=descriptionText

var color: Color = Color.BLACK:
	set(new_color):
		color=new_color


func _ready() -> void:
	health_bar.max_value = hp
	health_bar.value = hp
	$MouseHitbox.hovered_enemy.connect(_on_hovered)
	$MouseHitbox.unhovered_enemy.connect(_on_unhovered)
	#$ColorRect.color = color


func take_damage(_amount: Damage) -> void:
	pass
	#hp = damage_handler.take_damage(hp, _amount)
	#health_bar.value = hp
	#if hp <= 0:
	#	die()


func _on_hovered():
	$DescriptionPanel.visible=true
	position_tooltip()

func _on_unhovered():
	$DescriptionPanel.visible=false

func position_tooltip():
	var panel = $DescriptionPanel
	var viewport_rect = get_viewport_rect()
	var panel_size = panel.size
	
	# Calculate the center position relative to the node
	var desired_position = Vector2(
		-panel_size.x / 2,  # Center horizontally
		25  # 25 pixels below the node 
	)
	
	# Convert to global coordinates for screen bounds checking
	var global_panel_pos = to_global(desired_position)
	var final_position = desired_position
	
	# Check if the panel goes off the left side of the screen
	if global_panel_pos.x < 25:
		final_position.x = to_local(Vector2(25, 0)).x
	
	# Check if the panel goes off the right side of the screen
	var global_right_edge = to_global(desired_position + Vector2(panel_size)).x
	if global_right_edge > viewport_rect.size.x - 25.0:
		final_position.x = to_local(Vector2(viewport_rect.size.x - 25, 0)).x - panel_size.x
	
	# Apply the final position
	panel.position = final_position

func become_affected(frequencies):
	if preferences[0].fulfilled(frequencies):
		preferences.pop_front()
	prefText = prefToText(preferences)
	descriptionText = prefToDesc(preferences)
	if len(preferences) == 0:
		die()
	
func _process(delta: float) -> void:
	if current_path != null:
		_path_progress += delta * 2.5
		
		var progress_len = _path_progress * current_path.get_baked_length()
		global_position = current_path.sample_baked(progress_len)
		if _path_progress >= 1.0:
			current_path = null
			is_done_moving.emit()
			


func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.is_released():
			enemy_clicked.emit(self)
			

func _on_ghost_done_animation():
	assert(self.dead)
	queue_free()
	
func die():
	if self.dead:
		return
		
	self.dead = true
	var ghost := Ghost.new_with_color(Color.WHITE)
	assert(ghost != null)
	
	add_child(ghost)
	
	$ProgressBar.visible = false
	$Sprite2D.visible = false
	
	ghost.position = self.position
	ghost.start_animation()
	ghost.done_animation.connect(_on_ghost_done_animation)
