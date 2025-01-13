class_name TowerChangePanel
extends Panel

const MIN_OCTAVE := -1
const MAX_OCTAVE := 1
const DEFAULT_OCTAVE := 0

var current_octave := DEFAULT_OCTAVE

@onready var octave_label = $OctaveContainer/OctaveControls/OctaveLabel
@onready var up_button = $OctaveContainer/OctaveControls/UpButton
@onready var down_button = $OctaveContainer/OctaveControls/DownButton

func _ready() -> void:
	up_button.pressed.connect(_on_up_pressed)
	down_button.pressed.connect(_on_down_pressed)
	_update_octave_display()

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
	octave_label.text = str(current_octave)

	# Update button states based on octave limits
	up_button.disabled = current_octave >= MAX_OCTAVE
	down_button.disabled = current_octave <= MIN_OCTAVE

func toNote(button: Button) -> Note:
	var note_name = button.text
	return Note.new(note_name, current_octave)
