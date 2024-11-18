// Checks if the game is playing
if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
{
	// Draws the banner sprite
	draw_self();

	// Sets the banners draw text options
	draw_set_font(font_1);
	draw_set_color(colour_1);
	draw_set_alpha(image_alpha);
	draw_set_halign(halign);
	draw_set_valign(valign);

	// Draws the banners text scaled to the banner
	draw_text_transformed(x, y - 64, text_1, image_xscale, image_yscale, image_angle)

	// Sets the banners sub text draw options
	draw_set_font(font_2);
	draw_set_color(colour_2);
	draw_set_alpha(image_alpha);
	
	// Draws the banners sub text scaled to the banner
	draw_text_transformed(x, y + 32, text_2, image_xscale, image_yscale, image_angle)
	
	// Returns the draw options to defaults
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}