
if oSys.physics_paused {
    exit
}

if speed_max <= 0 or dist_max <= 0 {
	exit
}

var sp = spd.len()
sp = Approach(sp, speed_max, accel)
spd.set_polar(sp, dir)

x += spd.x
y += spd.y

dist += sp
if dist >= dist_max {
    dir += 180
    dist = 0
}
