
side = Sides.ours
hp = 5

function hit(dmg=1) {
	hp -= dmg
	if !hp {
		instance_destroy()	
	}
}

function shoot() {
	Shoot(point_dir(mouse_x, mouse_y),
		  global.default_bullet_obj,
		  {lifetime: 30})
}
