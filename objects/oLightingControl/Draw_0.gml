/// @description Update and Draw Lighting

if deactivate_lights_enabled {
    //// Reactivate lights if in camera
    for (var i = 0; i < array_length(deactivated_lights); ++i) {
        with deactivated_lights[i] {
            if aura_in_view(other.aura_view) {
                instance_activate_object(self.id)
                array_delete(other.deactivated_lights, i, 1)
                i--
            }
        }
    }
    //// Deactivate lights out of camera
    with obj_Aura_Light_Parent {
        if !aura_in_view(other.aura_view) {
            instance_deactivate_object(id)
            array_push(other.deactivated_lights, {
                id: id,
                aura_light_radius: aura_light_radius,
                x: x,
                y: y
            })
        }
    }
} else { // activate all lights
    for (var i = 0; i < array_length(deactivated_lights); ++i) {
        with deactivated_lights[i] {
            instance_activate_object(self.id)
            array_delete(other.deactivated_lights, i, 1)
            i--
        }
    }
}


draw_lit_instances()

aura_update();
aura_draw_layered();


