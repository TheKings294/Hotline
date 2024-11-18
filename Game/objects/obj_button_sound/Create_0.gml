// Checks if global audio volume variable exist
if (!variable_global_exists("audio_volume"))
{
	// Sets audio gain to 1
	global.audio_volume = 1;
}

// Checks if audio volume is above 0
if (global.audio_volume > 0)
{
	// Sets audio gain to 1
	global.audio_volume = 1;
	// Sets sound on sprite from index
	image_index = 0;
}
else
{
	// Sets audio gain to 0
	global.audio_volume = 0;
	// Sets sound off sprite from index
	image_index = 1;
}

// Sets master gain to audio volume variable
audio_set_master_gain(0, global.audio_volume);

// Variable for target scale
target_scale = 1.0;

// Variables for scaling rate
scale_rate = 0.1;
can_scale_at_rate = false;

// Variable for pressed state
is_pressed = false;