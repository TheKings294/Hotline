// Checks if the owner id does not match the hit players id
if (owner.id != other.id)
{
	// Checks if the player is flashed
	if (!other.is_flashed)
	{
		// Checks if the owner is a player
		if (owner.object_index == obj_player)
		{
			// Stores the owners local id
			var _owner_id = owner.player_local_id;
		
			// Loops through players
			with (obj_player)
			{
				// Checks if the players local id matches its own local id
				if (self.player_local_id == _owner_id)
				{
					// Increases the players score by 500
					self.player_score += 500;
				}
			}
		}
		
		// Sets the player to flashed state
		other.is_flashed = true;
		// Sets the hud alpha for player to 1 meaning it will fade out
		other.hud_health_alpha = 1.0;
		// Reduces the players health
		other.player_health--;
		
		// Plays player hit sound effect
		var _sound_player_hit = audio_play_sound(snd_player_hit, 100, false, 0.6, 0, 1.0);
	}
	// Calls spark projectile function
	spark_projectile();
}