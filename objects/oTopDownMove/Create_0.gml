
function shoot(dir, obj=oSimpleBullet, spr=libSBullet, sp=undefined) {
	var inst = instance_create_layer(x, y, layer, obj)
	inst.image_angle = dir
	inst.sprite_index = spr
	if sp != undefined
		inst.sp = sp
	
	inst.side = side
}

sp = 2
hsp = 0
vsp = 0
side = Sides.ours
reload_time = 30
reloading = 0

CameraSetPos(x, y)
