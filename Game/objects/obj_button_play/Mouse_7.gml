// Sets the key variable to pressed
is_pressed = true;
// Sets the target scale
target_scale = 0.9;
// Speeds up the scale rate
scale_rate = 0.9;

// Plays the button pushed sound effect
sound_button = audio_play_sound(snd_menu_button, 100, false);

// Sets the mouse aiming state to true since clicked
global.is_mouse_aiming = true;