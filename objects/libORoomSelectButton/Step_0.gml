

interacting = mouse_collision(id)

/// lightening if interaction
if interacting {
	image_index = _interact_img
	// just pressed
	if libOInput.key_shoot_pressed {
		image_index = _checked_img
		room_goto(room_to_start)
	}
}
else {
	image_index = _default
}