// Sets the buttons draw options
draw_set_font(font);
draw_set_color(colour);
draw_set_halign(halign);
draw_set_valign(valign);

// Draws the continue button
draw_self();

// Draws the buttons text scaled
draw_text_transformed(x, y + 10, text, image_xscale, image_yscale, 0);

// Returns the draw options to defaults
draw_set_color(c_white);
draw_set_alpha(1.0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);