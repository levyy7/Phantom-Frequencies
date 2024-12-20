extends CanvasLayer

@onready var title = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var restartButton = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/RestartButton

func _ready() -> void:
	set_title(Global.win)

func set_title(win: bool):
	
	if win:
		title.text = "YOU WIN!"
		restartButton.text = "Next Level"
		title.modulate = Color.GREEN
	else:
		title.text = "YOU LOSE!"
		restartButton.text = "Restart"
		title.modulate = Color.RED


func _on_RestartButton_pressed() -> void:
	if(Global.win):
		#next level
		var i = Global.levels.find(Global.currentLevel,0)
		if(i<len(Global.levels)-1):
			Global.currentLevel=Global.levels[i+1]
			get_tree().change_scene_to_file("res://main_scene.tscn")
		else:
			get_tree().change_scene_to_file("res://level/level_select.tscn")		
		
	else:
		get_tree().change_scene_to_file("res://main_scene.tscn")




func _on_LevelSelectButton_pressed() -> void:
	get_tree().change_scene_to_file("res://level/level_select.tscn")
