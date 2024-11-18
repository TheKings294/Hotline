// Gets how many gamepads there are
var _max_pads = gamepad_get_device_count();

// Loops through gamepads
for (var _i = 0; _i < _max_pads; _i++)
{
	// Checks if gamepad is connected
	if (gamepad_is_connected(_i))
	{	
		// Checks if A button or start button pressed
		if (gamepad_button_check_released(_i, gp_face1) || gamepad_button_check_released(_i, gp_start))
		{
			// Sets button state to pressed
			is_pressed = true;
			// Changes target scale
			target_scale = 0.9;
			// Speeds up scaling rate
			scale_rate = 0.9;
			
			// Plays the button pushed sound effect
			sound_button = audio_play_sound(snd_menu_button, 100, false);
			
			// Sets global mouse aiming state to false since gamepad input
			global.is_mouse_aiming = false;
		}
	}
}

// Checks if image scale is not at target scale yet
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

// Checks if button has been pressed
if (is_pressed)
{
	// Checks if image scale is target scale
	if (image_xscale == target_scale && image_yscale == target_scale)
	{
		// Checks if image scale is 100%
		if (image_xscale == 1 && image_yscale == 1)
		{
			// Checks if button sound effect has finished playing
			if (!audio_exists(sound_button))
			{
				// Goes to arena room
				room_goto(rm_arena);
			}
		}
		else
		{
			// Sets target scale to 100%
			target_scale = 1.0;	
		}
	}
}