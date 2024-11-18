// Variable used for the owner of the projectile
owner = noone;
// Variable used for speed drop off from owner when fired
speed_dropoff = 0.5;
// Variable used for the arena wall edge buffers
wall_buffer = 180;

// Speed variable for projectiles inital speed
speed = 20;
// Variable used for storing the speed when the game is paused
last_speed = speed;

// Function called when the projectile is fired from a player
correct_player = function()
{
	// Sets sprite to player fireball
	sprite_index = spr_player_fireball;
	
	// Sets direction of projectile to the players gun angle
	direction = owner.gun_angle;
	// Sets the angle of the projectile to the direction
	image_angle = direction;
	
	// Adjusts the projectiles speed to factor the players speed
	hspeed += owner.hspeed * speed_dropoff;
	vspeed += owner.vspeed * speed_dropoff;
	
	// Creates a gun flash animation from the muzzel of the players gun
	var _new_gun_flash = instance_create_depth(x, y, depth - 1, obj_player_shoot);
	_new_gun_flash.owner = owner;
	_new_gun_flash.image_angle = direction;
	
	// Creates a smoke particle system that will follow the projectile
	var _new_smoke = instance_create_depth(x, y, depth - 1, obj_particle_handler);
	_new_smoke.set_smoke();
	_new_smoke.owner = self;
}

// Function called when the projectile is fired from an enemy
correct_enemy = function()
{
	// Sets the sprite to enemy fireball
	sprite_index = spr_enemy_fireball;
	
	// Sets the direction to the fire from the enemy postion towards its targets position
	direction = point_direction(owner.x, owner.y, owner.target.x, owner.target.y);
	// Sets the image angle to this direction
	image_angle = direction;
	
	// Adjusts the projectile speed to the enemies speed
	hspeed += owner.hspeed * speed_dropoff;
	vspeed += owner.vspeed * speed_dropoff;
	
	// Creates a smoke particle system that will follow the projectile
	var _new_smoke = instance_create_depth(x, y, depth - 1, obj_particle_handler);
	_new_smoke.set_smoke();
	_new_smoke.owner = self;
}

// Function called when the projectile is sparked and destroyed
spark_projectile = function()
{
	// Checks if the owner is a player
	if (owner.object_index == obj_player)
	{
		// Creates a particle system of player fireball sparks
		var _new_hit = instance_create_depth(x, y, depth - 1, obj_particle_handler);
		_new_hit.set_player_shot();
		_new_hit.owner = self;
		_new_hit.set_angle(direction + 180);
	}
	else
	{
		// Creates a particle system of enemy fireball sparks
		var _new_hit = instance_create_depth(x, y, depth - 1, obj_particle_handler);
		_new_hit.set_enemy_shot();
		_new_hit.owner = self;
		_new_hit.set_angle(direction + 180);
	}
	
	// Destroys the projectile
	instance_destroy();
}