extends Node

var note_names: Array[String] = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]
func maj(root: String, ct: int):
  var base = note_names.find(root)
  return note_names[base] + "," + note_names[(base + 4) % 12] + "," + note_names[(base + 7) % 12] + "," + str(ct)

var level0 = Level.create_level("level0", "Level 0: Pitches as frequencies
As you might already know, musical pitches correspond to frequencies of sound vibrations. Try to place notes such that all ghosts hear what they want to hear.
Tip - Hover over ghosts to see their preference", ["A", "B", "C", "E", "G", ], ["Hi", "Lo", "Lo"], ["Hi", "Lo->Hi->Hi", "Lo->Lo->Hi", "Lo->Hi->Hi", "Lo->Lo->Hi"]) \
	.with_moves_per_round(4)
	
var level1 = Level.create_level("level1", "Notes are divided into octaves. Notes are named ABCDEFG. After G, a new octave starts and the next A is double the frequency of the first A.
The 4th A on a piano is 440Hz and the 5th A on a piano is 880Hz.
Likewise, if the 3rd C is 261.63 Hz, then the 5th C is 1046.50 Hz
", ["A", "B", "G"], ["Hi->Oc", "Lo->Oc", "Oc->Hi"], ["Lo->Hi->Lo->Hi->Oc", "Oc->Oc->Oc", "Oc->Lo"]) \
	.with_moves_per_round(2)
var level2 = Level.create_level("level2", "Music notes are roughly 440*2^(k/12) Hz. Music notation is centered around A4=440Hz (4th A on the piano). An octave up is double the frequency. Within an octave, there are 12 notes (A A# B C C# D D# E F F# G G#; A ...). Each note is a key on the piano. The difference between two adjacent notes is the ratio 2^(1/12). The difference between notes (C,G) and (D,A) sound similar because both are a factor of 2^(7/12) apart. This distance factor of 2^(1/12) is a semitone. C and G are 7 semitones apart, likewise for D and A.
Thus, each note on a piano is 440*2^(k/12) Hz!
Fun fact - The #'s are called sharps and are the black keys on a piano, the basic ones are the white keys.
", note_names, ["A*2^(0/12)->Hi", "A*2^(4/12)->G", "A*2^(7/12)"], ["A*2^(0/12)->Lo", "A*2^(2/12)->A*2^(9/12)", "A*2^(4/12)->Oc", "A*2^(5/12)->Oc->A", "A*2^(7/12)->E->A"]) \
	.with_moves_per_round(3)

var level3 = Level.create_advanced_level("level3", "Consonance, Dissonance
If you play two notes at the same time, why does it sometimes sound nice but sometimes sound like ear torture?
It's because of the interference between the sound waves of each note!
Superposed waves generate a new wave with a longer wavelength. Shorter superposed wavelength => easier for brain to process => sounds nicer. In our frequencies of 440*2^(k/12), this means if the ratios between two notes is closer to a simpler rational number (like 2^(7/12)≈3/2), it sounds more consonant because the waves superimpose 'simply'. When A≈440Hz and G≈660Hz are played together, the new wave has a shorter wavelength compared to dissonant notes like A≈440Hz and F#≈622Hz. Essentially, consonance is lower LCM of frequency ratios, dissonance is higher LCM of ratios.
Tip - pay attention to the harmonograph!
",
["C", "F", "G", "B"], ["A*2^(8/12)", "Lo", "Hi"], ["Oc", "Lo->Hi->Hi", "Lo->Lo->Hi", "Lo->Oc->Hi", "F->G->C->A*2^(2/12)->Oc->C"],
["Con", "Con", "Con", "Con", "Dis", "Dis", "Con", "Con"]) \
 .with_moves_per_round(3)
var level4 = Level.create_level("level4", "Notes played at the same time are a chord or an interval. To describe these, we use chord/interval notation: (X, X+k_1, X+k_2, ...), where k_i is the number of semitones above a base X. 

With the base C as '0', '07' is the interval CG, '047' is the chord CEG", note_names, ["I12", "I7", "I12"], ["I5", "I3->I8", "I9", "I11->I6", "I7", "I12"]).with_moves_per_round(3)

var level5 = Level.create_advanced_level("level5", "Chords: >= 3 notes at a time
Harmonographs visualize the emotional 'intensity' of a chord. Simple then complex = music intensifies, complex then simple = music calms down and resolves to an ending.",
  ["A", "B", "C", "D", "E", "F", "G"], ["C->G", "E", "A->C", "F->Hi->B"], ["D->G->I7", "B->Lo->Hi", "C->C", "E"],
  [maj("C", 3), maj("C", 3), "F,A,C,3", "F,A,C,3", maj("G", 3), maj("G", 3), maj("C", 3), maj("C", 3)]) \
  .with_moves_per_round(4)

var level6 = Level.create_advanced_level("level6", "Major vs Minor triads
Triad = chord with 3 notes
Major triad = 047, ratios 4:5:6. It is a happy triad.
Minor triad = 037, ratios 10:12:15. It is a more sad/dissonant triad.",
  ["A", "B", "C", "D", "E", "F#", "G"], ["G->Lo", "B->Hi->Lo->Lo", "C->Hi", "E->Hi"], ["E->C", "A->Lo", "F#->Lo", "D"],
  ["maj", "maj", "maj", "maj", "min", "min", "maj", "maj"]) \
  .with_moves_per_round(4)
var level7 = Level.create_advanced_level("level7", "A sad song.",
  ["A", "B", "C", "D", "E", "F", "G#"], ["A->Lo->Lo->Lo", "A->Lo->Lo", "A->Lo", "A"], ["A->Lo->Lo->Lo->Hi", "A->Lo->Lo->Lo->Hi->E", "Hi->E->A", "Hi->E->A->A"],
  ["min", "min", "min", "min", "maj", "maj", "min", "min"]) \
  .with_moves_per_round(4)

var level8 = Level.create_advanced_level("level8", "Major keys
A song in a\"major key from 0=X\" (where X is one of A, A#, ..., G) almost always uses notes with 0 2 4 5 7 9 11 mod 12.
The semitone differences, starting from X, follow 2212221.
Eg. C major is CDEFGAB.

Key: A major (is it happy?)
Tip - try figuring out which notes belong in A major!",
  ["C#", "A", "B", "D", "E", "F#", "G#"], ["A", "Hi", "Lo", "Lo->Hi"], ["Oc", "Hi", "E->G#", "E"],
  ["", "", "A,C#,E,1", "E,G#,B,1", "", "", "E,G#,B,1", "A,C#,E,1"])
var level9 = Level.create_advanced_level("level9", "Minor keys
A song in a\"minor key from 0=X\" (where X is one of A, A#, ..., G) almost always uses notes with 0 2 3 5 7 8 11 mod 12.
The semitone differences, starting from X, follow 2122131.
Eg. A minor is ABCDEFG#.
Tip - To get keys for X minor, grab the major keys for X+3 major, then turn the X-2 mod 12 keys into X-1 mod 12
Eg A minor <-> A+3=C major (CDEFGAB) with G mapped to G+1=G# (ABCDEFG#).

Key: A minor (is it sad?)",
  ["A", "B", "C", "D", "E", "F", "G#"], ["A", "Hi", "Lo", "Lo->Hi"], ["Oc", "Hi", "E->G#", "E"],
  ["", "", "A,C,E,1", "E,G#,B,1", "", "", "E,G#,B,1", "A,C,E,1"])
var level10 = Level.create_advanced_level("level10", "Key: G major",
  ["A", "B", "C", "D", "E", "F#", "G"], ["A", "Hi", "A*2^(7/12)", "Lo->Hi"], ["Oc", "I6", "D->C", "Hi"],
  ["Con", "Con", maj("G", 1), "D,F#,A,1", "Dis", "Dis", "D,F#,A,C,1", maj("G", 1)]) \
  .with_moves_per_round(3)
var level11 = Level.create_advanced_level("level11", "Key: G major again",
  ["A", "B", "C", "D", "E", "F#", "G"], ["Hi", "Hi", "Lo", "Lo->Hi"], ["Lo", "Hi", "Lo", "Lo"],
  ["Con", "Con", "Con", "Con", "Dis", "Dis", maj("C", 3), maj("G", 3)]) \
  .with_moves_per_round(4)
var level12 = Level.create_advanced_level("level12", "Key: E minor",
  ["A", "B", "C", "D#", "E", "F#", "G"], ["Hi", "Hi", "Lo", "Lo->Hi"], ["Lo", "Hi", "Lo", "Lo"],
  ["Con", "Con", "Con", "Con", "Dis", "Dis", "B,D#,F#,3", "E,G,B,3"]) \
  .with_moves_per_round(4)

var levelTest = Level.create_level("levelT", "", note_names, ["A", "A#", "E"], ["Hi", "Oc->Hi->Hi", "Lo->Lo->Hi", "Lo->Hi->Hi", "Lo->Lo->Hi"])
var levelTest2 = Level.create_level("levelT", "", note_names, ["Lo"], ["Hi", "Lo->Hi", "Hi->Lo->Lo", "A", "A->E", "A->C", "A->C->E", "I3", "I7", "I3->C->Hi"])

var levels = [level0, level1, level2, level3, level4, level5, level6, level7, level8, level9, level10, level11, level12]

var currentLevel = null
var lives = 3
var win = false
var hovered_tower_group = null
