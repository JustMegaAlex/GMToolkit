event_inherited()

side = Sides.theirs

function shoot() {
	Shoot(point_dir(mouse_x, mouse_y), global.default_bullet_obj, {distance: 2000})
}
