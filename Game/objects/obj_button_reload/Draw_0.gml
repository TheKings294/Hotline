// Checks if the game is currently playing
if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
{
	// Updates reload button positions based on camera position and offsets
	x = camera_get_view_x(view_camera[0]) + 1920 * 0.775;
	y = camera_get_view_y(view_camera[0]) + 1080 * 0.625;
	
	// Draws reload button on screen
	draw_self();
}