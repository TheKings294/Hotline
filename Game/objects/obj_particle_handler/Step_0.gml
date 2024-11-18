// Checks if owner has been set
if (owner != noone)
{
	// Checks if dust particles
	if (is_dust)
	{	
		// Checks if the game state is not paused
		if (obj_game_manager.curr_game_state != GAME_STATE.PAUSED)
		{
			// Sets target alpha from speed
			target_alpha = (1 / owner.max_speed) * owner.speed;
		
			// Lerps the alpha to target
			current_alpha = lerp(current_alpha, target_alpha, 0.1);
		}
		
		// Sets the dusts alpha
		part_system_color(particle_sys,c_white, current_alpha);
		
		// Stores the direction angle as a real variable
		var _new_angle = real(owner.direction);
		
		// Applies angle to particle system
		part_system_angle(particle_sys, _new_angle + 90);
		
		// Converts angle to radians
		var _theta = degtorad(_new_angle);
	
		// Calculates the adjusted repositioned angles from the set offsets and angle
		var _projectile_adjust_x = (x_offset * cos(_theta)) - (y_offset * sin(_theta));
		var _projectile_adjust_y = (y_offset * cos(_theta)) + (x_offset * sin(_theta));
	
		// Updates the position to the adjusted owner positions
		x = owner.x + _projectile_adjust_x;
		y = owner.y - _projectile_adjust_y;
	}
	else
	{
		// Checks if postion should be at an offset
		if (is_offset)
		{ 
			// Stores the players gun angle as a real variable
			var _new_angle = real(owner.gun_angle);
		
			// Applies angle to particle system
			part_system_angle(particle_sys, _new_angle);
		
			// Converts angle to radians
			var _theta = degtorad(_new_angle);
	
			// Calculates the adjusted repositioned angles from the set offsets and angle
			var _projectile_adjust_x = (x_offset * cos(_theta)) - (y_offset * sin(_theta));
			var _projectile_adjust_y = (y_offset * cos(_theta)) + (x_offset * sin(_theta));
	
			// Updates the position to the adjusted owner positions
			x = owner.x + _projectile_adjust_x;
			y = owner.y - _projectile_adjust_y;
		}
		else
		{
			// Updates the position to the owner positions
			x = owner.x;
			y = owner.y;
		}
	}
	
	// Updats the particle system position to the object position
	part_system_position(particle_sys, x, y);
}

// Checks if the game state is paused
if (obj_game_manager.curr_game_state == GAME_STATE.PAUSED)
{
	// Stops updating the particle systems
	part_system_automatic_update(particle_sys, false)
}
else
{
	// Resumes updating the particle systems
	part_system_automatic_update(particle_sys, true)
}

// Checks if the particle system has finished
if (part_particles_count(particle_sys) == 0 && !is_dust)
{
	// Cleans up the particle system
	part_system_destroy(particle_sys);
	// Destroys the object
	instance_destroy();
}
// Checks if dust particles
else if (is_dust)
{
	// Checks if player dust
	if (owner.object_index == obj_player)
	{
		// Checks if player is dead
		if (owner.player_health <= 0)
		{
			// Checks if the game state is not paused
			if (obj_game_manager.curr_game_state != GAME_STATE.PAUSED)
			{
				// Lerps alpha to 0
				current_alpha = lerp(current_alpha, 0, 0.9);
			}
			
			// Sets alpha to dust
			part_system_color(particle_sys, c_white, current_alpha);
			
			// Checks if dust is invisible
			if (current_alpha <= 0)
			{
				// Cleans up the particle system
				part_system_destroy(particle_sys);
				// Destroys the object
				instance_destroy();
			}
		}
	}
	// Checks if enemy dust
	else if (owner.object_index == obj_enemy)
	{
		// Checks if enemy is dead
		if (owner.curr_health <= 0)
		{
			// Checks if the game state is not paused
			if (obj_game_manager.curr_game_state != GAME_STATE.PAUSED)
			{
				// Lerps alpha to 0
				current_alpha = lerp(current_alpha, 0, 0.9);
			}
			
			// Sets alpha to dust
			part_system_color(particle_sys, c_white, current_alpha);
			
			// Checks if dust is invisible
			if (current_alpha <= 0)
			{
				// Cleans up the particle system
				part_system_destroy(particle_sys);
				// Destroys the object
				instance_destroy();
			}
		}
	}
}