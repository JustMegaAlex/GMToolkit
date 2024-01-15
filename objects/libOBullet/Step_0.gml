
xprev = x
yprev = y
move(sp, image_angle)

var hit = collision_line(x, y, xprev, yprev, target, false, true)
if hit != noone and hit.side != side {
	hit.hit()
	instance_destroy()
}

if lifetime and !--lifetime {
	instance_destroy()
}
