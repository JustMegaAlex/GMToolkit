
if true {
	key_left = keyboard_check(ord("A")) or keyboard_check(vk_left)
	key_right = keyboard_check(ord("D")) or keyboard_check(vk_right)
	key_up = keyboard_check(ord("W")) or keyboard_check(vk_up)
	key_down = keyboard_check(ord("S")) or keyboard_check(vk_down)
	key_shoot = mouse_check_button(mb_left)
	key_interact = mouse_check_button_pressed(mb_right)
	key_detach = keyboard_check_pressed(ord("Q"))
} else {
	key_left = false
	key_right = false
	key_up = false
	key_down = false
	key_interact = false
	key_shoot = false
	key_detach = false
}

setDirTo(PointDir(mouse_x, mouse_y))
updateDir()

//// movement
move_h = key_right - key_left
move_v = key_down - key_up
var input = abs(move_h) or abs(move_v)

var move_dir = point_direction(0, 0, move_h, move_v)

setSpTo(sp_max * sp_gain, move_dir)
updateSp(input)
MoveCoord(hsp, vsp)

//// shooting
if !reload_timer.update() and key_shoot {
	shoot(dir)
	reload_timer.reset()
	// audio_play_sound(snd_player_shoot_s, 0, false)
}


