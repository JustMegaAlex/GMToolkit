
visible = false

if zoom_left <= 0 or zoom_right <= 0 {
	show_debug_message("Zoom area camera size wasn't initialized")
}

function GetZoom() {
	if zoom_left <= 0 or zoom_right <= 0 {
		return undefined	
	}
	var amount = (global.player.x - bbox_left) / sprite_width
	return lerp(zoom_left, zoom_right, amount)
}
