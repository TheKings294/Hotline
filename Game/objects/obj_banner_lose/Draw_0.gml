// Sets black rectangle behind lose screen
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(x - (room_width / 2), (y + 108.5) - (room_height / 2), x + (room_width / 2), (y + 108.5) + (room_height / 2), false);

// Resets draw options to default
draw_set_color(c_white);
draw_set_alpha(1.0);

// Draws lose banner sprite
draw_self();

// Sets the lose banners texts draw options
draw_set_font(font_1);
draw_set_color(colour);
draw_set_halign(halign);
draw_set_valign(valign);

// Draws the text
draw_text(x, y - 64, text_1);

// Sets the sub text font
draw_set_font(font_2);

// Draws the text
draw_text(x, y + 32, text_2);

// Returns the draw options to defaults
draw_set_color(c_white);
draw_set_alpha(1.0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);