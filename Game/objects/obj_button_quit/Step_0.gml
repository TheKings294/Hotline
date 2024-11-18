// Variable stores gamepad count
var _max_pads = gamepad_get_device_count();

// Loops through game pads
for (var _i = 0; _i < _max_pads; _i++)
{
	// Checks if game pad is connected
	if (gamepad_is_connected(_i))
	{	
		// Checks if the B button has been pressed
		if (gamepad_button_check_released(_i, gp_face2))
		{
			// Sets pressed state to true
			is_pressed = true;
			// Sets target scale
			target_scale = 0.9;
			// Speeds up the scaling rate
			scale_rate = 0.9;
			
			// Plays the button pushed sound effect
			sound_button = audio_play_sound(snd_menu_button, 100, false);
		}
	}
}

// Checks if the images scale has not reached its target scale
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

// Checks if pressed
if (is_pressed)
{
	// Checks if image scale has reached target scale
	if (image_xscale == target_scale && image_yscale == target_scale)
	{
		// Checks if scale is 100%
		if (image_xscale == 1 && image_yscale == 1)
		{
			// Checks if button sound effect has finished playing
			if (!audio_exists(sound_button))
			{
				// Closes game
				game_end();
			}
		}
		else
		{
			// Sets target scale to 100%
			target_scale = 1.0;	
		}
	}
}