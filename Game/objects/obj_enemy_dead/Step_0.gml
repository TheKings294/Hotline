// Checks if the game is not paused
if (obj_game_manager.curr_game_state != GAME_STATE.PAUSED)
{
	// Checks if the sequence is paused
	if (layer_sequence_is_paused(body_seq))
	{
		// Resumes the sequence
		layer_sequence_play(body_seq);
	}
	
	// Checks if the images alpha is visible
	if (image_alpha <= 0)
	{
		// Checks if the sequence has finished
		if (layer_sequence_is_finished(body_seq))
		{
			// Destroys the sequence
			layer_sequence_destroy(body_seq);
			// Destroys the object
			instance_destroy();
		}
	}
	else
	{
		// Reduces the sprites alpha by the rate
		image_alpha -= delta_time * 0.000001 * fade_rate;	
	}
}
else
{
	// Pauses the sequence
	layer_sequence_pause(body_seq);
}