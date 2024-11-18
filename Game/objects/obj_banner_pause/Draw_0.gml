// Sets black rectangle behind pause screen
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(x - (room_width / 2), (y + 108.5) - (room_height / 2), x + (room_width / 2), (y + 108.5) + (room_height / 2), false);

// Resets draw options to default
draw_set_color(c_white);
draw_set_alpha(1.0);

// Draws pause banner sprite
draw_self();

// Sets the pause banners texts draw options
draw_set_font(font);
draw_set_color(colour);
draw_set_halign(halign);
draw_set_valign(valign);

// Draws the text
draw_text(x, y - 64, text);

// Returns the draw options to defaults
draw_set_color(c_white);
draw_set_alpha(1.0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);