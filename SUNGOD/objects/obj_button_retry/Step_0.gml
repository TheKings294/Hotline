// Variable stores gamepad count
var _max_pads = gamepad_get_device_count();

// Loops though the gamepads
for (var _i = 0; _i < _max_pads; _i++)
{
	// Checks gamepad is connected
	if (gamepad_is_connected(_i))
	{	
		// Checks if the A button has been pressed 
		if (gamepad_button_check_pressed(_i, gp_face1))
		{
			// Sets the key variable to pressed
			is_pressed = true;
			// Sets the target scale
			target_scale = 0.9;
			// Speeds up the scale rate
			scale_rate = 0.9;
			
			// Plays the button pushed sound effect
			sound_button = audio_play_sound(snd_menu_button, 100, false);
		}
	}
}

// Checks if the image is at the target scale
if (image_xscale != target_scale || image_yscale != target_scale)
{
	// Checks if scale changes at rate or snaps to size
	if (can_scale_at_rate)
	{
		// Lerps the scale towards the target scale
		image_xscale = lerp(image_xscale, target_scale, scale_rate);
		image_yscale = lerp(image_yscale, target_scale, scale_rate);
	}
	else
	{
		// Hard sets the scale to new target scale
		image_xscale = target_scale;
		image_yscale = target_scale;
	}
}

// Checks if the pressed state is true
if (is_pressed)
{
	// Checks if the button has reached its target scale
	if (image_xscale == target_scale && image_yscale == target_scale)
	{
		// Checks if the image scale is returned to full (1)
		if (image_xscale == 1 && image_yscale == 1)
		{
			// Checks if button sound effect has finished playing
			if (!audio_exists(sound_button))
			{
				// Restarts the current room
				room_restart();
			}
		}
		else
		{
			// Sets the target scale to full (1)
			target_scale = 1.0;	
		}
	}
}