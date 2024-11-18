// Checks if the game is playing
if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
{
	// Draws the indicator sprite at the clamped positions with the correct alpha value pointing at the enemy
	draw_sprite_ext(spr_enemy_indicator, 0, clamped_x, clamped_y, 1.0, 1.0, target_direction, c_white, curr_alpha);
}