
// aura_init(0.05, c_aqua, true, 0, "Shadow_Tiles")
aura_init(0, c_aqua, true, 0, "Shadow_Tiles", 2, aura_blend_multiply);

deactivated_lights = []
deactivate_lights_enabled = true

/// Debug info
active_lights_count = 0
shadow_casters_count = 0
debug_view = dbg_view("Lighting", false)
dbg_watch(ref_create(self, "active_lights_count"), "Lights active")
dbg_watch(ref_create(self, "shadow_casters_count"), "Shadow casters")
dbg_checkbox(ref_create(self, "deactivate_lights_enabled"), "deactivate_lights")

/*
Set up layers which will be lit by aura
- all added layers are retargeted to be drawn to lit_layers_surf
- non-instance layers are retargeted using layer scripts
- instance layers are set invisible, all instance that should be drawn 
  must have parent set to oLightingSysInstance. They will be drawn manually (see Draw event)
*/
lit_layers_surf = surface_create(CamW(), CamH())
lit_layers = []
lit_instance_layers = []
cam_pos_prev = new Vec2(CamX(), CamY())
function layer_start() {
    if (event_type == ev_draw) {
        if (event_number == ev_draw_normal) {
			if !surface_exists(oLightingControl.lit_layers_surf) {
				oLightingControl.lit_layers_surf = surface_create(CamW(), CamH())	
			}
			surface_set_target(oLightingControl.lit_layers_surf)
        }
    }
}
function layer_end() {
    if (event_type == ev_draw) {
        if (event_number == ev_draw_normal) {
			surface_reset_target()
        }
    }
}

function LayerWrapper(lay_id, is_instances, is_static) constructor {
	self.id = lay_id
	self.is_instances = is_instances
	self.is_static = is_static
}


/// @param name - layer name
/// @param is_instances - self explanatory
/// @param is_static - static layers are not moved by lighting system
function add_layer(name, is_instances, is_static) {
    var layid = layer_get_id(name)
	if !is_instances {
	    layer_script_begin(layid, layer_start)
	    layer_script_end(layid, layer_end)
        array_push(lit_layers, new LayerWrapper(layid, is_instances, is_static))
	} else {
		layer_set_visible(layid, false)
	}
}

function draw_lit_instances() {
    if !surface_exists(lit_layers_surf) { lit_layers_surf = surface_create(CamW(), CamH()) }

    surface_set_target(lit_layers_surf)
    var x0 = CamX(), y0 = CamY(), x1 = CamX() + CamW(), y1 = CamY() + CamH()
    with oLightingSysInstance {
        if sprite_index and collision_rectangle(
                                x0, y0, x1, y1,
                                id, false, false) {
            draw_sprite_ext(sprite_index, image_index,
                x - x0, y - y0,
                image_xscale, image_yscale,
                image_angle, c_white, image_alpha
            )
        }
    }
    surface_reset_target()

}


function aura_draw_layered() {
	
	if !surface_exists(lit_layers_surf) { lit_layers_surf = surface_create(CamW(), CamH()) }
	
    /*
	Use stencil to draw lighting only above lit_layers_surf
	not affecting backgrounds
    0. Clear stencil with value of 3
    1. Draw lit_layers_surf with stencil enabled and alplha testing.
       This will set stencil buffer to value 1 only in solid-colored regions
    2. Draw aura light surface with stencil ref of 2 and compare func "greater"
       Thus drawing light only where (2 > stencil) - i.e. only where lit_layers_surf is solid
    3. Profit. Get lighting with untouched backgrounds
    */
	gpu_set_stencil_enable(true)
	draw_clear_stencil(3)
	gpu_set_alphatestenable(true)
	gpu_set_alphatestref(0)

	gpu_set_stencil_func(cmpfunc_always)
	gpu_set_stencil_ref(1)
	gpu_set_stencil_pass(stencilop_replace)
	draw_surface(lit_layers_surf, CamX(), CamY())

	gpu_set_alphatestenable(false)


	gpu_set_stencil_ref(2)
	gpu_set_stencil_func(cmpfunc_greater)

    #region aura default code
    // Set the blend mode (by default we use a multiply blend mode to get better lighting
	// that isn't as "burnt" or saturated as an additive blend mode, but this can be changed 
	// when you call the aura_init() function).
	if aura_blendmode == aura_blend_additive
		{
		gpu_set_blendmode(bm_add);
		}
	else gpu_set_blendmode_ext(bm_dest_color, bm_zero);

	// Draw the main AURA surface... First we get the position to draw at based 
	// on whether there is a view active or not.
	if aura_view > -1
		{
		var _vx = camera_get_view_x(view_camera[aura_view]);
		var _vy = camera_get_view_y(view_camera[aura_view]);
		}
	else
		{
		var _vx = 0;
		var _vy = 0;
		}

	// Here we check to see whether soft shadows are enabled
	if aura_soft > 0
		{
		// Soft shadows are enabled so we need to set the shader properties before drawing
		var _vw = camera_get_view_width(view_camera[aura_view]);
		var _vh = camera_get_view_height(view_camera[aura_view]);
		shader_set(sh_Aura_Blur)
		shader_set_uniform_f(aura_soft_usize, _vw, _vh, aura_soft);
		// Draw the surface
		draw_surface(aura_surface, _vx, _vy);
		shader_reset()
		}
	else
		{
		// No soft shadows so just draw the surface
		draw_surface(aura_surface, _vx, _vy);
		}
	
	// Reset the blend mode
	gpu_set_blendmode(bm_normal);
    #endregion

	gpu_set_stencil_enable(false)
}
