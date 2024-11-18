// Checks the game is not paused
if (obj_game_manager.curr_game_state != GAME_STATE.PAUSED)
{
	// Checks player is still in play area
	if (x < wall_buffer || x > (obj_game_manager.arena_grid_width * obj_game_manager.cell_width) - wall_buffer)
	{
		// Clamps players position to play area
		x = clamp(x, wall_buffer, (obj_game_manager.arena_grid_width * obj_game_manager.cell_width) - wall_buffer);
		// Bounces against wall
		hspeed *= -speed_dropoff;
	}

	if (y < wall_buffer || y > (obj_game_manager.arena_grid_height * obj_game_manager.cell_height) - wall_buffer)
	{
		// Clamps players position to play area
		y = clamp(y, wall_buffer, (obj_game_manager.arena_grid_height * obj_game_manager.cell_height) - wall_buffer);
		// Bounces against wall
		vspeed *= -speed_dropoff;
	}

	// Updates previous mouse positions
	mouse_prev_x = mouse_x;
	mouse_prev_y = mouse_y;
}