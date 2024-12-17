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


const PIANO_A3  = preload("res://audio/piano/A3.mp3")
const PIANO_As3 = preload("res://audio/piano/As3.mp3")
const PIANO_B3  = preload("res://audio/piano/B3.mp3")
const PIANO_C4  = preload("res://audio/piano/C4.mp3")
const PIANO_Cs4 = preload("res://audio/piano/Cs4.mp3")
const PIANO_D4  = preload("res://audio/piano/D4.mp3")
const PIANO_Ds4 = preload("res://audio/piano/Ds4.mp3")
const PIANO_E4  = preload("res://audio/piano/E4.mp3")
const PIANO_F4  = preload("res://audio/piano/F4.mp3")
const PIANO_Fs4 = preload("res://audio/piano/Fs4.mp3")
const PIANO_G4  = preload("res://audio/piano/G4.mp3")
const PIANO_Gs4 = preload("res://audio/piano/Gs4.mp3")
const PIANO_A4  = preload("res://audio/piano/A4.mp3")

const PIANO_OCTAVE4 = {
	"A":  PIANO_A3,
	"Bb": PIANO_As3,
	"B":  PIANO_B3,
	"C":  PIANO_C4,
	"C#": PIANO_Cs4,
	"D":  PIANO_D4,
	"Eb": PIANO_Ds4,
	"E":  PIANO_E4,
	"F":  PIANO_F4,
	"F#": PIANO_Fs4,
	"G":  PIANO_G4,
	"G#": PIANO_Gs4,
	"A4": PIANO_A4
}

static var NOTES: Array[AudioStream] = _generate_notes()


static func _generate_notes():
	var notes: Array[AudioStream] = []
	
	for note in PIANO_OCTAVE4.values():
		notes.append(note)
	
	return notes
