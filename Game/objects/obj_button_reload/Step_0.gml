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
			// Resets the buttons pressed state
			is_pressed = false;
			// Resets the buttons scale rate
			scale_rate = 0.1;
		}
		else
		{
			// Resets the buttons scale
			target_scale = 1.0;	
		}
	}
}

// Checks if player exists before reading ammo count
if (instance_exists(obj_player))
{
	// Checks the current value for players ammo
	if (obj_player.player_curr_ammo == 0)
	{
		// Tracks time to blend colour back and forth
		blend_time += delta_time * 0.000001;
		
		// Variables used for the colour rate and values
		var _blend_rate = 0.25;
		var _blend_colour_1 = make_color_rgb(255, 20, 20);
		var _blend_colour_2 = make_color_rgb(255, 200, 20);
		
		// Sets to first colour if still white
		if (blend_target == c_white)
		{
			blend_target = _blend_colour_1;
		}
		
		// Checks if first blend is finished
		if (blend_target == _blend_colour_1 && blend_time >= _blend_rate)
		{
			// Sets values for second blend
			blend_time = 0;
			blend_target = _blend_colour_2;
		}
		// Checks if second blend is finished
		else if (blend_target == _blend_colour_2 && blend_time >= _blend_rate)
		{
			// Sets values for first blend
			blend_time = 0;
			blend_target = _blend_colour_1;
		}
	}
	else
	{
		// Resets blend to white
		blend_time = 0;
		blend_target = c_white;
	}
	
	// Adjusts the actual image blend to desired target
	image_blend = merge_color(image_blend, blend_target, 0.05);
}