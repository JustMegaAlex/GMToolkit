
enum Sides {
	ours,
	theirs,
	neutral,
}

default_bullet_obj = libOBullet
default_hitable_obj = libOHitable

function Shoot(dir=0, obj=global.default_bullet_obj, args={}) {
	var bullet = instance_create_args(x, y, "Instances", obj, args)
	bullet.image_angle = dir
	bullet.side = side
	return bullet
}
