// Variables for the lose banner text
text_1 = "YOU LOSE";
text_2 = "";
player_score = 0;
font_1 = fnt_luckiest_guy_96_outline;
font_2 = fnt_luckiest_guy_36_outline;
colour = c_white;
halign = fa_center;
valign = fa_middle;

// Sets the lose banner text to the players score
player_score = obj_player.player_score;
text_2 = "SCORE: " + string(player_score);

// Sets font to have outline effect
font_enable_effects(fnt_luckiest_guy_96_outline, true, {
    outlineEnable: true,
    outlineDistance: 4,
    outlineColour: c_black
});

// Sets font to have outline effect
font_enable_effects(fnt_luckiest_guy_36_outline, true, {
    outlineEnable: true,
    outlineDistance: 2,
    outlineColour: c_black
});

// Creates empty array for the highscores
highscores = [];

// Loops 10 times
for (var _i = 0; _i < 10; _i ++)
{
	// Stores the highscores to 0
	highscores[_i] = 0;
}

// Loads the high scores buffer
high_score_buffer = buffer_load("TWIN_STICK_HS.sav");

// Checks if the buffer exists
if(buffer_exists(high_score_buffer))
{
	// Goes to the start of the buffer
	buffer_seek(high_score_buffer, buffer_seek_start, 0);
	
	// Loops 10 times
	for (var _i = 0; _i < 10; _i ++)
	{
		// Reads the highscores from the buffer and stores them in the array
		highscores[_i] = buffer_read(high_score_buffer, buffer_u64);
	}
}
else
{
	// Creates the highscore buffer
	high_score_buffer = buffer_create(16384, buffer_fixed, 2);
	
	// Goes to the start of the buffer
	buffer_seek(high_score_buffer, buffer_seek_start, 0);
	
	// Loops 10 times
	for (var _i = 0; _i < 10; _i ++)
	{
		// Writes to the highscore buffer the empty scores
		buffer_write(high_score_buffer, buffer_u64, highscores[_i]);
	}
}

// Creates varaibles used for sorting the highscore table
var _is_swapping = false;
var _stored_score = -1;

// Loops 10 times
for (var _i = 0; _i < 10; _i ++)
{
	// Checks if the players score is more than the highscore and it hasnt started swapping
	if (highscores[_i] < player_score && !_is_swapping)
	{
		// Changes the swapping state
		_is_swapping = true;
		// Stores the players score
		_stored_score = player_score;
	}
	
	// Checks if the table has started swapping
	if (_is_swapping)
	{
		// Stores the current highscore
		var _next_swap = highscores[_i];
		// Swaps the stored score into the highscore
		highscores[_i] = _stored_score;
		// Stores the last highscore
		_stored_score = _next_swap;
	}
}

// Goes to the start of the buffer
buffer_seek(high_score_buffer, buffer_seek_start, 0);
	
// Loops 10 times
for (var _i = 0; _i < 10; _i ++)
{
	// Writes the highscores to the buffer
	buffer_write(high_score_buffer, buffer_u64, highscores[_i]);
}

// Saves the highscore buffer
buffer_save(high_score_buffer, "TWIN_STICK_HS.sav");