// States used for the type of wall faces
enum FACE_TYPE
{
	TOP_LEFT,
	TOP,
	TOP_RIGHT,
	RIGHT,
	BOTTOM_RIGHT,
	BOTTOM,
	BOTTOM_LEFT,
	LEFT,
	TOP_GAP,
	RIGHT_GAP,
	BOTTOM_GAP,
	LEFT_GAP,
	SIZE
}

// Variable used for storing the face state
curr_face_type = FACE_TYPE.SIZE;

// Function called that sets the type of face to the relevant sprite
set_sprite = function()
{
	// Case statement for face state
	switch (curr_face_type)
	{
		// Case for top left face
		case FACE_TYPE.TOP_LEFT:
			// Sets sprite
			sprite_index = spr_grass_top_left;
		break;
		// Case for top face
		case FACE_TYPE.TOP:
			// Sets sprite
			sprite_index = spr_grass_top;
		break;
		// Case for top right face
		case FACE_TYPE.TOP_RIGHT:
			// Sets sprite
			sprite_index = spr_grass_top_right;
		break;
		// Case for right face
		case FACE_TYPE.RIGHT:
			// Sets sprite
			sprite_index = spr_grass_right;
		break;
		// Case for bottom right face
		case FACE_TYPE.BOTTOM_RIGHT:
			// Sets sprite
			sprite_index = spr_grass_bottom_right;
		break;
		// Case for bottom face
		case FACE_TYPE.BOTTOM:
			// Sets sprite
			sprite_index = spr_grass_bottom;
		break;
		// Case for bottom left face
		case FACE_TYPE.BOTTOM_LEFT:
			// Sets sprite
			sprite_index = spr_grass_bottom_left;
		break;
		// Case for left face
		case FACE_TYPE.LEFT:
			// Sets sprite
			sprite_index = spr_grass_left;
		break;
		// Case for top gap face
		case FACE_TYPE.TOP_GAP:
			// Sets sprite
			sprite_index = spr_grass_top_gap;
		break;
		// Case for right gap face
		case FACE_TYPE.RIGHT_GAP:
			// Sets sprite
			sprite_index = spr_grass_right_gap;
		break;
		// Case for bottom gap face
		case FACE_TYPE.BOTTOM_GAP:
			// Sets sprite
			sprite_index = spr_grass_bottom_gap;
		break;
		// Case for left gap face
		case FACE_TYPE.LEFT_GAP:
			// Sets sprite
			sprite_index = spr_grass_left_gap;
		break;
	}
}