// Checks if player has any health and the game is playing
if (player_health <= 0 && obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
{
	// Calls lose game function
	obj_game_manager.lose_game();
}