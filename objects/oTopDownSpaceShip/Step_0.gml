
if not global.game_over {
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

set_dir_to(point_dir(mouse_x, mouse_y))
if !global.game_over
	update_dir()

//// movement
move_h = key_right - key_left
move_v = key_down - key_up
var input = abs(move_h) or abs(move_v)

var move_dir = point_direction(0, 0, move_h, move_v)

set_sp_to(sp_max * sp_gain, move_dir)
update_sp(input)
move_coord(hsp, vsp)

//// shooting
reloading--
if key_shoot
		and !reloading {
	shoot(dir, oBullet, bullet_sprite)
	reloading = reload_time
	audio_play_sound(snd_player_shoot_s, 0, false)
}

// attach resource
if key_interact {
	var num = collision_circle_list(
			x, y, attach_resource_range,
			o_resource, false, true, list_nearest_resources, false)
	for (var i = 0; i < num; ++i) {
	    var inst = list_nearest_resources[| i]
		if !inst.is_attached() {
			inst.attach_to(last_attached_inst)
			last_attached_inst = inst
			update_agility(1)
			audio_play_sound(snd_select, 0, false)
			break
		}
	}
	ds_list_clear(list_nearest_resources)
}

// detach resource
if key_detach and last_attached_inst != id {
	var new_last = last_attached_inst.follow_inst
	last_attached_inst.detach()
	last_attached_inst = new_last
	update_agility(-1)
	audio_play_sound(snd_discard, 0, false)
}

// store resources
if place_meeting(x, y, o_homebase) {
	store_resources()
	update_agility(-attach_max_count)
}

