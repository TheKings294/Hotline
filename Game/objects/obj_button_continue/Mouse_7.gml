// Checks if the game is paused
if (obj_game_manager.curr_game_state == GAME_STATE.PAUSED)
{
	// Sets the key variable to pressed
	is_pressed = true;
	// Sets the target scale
	target_scale = 0.9;
	// Speeds up the scale rate
	scale_rate = 0.9;
}