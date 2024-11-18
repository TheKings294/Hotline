// Variable for target scale
target_scale = 1.0;

// Variables for scaling rate
scale_rate = 0.1;
can_scale_at_rate = false;

// Variable for pressed state
is_pressed = false;

// Checks if game is in touch mode
if (global.is_touch)
{
	// Sets button to larger sprite
	sprite_index = spr_button_pause_mobile;	
}