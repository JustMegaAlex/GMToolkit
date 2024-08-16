
// radius is max of width/height defined
var radius = max(sprite_width, sprite_height) * 0.5
sprite_index = spr_Aura_Point_Light
aura_light_init(radius, c_white, 1, false, true)



// movement (copy of oGround)
dist = 0
spd = new Vec2(0, 0)
initial_dir = dir

is_moving = false

function Reset() {
    spd.set(0, 0)
	x = xstart
	y = ystart
	dist = 0
	is_moving = false
	dir = initial_dir
}
