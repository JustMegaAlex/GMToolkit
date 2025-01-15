
if !is_active {
	exit
}


if current_frame.text != undefined {

    //// Draw dialog window, aligned by top cente
    var window_x = display_get_gui_width() / 2
    var window_left_x = window_x - window_width / 2
	if sprite_box {
	    draw_sprite_ext(
	        sprite_box,    // Dialog window sprite
	        0,             // Image index
	        window_left_x,  // X position centered
	        window_y,      // Y position (top)
	        window_xscale,       // X scale calculated from desired width
	        window_yscale,       // Y scale calculated from desired height
	        0,             // Rotation
	        c_white,       // Color
	        1              // Alpha
	    )
	}

    // Draw current frame's sprite if it exists
    if (current_frame.sprite != noone) {
        draw_sprite(
            current_frame.sprite,
            0,
            window_left_x + sprite_rel_x,
            window_y + sprite_rel_y
        )
    }

    // Set text drawing parameters
    // draw_set_font(dialog_font)
    draw_set_halign(fa_left)
    draw_set_valign(fa_top)
    draw_set_color(text_color)
    
    // Calculate text dimensions and position
    var text_x = window_left_x + text_margin_x
    var text_y = window_y + text_margin_y
    
    current_text_index += text_speed
    // Draw current frame's text, animated
	draw_set_font(text_font)
	
    draw_text_ext(
        text_x,
        text_y,
        string_copy(current_frame.text, 1, current_text_index),
        text_line_height,
        text_width
    )
    
	draw_set_font(name_font)
    draw_set_halign(fa_center)
    draw_text_transformed(
        window_left_x - sprite_w * 0.5,
        window_y + sprite_h + name_margin_y,
        current_frame.name,
        name_scale, name_scale, 0
    )    
}
