
if oSys.physics_paused {
    exit
}

if !is_moving {
	var test = true
}

if !is_moving {
    var player = instance_nearest(x, y, oPlayer)
	is_moving = InstDist(player) < aura_light_radius
	
	if is_moving {
        // trigger moving platforms
        var trigger_box = instance_place(x, y, oTriggerBox)
        if trigger_box {
            var list = trigger_box.list
            for (var i = 0; i < ds_list_size(list); i += 1) {
                list[| i].Trigger()
            }
        }
	}
}

if !is_moving or speed_max <= 0 or dist_max <= 0 {
	exit
}

var sp = spd.len()
sp = Approach(sp, speed_max * is_moving, accel)
spd.set_polar(sp, dir)

x += spd.x
y += spd.y

dist += sp
if dist >= dist_max {
    dir += 180
    dist = 0
}
