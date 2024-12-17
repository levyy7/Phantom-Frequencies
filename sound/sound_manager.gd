class_name SoundManager

const VIOLIN_A3  = preload("res://audio/violin/violin_A3_1_fortissimo_arco-normal.mp3")
const VIOLIN_As3 = preload("res://audio/violin/violin_As3_1_fortissimo_arco-normal.mp3")
const VIOLIN_B3  = preload("res://audio/violin/violin_B3_1_fortissimo_arco-normal.mp3")
const VIOLIN_C4  = preload("res://audio/violin/violin_C4_1_fortissimo_arco-normal.mp3")
const VIOLIN_Cs4 = preload("res://audio/violin/violin_Cs4_1_fortissimo_arco-normal.mp3")
const VIOLIN_D4  = preload("res://audio/violin/violin_D4_1_fortissimo_arco-normal.mp3")
const VIOLIN_Ds4 = preload("res://audio/violin/violin_Ds4_1_fortissimo_arco-normal.mp3")
const VIOLIN_E4  = preload("res://audio/violin/violin_E4_1_fortissimo_arco-normal.mp3")
const VIOLIN_F4  = preload("res://audio/violin/violin_F4_1_fortissimo_arco-normal.mp3")
const VIOLIN_Fs4 = preload("res://audio/violin/violin_Fs4_1_fortissimo_arco-normal.mp3")
const VIOLIN_G4  = preload("res://audio/violin/violin_G4_1_fortissimo_arco-normal.mp3")
const VIOLIN_Gs4 = preload("res://audio/violin/violin_Gs4_1_fortissimo_arco-normal.mp3")
const VIOLIN_A4  = preload("res://audio/violin/violin_A4_1_fortissimo_arco-normal.mp3")

const VIOLIN_OCTAVE4 = {
	"A":  VIOLIN_A3,
	"Bb": VIOLIN_As3,
	"B":  VIOLIN_B3,
	"C":  VIOLIN_C4,
	"C#": VIOLIN_Cs4,
	"D":  VIOLIN_D4,
	"Eb": VIOLIN_Ds4,
	"E":  VIOLIN_E4,
	"F":  VIOLIN_F4,
	"F#": VIOLIN_Fs4,
	"G":  VIOLIN_G4,
	"G#": VIOLIN_Gs4,
	"A4": VIOLIN_A4
}

static var NOTES: Array[AudioStream] = _generate_notes()


static func _generate_notes():
	var notes: Array[AudioStream] = []
	
	for note in VIOLIN_OCTAVE4.values():
		notes.append(note)
	
	return notes
