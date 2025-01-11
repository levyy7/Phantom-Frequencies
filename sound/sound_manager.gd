class_name SoundManager

const VIOLIN_A3 = preload("res://audio/violin/violin_A3_1_fortissimo_arco-normal.mp3")
const VIOLIN_As3 = preload("res://audio/violin/violin_As3_1_fortissimo_arco-normal.mp3")
const VIOLIN_B3 = preload("res://audio/violin/violin_B3_1_fortissimo_arco-normal.mp3")
const VIOLIN_C4 = preload("res://audio/violin/violin_C4_1_fortissimo_arco-normal.mp3")
const VIOLIN_Cs4 = preload("res://audio/violin/violin_Cs4_1_fortissimo_arco-normal.mp3")
const VIOLIN_D4 = preload("res://audio/violin/violin_D4_1_fortissimo_arco-normal.mp3")
const VIOLIN_Ds4 = preload("res://audio/violin/violin_Ds4_1_fortissimo_arco-normal.mp3")
const VIOLIN_E4 = preload("res://audio/violin/violin_E4_1_fortissimo_arco-normal.mp3")
const VIOLIN_F4 = preload("res://audio/violin/violin_F4_1_fortissimo_arco-normal.mp3")
const VIOLIN_Fs4 = preload("res://audio/violin/violin_Fs4_1_fortissimo_arco-normal.mp3")
const VIOLIN_G4 = preload("res://audio/violin/violin_G4_1_fortissimo_arco-normal.mp3")
const VIOLIN_Gs4 = preload("res://audio/violin/violin_Gs4_1_fortissimo_arco-normal.mp3")
const VIOLIN_A4 = preload("res://audio/violin/violin_A4_1_fortissimo_arco-normal.mp3")

const VIOLIN_OCTAVE4 = {
	"A": VIOLIN_A3,
	"Bb": VIOLIN_As3,
	"B": VIOLIN_B3,
	"C": VIOLIN_C4,
	"C#": VIOLIN_Cs4,
	"D": VIOLIN_D4,
	"Eb": VIOLIN_Ds4,
	"E": VIOLIN_E4,
	"F": VIOLIN_F4,
	"F#": VIOLIN_Fs4,
	"G": VIOLIN_G4,
	"G#": VIOLIN_Gs4,
	"A4": VIOLIN_A4
}

# lower octave, coded as -1
const PIANO__1_A = preload("res://audio/piano/-1-A.mp3")
const PIANO__1_As = preload("res://audio/piano/-1-As.mp3")
const PIANO__1_B = preload("res://audio/piano/-1-B.mp3")
const PIANO__1_C = preload("res://audio/piano/-1-C.mp3")
const PIANO__1_Cs = preload("res://audio/piano/-1-Cs.mp3")
const PIANO__1_D = preload("res://audio/piano/-1-D.mp3")
const PIANO__1_Ds = preload("res://audio/piano/-1-Ds.mp3")
const PIANO__1_E = preload("res://audio/piano/-1-E.mp3")
const PIANO__1_F = preload("res://audio/piano/-1-F.mp3")
const PIANO__1_Fs = preload("res://audio/piano/-1-Fs.mp3")
const PIANO__1_G = preload("res://audio/piano/-1-G.mp3")
const PIANO__1_Gs = preload("res://audio/piano/-1-Gs.mp3")

# standard octave, coded as 0
const PIANO_0_A = preload("res://audio/piano/0-A.mp3")
const PIANO_0_As = preload("res://audio/piano/0-As.mp3")
const PIANO_0_B = preload("res://audio/piano/0-B.mp3")
const PIANO_0_C = preload("res://audio/piano/0-C.mp3")
const PIANO_0_Cs = preload("res://audio/piano/0-Cs.mp3")
const PIANO_0_D = preload("res://audio/piano/0-D.mp3")
const PIANO_0_Ds = preload("res://audio/piano/0-Ds.mp3")
const PIANO_0_E = preload("res://audio/piano/0-E.mp3")
const PIANO_0_F = preload("res://audio/piano/0-F.mp3")
const PIANO_0_Fs = preload("res://audio/piano/0-Fs.mp3")
const PIANO_0_G = preload("res://audio/piano/0-G.mp3")
const PIANO_0_Gs = preload("res://audio/piano/0-Gs.mp3")


# higher octave, coded as 1
const PIANO_1_A = preload("res://audio/piano/1-A.mp3")
const PIANO_1_As = preload("res://audio/piano/1-As.mp3")
const PIANO_1_B = preload("res://audio/piano/1-B.mp3")
const PIANO_1_C = preload("res://audio/piano/1-C.mp3")
const PIANO_1_Cs = preload("res://audio/piano/1-Cs.mp3")
const PIANO_1_D = preload("res://audio/piano/1-D.mp3")
const PIANO_1_Ds = preload("res://audio/piano/1-Ds.mp3")
const PIANO_1_E = preload("res://audio/piano/1-E.mp3")
const PIANO_1_F = preload("res://audio/piano/1-F.mp3")
const PIANO_1_Fs = preload("res://audio/piano/1-Fs.mp3")
const PIANO_1_G = preload("res://audio/piano/1-G.mp3")
const PIANO_1_Gs = preload("res://audio/piano/1-Gs.mp3")

const PIANO_OCTAVE345 = {
	"-1-A": PIANO__1_A,
	"-1-A#": PIANO__1_As,
	"-1-B": PIANO__1_B,
	"-1-C": PIANO__1_C,
	"-1-C#": PIANO__1_Cs,
	"-1-D": PIANO__1_D,
	"-1-D#": PIANO__1_Ds,
	"-1-E": PIANO__1_E,
	"-1-F": PIANO__1_F,
	"-1-F#": PIANO__1_Fs,
	"-1-G": PIANO__1_G,
	"-1-G#": PIANO__1_Gs,

	"0-A": PIANO_0_A,
	"0-A#": PIANO_0_As,
	"0-B": PIANO_0_B,
	"0-C": PIANO_0_C,
	"0-C#": PIANO_0_Cs,
	"0-D": PIANO_0_D,
	"0-D#": PIANO_0_Ds,
	"0-E": PIANO_0_E,
	"0-F": PIANO_0_F,
	"0-F#": PIANO_0_Fs,
	"0-G": PIANO_0_G,
	"0-G#": PIANO_0_Gs,

	"1-A": PIANO_1_A,
	"1-A#": PIANO_1_As,
	"1-B": PIANO_1_B,
	"1-C": PIANO_1_C,
	"1-C#": PIANO_1_Cs,
	"1-D": PIANO_1_D,
	"1-D#": PIANO_1_Ds,
	"1-E": PIANO_1_E,
	"1-F": PIANO_1_F,
	"1-F#": PIANO_1_Fs,
	"1-G": PIANO_1_G,
	"1-G#": PIANO_1_Gs,
}

static var NOTES: Array[AudioStream] = _generate_notes()


static func _generate_notes():
	var notes: Array[AudioStream] = []
	
	for note in PIANO_OCTAVE345.values():
		notes.append(note)
	
	return notes
