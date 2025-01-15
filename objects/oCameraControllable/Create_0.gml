
event_inherited()

EnsureSingleton()

target = noone
velocity = new Vec2(0, 0)
shift_vec = new Vec2(0, 0)
shift_vec_to = new Vec2(0, 0)

view_enabled = true
view_visible[0] = true

/// Set up default camera size
aspect_ratio = 1920 / 1080
camera_width = 1920 * 1.3
camera_height = camera_width / aspect_ratio

zoom = 1
zoom_to = 1
zoom_treshold_speed = 40
zoom_factor = 1.25
is_manual_control = false
stay_in_room_bounds_enabled = false
max_target_distance = 100
move_factor = 0.05

function GetState() {
    return {
        zoom: zoom,
        zoom_to: zoom_to,
        zoom_treshold_speed: zoom_treshold_speed,
        zoom_factor: zoom_factor,
        is_manual_control: is_manual_control,
        stay_in_room_bounds_enabled: stay_in_room_bounds_enabled,
        max_target_distance: max_target_distance,
        move_factor: move_factor
    }
}

function SetState(state) {
    var keys = variable_struct_get_names(state)
    for (var i = 0; i < array_length(keys); ++i) {
        inst_set(id, keys[i], state[$ keys[i]])
    }
}

function SetZoom(value) {
    zoom = value
    camera_set_view_size(view_camera[0], camera_width * zoom, camera_height * zoom)
}

alarm[0] = 2

display_set_gui_size(window_get_width(), window_get_height())



