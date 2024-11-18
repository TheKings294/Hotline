// Checks the game is not paused
if (obj_game_manager.curr_game_state != GAME_STATE.PAUSED)
{	
	// Checks if enemy is spawning
	if (is_spawning)
	{
		// Slows enemy to half speed but still lets them move into the arena
		speed = 1.5;	
	}
	else
	{
		// Sets colliding state to true
		is_colliding = true;
		
		// Recalculates path to enemy
		find_path();
	
		// Calculates distance to obstacle
		var _obs_dist = point_distance(x, y, other.x, other.y);
		// Calculates direction of obstacle
		var _obs_dir = point_direction(other.x, other.y, x, y);
	
		// Sets buffer values from obstacles dimensions
		var _x_buff = other.sprite_width * 0.9;
		var _y_buff = other.sprite_height * 0.9;
		
		// Calculates speed of repulsion from obstacle
		var _repulse_x = lengthdir_x(clamp(1 - _obs_dist / _x_buff, 0, 1), _obs_dir) * _x_buff;
		var	_repulse_y = lengthdir_y(clamp(1 - _obs_dist / _y_buff, 0, 1), _obs_dir) * _y_buff;

		// Adjusts and applies the new speed to the existing speed
		hspeed = lerp(hspeed, hspeed + _repulse_x, repulse_rate);
		vspeed = lerp(vspeed, vspeed + _repulse_y, repulse_rate);
	
		// Applies the speed to the position
		x += hspeed * speed_dropoff;
		y += vspeed * speed_dropoff;
	
		// Limits the speed to max speed
		hspeed = clamp(hspeed, -max_speed, max_speed);
		vspeed = clamp(vspeed, -max_speed, max_speed);
	}
}