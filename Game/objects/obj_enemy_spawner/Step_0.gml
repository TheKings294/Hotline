// Checks the current game is playing
if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
{
	// Checks if the spawner has a queue
	if (spawn_queue > 0)
	{
		// Checks if the cooldown has run down
		if (cooldown <= 0)
		{
			// Checks if the level has not exceded the maximum amount of enemies
			if(instance_number(obj_enemy) < obj_game_manager.max_enemies)
			{
				// Calls the spawn enemy function 
				spawn_enemy();
			}
		}
		else
		{
			// Counts down the spawner cooldown
			cooldown -= delta_time * 0.000001;
		}
	}
}