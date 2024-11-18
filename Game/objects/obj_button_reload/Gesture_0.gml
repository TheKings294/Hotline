// Checks if the button has not been pressed
// Checks if the button is aready being pressed
if (!is_pressed)
{
	// Sets the buttons scale to 95%
	target_scale = 0.95;
}

// Checks if the game is currently playing
if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
{
	// Tells the player to reload if isnt already reloading
	if (!obj_player.player_is_reloading)
	{
		// Sets the reloading to true
		obj_player.player_is_reloading = true;
		
		// Checks if reloading sound loop isn't playing
		if(!audio_is_playing(obj_player.reloading_sound))
		{
			// Plays reloading sound loop
			obj_player.reloading_sound = audio_play_sound(snd_gun_reload, 100, true, 0.4, 0, 1.0);
		}
	}
	
	// Sets the key variable to pressed
	is_pressed = true;
	// Sets the target scale
	target_scale = 0.9;
	// Speeds up the scale rate
	scale_rate = 0.9;
}