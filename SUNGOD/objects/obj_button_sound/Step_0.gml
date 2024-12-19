// Variable stores gamepad count
var _max_pads = gamepad_get_device_count();

// Loops though the gamepads
for (var _i = 0; _i < _max_pads; _i++)
{
	// Checks gamepad is connected
	if (gamepad_is_connected(_i))
	{	
		// Checks if the select button has been pressed 
		if (gamepad_button_check_pressed(_i, gp_select))
		{
			// Sets the key variable to pressed
			is_pressed = true;
			// Sets the target scale
			target_scale = 0.9;
			// Speeds up the scale rate
			scale_rate = 0.9;
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
			// Checks if the volume button is showing on sprite
			if (image_index == 0)
			{
				// Sets audio gain to 0
				global.audio_volume = 0;
				// Sets sprite to off state
				image_index = 1;
			}
			else
			{
				// Sets audio gain to 1
				global.audio_volume = 1;
				// Sets sprite to on state
				image_index = 0;
				
				// Plays button pushed sfx
				var _button_push = audio_play_sound(snd_menu_button, 100, false);
			}
			
			// Sets the master gain to audio volume variable
			audio_set_master_gain(0, global.audio_volume);
			
			// Resets the buttons pressed state
			is_pressed = false;
			// Resets the buttons scale rate
			scale_rate = 0.1;
		}
		else
		{
			// Set the target scale to full (1)
			target_scale = 1.0;	
		}
	}
}