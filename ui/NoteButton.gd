class_name NoteButton
extends Button

var note_name: String
var octave: int
var note_player: AudioStreamPlayer
var number_hint: int
static var AUDIO_VOLUME = 0.3

static var NoteButtonScene = preload("res://ui/NoteButton.tscn")


static func create(note_name: String, octave: int, number_hint: int) -> NoteButton:
	var button = NoteButtonScene.instantiate() as NoteButton

	button._init_params(note_name, octave, number_hint)
	return button

func _init_params(in_note_name: String, in_octave: int, number_hint: int) -> void:
	note_name = in_note_name
	octave = in_octave
	text = note_name
	
	note_player = AudioStreamPlayer.new()
	note_player.volume_db = linear_to_db(AUDIO_VOLUME)  # Convert linear scale to decibels
	add_child(note_player)
	
	# Set the number hint text
	self.number_hint = number_hint
	update_note()

func _ready() -> void:
	$NumberHint.text = str(number_hint)
	
	pressed.connect(_on_pressed)

func update_note() -> void:
	# Calculate frequency index same way as Shooter
	var note_index = Shooter.NOTE_TO_INDEX[note_name] + (octave + 1) * 12
	note_player.stream = Shooter.NOTES[note_index]

func set_octave(new_octave: int) -> void:
	octave = new_octave
	update_note()

func _on_pressed() -> void:
	note_player.play()

func to_note() -> Note:
	return Note.new(note_name, octave)
