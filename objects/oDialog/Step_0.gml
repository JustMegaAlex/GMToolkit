if is_dialog_running {
    text_length += 2
    if oInput.key_any {
        var option_ind = keyboard_key - 49
        if option_ind >= 0 && option_ind < array_length(current_options) {
            chooseOption(current_options[option_ind])
        }
    }
} else if is_active {
    image_alpha = 0.8
    if collision_point(mouse_x, mouse_y, id, false, false) {
        image_alpha = 1
    }
    if !global.dialog_on and MouseCollision(id)
            and mouse_check_button_pressed(mb_left) {
        intro_timer.reset()
        image_alpha = 1
        startDialog()
    }
}
