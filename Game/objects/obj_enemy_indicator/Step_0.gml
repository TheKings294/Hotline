// Checks if game is playing
if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
{
	// Checks if the enemy target exists
	if (instance_exists(target))
	{
		// Sets the clamped x position to the target position 
		clamped_x = target.x - x;
		clamped_y = target.y - y;
		
		// Clamps the positions from the buffer and room size
		clamped_x = clamp(clamped_x, wall_buffer, room_width - wall_buffer);
		clamped_y = clamp(clamped_y, wall_buffer, room_height - wall_buffer);
		
		// Sets the direction from the room center and the clamped x and y positions
		target_direction = point_direction(room_width / 2, room_height / 2, clamped_x, clamped_y);
		
		// Sets the alpha target to the distance devided by a cell with a maximum value of 0.9
		target_alpha = min(point_distance(x + clamped_x, y + clamped_y, target.x, target.y) / (obj_game_manager.cell_width + obj_game_manager.cell_height) , 0.9);
		
		// Checks if the target alpha is above the current alpha
		if (target_alpha > curr_alpha)
		{
			// Lerps slowly
			curr_alpha = lerp(curr_alpha, target_alpha, 0.05);
		}
		else
		{
			// Lerps fast
			curr_alpha = lerp(curr_alpha, target_alpha, 0.9);
		}
	}
	else
	{
		// Sets the target alpha to 0
		target_alpha = 0;
		// Lerps alpha to target fast
		curr_alpha = lerp(curr_alpha, target_alpha, 0.5);
		
		// Checks if the alpha is now invisible
		if (curr_alpha <= 0)
		{
			// Destroys the object
			instance_destroy();
		}
	}
}