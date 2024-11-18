// Checks to see if the game is playing
if(curr_game_state == GAME_STATE.PLAYING)
{
	// Checks for when new wave of enemies should be spawned
	// condition depends of if there are no enimes in the room
	// the current wave is not 0
	// and there are no banners present witin the room either
	if (instance_number(obj_enemy) <= 0 && curr_wave != 0 && !instance_exists(obj_banner_wave_clear) && !instance_exists(obj_banner_wave_incoming))
	{
		// Check for if a new wave is called
		if (was_new_wave)
		{
			// Variable that is used to check spawner queues are empty
			var _is_queue_empty = true
			
			// Loops through all the spawners
			with (obj_enemy_spawner)
			{
				// Checks if queue has more spawns to come
				if (spawn_queue > 0)
				{
					// Sets variable to false indicating queue is not empty
					_is_queue_empty = false;	
				}
			}
			
			// Checks if queue's were empty
			if (_is_queue_empty)
			{
				// Checks if the current wave is less than max waves
				if (curr_wave < max_levels)
				{
					// Increments the current wave 
					curr_wave++;
					// Runs the wave cleared fucction spawning the wave clear banner
					wave_cleared();
					// Sets the check for new wave to false
					was_new_wave = false;
				}
				else
				{
					// Calls win game function that shows the template complete banner
					win_game();
				}
			}
		}
		else
		{
			// Sets the check for new wave to true
			was_new_wave = true;
		}
	}
	// Checks if the current wave is 0 (game start)
	else if (curr_wave == 0)
	{
		// Checks if the start timer has run down yet
		if (start_time <= 0)
		{
			// Increments the current wave
			curr_wave++;
			// Runs the wave incoming function
			wave_incoming();
		}
		else
		{
			// Decreases the start time variable by 1 frame
			start_time -= delta_time * 0.000001;	
		}
	}
	
	// Variables used for the camera postions set to half the rooms width and height
	var _x_adjust = room_width / 2;
	var _y_adjust = room_height / 2;
	
	// Sets the cameras intial position variables
	var _cam_x = 0;
	var _cam_y = 0;
	
	// Loops through the players positions and adds them to the camera's position
	// done this way incase more than 1 player is used later and value can be manipulated by the player count
	with (obj_player)
	{
		_cam_x += obj_player.x;
		_cam_y += obj_player.y;
	}
	
	// Clamps the camera position to stay witin the games play area
	_cam_x = clamp(_cam_x, _x_adjust, (arena_grid_width * cell_width) - _x_adjust);
	_cam_y = clamp(_cam_y, _y_adjust, (arena_grid_height * cell_height) - _y_adjust);
	
	// Moves the camera positon based on the room dimensions
	_cam_x -= _x_adjust;
	_cam_y -= _y_adjust;
	
	// Sets the camera view position
	camera_set_view_pos(view_camera[0], _cam_x, _cam_y);
	
	// Moves the game manager position to the cameras x and y position
	x = _cam_x;
	y = _cam_y;
}
