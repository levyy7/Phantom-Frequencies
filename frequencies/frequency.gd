class_name Frequency extends RefCounted

var frequency: float
var color: Color

static func int_to_color_hash(value_float: float) -> Color:
	var value = int(value_float * 100000)
	# Get a hash of the value
	var hash_val := hash(value)
	
	# Extract RGB components using modulo to ensure values are in 0-1 range
	# We use different bit shifts to reduce correlation between components
	var r := float(abs(hash_val >> 16) % 255) / 255.0
	var g := float(abs(hash_val >> 8) % 255) / 255.0
	var b := float(abs(hash_val) % 255) / 255.0
	
	# Ensure the color isn't too dark by boosting all components
	var min_brightness := 0.1
	r = r * (1.0 - min_brightness) + min_brightness
	g = g * (1.0 - min_brightness) + min_brightness
	b = b * (1.0 - min_brightness) + min_brightness
	
	return Color(r, g, b)

func _init(freq: float):
	frequency = freq
	color = int_to_color_hash(freq)
