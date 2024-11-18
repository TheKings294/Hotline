// Checks player exists
if (instance_exists(obj_player))
{	
	// Checks the current value for players ammo and displays when less than 20% ammo
	if (obj_player.player_curr_ammo <= obj_player.player_max_ammo * 0.2)
	{		
		// Tracks time to transition alpha on and off
		alpha_time += delta_time * 0.000001;
		
		// Variable used for the rate
		var _alpha_rate = 0.2;
		
		// Checks if first transition is finished
		if (alpha_target >= 0.99 && alpha_time >= _alpha_rate)
		{
			// Sets values for second transition
			alpha_time = 0;
			alpha_target = 0;
		}
		// Checks if second transition is finished
		else if (alpha_target <= 0.01 && alpha_time >= _alpha_rate)
		{
			// Sets values for first transition
			alpha_time = 0;
			alpha_target = 1;
		}
	}
	else
	{
		// Resets the alpha to transparent (or just below zero alpha to help for smoother fade out)
		alpha_time = 0;
		alpha_target = -0.1;
	}
	
	// Adjusts the alpha to desired target
	image_alpha = lerp(image_alpha, alpha_target, 0.1);
}
else
{
	// Destroys the object as player would be dead and values unreadable
	instance_destroy();	
}