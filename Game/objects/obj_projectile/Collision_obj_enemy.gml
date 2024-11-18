// Checks if the owner is a player
if (owner.object_index == obj_player)
{
	// Checks if the enemy not flashed and able to take damage
	if (!other.is_flashed)
	{
		// Sets player id
		var _owner_id = owner.player_local_id;
		// Sets inital score
		var _score = 100;
		
		// Changes the enemy to flashed
		other.is_flashed = true;
		// Reduces enemy health
		other.curr_health--;
		
		// Creates an enemy hit sound
		var _sound_enemy_hit = audio_play_sound(snd_enemy_hit, 100, false, 0.5, 0, 1.0);
		
		// Checks if the enemy is out of health
		if (other.curr_health <= 0)
		{
			// Changes possible score to 300
			_score = 300;
		}
	
		// Loops through players
		with (obj_player)
		{
			// Looks for player with matching local ID
			if (self.player_local_id == _owner_id)
			{
				// Increases the players score
				self.player_score += _score;
			}
		}
	}
	
	// Calls spark projectile function
	spark_projectile();
}