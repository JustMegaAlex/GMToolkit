
enum Sides {
	non_hitable,
	ours,
	theirs,
	neutral,
}

default_bullet_obj = libOBullet
default_hitable_obj = libOHitable

function Shoot(dir=0, obj=global.default_bullet_obj, args={}) {
	var bullet = instance_create_layer(x, y, "Instances", obj, args)
	bullet.dir = dir
	bullet.side = side
	return bullet
}
