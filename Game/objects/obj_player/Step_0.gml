// Checks if the game isnt paused
if (obj_game_manager.curr_game_state != GAME_STATE.PAUSED)
{
	// Applies speed dropoff to the players speed 
	hspeed *= speed_dropoff;
	vspeed *= speed_dropoff;

	// Checks if the game is playing
	if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
	{
		// Stores how many gamepad count
		var _max_pads = gamepad_get_device_count();

		// Loops through the gamepads
		for (var _i = 0; _i < _max_pads; _i++)
		{
			// Checks the gamepad is connected
		    if (gamepad_is_connected(_i))
		    {
				// Sets the gamepads deadzone
		        gamepad_set_axis_deadzone(_i, controller_deadzone);
		    }
		}

		// Checks if the players local id is 0 (player 1)
		if (player_local_id == 0)
		{
			// Checks for W or up key presses
			if (keyboard_check(ord("W")) || keyboard_check(vk_up))
			{
				vspeed -= move_speed;
			}
	
			// Checks for A or left key presses
			if (keyboard_check(ord("A")) || keyboard_check(vk_left))
			{
				hspeed -= move_speed;
			}
	
			// Checks for S or down key presses
			if (keyboard_check(ord("S")) || keyboard_check(vk_down))
			{
				vspeed += move_speed;
			}
			
			// Checks for D or right key presses
			if (keyboard_check(ord("D")) || keyboard_check(vk_right))
			{
				hspeed += move_speed;
			}
	
			// Checks if the mouse positions have moved and isnt touch screen
			if (mouse_x != mouse_prev_x || mouse_y != mouse_prev_y)
			{
				// Checks if it is not longer the first frame
				if (!is_first_frame)
				{
					// Sets mouse aiming to true
					is_mouse_aiming = true;
				}
				else
				{
					// Sets the first frame state to false
					is_first_frame = false;	
				}
			}
			// Checks if player has a controller connected to player 1
			else if (gamepad_is_connected(0))
			{
				// Checks if the gamepads right stick is moved
				if (gamepad_axis_value(0, gp_axisrv) != 0 || gamepad_axis_value(0, gp_axisrh) != 0)
				{
					// Sets mouse aiming state to false
					is_mouse_aiming = false;
				}
			}
	
			// Check if touch input
			if (global.is_touch)
			{
				// Disable mouse controls
				is_mouse_aiming = false;
			}
			else
			{
				// Checks if mouse is aiming
				if (is_mouse_aiming)
				{
					// Creates direction of pointing from player position to mouse position
					var _new_dir = point_direction(x, y, mouse_x, mouse_y);
					// Works out the change in direction
					var _delta_dir = abs(_new_dir - gun_angle)
				
					// Checks out if the change in direction is more than 180
					if (_delta_dir >= 180)
					{
						// Checks if the gun angle is greater than a half rotation
						if (gun_angle > 180)
						{
							// Reduces the gun angle by 1 rotation
							gun_angle -= 360;
						}
						else
						{
							// Increased the gun angle by 1 rotation
							gun_angle += 360;
						}
					}
	
					// Lerps the gun angle to the new directionat the rotation speed
					gun_angle = lerp(gun_angle, _new_dir, rotation_speed);
				}
			
				// Checks if the player has pressed the R key or right mouse button and isnt already reloading
				if ((keyboard_check(ord("R")) || mouse_check_button(mb_right)) && !player_is_reloading)
				{
					// Sets the reloading to true
					player_is_reloading = true;
				
					// Checks if reloading sound loop isn't playing
					if(!audio_is_playing(reloading_sound))
					{
						// Plays reloading sound loop
						reloading_sound = audio_play_sound(snd_gun_reload, 100, true, 0.4, 0, 1.0);
					}
				}
	
				// Checks for the space key or left mouse button
				if (keyboard_check(vk_space) || mouse_check_button(mb_left))
				{
					// Calls trigger pressed function to fire
					trigger_pressed();
				}
			}
		}
		else
		{
			// Sets mouse aiming off
			is_mouse_aiming = false;
		}
		
		// Grab vitual joystick input if they exist
		if (global.is_touch)
		{
			// Adds movement speed to player based on left stick input
			vspeed += move_speed * obj_joystick_left.joy_h;
			hspeed += move_speed * obj_joystick_left.joy_v;
	
			// Creates look positions based on right stick input
			var _look_x = obj_joystick_right.joy_h;
			var _look_y = -obj_joystick_right.joy_v;
			
			// Checks the look positions arent 0
			if (_look_x != 0 || _look_y != 0)
			{
				// Sets a new direction from the look positions
				var _new_dir = point_direction(0, 0, _look_x, _look_y) - 90;
				// Calculates the change in direction
				var _delta_dir = abs(_new_dir - gun_angle)
	
				// Checks if the change in direction is more than a half rotation
				if (_delta_dir > 180)
				{
					// Checks if gun angle is above a half roatation
					if (gun_angle > 180)
					{
						// Reduces gun angle by one rotation 
						gun_angle -= 360;
					}
					else
					{
						// Increases gun angle by one rotation
						gun_angle += 360;
					}
				}
				
				// Lerps gun angle towards new direction
				gun_angle = lerp(gun_angle, _new_dir, rotation_speed);
			}
			
			// Checks if the right joystick is currently being touched
			if (obj_joystick_right.touch_id != -1)
			{
				// Calls trigger function to fire
				trigger_pressed();
			}
		}
		// Checks if the gamepad matches the local player id
		else if (gamepad_is_connected(player_local_id))
		{	
			// Adds movement speed to player based on left stick input
			vspeed += move_speed * gamepad_axis_value(player_local_id, gp_axislv);
			hspeed += move_speed * gamepad_axis_value(player_local_id, gp_axislh);
	
			// Creates look positions based on right stick input
			var _look_x = gamepad_axis_value(player_local_id, gp_axisrv);
			var _look_y = -gamepad_axis_value(player_local_id, gp_axisrh);
			
			// Checks the look positions arent 0
			if (_look_x != 0 || _look_y != 0)
			{
				// Sets a new direction from the look positions
				var _new_dir = point_direction(0, 0, _look_x, _look_y) - 90;
				// Calculates the change in direction
				var _delta_dir = abs(_new_dir - gun_angle)
	
				// Checks if the change in direction is more than a half rotation
				if (_delta_dir > 180)
				{
					// Checks if gun angle is above a half roatation
					if (gun_angle > 180)
					{
						// Reduces gun angle by one rotation 
						gun_angle -= 360;
					}
					else
					{
						// Increases gun angle by one rotation
						gun_angle += 360;
					}
				}
				
				// Lerps gun angle towards new direction
				gun_angle = lerp(gun_angle, _new_dir, rotation_speed);
			}
			
			// Checks if the player has pressed the X or B buttons and isnt reloading
			if ((gamepad_button_check(player_local_id, gp_face3) || gamepad_button_check(player_local_id, gp_face2)) && !player_is_reloading)
			{
				// Sets reloading state to true
				player_is_reloading = true;
				
				// Checks if reloading audio is playing
				if(!audio_is_playing(reloading_sound))
				{
					// Sets reloading sound to looping sound
					reloading_sound = audio_play_sound(snd_gun_reload, 100, true, 0.4, 0, 1.0);
				}
			}
			
			// Checks if player has pressed the right trigger button
			if (gamepad_button_check(player_local_id, gp_shoulderrb))
			{
				// Calls trigger function
				trigger_pressed();
			}
		}
		
		// Limits speed to max speed
		speed = clamp(speed, -max_speed, max_speed);
		
		// Calculate change in body direction
		var _delta_body_dir = abs(body_angle - direction);
	
		// Checks if change is more than half a rotation
		if (_delta_body_dir >= 180)
		{
			// Checks if body is more than a half rotation
			if (body_angle > 180)
			{
				// Reduces the body angle by 1 rotation
				body_angle -= 360;
			}
			else
			{
				// Increases the body by 1 rotation
				body_angle += 360;
			}
		}
		
		// Lerps the body angle to the new direction
		body_angle = lerp(body_angle, direction, rotation_speed * 0.5);
		// Sets the image angle to the body angle
		image_angle = body_angle;
		
		// Checks if the player is reloading
		if (player_is_reloading)
		{
			// Checks if the player has less than max ammo
			if (player_curr_ammo < player_max_ammo)
			{
				// Increments reload cooldown timer
				player_reload_cooldown += delta_time * 0.000001;
				
				// Checks if the timer has more than the rate value
				if (player_reload_cooldown >= player_reload_rate)
				{
					// reduces the timer by the rate
					player_reload_cooldown -= player_reload_rate;
					// increases the ammo count
					player_curr_ammo++;
				}
			}
			else
			{
				// Sets reloading state to false
				player_is_reloading = false;	
				// Stops reloading sound
				audio_stop_sound(reloading_sound);
			}
		}
		// Checks if the fire cooldown is greater than 0
		if (player_fire_cooldown > 0)
		{
			// reduces the fireing cooldown
			player_fire_cooldown -= delta_time * 0.000001;	
		}
		
		// Checks if the player is flashed
		if (is_flashed)
		{
			// Reduces the flashed cooldown
			flash_cooldown -= delta_time * 0.000001;
			
			// Checks if the flashed cooldown has finished
			if (flash_cooldown <= 0)
			{
				// Set flashed state to false
				is_flashed = false;
				// Reset the flashed cooldown
				flash_cooldown = flash_time;
			}
		}
		
		// Checks if the health hud alpha is above 0
		if (hud_health_alpha > 0)
		{
			// reduces the alpha value
			hud_health_alpha -= delta_time * 0.000001 * 2;
		}
	}
	
	// Checks if the player has any health left
	if (player_health <= 0)
	{
		// Creates an explosion particle effect at the player
		var _new_boom = instance_create_depth(x, y, depth - 1, obj_particle_handler);
		_new_boom.set_character_defeat();
		_new_boom.owner = self;
		
		// Destroys the player
		instance_destroy();	
	}
}