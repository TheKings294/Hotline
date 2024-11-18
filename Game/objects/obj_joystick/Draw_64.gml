// Checks if the game is currently playing
if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
{
	// Draws the base of the joystick
	draw_self();
	// Draws the top head of joystick at adjusted locations
	draw_sprite(spr_joystick_tap, 0, x + joy_x, y + joy_y);
}