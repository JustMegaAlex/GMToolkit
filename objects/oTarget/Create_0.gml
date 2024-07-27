event_inherited()

side = Sides.theirs

function shoot() {
	Shoot(PointDir(mouse_x, mouse_y), global.default_bullet_obj, {distance: 2000})
}
