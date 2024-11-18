// Checks the current game state is playing
if(curr_game_state == GAME_STATE.PLAYING)
{	
	// Loops through the player objects
	with (obj_player)
	{
		// Draws the hud sprite in the top left corner
		draw_sprite(spr_hud_background, 0, 0, 0);
			
		// Checks if the player health is above 0
		if (player_health >= 1)
		{
			// Draws the first health bar sprite at full strength
			draw_sprite_ext(spr_hud_health, 0, 86, 40, 1.0, 1.0, 0, c_white, 1.0);	
			
			// Checks the players health is above 1
			if (player_health >= 2)
			{
				// Draws the second health sprite at full strength
				draw_sprite_ext(spr_hud_health, 0, 237, 40, 1.0, 1.0, 0, c_white, 1.0);
				
				// Checks the players health is above 2
				if (player_health >= 3)
				{
					// Draws the third health sprite at full strength
					draw_sprite_ext(spr_hud_health_end, 0, 385, 40, 1.0, 1.0, 0, c_white, 1.0);
				}
				else
				{
					// Draws the third health sprite at fade out alpha
					draw_sprite_ext(spr_hud_health_end, 0, 385, 40, 1.0, 1.0, 0, c_white, hud_health_alpha);
				}
			}
			else
			{
				// Draws the second health sprite at fade out alpha
				draw_sprite_ext(spr_hud_health, 0, 237, 40, 1.0, 1.0, 0, c_white, hud_health_alpha);	
			}
		}
		else
		{
			// Draws the first health bar sprite at fade out alpha
			draw_sprite_ext(spr_hud_health, 0, 86, 40, 1.0, 1.0, 0, c_white, hud_health_alpha);	
		}

		// Loops through the current ammo count
		for (var _i = 0; _i < player_curr_ammo; _i++)
		{
			// Checks if its the first ammo
			if (_i == 0)
			{
				// Draws the starting ammo sprite
				draw_sprite(spr_hud_ammo_start, 0, 58, 85);
			}
			else
			{
				// Draws the remaining ammo sprites at offset based on the loops count
				draw_sprite(spr_hud_ammo, 0, 53 + (_i) * 11, 85);
			}
		}
		
		// Sets the draw options for the scores text
		draw_set_font(obj_game_manager.score_font);
		draw_set_color(obj_game_manager.score_colour);
		draw_set_alpha(obj_game_manager.score_alpha);
		draw_set_halign(obj_game_manager.score_halign);
		draw_set_valign(obj_game_manager.score_valign);
		
		// Draws the text
		draw_text(room_width / 2, 64, string(player_score));
		
		// Returns the draw options to defaults
		draw_set_color(c_white);
		draw_set_alpha(1.0);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
	
	// Hides the cursor
	window_set_cursor(cr_none);
	
	// Sets the alpha to 0.5 for the crosshair
	draw_set_alpha(0.5);
	
	// Checks if the player is aiming
	if (obj_player.is_mouse_aiming)
	{
		// Draws the crosshair sprite on the players mouse position
		draw_sprite(spr_crosshair, 0, mouse_x - x, mouse_y - y);
	}
	else
	{
		// Crosshair position offsets
		var _offset_x = 400;
		var _offset_y = 0;
		
		// Converts angle to radians
		var _theta = degtorad(real(obj_player.gun_angle));
	
		// Calculates the adjusted repositioned angles from the set offsets and angle
		var _crosshair_adjust_x = (_offset_x * cos(_theta)) - (_offset_y * sin(_theta));
		var _crosshair_adjust_y = (_offset_y * cos(_theta)) + (_offset_x * sin(_theta));
	
		// Updates the position to the adjusted player positions
		var _crosshair_pos_x = obj_player.x + _crosshair_adjust_x;
		var _crosshair_pos_y = obj_player.y - _crosshair_adjust_y;
		
		// Sets buffer for crosshair to be from edge of screen
		var _crosshair_buffer = 60;
		
		// Clamps crosshair postions to be in players view
		_crosshair_pos_x = clamp(_crosshair_pos_x - x, _crosshair_buffer, room_width - _crosshair_buffer);
		_crosshair_pos_y = clamp(_crosshair_pos_y - y, _crosshair_buffer, room_height - _crosshair_buffer);
		
		// Draws the crosshair at the adjusted position
		draw_sprite(spr_crosshair, 0, _crosshair_pos_x, _crosshair_pos_y);
	}
	
	// Resets the draw alpha
	draw_set_alpha(1.0);
}
else
{
	// Shows the default normal cursor
	window_set_cursor(cr_default);
}