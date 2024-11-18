// Case statement used to control enemy behavior based on games state
switch(obj_game_manager.curr_game_state)
{
	// Case for when the game has ended
	case GAME_STATE.ENDED:
		// Enemy speed will slow down based on dropoff rate
		speed *= speed_dropoff;
		// Enemy speed cannot exceed maximum speed
		speed = min(speed, max_speed);
		break;
	// Case for when the game is playing
	case GAME_STATE.PLAYING:
		// Checks if the enemy is still spawning
		if (is_spawning)
		{
			// Checks if itself is within a collision rectangle created around the spawner it came from and sets itself to the variable is it still does
			var _instance = collision_rectangle(owner.x - (obj_game_manager.cell_width / 1.05), owner.y - (obj_game_manager.cell_height / 1.05), owner.x + (obj_game_manager.cell_width / 1.05) , owner.y + (obj_game_manager.cell_height / 1.05), self, true, false);
			
			// Checks if the variable is empty
			if (_instance == noone)
			{
				// Changes its spawning state to false
				is_spawning = false;
				// Locks the nearest player target and begins path finding
				lock_target();
				
				// Makes sure the direction it is traveling in matches its sprite facing
				direction = image_angle + 180;
			}
		}
		else
		{	
			// Checks if the next node is within threshold distance
			if (point_distance(x, y, next_node_x, next_node_y) <= node_threshold)
			{
				// Calls function to find new path
				find_path();
			}
			
			// Stores the node direction
			var _node_direction = point_direction(x, y, next_node_x, next_node_y);
	
			// Calculates the speed change to the next node position
			var _node_velo_x = lengthdir_x(max_speed, _node_direction);
			var _node_velo_y = lengthdir_y(max_speed, _node_direction);

			// Lerps the speed towards the next position
			hspeed = lerp(hspeed, _node_velo_x, speed_rate);
			vspeed = lerp(vspeed, _node_velo_y, speed_rate);
			
			// Caps the speed to the max speed
			speed = min(speed, max_speed);
			
			// Stores a tempory variable of self
			var _self = self;
			
			// Loops through obstacles witin the room
			with (obj_obstacle)
			{
				// Calculates the distance to obstacle
				var _repulse_dis = point_distance(_self.x, _self.y, x, y);
				
				// Checks distance is less than repulse distance
				if (_repulse_dis <= _self.repulse_buffer)
				{
					// Calculates strength of repulse from distance
					var _repulse_strength = _self.repulse_buffer / _repulse_dis;
					
					// Calculates direction of repulse from positions
					var _repulse_dir = point_direction(x, y, _self.x, _self.y);
				
					// Repulse speed calculated from direction, speed and strength
					var _repulse_velo_x = lengthdir_x(_self.max_speed, _repulse_dir) * _repulse_strength;
					var _repulse_velo_y = lengthdir_y(_self.max_speed, _repulse_dir) * _repulse_strength;
					
					// Lerps towards new speed
					_self.hspeed += lerp(_self.hspeed, _repulse_velo_x, _self.speed_rate);
					_self.vspeed += lerp(_self.vspeed, _repulse_velo_y, _self.speed_rate);
			
					// Limits speed by maximum speed
					_self.speed = min(_self.speed, _self.max_speed);
				}	
			}
			
			// Loops through enemies within the room
			with (obj_enemy)
			{
				// Checks enemy is not itself
				if (id != _self.id)
				{
					// Calculates the distance to enemy
					var _repulse_dis = point_distance(_self.x, _self.y, x, y);
					
					// Checks distance is less than repulse distance
					if (_repulse_dis <= _self.repulse_buffer)
					{
						// Calculates the strenght of repulse from distance
						var _repulse_strength = _self.repulse_buffer / _repulse_dis;
					
						// Calculates the direction of repulse from positions
						var _repulse_dir = point_direction(x, y, _self.x, _self.y);
				
						// Repulse speed calculated from direction speed and strength
						var _repulse_velo_x = lengthdir_x(_self.max_speed, _repulse_dir) * _repulse_strength;
						var _repulse_velo_y = lengthdir_y(_self.max_speed, _repulse_dir) * _repulse_strength;
					
						// Lerps towards new speed
						_self.hspeed += lerp(_self.hspeed, _repulse_velo_x, _self.speed_rate);
						_self.vspeed += lerp(_self.vspeed, _repulse_velo_y, _self.speed_rate);
						
						// Limits speed by maximum speed
						_self.speed = min(_self.speed, _self.max_speed);
					}
				}
			}
			
			// Calculates new angle from direction fliped because left facing
			var _new_angle = direction - 180;
			// Calculates the angle difference between the two facings
			var _angle_difference = angle_difference(_new_angle, image_angle);
			
			// Checks if colliding with something
			if (is_colliding)
			{
				// Adjusts the image angle to actual angle very slowly
				image_angle += _angle_difference * rotation_speed * speed_dropoff;
				// Sets state back to false
				is_colliding = false;
			}
			else
			{
				// Adjusts the image angle to actual angle
				image_angle += _angle_difference * rotation_speed;
			}
		
			// Calculates how far target is
			var _target_distance = point_distance(x, y, target.x, target.y);
		
			// Checks if target is inside ignore threshold
			if (_target_distance <= danger_close_distance)
			{
				// Slows speed down
				speed *= 0.1;
				// Allows firing without caring for other obstacles or enemies
				can_danger_close = true;
			}
			else
			{
				// Sets state back to false
				can_danger_close = false;	
			}
		
			// Checks if target distance is close enough to fire upon
			if (_target_distance <= fire_max_distance)
			{
				// Reduces fire cooldown
				fire_cooldown -= delta_time * 0.000001;
				
				// Checks if cooldown ready to fire
				if (fire_cooldown <= 0)
				{
					// Calls create projectile function
					create_projectile_enemy();
					// Resets cooldown
					fire_cooldown = fire_rate;
				}
			}
		}
		break;
}

// Checks if the enemy is flashed and the game is not paused
if (is_flashed && obj_game_manager.curr_game_state != GAME_STATE.PAUSED)
{
	// Reduces the flash cooldown
	flash_cooldown -= delta_time * 0.000001;

	// Checks if the flash cooldown has finished
	if (flash_cooldown <= 0)
	{
		// Resets the flash state
		is_flashed = false;
		// Resets the flash cooldown
		flash_cooldown = flash_time;
	}
}

// Checks if the enemy is out of health
if (curr_health <= 0)
{
	// Destroys itself
	instance_destroy();
}