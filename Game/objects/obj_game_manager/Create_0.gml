// States used for storing the game playing state
enum GAME_STATE
{
	PLAYING,
	PAUSED,
	ENDED,
	SIZE
}

// Sets a random seed for the project
randomise();

// Variable for the current game state - initally set to playing
curr_game_state = GAME_STATE.PLAYING;
// Variable for storing the current wave - initally set to 0
curr_wave = 0;
// Variable for storing the maximum waves a player can go through
max_levels = 10;

// Variables for setting the grid size of the level
// can be changed to larger or smaller sizes for bigger or smaller levels
arena_grid_width = 8;
arena_grid_height = 8;

// Variables for cell sizes (background grid pieces)
cell_width = 512;
cell_height = 512;

// Variables for setting up the pathfiding grid
// The higher the rate the more precise the pathfinding but more resource demanding
grid_rate = 8;
grid = mp_grid_create(0, 0, arena_grid_width * grid_rate, arena_grid_height * grid_rate, cell_width / grid_rate, cell_height / grid_rate);

// Variables for setting up the rate gaps appear in the walls (enemy spawn points)
// Rate is how offten a side peice will become a gap
gap_rate = 1/3;
// Count is how many gaps are created
gap_count = 0;
// Min is the minimum amount of gaps a level can have or it will regenerate
gap_min = 2;
// Max is the maximum amount of gaps a level can have before it stops making more
gap_max = 8;

// Variables used for the score font used in the hud
score_font = fnt_luckiest_guy_48;
score_colour = c_white;
score_alpha = 0.75;
score_halign = fa_center;
score_valign = fa_middle;

// Variables used to check the last states of paused and new waves so they arnt acceidentally called twice
was_paused = false;
was_new_wave = false;

// Variable used to change how long the inital wave will take to start after the game begins
start_time = 3.0;
// Variable used to set the maximum amount of enemeies that can appear on screen at any time
max_enemies = 40;

// Creates pause button used in the top left corner of the screen
instance_create_layer(0, 0, "Popups", obj_button_pause);

// Creates the reload HUD popup
instance_create_layer(0, 0, "Popups", obj_reload_hud_element);

// Checks if game has touch controls
if (global.is_touch)
{
	// Creates the reload button
	instance_create_layer(0, 0, "Popups", obj_button_reload);
	
	// Creates the touch manager
	instance_create_layer(0, 0, "GM", obj_touch_manager);
	
	// Creates virtual joysticks
	instance_create_layer(0, 0, "Popups", obj_joystick_left);
	instance_create_layer(0, 0, "Popups", obj_joystick_right);
}

// Stops all sound
audio_stop_all();
// Plays the first music track and creates variable for music to play from
music = audio_play_sound(snd_music_menu_main, 100, true);

// Loops that create the level from the grid variables by its width and height
for (var _i = 0; _i < arena_grid_width; _i++)
{
	for (var _j = 0; _j < arena_grid_height; _j++)
	{
		// Checks if current grid element is on the left wall
		if (_i == 0)
		{
			// Checks if the current grid element is along the top wall
			if (_j == 0)
			{
				// Sets top left grid element
				var _new_wall = instance_create_layer(_i * cell_width, _j * cell_height, "Level", obj_level_wall);
				_new_wall.curr_face_type = FACE_TYPE.TOP_LEFT;
				_new_wall.set_sprite();
			}
			// Checks if the current grid element is along the bottom wall
			else if (_j == arena_grid_height - 1)
			{
				// Sets the bottom left grid element
				var _new_wall = instance_create_layer(_i * cell_width, _j * cell_height, "Level", obj_level_wall);
				_new_wall.curr_face_type = FACE_TYPE.BOTTOM_LEFT;
				_new_wall.set_sprite();
			}
			else
			{
				// Checks if the wall element should become a gap if too many dont already exist
				if (random(1.0) <= gap_rate && gap_count < gap_max)
				{
					// Sets a left gap element
					var _new_wall = instance_create_layer(_i * cell_width, _j * cell_height, "Level", obj_level_wall);
					_new_wall.curr_face_type = FACE_TYPE.LEFT_GAP;
					_new_wall.set_sprite();
					
					// Creates an enemy spawner inside the gap location
					var _new_spawner = instance_create_layer(_new_wall.x - cell_width / 2, _new_wall.y + cell_height / 2, "Level", obj_enemy_spawner);
					_new_spawner.curr_face_direction = FACE_DIRECTION.LEFT;
					
					// Increases the gap count
					gap_count++;
				}
				else
				{
					// Sets a left wall element
					var _new_wall = instance_create_layer(_i * cell_width, _j * cell_height, "Level", obj_level_wall);
					_new_wall.curr_face_type = FACE_TYPE.LEFT;
					_new_wall.set_sprite();
				}
			}
		}
		// Checks if current grid element is on the right wall
		else if (_i == arena_grid_width - 1)
		{
			// Checks if current grid element is along the top wall
			if (_j == 0)
			{
				// Sets the top right grid element
				var _new_wall = instance_create_layer(_i * cell_width, _j * cell_height, "Level", obj_level_wall);
				_new_wall.curr_face_type = FACE_TYPE.TOP_RIGHT;
				_new_wall.set_sprite();
			}
			// Checks if the current grid element is along the bottom wall
			else if (_j == arena_grid_height - 1)
			{
				// Sets the bottom right grid element
				var _new_wall = instance_create_layer(_i * cell_width, _j * cell_height, "Level", obj_level_wall);
				_new_wall.curr_face_type = FACE_TYPE.BOTTOM_RIGHT;
				_new_wall.set_sprite();
			}
			else
			{
				// Checks if the wall element should become a gap if too many dont already exist
				if (random(1.0) <= gap_rate && gap_count < gap_max)
				{
					// Sets right gap element
					var _new_wall = instance_create_layer(_i * cell_width, _j * cell_height, "Level", obj_level_wall);
					_new_wall.curr_face_type = FACE_TYPE.RIGHT_GAP;
					_new_wall.set_sprite();
					
					// Creates an enemy spawner inside the gap location
					var _new_spawner = instance_create_layer(_new_wall.x + (3 * cell_width) / 2, _new_wall.y + cell_height / 2, "Level", obj_enemy_spawner);
					_new_spawner.curr_face_direction = FACE_DIRECTION.RIGHT;
					
					// Increases the gap count
					gap_count++;
				}
				else
				{
					// Sets a right wall element
					var _new_wall = instance_create_layer(_i * cell_width, _j * cell_height, "Level", obj_level_wall);
					_new_wall.curr_face_type = FACE_TYPE.RIGHT;
					_new_wall.set_sprite();
				}
			}
		}
		// Checks if current grid element is along the top wall
		else if (_j == 0)
		{
			// Checks if the wall element should become a gap if too many dont already exist
			if (random(1.0) <= gap_rate && gap_count < gap_max)
			{
				// Sets top gap element
				var _new_wall = instance_create_layer(_i * cell_width, _j * cell_height, "Level", obj_level_wall);
				_new_wall.curr_face_type = FACE_TYPE.TOP_GAP;
				_new_wall.set_sprite();
				
				// Creates an enemy spawner inside the gap location
				var _new_spawner = instance_create_layer(_new_wall.x + cell_width / 2, _new_wall.y - cell_height / 2, "Level", obj_enemy_spawner);
				_new_spawner.curr_face_direction = FACE_DIRECTION.TOP;
				
				// Increases the gap count
				gap_count++;
			}
			else
			{
				// Sets a top wall element
				var _new_wall = instance_create_layer(_i * cell_width, _j * cell_height, "Level", obj_level_wall);
				_new_wall.curr_face_type = FACE_TYPE.TOP;
				_new_wall.set_sprite();
			}
		}
		// Checks if current grid element is along the bottom wall
		else if (_j == arena_grid_height - 1)
		{
			// Checks if the wall element should become a gap if too many dont already exist
			if (random(1.0) <= gap_rate && gap_count < gap_max)
			{
				// Sets a bottom gap element
				var _new_wall = instance_create_layer(_i * cell_width, _j * cell_height, "Level", obj_level_wall);
				_new_wall.curr_face_type = FACE_TYPE.BOTTOM_GAP;
				_new_wall.set_sprite();
				
				// Creates an enemy spawner inside the gap location
				var _new_spawner = instance_create_layer(_new_wall.x + cell_width / 2, _new_wall.y + (3 * cell_height) / 2, "Level", obj_enemy_spawner);
				_new_spawner.curr_face_direction = FACE_DIRECTION.BOTTOM;
				
				// Increases the gap count
				gap_count++;
			}
			else
			{
				// Sets a bottom wall element
				var _new_wall = instance_create_layer(_i * cell_width, _j * cell_height, "Level", obj_level_wall);
				_new_wall.curr_face_type = FACE_TYPE.BOTTOM;
				_new_wall.set_sprite();
			}
		}
		else
		{
			// Sets a normal ground element
			instance_create_layer(_i * cell_width, _j * cell_height, "Level", obj_level_ground);
		}
	}
}

// Checks enough gaps have been created to fufil the minimum criteria
if (gap_count < gap_min)
{
	// Restarts room to try generate new level
	room_restart();	
}

// Variabls used for the rate flowers can be made per level grid cell
var _flower_rate = 3;
// Variable for the offset flowers can spawn from wall edges
var _flower_edge_offset = 240;

// Variable created to set the amount of flowers within the level
var _flower_count = round(arena_grid_width * arena_grid_height * _flower_rate);
	
// Loop for creation of flowers 
for (var _i = 0; _i < _flower_count; _i++)
{
	// Creates new flower at random location within the bounds of the level and offset
	var _new_flower_x = random_range(_flower_edge_offset, (cell_width * arena_grid_width) - _flower_edge_offset);
	var _new_flower_y = random_range(_flower_edge_offset, (cell_height * arena_grid_height) - _flower_edge_offset);
	instance_create_layer(_new_flower_x, _new_flower_y, "Flowers", obj_flower);
}

// Creates a player within the centre of the room and sets their ID to 0 (player 1) facing them down
var _player = instance_create_layer((arena_grid_width * cell_width) / 2, (arena_grid_height * cell_height) / 2,"Instances", obj_player);
_player.player_local_id = 0;
_player.image_angle = 270;
_player.gun_angle = 270;

// Variables for spwaning the obstacles within the room
// Rate of obstacles per grid cell in level
var _obstacle_rate = 0.2;
// Offset from room edges they can spawn
var _obstacle_edge_offset = 600;
// Buffer distance from each other they can spawn to allow spacing
var _obstacle_cell_buffer_width = cell_width * 1.5;
var _obstacle_cell_buffer_height = cell_height * 1.5;

// Total obstacle count based from the variables
var _obstacle_count = round(arena_grid_width * arena_grid_height * _obstacle_rate);

// Loop for creating the obstacles
for (var _i = 0; _i < _obstacle_count; _i++)
{
	// Variables for checking if a placement is possible
	var _new_search = true;
	var _can_place = true;
	
	// Variables for checking how many tries have been attempted to prevent excessive hangs
	var _tries = 0;
	var _max_tries = 60;
	
	// Variables for new obstacles position
	var _new_obstacle_x = 0;
	var _new_obstacle_y = 0;
	
	// Loop for searching
	while (_new_search)
	{
		// Reset loop criteria
		_new_search = false;
	
		// Set new positions
		_new_obstacle_x = random_range(_obstacle_edge_offset, (cell_width * arena_grid_width) - _obstacle_edge_offset);
		_new_obstacle_y = random_range(_obstacle_edge_offset, (cell_height * arena_grid_height) - _obstacle_edge_offset);
		
		// Loop through players
		with (obj_player)
		{
			// Check if objects within spawn location
			if (point_in_rectangle(_new_obstacle_x, _new_obstacle_y, x - _obstacle_cell_buffer_width, y - _obstacle_cell_buffer_height, x + _obstacle_cell_buffer_width, y + _obstacle_cell_buffer_height))
			{	
				// Ask for new search
				_new_search = true;
			}
		}
		
		// Checks if still can search
		if (_new_search == false)
		{
			// Loops through obstable objects within room
			with (obj_obstacle)
			{
				// Check if objects within spawn location
				if (point_in_rectangle(_new_obstacle_x, _new_obstacle_y, x - _obstacle_cell_buffer_width, y - _obstacle_cell_buffer_height, x + _obstacle_cell_buffer_width, y + _obstacle_cell_buffer_height))
				{
					// Ask for new search
					_new_search = true;
				}
			}
		}
		
		// Increase try counter
		_tries++;
		
		// Check if tries have been exceded and still needs to search
		if (_tries >= _max_tries && _new_search)
		{
			// Stops search but cant place obstacle
			_can_place = false;
			_new_search = false;
		}
	}
	
	// Checks if can place obstacle
	if (_can_place)
	{
		// Creates new obstacle at desired position
		instance_create_layer(_new_obstacle_x, _new_obstacle_y, "Obstacles", obj_obstacle);
	}
}

// Adds the obstacle objects to the enemies pathfiding grid
var _add_grid_obstacles = function()
{
	 mp_grid_add_instances(grid, obj_obstacle, true);
}

// Calls the obstacle objects to be added to the path finding after one from to allow them to set their sprites
var _handle =  call_later(1, time_source_units_frames, _add_grid_obstacles);

// Function used to pause the game
pause_game = function()
{
	// Changes the current game state to paused
	curr_game_state = GAME_STATE.PAUSED;
	// Creates the pause menu on the screen
	layer_sequence_create("Popups", camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2), camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2), seq_pause);
	
	// Sets all the players to stop moving and saves their last speed if moving
	with(obj_player)
	{
		if (speed != 0)
		{
			last_speed = speed;
			speed = 0;
		}
	}
	
	// Sets all the players firing animations to stop moving and saves their last speed if moving
	with(obj_player_shoot)
	{
		if (image_speed != 0)
		{
			last_image_speed = image_speed;
			image_speed = 0;
		}
	}
	
	// Sets all the enemies to stop moving and saves their last speed if moving
	with(obj_enemy)
	{
		if (speed != 0)
		{
			last_speed = speed;
			speed = 0;
		}
	}
	
	// Sets all the projectiles to stop moving and saves their last speed if moving
	with(obj_projectile)
	{
		if (speed != 0)
		{
			last_speed = speed;
			speed = 0;
		}
	}
	
	// Pauses all audio
	audio_pause_all();
	// Plays button sound effect
	var _button_push = audio_play_sound(snd_menu_button, 100, false);
}

// Function used to resume the game
resume_game = function()
{
	// Sets the current games state to playing
	curr_game_state = GAME_STATE.PLAYING;
	
	// Destroys the pause menu
	with(obj_banner_pause)
	{
		instance_destroy();	
	}
	
	// Destroys the pause menu buttom
	with(obj_button_main_menu)
	{
		instance_destroy();	
	}
	
	// Destroys the pause play button
	with(obj_button_continue)
	{
		instance_destroy();	
	}
	
	// Sets the players move speed back to its previous value
	with(obj_player)
	{
		speed = last_speed;
	}
	
	// Sets the players shooting animation speed back to its previous value
	with(obj_player_shoot)
	{
		image_speed = last_image_speed;	
	}
	
	// Sets the enemies speed back to their previous value
	with(obj_enemy)
	{
		speed = last_speed;
	}
	
	// Sets the projectiles speed back to their previous value
	with(obj_projectile)
	{
		speed = last_speed;
	}
	
	// Resumes all audio
	audio_resume_all();
	// Plays button sound effect
	var _button_push = audio_play_sound(snd_menu_button, 100, false);
}

// Function used when wave is cleared
wave_cleared = function()
{
	// Creates wave complete banner
	layer_sequence_create("Popups", camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2), camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2), seq_wave_cleared);
	
	// Stops the current music
	audio_stop_sound(music);
	// Resets and plays round clear music
	music = -1;
	music = audio_play_sound(snd_music_round_clear, 100, false);
}

// Fuction used when wave is incoming
wave_incoming = function()
{
	// Creates wave incoming banner
	layer_sequence_create("Popups", camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2), camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2), seq_wave_incoming);
	
	// Checks if not on wave 1
	if (curr_wave > 1)
	{
		// Stops the current music
		audio_stop_sound(music);
		// Resets and plays random song for new round
		music = -1;
		music = audio_play_sound(choose(snd_music_game_1, snd_music_game_2, snd_music_game_3), 100, true);	
	}
}

// Function used for calling a new wave through the spawners
wave_new_spawners = function()
{
	// Variable used for the enemy spawn rate
	var _enemy_rate = 0.1;
	
	// Variable that calculates how many enemies will spawn based on the room size, current wave and enemy rate
	var _enemy_count = ceil((arena_grid_width - 2)  * (arena_grid_height - 2) * _enemy_rate * curr_wave);
	
	// Loops through the enemy count
	for (var _i = 0; _i < _enemy_count; _i++)
	{
		// Picks a random spawner to spawn from
		var _picked_spawner = irandom(instance_number(obj_enemy_spawner) - 1)
		// Variable for counting current spawner
		var _curr_spawner = 0;
		
		// Loops through the spawners
		with(obj_enemy_spawner)
		{
			// Checks if the current spawner is the picked spawner
			if (_curr_spawner == _picked_spawner)
			{
				// Adds and enemy to its spawn queue
				spawn_queue++;
			}
			
			// Increases the current spawner count
			_curr_spawner++;
		}
	}
}

// Function called for when the player loses the game
lose_game = function()
{
	// Sets the current game state to ended
	curr_game_state = GAME_STATE.ENDED;
	// Creates the gameover banner popup
	layer_sequence_create("Popups", camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2), camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2), seq_lose);
	
	// Stops the current game music
	audio_stop_sound(music);
	// Resets and sets the music to play the lose sound
	music = -1;
	music = audio_play_sound(snd_music_lose, 100, false);
}

// Function called for when the player completes the game
win_game = function()
{
	// Sets the current game state to ended
	curr_game_state = GAME_STATE.ENDED;
	// Creates the template complete banner popup
	layer_sequence_create("Popups", camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2), camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2), seq_win);
	
	// Stops the current game music
	audio_stop_sound(music);
	// Resets and sets the music to play the clear sound
	music = -1;
	music = audio_play_sound(snd_music_round_clear, 100, false);
}