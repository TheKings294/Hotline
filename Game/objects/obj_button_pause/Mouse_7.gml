// Checks if the game is currently playing
if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
{
	// Calls the pause game function
	obj_game_manager.pause_game();
	
	// Sets the key variable to pressed
	is_pressed = true;
	// Sets the target scale
	target_scale = 0.9;
	// Speeds up the scale rate
	scale_rate = 0.9;
}