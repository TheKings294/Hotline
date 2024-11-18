// Checks if highscore table should show
if (is_highscore_table)
{
	// Sets target alpha to 1
	highscores_alpha_target = 1.0;	
}
else
{
	// Sets target alpha to 0
	highscores_alpha_target = 0.0;
}

// Lerps the current alpha to the target alpha at a rate of 0.1
highscores_alpha = lerp(highscores_alpha, highscores_alpha_target, 0.1);

// Checks if the highscores should draw based on their alpha
if (highscores_alpha != 0.0)
{
	// Sets the back sprite to transparent black rectangle
	draw_set_color(c_black);
	draw_set_alpha(0.6 * highscores_alpha);
	draw_rectangle((room_width / 4), (room_height / 8) - 20, (room_width / 4) * 3, ((room_height / 8) * 6) + 20, false);
	draw_set_alpha(1.0 * highscores_alpha);
	
	// Sets the highscore heading text
	draw_set_font(font_1);
	draw_set_color(colour);
	draw_set_halign(halign);
	draw_set_valign(valign);

	// Draws the highscore heading text
	draw_text(room_width / 2, room_height / 5, text);

	// Sets the highscore scores font
	draw_set_font(font_2);

	// Loops 10 times
	for (var _i = 0; _i < 10; _i++)
	{
		// Draws the highscores from the arrays values
		draw_text(room_width / 2, room_height / 3 + (48 * _i), highscores[_i]);
	}
	
	// Resets the draw values to default
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
