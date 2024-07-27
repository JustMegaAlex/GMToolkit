
side = Sides.ours
hp = 5

function hit(dmg=1) {
	hp -= dmg
	if !hp {
		instance_destroy()	
	}
}

function shoot() {
	Shoot(PointDir(mouse_x, mouse_y),
		  libOBullet, {lifetime: 30})
}
