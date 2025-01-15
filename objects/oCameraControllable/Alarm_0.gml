
target = oPlayer


if instance_exists(target) {
	x = target.x
	y = target.y
}


view_enabled = true
view_visible[0] = true

camera_set_view_size(view_camera[0], camera_width, camera_height)

var w = CamW(0) * 0.5, h = CamH(0) * 0.5

CameraSetPos(
	clamp(x, w, room_width - w),
	clamp(y, h, room_height - h))

















