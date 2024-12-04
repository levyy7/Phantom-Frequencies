using Godot;
using System;

public partial class AudioGenerator : Node
{
[Export] public AudioStreamPlayer Player { get; set; }

private AudioStreamGeneratorPlayback _playback; // Will hold the AudioStreamGeneratorPlayback.
private float _sampleHz;
private float _pulseHz = 440.0F; // The frequency of the sound wave.

public override void _Ready()
{
	if (Player.Stream is AudioStreamGenerator generator) // Type as a generator to access MixRate.
	{
		_sampleHz = generator.MixRate;
	
	Player.Play();
	_playback = (AudioStreamGeneratorPlayback)Player.GetStreamPlayback();
	FillBuffer();
	}
}

public void FillBuffer()
{
	double phase = 0.0;
	float increment = _pulseHz / _sampleHz;
	int framesAvailable = _playback.GetFramesAvailable();

	for (int i = 0; i < framesAvailable; i++)
	{
		_playback.PushFrame(Vector2.One * (float)Mathf.Sin(phase * Mathf.Tau));
		phase = Mathf.PosMod(phase + increment, 1.0);
	}
}

public void Play()
{

}
}
