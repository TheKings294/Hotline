// Checks if the game is playing and the enemy is not spawning
if (obj_game_manager.curr_game_state != GAME_STATE.PAUSED && !is_spawning)
{		
	// Checks if the enemy goes either too far to the left or right of the level boundries
	if (x < wall_buffer || x > (obj_game_manager.arena_grid_width * obj_game_manager.cell_width) - wall_buffer)
	{
		// Clamps the enemy position to the levels playable width
		x = clamp(x, wall_buffer, (obj_game_manager.arena_grid_width * obj_game_manager.cell_width) - wall_buffer);
		// Looks for next nearest target
		lock_target();
		// Sets colliding state to true
		is_colliding = true;
	}

	// Checks if the enemy goes either too far to the top or bottom of the level boundries
	if (y < wall_buffer || y > (obj_game_manager.arena_grid_height * obj_game_manager.cell_height) - wall_buffer)
	{
		// Clamps the enemy position to the levels playable height
		y = clamp(y, wall_buffer, (obj_game_manager.arena_grid_height * obj_game_manager.cell_height) - wall_buffer);
		// Looks for next nearest target
		lock_target();
		// Sets colliding state to true
		is_colliding = true;
	}	
}