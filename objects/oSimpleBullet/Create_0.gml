
function bring_damage() {
	var inst = instance_place(x, y, object_to_hit)
	if inst and inst.side != Sides.neutral and inst.side != side {
		inst.hit()
		instance_destroy()
	}
}

function move() {
	move(sp, image_angle)
}

visible = false
image_speed = 0
// become visible back
alarm[0] = 1
sp = 10
life_distance = 500
side = -1
object_to_hit = libOHitable

xprev = x
yprev = y
