// Variable for how long the banner will display for before fading out
banner_life = 2;
// Variable for storing the objects alpha
banner_alpha = image_alpha;

// Variables for the wave clear text
text_1 = "WAVE CLEAR";
font_1 = fnt_luckiest_guy_96_outline;
colour_1 = c_green;
halign = fa_center;
valign = fa_middle;

// Variable for the wave clear sub text
text_2 = "LOOKING NEAT BUT MORE ARE COMING";
font_2 = fnt_luckiest_guy_24;
colour_2 = c_white;

// Sets font to have outline effect
font_enable_effects(fnt_luckiest_guy_96_outline, true, {
    outlineEnable: true,
    outlineDistance: 4,
    outlineColour: c_black
});