// Checks the game is playing
if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING)
{
	// Checks if the banner still has time to be shown
	if (banner_life > 0)
	{
		// Counts down the banner life
		banner_life -= delta_time * 0.000001;
		// Sets the variable to its actual alpha
		banner_alpha = image_alpha;
	}
	else
	{
		// Reduces the alpha of the banner to fade out
		banner_alpha -= delta_time * 0.000001 * 2;
		// Sets the alpha to the variable value
		image_alpha = banner_alpha;
	
		// Checks if the object has faded out
		if(image_alpha <= 0)
		{
			// Calls the wave incoming banner function
			obj_game_manager.wave_incoming();
			// Destroys the banner object
			instance_destroy();	
		}
	}
}