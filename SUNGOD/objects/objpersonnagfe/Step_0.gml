var move_speed = 5; 
var move_x = 0;
var move_y = 0;

if keyboard_check(ord("S")) { move_y += 1; }
if keyboard_check(ord("W")) { move_y -= 1; }
if keyboard_check(ord("D")) { move_x += 1; }
if keyboard_check(ord("A")) { move_x -= 1; }


if keyboard_check(vk_down) { move_y += 1; }
if keyboard_check(vk_up) { move_y -= 1; }
if keyboard_check(vk_right) { move_x += 1; }
if keyboard_check(vk_left) { move_x -= 1; }


var magnitude = sqrt(move_x * move_x + move_y * move_y);
if magnitude > 0 {
    move_x /= magnitude;
    move_y /= magnitude;
    image_angle = point_direction(0, 0, move_x, move_y);
}

x += move_x * move_speed; 
y += move_y * move_speed; 


move_wrap(true, true, 0);
