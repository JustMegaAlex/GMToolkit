
if !global.dialogs_enabled {
	exit
}

if !is_active {
    with trigger {
        if place_meeting(x, y, oPlayer) {
            other.Trigger()
        }
    }
} else {					  /// if there's no text, we only wait for the
						      // camera focus to finish without player's input
	if oInput.jump_pressed or current_text_size == 0 {
        /// Finish text animation, if not finished yet
		if current_text_index < current_text_size {
            current_text_index = current_text_size
		} else {
            NextFrame()
        }
        /* Dialog camera is not used now
        /// Go to next frame if camera focus is finished or absent
        else if current_camera_focus == undefined
             or CameraFocusFinished(current_camera_focus) {
            NextFrame()
        }
        */
	}
}
