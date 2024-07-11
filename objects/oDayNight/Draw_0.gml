

var normalized = day_time/100;
//normalized = normalized < 1 ? normalized : (2 - normalized)

// turn on shader
shader_set(shDayNight)
// pass data to shader
shader_set_uniform_f(shader_get_uniform(shDayNight, "day_time"), normalized)
// draw everything with a shader
draw_sprite(sDayMight, 0, 0, 0)
// turn off shader
shader_reset()

draw_text(100, 100, normalized)
