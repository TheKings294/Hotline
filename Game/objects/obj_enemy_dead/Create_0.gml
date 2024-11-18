// Variables set for the dead enemy flashed sprite
image_index = 1;
// Set to alreadt faded alpha
image_alpha = 0.75;
// Set rate to fade alpha fast
fade_rate = 60;

// Create explosion particle system
var _new_boom = instance_create_depth(x, y, depth - 1, obj_particle_handler);
// Set particle system to character explosion
_new_boom.set_character_defeat();
// Set particle system parent to dead enemy
_new_boom.owner = self;

// Create sequence for enemy parts sequence
body_seq = layer_sequence_create("Bodies", x, y, seq_enemy_parts);
// Angle sequence to body angle
layer_sequence_angle(body_seq, image_angle);