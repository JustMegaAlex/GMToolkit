camera_setups = {}

is_active = false
current_frame_index = -1
current_frame = undefined
current_text_index = 0
current_text_size = 0
current_camera_focus = undefined

/// Window coordinates, with and height
window_y = 50
window_width = 800
window_height = 280
window_xscale = window_width / sprite_get_width(sDialogbox)
window_yscale = window_height / sprite_get_height(sDialogbox)

text_margin_x = 72
text_margin_y = 48
text_width = window_width - 2 * text_margin_x
text_line_height = 42
text_speed = 3
text_color = c_black

text_font = draw_get_font() // replace with a custom font
name_font = draw_get_font()

sprite_box = noone
sprite_w = sprite_get_width(sPicoPortrait)
sprite_h = sprite_get_height(sPicoPortrait)
sprite_rel_x = -sprite_w
sprite_rel_y = 0

name_margin_y = 0
name_scale = 1
saved_camera_state = {}

function Trigger() {
    if is_active { return; }
    is_active = true
    saved_camera_state = global.camera_object.GetState()
    camera_setups.__finish.x = global.player.x
    camera_setups.__finish.y = global.player.y
    global.player.disableInput()
    NextFrame()
}

function MakeCameraState(setup) {
    var result = {max_target_distance: infinity}
    if setup.zoom_to != undefined {
        result.zoom_to = setup.zoom_to
    }
    if setup.move_factor != undefined {
        result.move_factor = setup.move_factor
    }
    return result
}

function CameraFocusFinished(setup) {
    return point_distance(
        setup.x, setup.y,
        CamXCent(), CamYCent()
    ) < 15
}
function SetCameraFocus(camera_label) {
    /// Set camera target and change its parameters to make it
    // move smoother during dialog
    var setup = camera_setups[$ camera_label]
    global.camera_object.SetState(MakeCameraState(setup))
    global.camera_object.SetTarget(camera_setups[$ camera_label])
    current_camera_focus = camera_setups[$ camera_label]
    // save zoom_to to finish frame
    camera_setups.__finish.zoom_to = saved_camera_state.zoom_to
}

function Deactivate() {
    global.camera_object.SetTarget(global.player)
    global.camera_object.SetState(saved_camera_state)
    global.player.enableInput()
    instance_destroy(self)
}

function NextFrame() {
    current_frame_index++
    /// Deactivate if out of frames
    if current_frame_index >= array_length(frames) {
        Deactivate()
        return
    }
    current_frame = frames[current_frame_index]
    current_text_index = 0
    current_text_size = 0
    if current_frame.text != undefined {
        current_text_size = string_length(current_frame.text)
    }
    var camera_focus_label = struct_get(current_frame, "camera_focus")
    if camera_focus_label != undefined {
        SetCameraFocus(camera_focus_label)
    }
}


/// Collect dialog setup instances
alarm[0] = 1
