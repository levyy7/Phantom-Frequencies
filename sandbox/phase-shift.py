# experimenting with phase shift

# i can't tell the difference by ear

import numpy as np
import sounddevice as sd
import matplotlib.pyplot as plt

def generate_sine_wave(frequency, duration=1.0, sample_rate=44100, phase_shift=0):
    """
    Generate a sine wave for a given frequency with phase shift.
    phase_shift: shift in radians (2π = one complete wavelength)
    """
    t = np.linspace(0, duration, int(sample_rate * duration), False)
    return t, np.sin(2 * np.pi * frequency * t + phase_shift)

def play_and_plot_chord(frequencies, phase_shifts, duration=1):
    """Generate, play, and plot multiple frequencies with phase shifts."""
    # Set up the plot
    fig, (ax1, ax2, ax3) = plt.subplots(3, 1, figsize=(12, 8))
    fig.suptitle('Phase-Shifted Waveform Visualization')
    
    # Generate combined samples for playing
    combined_samples = np.zeros(int(44100 * duration))
    
    # Plot individual waves
    for i, (freq, phase) in enumerate(zip(frequencies, phase_shifts)):
        t, samples = generate_sine_wave(freq, duration, phase_shift=phase)
        combined_samples += samples
        
        # Only plot first 1000 samples for better visualization
        if i == 0:
            ax1.plot(t[:1000], samples[:1000], 
                    label=f'{freq} Hz (C4)\nPhase shift: {phase/np.pi:.2f}π')
            ax1.set_title('Middle C Wave')
        else:
            ax2.plot(t[:1000], samples[:1000], 
                    label=f'{freq} Hz (G4)\nPhase shift: {phase/np.pi:.2f}π')
            ax2.set_title('G4 Wave')
    
    # Normalize combined samples
    combined_samples = combined_samples * (0.3 / len(frequencies))
    
    # Plot combined wave
    ax3.plot(t[:1000], combined_samples[:1000], label='Combined', color='green')
    ax3.set_title('Combined Wave')
    
    # Add labels and grid
    for ax in [ax1, ax2, ax3]:
        ax.set_xlabel('Time (seconds)')
        ax.set_ylabel('Amplitude')
        ax.grid(True)
        ax.legend()
    
    # Adjust layout
    plt.tight_layout()
    
    # Play the sound
    sd.play(combined_samples, samplerate=44100)
    sd.wait()
    
    # Show the plot
    plt.show()

if __name__ == "__main__":
    # Middle C (261.63 Hz) and G above middle C (392.00 Hz)
    frequencies = [100, 2*100]
    
    # Example phase shifts (in radians)
    # 0 means the wave starts at the beginning
    # π/2 means the wave is shifted forward by 1/4 wavelength
    # π means the wave is shifted forward by 1/2 wavelength
    # 2π means the wave is shifted forward by a full wavelength
    phase_shifts = [0, np.pi/2]  # Second note delayed by 1/4 wavelength
    
    print("Playing and plotting phase-shifted notes...")
    play_and_plot_chord(frequencies, phase_shifts)
    play_and_plot_chord(frequencies, [0,0])

# Try different phase shifts:
print("\nDifferent phase shift examples you can try:")
print("In sync: phase_shifts = [0, 0]")
print("Quarter wavelength delay: phase_shifts = [0, np.pi/2]")
print("Half wavelength delay: phase_shifts = [0, np.pi]")
print("Three-quarter wavelength delay: phase_shifts = [0, 3*np.pi/2]")
print("Full wavelength delay: phase_shifts = [0, 2*np.pi]")