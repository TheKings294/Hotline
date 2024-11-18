// Checks if touch ID is set
if (touch_id != -1)
{
	// Checks if set ID is pressed
	if (device_mouse_check_button(touch_id, mb_left))
	{
		// Get x and y positions from ID and adjust from object position
		joy_x = device_mouse_x_to_gui(touch_id) - x;
		joy_y =	device_mouse_y_to_gui(touch_id) - y;
		
		// Create temp variables for direction and distance of pressed point
		var _direction = point_direction(0, 0, joy_x, joy_y);
        var _distance = point_distance(0, 0, joy_x, joy_y);
        
		// Checks if distance is greater than radius
        if (_distance > radius)
        {
			// Clamps the points based on the direction of joystick
			joy_x = lengthdir_x(radius, _direction);
			joy_y = lengthdir_y(radius, _direction);
        }
		
		// Sets the values of the joystick to a clamped values between -1 and 1
		joy_v = clamp(joy_x / radius, -1, 1);
		joy_h = clamp(joy_y / radius, -1, 1);
	}
	else
	{
		// Resets all the joystick variables since not being interacted with
		touch_id = -1;
		joy_x = 0;
		joy_y = 0;
		joy_h = 0;
		joy_v = 0;
	}
}