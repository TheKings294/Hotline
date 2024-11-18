// Creates the splash screen squence
layer_sequence_create("Instances", room_width / 2, room_height / 2, seq_splash);

// Sets variables used for the highscore table visible state
is_highscore_table = false;
highscores_alpha = 0.0;
highscores_alpha_target = 0.0;

// Array used for storing the high scores within
highscores = [];

// Loops to set array to 0 values
for (var _i = 0; _i < 10; _i ++)
{
	highscores[_i] = 0;
}

// Loads buffer for highscores
high_score_buffer = buffer_load("TWIN_STICK_HS.sav");

// Checks if buffer exists
if(buffer_exists(high_score_buffer))
{
	// Goes to the start of the buffer
	buffer_seek(high_score_buffer, buffer_seek_start, 0);
	
	// Loops 10 times
	for (var _i = 0; _i < 10; _i ++)
	{
		// Sets the highscores to values read from the buffer
		highscores[_i] = buffer_read(high_score_buffer, buffer_u64);
	}
}
else
{
	// Creates highscore buffer
	high_score_buffer = buffer_create(16384, buffer_fixed, 2);
	// Goes to the start of the buffer
	buffer_seek(high_score_buffer, buffer_seek_start, 0);
	
	// Loops 10 times
	for (var _i = 0; _i < 10; _i ++)
	{
		// Writes highscore values to the buffer
		buffer_write(high_score_buffer, buffer_u64, highscores[_i]);
	}
	
	// Saves the new empty highscore buffer
	buffer_save(high_score_buffer, "TWIN_STICK_HS.sav");
}

// Variables used for highscore text
text = "HIGH SCORES";
font_1 = fnt_luckiest_guy_96_outline;
font_2 = fnt_luckiest_guy_36_outline;
colour = c_white;
halign = fa_center;
valign = fa_middle;

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

// Stops all previous running audio
audio_stop_all();
// Plays menu audio
music = audio_play_sound(snd_music_menu_main, 100, true);

// Checks if game is being played on android or ios devices for touch controls
if (os_type == os_android || os_type == os_ios)
{
	// Sets global touch to true
	global.is_touch = true;
}
else
{
	// Sets global touch to false
	global.is_touch = false;
}