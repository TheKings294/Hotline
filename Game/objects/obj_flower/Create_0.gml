// Array for storing the possible flower sprites
var _flower_sprite = [];

// Sets the array variables to the possible sprites
_flower_sprite[0] = spr_flower_blue;
_flower_sprite[1] = spr_flower_yellow;
_flower_sprite[2] = spr_flower_group;

// Sets the sprite to a randomly selected sprite
sprite_index = _flower_sprite[irandom_range(0, 2)];

// Sets the scale variable of the flower to a random value between 0.5 and 1
var _scale = random_range(0.5, 1);

// Sets the sprites scale to the variable
image_xscale = _scale;
image_yscale = _scale;

// Rotates the sprite to a random angle
image_angle = random_range(0, 360);