// Checks game is not paused
if (obj_game_manager.curr_game_state != GAME_STATE.PAUSED)
{	
	// Checks if enemy is spawning
	if (is_spawning)
	{
		// Slows enemy to half speed but still lets them move into arena
		speed = 1.5;	
	}
	else
	{	
		// Sets colliding state to true
		is_colliding = true;
	
		// Recalculates path to target
		find_path();
	
		// Calculates distance to player
		var _player_dist = point_distance(x, y, other.x, other.y);
		// Calculates direction of player
		var _player_dir = point_direction(other.x, other.y, x, y);
		// Sets buffer value to repel from player
		var _buff = 184;
		
		// Calculates speed of repulsion from player
		var _repulse_x = lengthdir_x(clamp(1 - _player_dist / _buff, 0, 1), _player_dir) * _buff;
		var	_repulse_y = lengthdir_y(clamp(1 - _player_dist / _buff, 0, 1), _player_dir) * _buff;

		// Adjusts the new speed
		var _adjusted_speed_x = lerp(hspeed, hspeed + _repulse_x, repulse_rate) * speed_dropoff;
		var _adjusted_speed_y = lerp(vspeed, vspeed + _repulse_y, repulse_rate) * speed_dropoff;
	
		// Applies the speed to the position
		x = lerp(x, x + _adjusted_speed_x, 0.99);
		y = lerp(y, y + _adjusted_speed_y, 0.99);
	
		// Slows the speed down
		speed *= speed_dropoff;
	}
}