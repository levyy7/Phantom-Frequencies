class_name TowerChangePanel
extends Panel

const MIN_OCTAVE := -1
const MAX_OCTAVE := 1
const DEFAULT_OCTAVE := 0

var current_octave := DEFAULT_OCTAVE


func _ready() -> void:
	pass

func createButtons(notes: Array[String], enabled_notes: Array[String]) -> Array[NoteButton]:
	var container_width = $NoteButtonsContainer.size.x
	var container_height = $NoteButtonsContainer.size.y
	var button_width = container_width / 12
	var note_buttons: Array[NoteButton] = []

	var row = 0
	var row_height = container_height / 2
	
	for octave in [0, 1]:
		for i in notes.size():
			var is_enabled = enabled_notes.has(notes[i])
			var button = NoteButton.new(notes[i], current_octave)
			button.name = "Button" + str(i) + str(octave)
			# Center vertically at 17 pixels from top
			# Horizontally space based on fraction of container width
			button.set_position(Vector2(button_width * i, row * row_height))
			button.set_size(Vector2(button_width, row_height))
			
			if is_enabled:
				button.disabled = false
			else:
				button.disabled = true
				button.modulate = Color(0.25, 0.25, 0.25, 1.0)
				
			$NoteButtonsContainer.add_child(button)
			note_buttons.append(button)
		
		row += 1

	return note_buttons

func start_glows() -> void:
	print("Starting glows")
	# TODO: DO NOTHING, remove
func stop_glows() -> void:
	print("Stop glows")
	# TODO: DO NOTHING, remove

func _on_up_pressed() -> void:
	_increment_octave()

func _on_down_pressed() -> void:
	_decrement_octave()

func _increment_octave() -> bool:
	if current_octave < MAX_OCTAVE:
		current_octave += 1
		_update_octave_display()
		return true
	return false

func _decrement_octave() -> bool:
	if current_octave > MIN_OCTAVE:
		current_octave -= 1
		_update_octave_display()
		return true
	return false

func _update_octave_display() -> void:
	pass
	#octave_label.text = str(current_octave)
#
	## Update button states based on octave limits
	#up_button.disabled = current_octave >= MAX_OCTAVE
	#down_button.disabled = current_octave <= MIN_OCTAVE

func toNote(button: Button) -> Note:
	var note_name = button.text
	return Note.new(note_name, current_octave)
