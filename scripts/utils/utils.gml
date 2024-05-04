
function arr_join(arr, sep) {
	var len = array_length(arr)
	if len == 0
		return ""
	s = string(arr[0])
	for (var i = 1; i < len; ++i) {
	    s += sep + string(arr[i])
	}
	return s
}

function IterStruct(_struct) constructor {
	struct = _struct
	names = variable_struct_get_names(self.struct)
	len = array_length(names)
	i = -1

	next = function() {
		i++
		if i >= len
			return undefined
		return variable_struct_get(self.struct, names[i])
	}
	
	key = function(shift=0) {
		var ii = i + shift
        if ii < 0 or ii >= len
            return undefined
		return names[ii]
	}
	
	value = function(shift=0) {
		var ii = i + shift
        if ii < 0 or ii >= len
            return undefined
		return variable_struct_get(self.struct, names[ii])
	}
	
	reset = function() {
		i = -1
	}
}

function approach(val, to, amount) {
	var delta = to - val
	if abs(delta) < amount
		return to
	var sp = amount * sign(delta) 
	return val + sp
}

function array_sum(arr) {
	var res = 0
	for (var i = 0; i < array_length(resources); ++i) {
	    res += resources[$i]
	}
	return res
}

function array_has(arr, val) {
	for (var i = 0; i < array_length(arr); ++i) {
	    if val == arr[i]
			return true
	}
	return false
}

function array_count(arr, val) {
	var count = 0
	for (var i = 0; i < array_length(arr); ++i) {
	    if val == arr[i]
			count++
	}
	return count
}

function array_find(arr, val) {
	for (var i = 0; i < array_length(arr); ++i) {
	    if val == arr[i]
			return i
	}
	return -1
}

function array_remove(arr, val) {
	var i = array_find(arr, val)
	if i == -1
		throw " :array_remove: no value in array: " + string(val)
	var res = arr[i]
	array_delete(arr, i, 1)
	return res
}

function array_choose(arr) {
	var ind = irandom(array_length(arr) - 1)
	return arr[irandom(array_length(arr) - 1)]
}

function array_expand(arr, from) {
	for (var i = 0; i < array_length(from); ++i) {
	    array_push(arr, from[i])
	}
}

function array_empty(arr) {
	return array_length(arr) == 0
}

function chance(p) {
	return random(1) < p
}

function draw_text_custom(xx, yy, text, font=-1, col=c_white, alpha=1, halign=fa_top, valign=fa_left) {
	var prev_valign = draw_get_valign()	
	var prev_halign = draw_get_halign()
	var prev_font = draw_get_font()
	var prev_col = draw_get_color()
	var prev_alpha = draw_get_alpha()
	draw_set_font(font)
	draw_set_halign(halign)
	draw_set_valign(valign)
	draw_set_color(col)
	draw_set_alpha(alpha)

	draw_text(xx, yy, text)

	draw_set_font(prev_font)
	draw_set_halign(prev_halign)
	draw_set_valign(prev_valign)
	draw_set_color(prev_col)
	draw_set_alpha(prev_alpha)
}

function inst_mouse_dir(inst) {
	return point_direction(inst.x, inst.y, mouse_x, mouse_y)
}

function inst_inst_dir(inst, inst_to) {
	return point_direction(inst.x, inst.y, inst_to.x, inst_to.y)
}

function inst_inst_dist(inst, inst_to) {
	return point_distance(inst.x, inst.y, inst_to.x, inst_to.y)
}

function mouse_dir() {
	return point_direction(id.x, id.y, mouse_x, mouse_y)
}

function inst_dir(inst_to) {
	return point_direction(id.x, id.y, inst_to.x, inst_to.y)
}

function inst_dist(inst_to) {
	return point_distance(id.x, id.y, inst_to.x, inst_to.y)
}

function point_dist(xx, yy) {
	return point_distance(id.x, id.y, xx, yy)
}

function point_dir(xx, yy) {
	return point_direction(id.x, id.y, xx, yy)
}

function struct_sum(struct) {
	var names = variable_struct_get_names(struct)
	var res = 0
	for(var i = 0; i < array_length(names); ++i) {
		res += struct[$ names[i]]	
	}
	return res
}

function collision_line_width(x0, y0, x1, y1, obj, w) {
	// 0, 0, 10, -10, 10 --> 
	//
	var angle = point_direction(x0, y0, x1, y1)
	var angle_factor = (angle mod 180) < 90 ? 1 : -1 // 1
	var half = w * 0.5 // 5
	var xx0 = x0 - half * angle_factor	// 5
	var yy0 = y0 - half					// -5
	var xx1 = x1 - half * angle_factor	// 15
	var yy1 = y1 - half					// 5
	var inst = collision_line(xx0, yy0, xx1, yy1, obj, false, true)
	var xx2 = x0 + half * angle_factor
	var yy2 = y0 + half
	var xx3 = x1 + half * angle_factor
	var yy3 = y1 + half
	
	//if inst
	//	return inst
	//inst = collision_line(xx2, yy2, xx3, yy3, obj, false, true)
	//return inst

	if inst 
		return {inst:inst, x1: xx1, x2: xx2, x3:xx3, x0: xx0, y0: yy0, y1: yy1, y2: yy2, y3: yy3}

	inst = collision_line(xx2, yy2, xx3, yy3, obj_planet_mask, false, true)
	return {inst:inst, x1: xx1, x2: xx2, x3:xx3, x0: xx0, y0: yy0, y1: yy1, y2: yy2, y3: yy3}
}

function make_late_init() {
	alarm[0] = 1
}

function get_random_instance(obj) {
	return instance_find(obj, irandom(instance_number(obj) - 1))

}

function object_name(inst) {
	return object_get_name(inst.object_index)
}

// stub function to use as a deafault callback
function scr_stub() {}

function mouse_collision(obj_or_inst) {
	return collision_point(mouse_x, mouse_y, obj_or_inst, false, false)
}

function Timer(time) constructor {
	self.time = time
	self.timer = time
	
	function update() {
		self.timer -= timer > 0
		return self.timer
	}

	function reset() {
		self.timer = self.time	
	}

	function stop() {
		self.timer = 0	
	}
}

function _anim_get_treshold() {
	return sprite_frames_per_step(sprite_index)
}

function is_animation_end() {
	return abs(image_index - (image_number - 1)) < _anim_get_treshold()
}

function is_animation_at_frame(frame) {
	var delta = image_index - frame
	return delta >= 0 and delta <= _anim_get_treshold()
}

function sprite_frames_per_step(spr) {
	if sprite_get_speed_type(spr) == spritespeed_framespersecond {
		return sprite_get_speed(spr) / room_speed 
	} else {
		return sprite_get_speed(spr)
	}
}

function ensure_singleton() {
	if instance_number(object_index) > 1 {
		instance_destroy()
		return false
	}
	return true
}

function is_html_build() {
	return os_browser != browser_not_a_browser
}
//// Shortcuts
function Randomer(first, second=undefined) constructor {
    self.from = first
    self.to = second
    if second == undefined {
        self.from = 0
        self.to = first
    }
    function __get() {
        return random_range(self.from, self.to)
    }
}
function IRandomer(first, second=undefined) constructor {
    self.from = first
    self.to = second
    if second == undefined {
        self.from = 0
        self.to = first
    }
    function __get() {
        return irandom_range(self.from, self.to)
    }
}

function make_timer(time) {
    return new Timer(time)
}
function randomer(first, second=undefined) {
    return new Randomer(first, second).__get
}
function irandomer(first, second=undefined) {
    return new IRandomer(first, second).__get
}

/// @param src - integer representing bit array, e.g. 2 -> 10, 6 -> 110
/// @param dest - index of a bit to check in src
function check_bitwise(src, dest) {
	return src & power(2, dest)
}





