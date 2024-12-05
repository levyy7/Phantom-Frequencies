extends Control

# Data to plot
@export var left_channel = []
var amplitudes # Amplitude values
var frequencies = []  # Frequency values
var plot_size = Vector2(800, 400)  # Plot dimensions
var padding = 20  # Padding around the plot
var default_font : Font = ThemeDB.fallback_font;


# Method to set data
func set_data(new_frequencies, new_amplitudes):
	frequencies = new_frequencies
	amplitudes = new_amplitudes
	queue_redraw()  # Trigger redraw

# Draw function
func _draw():
	if frequencies.size() == 0 or amplitudes.size() == 0:
		return

	# Calculate plot area
	var origin = Vector2(padding, padding)
	var size = plot_size - Vector2(padding * 2, padding * 2)

	# Draw plot background
	draw_rect(Rect2(origin, size), Color(0.7,0.7,0.7))

	# Find min and max for normalization
	var max_frequency = frequencies[-1]
	var max_amplitude = amplitudes.max()

	# Avoid divide-by-zero errors
	if max_amplitude == 0:
		max_amplitude = 1

	# Normalize and plot points
	for i in range(frequencies.size()):
		var freq = frequencies[i]
		var amp = amplitudes[i]

		# Map frequency to X-axis
		var x = origin.x + (freq / max_frequency) * size.x

		# Map amplitude to Y-axis (invert Y for proper display)
		var y = origin.y + size.y - (amp / max_amplitude) * size.y/2

		# Draw point or line
		if i > 0:
			var prev_x = origin.x + (frequencies[i - 1] / max_frequency) * size.x
			var prev_y = origin.y + size.y - (amplitudes[i - 1] / max_amplitude) * size.y
			draw_line(Vector2(prev_x, prev_y), Vector2(x, y), Color(0, 1, 0), 2)  # Green line

	# Draw axes
	draw_line(origin, origin + Vector2(size.x, 0), Color(1, 1, 1), 1)  # X-axis
	draw_line(origin, origin + Vector2(0, size.y), Color(1, 1, 1), 1)  # Y-axis

	# Labels (Optional: Add frequency and amplitude labels for readability)
	draw_string(default_font, origin + Vector2(-10, size.y + 10), "0 Hz", 0, -1, 16, Color(1, 1, 1))
	draw_string(default_font,origin + Vector2(size.x - 30, size.y + 10), str(int(max_frequency)) + " Hz", 0, -1, 16, Color(1, 1, 1))
	draw_string(default_font,origin + Vector2(-30, -10), str(int(max_amplitude)) + " Amp", 0, -1, 16, Color(1, 1, 1))

# Example usage
func plot_fft():
	# Example data
	var sample_rate = 44100
	var fft_size = left_channel.size()

	var result = FFT.fft(left_channel)
	amplitudes = FFT.reals(result)
	var nyquist_limit = left_channel.size() / 2
	for n in range(0, nyquist_limit):
		var freq: float
		freq = n * sample_rate / left_channel.size()
		frequencies.append(freq)
	print(frequencies.size())
	#set_data(frequencies, amplitudes)
