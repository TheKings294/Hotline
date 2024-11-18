// States used for spawnwer facing
enum FACE_DIRECTION
{
	TOP,
	RIGHT,
	BOTTOM,
	LEFT,
	SIZE
}

// Variable used for storing face state
curr_face_direction = FACE_DIRECTION.SIZE;

// Variables for cooldown timer that spawns new enemies 
cooldown_rate = 2;
cooldown = 0;

// Variable that stores the queue for enemies needing to be spawned
spawn_queue = 0;

// Function called when a new enemy is due to be spawned
spawn_enemy = function()
{
	// Creates new enemy object instance
	var _new_enemy = instance_create_layer(x, y, "Enemies", obj_enemy);
	// Sets new enemy's owner to the spawner it is created from
	_new_enemy.owner = self;
	
	// Case statment for the face directions of the spawner
	switch(curr_face_direction)
	{
		// Case for the spawner being at the top of level
		case FACE_DIRECTION.TOP:
			// Sets the new enemy face direction
			_new_enemy.image_angle = 90;
			// Sets the new enemy speed
			_new_enemy.vspeed = 3;
			break;
		// Case for the spawner being at the right of level
		case FACE_DIRECTION.RIGHT:
			// Sets the new enemy face direction
			_new_enemy.image_angle = 0;
			// Sets the new enemy speed
			_new_enemy.hspeed = -3;
			break;
		// Case for the spawner being at the bottom of level
		case FACE_DIRECTION.BOTTOM:
			// Sets the new enemy face direction
			_new_enemy.image_angle = 270;
			// Sets the new enemy speed
			_new_enemy.vspeed = -3;
			break;
		// Case for the spawner being at the left of level
		case FACE_DIRECTION.LEFT:
			// Sets the new enemy face direction
			_new_enemy.image_angle = 180;
			// Sets the new enemy speed
			_new_enemy.hspeed = 3;
			break;
	}
	
	// Decreases the spawn queue
	spawn_queue--;
	// Resets the cooldown for spawner
	cooldown = cooldown_rate;
}