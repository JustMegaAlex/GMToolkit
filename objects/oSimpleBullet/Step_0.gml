
life_distance -= sp
if !life_distance {
	instance_destroy()
	exit
}

xprev = x
yprev = y
Move(sp, image_angle)
bringDamage()

