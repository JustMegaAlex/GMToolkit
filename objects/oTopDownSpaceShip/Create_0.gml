

function set_sp_to(sp, dir) {
	hsp_to = lengthdir_x(sp, dir)
	vsp_to = lengthdir_y(sp, dir)
}

function set_dir_to(_dir_to) {
	dir_to = _dir_to
}

function update_dir(rot_sp=rotary_sp) {
	var diff = angle_difference(dir_to, dir)
	if abs(diff) < rot_sp {
		dir = dir_to
		return true
	}
	dir += rotary_sp * sign(diff)
}

function update_sp(accelerate=true) {
	if accelerate {
		hsp = approach(hsp, hsp_to, acc)
		vsp = approach(vsp, vsp_to, acc)
	} else {
		hsp = approach(hsp, 0, acc)
		vsp = approach(vsp, 0, acc)	
	}
}

function shoot(dir, obj=oSimpleBullet, spr=sSimpleBullet, sp=undefined) {
	var inst = instance_create_layer(x, y, layer, obj)
	inst.image_angle = dir
	inst.sprite_index = spr
	if sp != undefined
		inst.sp = sp
	
	inst.side = side
	oParticles.emit_shoot_burst(x, y, dir)
}

hp = 7

sp_max = 5
hsp = 0
vsp = 0
hsp_to = 0
vsp_to = 0
acc = 0.5
vacc = 0
input_v = 0
move_h = 0
move_v = 0
input_dir = 0
rotary_sp = 5
dir = 0
dir_to = 0

sp_gain = 1

image_speed = 0

reload_time = global.player_reload_time
reloading = 0
bullet_sp = global.player_bullet_sp
bullet_sprite = libSBullet

side = Sides.ours

// systems
hp_max = global.player_hp_max
hp = hp_max

// drawing compas
compas_min_dist = 600
compas_r = 100

// attaching mechanic
attach_resource_range = 64
last_attached_inst = id
list_nearest_resources = ds_list_create()
attach_max_count = 5
attach_count = 0
acc = 0.3

hp = 0
side = Sides.neutral
