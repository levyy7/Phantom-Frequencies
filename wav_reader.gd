extends Node

var waveformPoints = []
var left_channel = []
var right_channel = []
var sample_rate = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func read_wav(filename: String) -> Dictionary:
	var L = []
	var R = []
	
	var file = FileAccess.open(filename, FileAccess.READ)
	#if file(filename, FileAccess.READ) == OK:
		#print("Failed to load: " + filename)
		#return {"success": false}
	var chunk_id = file.get_32()  # Chunk ID
	#print("%x" % chunk_id)
	var file_size = file.get_32()  # File size
	var riff_type = file.get_32()  # RIFF Type
	
	## Verify RIFF and WAVE headers
	#if chunk_id != 0x52494646 or riff_type != 0x57415645:  # 'RIFF' and 'WAVE'
		#print("Invalid WAV file")
		#file.close()
		#return {"success": false}
	# Read format chunk
	var fmt_id = file.get_32()  # Format ID
	var fmt_size = file.get_32()  # Size of format chunk
	var fmt_code = file.get_16()  # Format code
	var channels = file.get_16()  # Number of channels
	var sample_rate = file.get_32()  # Sample rate
	var byte_rate = file.get_32()  # Byte rate
	var block_align = file.get_16()  # Block align
	var bit_depth = file.get_16()  # Bits per sample
	
	# Skip extra data in format chunk if necessary
	if fmt_size > 16:
		var extra_size = file.get_16()
		file.seek(file.get_position() + extra_size)
		
	# Read data chunk header
	var data_id = file.get_32()  # Data chunk ID
	var data_size = file.get_32()  # Size of data chunk
	
	#if data_id != 0x64617461:  # 'data'
		#print("Unexpected chunk ID, expected 'data'")
		#file.close()
		#return {"success": false}
		
	# Read audio data
	var bytes_per_sample = bit_depth / 8
	var total_samples = data_size / bytes_per_sample
	var raw_data = file.get_buffer(data_size)
		
	# Parse audio data into floats
	var audio_data = []
	for i in range(total_samples):
		match bit_depth:
			16:
				var sample = raw_data.decode_s16(i * bytes_per_sample)
				audio_data.append(sample / float(0x8000))  # Normalize to [-1, 1]
			32:
				var sample = raw_data.decode_s32(i * bytes_per_sample)
				audio_data.append(sample)
			_:
				print("Unsupported bit depth:", bit_depth)
				file.close()
		#return {"success": false}
	#print("look here")
	#print(audio_data)
				
# De-interleave stereo channels if necessary
	if channels == 1:
		L = audio_data
		R = null
	elif channels == 2:
		var n_samples = int(total_samples / 2)
		L.resize(n_samples)
		R.resize(n_samples)
		for i in range(n_samples):
			L[i] = audio_data[i * 2]
			R[i] = audio_data[i * 2 + 1]
	else:
		print("Unsupported channel count:", channels)
		file.close()
		return {"success": false}
		
	file.close()
	return {"success": true, "L": L, "R": R}
