// Variable for how long the banner will display for before fading out
banner_life = 2;
// Variable for storing the objects alpha
banner_alpha = image_alpha;

// Variables for the wave incoming text
text_1 = "INCOMING WAVE " + string(obj_game_manager.curr_wave);
font_1 = fnt_luckiest_guy_96_outline;
colour_1 = c_red;
halign = fa_center;
valign = fa_middle;

// Variable for the wave incoming sub text
text_2 = "GET READY!";
font_2 = fnt_luckiest_guy_24;
colour_2 = c_white;

// Sets font to have outline effect
font_enable_effects(fnt_luckiest_guy_96_outline, true, {
    outlineEnable: true,
    outlineDistance: 4,
    outlineColour: c_black
});