// Checks if the game is currently playing
if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
{	
	// Updates positions based on camera position and offsets
	x = obj_player.x;
	y = obj_player.y + 150;
	
	// Draws on screen
	draw_self();
}