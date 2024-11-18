// Checks for a maximum of 4 touches
var _max_devices = 4;

// Loops for the max times
for (var _i = 0; _i < _max_devices; _i++)
{
	// Sets the touch position to temporary variables from ID
	var _touch_x = device_mouse_x_to_gui(_i);
    var _touch_y = device_mouse_y_to_gui(_i);
    
	// Checks if a joystick is at that touched position
    var _joystick = instance_position(_touch_x, _touch_y, obj_joystick);
	
	// Checks if the touch positions is actively being pressed (can be released)
    var _held = device_mouse_check_button(_i, mb_left);
    
	// Checks if both the joystick exists at the position and is being held
    if (_joystick != noone && _held)
    {
		// Sets the joystick to read input from that touch ID
		_joystick.input(_i);
    }
}