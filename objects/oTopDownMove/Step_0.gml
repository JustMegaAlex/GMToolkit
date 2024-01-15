
if true {
	key_left = keyboard_check(ord("A")) or keyboard_check(vk_left)
	key_right = keyboard_check(ord("D")) or keyboard_check(vk_right)
	key_up = keyboard_check(ord("W")) or keyboard_check(vk_up)
	key_down = keyboard_check(ord("S")) or keyboard_check(vk_down)
	key_shoot = mouse_check_button_pressed(mb_left)
} else {
	key_left = false
	key_right = false
	key_up = false
	key_down = false
	key_shoot = false
}

//// shooting
reloading--
if key_shoot
		and !reloading {
	shoot(point_dir(mouse_x, mouse_y))
	reloading = reload_time
}

//// movement
move_h = key_right - key_left
move_v = key_down - key_up
var input = abs(move_h) or abs(move_v)

var move_dir = point_direction(0, 0, move_h, move_v)
hsp = lengthdir_x(sp, move_dir) * input
vsp = lengthdir_y(sp, move_dir) * input

move_coord(hsp, vsp)
