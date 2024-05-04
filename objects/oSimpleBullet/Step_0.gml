
life_distance -= sp
if !life_distance {
	instance_destroy()
	exit
}

xprev = x
yprev = y
move(sp, image_angle)
bring_damage()

