
if !instance_exists(target) {
	exit
}

zoom_to = 1
if instance_exists(global.player) {
	var zoom_area = collision_point(global.player.x, global.player.y, oZoomArea, false, true)
	if zoom_area {
		zoom_to = zoom_area.GetZoom() ?? zoom_to
        shift_vec_to.set_polar(zoom_area.shift_distance, zoom_area.shift_direction)
	} else {
        shift_vec_to.set(0, 0)
    }
}

shift_vec.approach(shift_vec_to, 6)

x = lerp(x, target.x + shift_vec.x, move_factor)
y = lerp(y, target.y + shift_vec.y, move_factor)

/// Don't exceed max_target_distance
var dist = point_distance(x, y, target.x, target.y)
if dist > (shift_vec.len() + max_target_distance) {
    var angle = point_direction(x, y, target.x, target.y)
    x = (target.x + shift_vec.x) - lengthdir_x(max_target_distance, angle)
    y = (target.y + shift_vec.y) - lengthdir_y(max_target_distance, angle)
}

if instance_exists(oLevelLeftBound) {
    x = max(x, oLevelLeftBound.x + CamW() * 0.5)
}

zoom = Approach2(zoom, zoom_to, 0.04, 0.01)
SetZoom(zoom)

// update camera position with clampint to room bounds
var w = CamW() * 0.5, h = CamH() * 0.5
var xx = x, yy = y
if stay_in_room_bounds_enabled {
    xx = clamp(x, w, room_width - w)
    yy = clamp(y, h, room_height - h)
}


CameraSetPos(xx, yy)









