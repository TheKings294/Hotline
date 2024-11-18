// Draws players shadow sprite
draw_sprite_ext(spr_player_shadow, 0,x, y, 1.0, 1.0, body_angle, c_white, image_alpha);

// Checks if player is flashed
if (is_flashed)
{
	// Draws gun shadow
	draw_sprite_ext(spr_player_gun_shadow, 0, x, y, 1.0, 1.0, gun_angle, c_white, image_alpha);
}

// Change image index to if flashed or not
image_index = is_flashed;
// Draw player body sprite
draw_self();

// Checks if player isnt flashed
if (!is_flashed)
{
	// Draws gun shadow now
	draw_sprite_ext(spr_player_gun_shadow, 0,x, y, 1.0, 1.0, gun_angle, c_white, image_alpha);
}

// Draws the players gun and index depends on if flashed
draw_sprite_ext(spr_player_gun, is_flashed,x, y, 1.0, 1.0, gun_angle, c_white, image_alpha);