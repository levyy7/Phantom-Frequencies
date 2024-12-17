class_name NotePreference extends Preference

var color = Color.GREEN_YELLOW
var text = "A"
var freq = 440.0
var description = ""
func fulfilled(frequencies) -> bool:
	for fre in frequencies:
		if(fre.frequency==freq):
			return true
	return false

var notes=["A","A#","B","C","C#","D","D#","E","F","F#","G","G#"]
var noteFreqs=[440.0,469.0+1/3.0,495.0,528.0,550.0,586.0+2.0/3.0,618.75,660.0,704.0,733.0+1.0/3.0,792.0,825.0]
#func notetofreq(note):
#	return 440.0*2**(notes.find(note,0)/12.0)
		
	

func init(note):
	text=note
	freq=noteFreqs[notes.find(note,0)]
	description="A single "+text+" note"
	print(text,freq)
	
