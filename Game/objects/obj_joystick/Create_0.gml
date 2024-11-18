// Variables for the joysicks position
joy_x = 0;
joy_y = 0;

// Variables for the joysticks values
joy_h = 0;
joy_v = 0;

// Touch ID passed through
touch_id = -1;

// Radius of the joystick base for clamping the values to
radius = sprite_width / 2;

// Function called to add the joystick touch ID
input = function(_touch_id)
{
	// Sets the touch ID
	touch_id = _touch_id;	
}