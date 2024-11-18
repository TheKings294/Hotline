// Checks if the game is currently playing
if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
{
	// Updates the object position by the cameras position
	x = camera_get_view_x(view_camera[0]);
	y = camera_get_view_y(view_camera[0]);
}