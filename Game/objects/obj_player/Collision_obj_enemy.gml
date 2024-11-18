// Checks if game is playing
if (obj_game_manager.curr_game_state != GAME_STATE.PAUSED)
{
	// Drops off player speed
	speed *= speed_dropoff;
}