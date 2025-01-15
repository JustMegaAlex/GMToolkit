
if fade_alpha > 0 {
    draw_set_color(fade_color)
    draw_set_alpha(fade_alpha)
    draw_rectangle(CamX(), CamY(), CamX() + CamW(), CamY() + CamH(), false)
    draw_set_color(c_white)
    draw_set_alpha(1)
}
