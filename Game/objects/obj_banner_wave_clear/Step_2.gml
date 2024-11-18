// Checks if the game is playing
if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
{
	// Updates the banner position based on the camera position
	x = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2);
	y = camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2) - 217;
}