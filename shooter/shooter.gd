class_name Shooter
extends Node2D

const bullet_scene = preload("res://enemy/Bullet.tscn")
var spawn_timer: float = 0.0
const SPAWN_INTERVAL: float = 0.5
const BULLET_SPEED: float = 1400.0

const NOTE_TO_INDEX = {
	"A": 0,
	"A#": 1,
	"B": 2,
	"C": 3,
	"C#": 4,
	"D": 5,
	"D#": 6,
	"E": 7,
	"F": 8,
	"F#": 9,
	"G": 10,
	"G#": 11,
}


var damage = 50
var current_name = "A"
var current_frequency_index = 0

static var FREQUENCIES: Array[Frequency] = MusicalFrequencies.FREQUENCIES

@onready var note_player = $NotePlayer
static var NOTES: Array[AudioStream] = SoundManager.NOTES

func current_frequency() -> Frequency:
	return FREQUENCIES[current_frequency_index]

func play_current_note() -> void:
	note_player.stream = NOTES[current_frequency_index]
	note_player.play()
	

func _ready() -> void:
	assert(FREQUENCIES.size() == NOTES.size())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	queue_redraw() # Ensure the circle is always drawn

func _draw() -> void:
	var freq = FREQUENCIES[current_frequency_index]

	# Draw a circle at the spawner's position
	var radius = 20 # Adjust size as needed
	draw_circle(Vector2.ZERO, radius, freq.color)
	#draw_line(Vector2.ZERO, Vector2(radius, 0), Color.BLACK, 2.5)
	
	
	var font = ThemeDB.fallback_font
	# Draw the note on top of the circle
	if font:
		var text_size = font.get_string_size(current_name)
		draw_string(font, Vector2(-text_size.x, text_size.y / 2) / 2, current_name, HORIZONTAL_ALIGNMENT_CENTER, -1, 20, Color.BLACK)


func spawn_bullet(target: Node2D) -> void:
	var bullet = bullet_scene.instantiate()
	
	bullet.damage = Damage.new(damage, current_frequency())
	var angle = global_position.angle_to_point(target.global_position)
	
	# TODO: actually make sure that the parent rotation is 0, else this doesn't work since angle is in global coordinates
	# angle only equals local rotation if parent rotation is 0
	bullet.global_rotation = angle
	
	var velocity = Vector2(0, 1) * BULLET_SPEED
	bullet.set_meta("velocity", velocity)
	
	#rotation = angle
	
	add_child(bullet)


func update_frequency(note: Note) -> void:
	current_frequency_index = NOTE_TO_INDEX[note.name] + (note.octave + 1) * 12
	print("Note: " + note.name + " Octave: " + str(note.octave) + " Frequency: " + str(current_frequency().frequency))
	print(current_frequency_index)
	current_name = note.name


func next_frequency() -> bool:
	# Sets the current frequency to the next frequency in the list
	# If no more frequencies to set, returns False to signal that the shooter should be removed
	# Otherwise, returns True to signal that the shooter should remain
	if current_frequency_index < FREQUENCIES.size() - 1:
		current_frequency_index += 1
		return true
	else:
		return false
