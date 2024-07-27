
enum Sides {
	non_hitable,
	ours,
	theirs,
	neutral,
}

function Shoot(dir=0, obj=libOBullet, args={}) {
	var bullet = instance_create_layer(x, y, "Instances", obj, args)
	bullet.dir = dir
	bullet.side = side
	return bullet
}
