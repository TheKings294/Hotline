// Variable for local player id
player_local_id = 0;
// Variable for player score
player_score = 0;
// Variable for player health
player_health = 3;

// Variable for player ammo
player_curr_ammo = 31;
// Variable for player max ammo
player_max_ammo = 31;
// Variable for player fire rate
player_fire_rate = 0.25;
// Variable for firing cooldown
player_fire_cooldown = 0;
// Variable for reload rate
player_reload_rate = 0.075;
// Variable for reload cooldown
player_reload_cooldown = 0;
// Variable for reloading state
player_is_reloading = false; 

// Variable for gamepad deadzone
controller_deadzone = 0.1;
// Variable for if player is mouse aiming
is_mouse_aiming = global.is_mouse_aiming;
// Variable for checking if the first frame has finished (used for mouse aiming)
is_first_frame = true;
// Variable for storing previous mouse positions
mouse_prev_x = mouse_x;
mouse_prev_y = mouse_y;

// Variable for the players buffer distance from arena edges
wall_buffer = 250;
// Variable for players rotation speed
rotation_speed = 0.25;
// Variable for players speed drop off
speed_dropoff = 0.9;
// Variable for players move speed
move_speed = 1;
// Variable for players maximum move speed
max_speed = 10;

// Sets players direction to its image angle
direction = image_angle;
// Variable for players gun angle
gun_angle = direction;
// Variable for players body angle
body_angle = direction;

// Variables for players speeds
hspeed = 0;
vspeed = 0;

// Variable for storing players speed when paused
last_speed = speed;

// Variable for players flashed state
is_flashed = false;
// Variable for players immunity time
flash_time = 0.2;
// Variable for immunity cooldown
flash_cooldown = flash_time;

// Variable for players last hud alpha
hud_health_alpha = 0;

// Variable for storing players reloading sound
reloading_sound = -1;

// Creates new particle emitter for dust smoke on left
var _new_dust_1 = instance_create_depth(x, y, depth - 1, obj_particle_handler);
_new_dust_1.owner = self;
_new_dust_1.set_dust_smoke(1);

// Creates new particle emitter for dust smoke centre
var _new_dust_2 = instance_create_depth(x, y, depth - 1, obj_particle_handler);
_new_dust_2.owner = self;
_new_dust_2.set_dust_smoke(1);

// Creates new particle emitter for dust smoke on right
var _new_dust_3 = instance_create_depth(x, y, depth - 1, obj_particle_handler);
_new_dust_3.owner = self;
_new_dust_3.set_dust_smoke(3);

// Function for creating projectile from players gun angle
create_projectile = function(_gun_angle)
{
	// Offsets for players gun position
	var _projectile_origin_x = 110;
	var _projectile_origin_y = 0;
	
	// Gun angle stored in radians
	var _theta = degtorad(_gun_angle);
	
	// Calculates the adjusted positions from offsets and angle
	var _projectile_adjust_x = (_projectile_origin_x * cos(_theta)) - (_projectile_origin_y * sin(_theta));
	var _projectile_adjust_y = (_projectile_origin_y * cos(_theta)) + (_projectile_origin_x * sin(_theta));
	
	// Sets new postions from adjusted positions and players position
	var _projectile_pos_x = x + _projectile_adjust_x;
	var _projectile_pos_y = y - _projectile_adjust_y;

	// Creates new player projectile from the new positions
	var _new_projectile = instance_create_layer(_projectile_pos_x, _projectile_pos_y, "Projectiles", obj_projectile);
	_new_projectile.owner = self;	
	_new_projectile.correct_player();
	
	// Creates new sparked projectile from angle and offset to add to players fired effect
	var _new_hit = instance_create_depth(_projectile_pos_x, _projectile_pos_y, depth - 1, obj_particle_handler);
	_new_hit.set_player_shot();
	_new_hit.owner = self;
	_new_hit.set_angle(_gun_angle);
	_new_hit.set_offset(true, 110, 0)
	
	// Plays firing audio sound
	var _sound_spark = audio_play_sound(snd_player_fire, 100, false, 0.3, 0, 1.0);
}

// Function called when player triggers to fire
trigger_pressed = function()
{
	// Checks if player has ammo and isnt reloading
	if (!player_is_reloading && player_curr_ammo > 0)
	{
		// Checks if the fire cooldown has finished
		if (player_fire_cooldown <= 0)
		{
			// Resets the fire cooldown
			player_fire_cooldown = player_fire_rate;
			// Reduces the ammo
			player_curr_ammo--;
			// Creates a projectile
			create_projectile(gun_angle);
		}
		
		// Stops the reloading sound
		audio_stop_sound(reloading_sound);
	}
	else
	{
		// Sets player to no longer reload
		player_is_reloading = false;
		
		// Stops the reloading sound
		audio_stop_sound(reloading_sound);
		// Plays a gun jam sound effect
		var _sound_jam = audio_play_sound(snd_gun_jam, 100, false, 0.4, 0, 1.0);
		
		// Offsets used for gun jam smoke
		var _projectile_origin_x = 110;
		var _projectile_origin_y = 0;
	
		// Angle smoke is created from
		var _theta = degtorad(gun_angle);
	
		// Calculates the adjusted positions
		var _projectile_adjust_x = (_projectile_origin_x * cos(_theta)) - (_projectile_origin_y * sin(_theta));
		var _projectile_adjust_y = (_projectile_origin_y * cos(_theta)) + (_projectile_origin_x * sin(_theta));
	
		// Creates new positons form adjusted position and players position
		var _projectile_pos_x = x + _projectile_adjust_x;
		var _projectile_pos_y = y - _projectile_adjust_y;
		
		// Creates an empty spark particle system from new position
		var _new_empty_spark = instance_create_depth(_projectile_pos_x, _projectile_pos_y, depth - 1, obj_particle_handler);
		_new_empty_spark.set_empty_shot();
		_new_empty_spark.owner = self;
		_new_empty_spark.set_angle(gun_angle);
		_new_empty_spark.set_offset(true, _projectile_origin_x, _projectile_origin_y)
	}
}