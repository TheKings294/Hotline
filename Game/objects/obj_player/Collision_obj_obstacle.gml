// Checks if game is not paused
if (obj_game_manager.curr_game_state != GAME_STATE.PAUSED)
{	
	// Calculates distance to obstacles center
	var _obs_dist = point_distance(x, y, other.x, other.y);
	// Calculates direction to obstacle
	var _obs_dir = point_direction(other.x, other.y, x, y);
	
	// Sets buffer from sprite dimentions
	var _x_buff = other.sprite_width * 0.75;
	var _y_buff = other.sprite_height * 0.75;
	
	// Calculates the repulse speed from the distance and direction
	var _repulse_x = lengthdir_x(clamp(1 - _obs_dist / _x_buff, 0, 1), _obs_dir) * _x_buff * 1.5;
	var	_repulse_y = lengthdir_y(clamp(1 - _obs_dist / _y_buff, 0, 1), _obs_dir) * _y_buff * 1.5;
	
	// Adds the new speed to the existing speed
	hspeed += _repulse_x;
	vspeed += _repulse_y;
	
	// Clamps the speed to maximum speed
	hspeed = clamp(hspeed, -max_speed, max_speed);
	vspeed = clamp(vspeed, -max_speed, max_speed);
}