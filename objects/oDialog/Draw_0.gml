draw_self()
if spr_face {
    draw_sprite(spr_face, 0, x, y)
}

if is_dialog_running {

    var _x1 = room_width * 0.1
    var _y1 = room_height * 0.5
    var _x2 = room_width * 0.9
    var _y2 = room_height * 0.99
    var _wmax = _x2 - _x1
    var _hmax = _y2 - _y1
    var _dialog_x = _x1 + 20
	var _dialog_y = _y1 + 20

    var _color = c_white
    textbox_alpha = lerp(textbox_alpha, 1, 1)
    var _alpha = textbox_alpha

    if (textbox_w < _wmax) {
        textbox_w += _wmax * 0.2
    }
    var _w = _wmax //textbox_w (this was the old width)

    var _h = _hmax

    draw_sprite_stretched_ext(sNineSlice1, 0, _x1, _y1, _w, _h, _color, _alpha)

    draw_set_color(c_black)

    draw_set_halign(fa_left)
    draw_set_valign(scribble_fallback_bulletpoint)
    if !intro_timer.update() {
        var w = _wmax * 0.8
        draw_text_scribble_ext(_dialog_x, _dialog_y, current_replica, w, text_length)
        var option_y = (_y2 + _y1) * 0.5 //_dialog_y + string_height_scribble_ext(current_replica, w) + row_height
        for (var i = 0; i < array_length(current_options); ++i) {
            draw_set_color(c_black)
            var option = current_options[i]

            var xx = _dialog_x
            var enumerator = string(i+1) + "."
			draw_text(xx, option_y, enumerator)
            xx += string_width(enumerator)
            // workaround scribble using "[" as a format marker
            if string_ends_with(option, "]") {
                draw_text(xx, option_y, "[")
                xx += string_width("[")
            }

            // mouse collision
            var opt_h = string_height_scribble_ext(option, w)
            if point_in_rectangle(mouse_x, mouse_y, 
                    _dialog_x, option_y, _dialog_x + w, option_y + opt_h) {
                if oInput.key_interact_pressed {
                    chooseOption(option)
                }
				draw_set_color(c_green)
            }

            draw_text_scribble_ext(xx, option_y, option, w)
            // draw_rectangle(_dialog_x, option_y, _dialog_x + w, option_y + opt_h, true)
            option_y += opt_h
        }

    }

    draw_set_color(c_white)
}




