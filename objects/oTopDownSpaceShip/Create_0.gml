

function setSpTo(sp, dir) {
	hsp_to = lengthdir_x(sp, dir)
	vsp_to = lengthdir_y(sp, dir)
}

function setDirTo(_dir_to) {
	dir_to = _dir_to
}

function updateDir(rot_sp=rotary_sp) {
	var diff = angle_difference(dir_to, dir)
	if abs(diff) < rot_sp {
		dir = dir_to
		return true
	}
	dir += rotary_sp * sign(diff)
}

function updateSp(accelerate=true) {
	if accelerate {
		hsp = Approach(hsp, hsp_to, acc)
		vsp = Approach(vsp, vsp_to, acc)
	} else {
		hsp = Approach(hsp, 0, acc)
		vsp = Approach(vsp, 0, acc)	
	}
}

function shoot(dir, obj=oSimpleBullet, spr=sSimpleBullet, sp=undefined) {
	var inst = instance_create_layer(x, y, layer, obj)
	inst.image_angle = dir
	inst.sprite_index = spr
	if sp != undefined
		inst.sp = sp
	
	inst.side = side
	oParticles.emitShootBurst(x, y, dir)
}

hp = 7

sp_max = 5
hsp = 0
vsp = 0
hsp_to = 0
vsp_to = 0
acc = 0.5
input_v = 0
move_h = 0
move_v = 0
input_dir = 0
rotary_sp = 5
dir = 0
dir_to = 0

sp_gain = 1

image_speed = 0

reload_timer = MakeTimer(20)
bullet_sp = 20

side = Sides.ours

// systems
hp_max = 10
hp = hp_max


acc = 0.3

hp = 0
side = Sides.neutral
