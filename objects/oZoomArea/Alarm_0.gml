
if (camera_height <= 0) and (camera_width <= 0) {
	show_debug_message("Zoom area camera size wasn't initialized")
	exit
}

/// if one dimension is 0 pick another one
// otherwise pick the smaller one
if instance_exists(global.camera_object) {
	var ww = camera_width / global.camera_object.camera_width
	var hh = camera_height / global.camera_object.camera_height
	if camera_height <= 0 {
		zoom = ww
		exit
	}
	if camera_width <= 0 {
		zoom = hh
		exit
	}
	zoom = min(ww, hh)
}
