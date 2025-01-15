if !EnsureSingleton() { exit }

/*
saved_data = {
    object_name: [
        {   
            // using detect data we find instance on the room start
            detect_data: {
                xstart: ,
                ystart: ,
                // image_xscale_start: ,
                // image_yscale_start: ,
                // image_angle_start: ,
                }

            },
            // after found an instance we assign variables from saved data to it
            saved_data: {

            }
        }
    ]
}
*/

saved_data = {}

function Save(inst, extra_detect_data, extra_save_data) {
    var obj_name = object_get_name(inst.object_index);

    // Check if instance has been saved before and remove it
    if struct_has(saved_data, obj_name) {
        var save_list = saved_data[$ obj_name];
        for (var i = 0; i < array_length(save_list); i++) {
            if (Detect(inst, save_list[i])) {
                array_delete(save_list, i, 1);
                show_debug_message("Removing previously saved instance")
                break;
            }
        }
    } else {
        // if there is no object_name in saved_data add it
        saved_data[$ obj_name] = []
    }

    // Create default save data for instance
    var saved = {
        detect_data: {
            xstart: inst.xstart,
            ystart: inst.ystart,
        },
        saved_data: {
            x: inst.x,
            y: inst.y,
            // image_angle: inst.image_angle,
        }
    };

    // Add additional detect and save data from extra_detect_data and extra_save_data
    if (extra_detect_data != undefined) {
        var keys = variable_struct_get_names(extra_detect_data);
        for (var i = 0; i < array_length(keys); i++) {
            saved.detect_data[$ keys[i]] = extra_detect_data[$ keys[i]];
        }
    }

    if (extra_save_data != undefined) {
        var keys = variable_struct_get_names(extra_save_data);
        for (var i = 0; i < array_length(keys); i++) {
            saved.saved_data[$ keys[i]] = extra_save_data[$ keys[i]];
        }
    }

    // Add to saved_data
    array_push(saved_data[$ obj_name], saved);
}

function Load() {
    // Iterate through all object names in saved_data
    var object_names = variable_struct_get_names(saved_data)
    for (var i = 0; i < array_length(object_names); i++) {
        var obj_name = object_names[i]
        var obj_index = asset_get_index(obj_name)
        var save_list = saved_data[$ obj_name]

        // Loop through all saved instances for the current object
        for (var j = 0; j < array_length(save_list); j++) {
            var saved = save_list[j]
			var found = false
			
            
            // Check if an existing instance matches the saved data
            with obj_index {
                if (other.Detect(self, saved)) {
                    other.LoadInstance(self, saved)
					found = true
                    break;
                }
            }
			
			if found { continue }

            // If no instance was found, create a new instance and load its data
            var inst = instance_create_layer(
                saved.saved_data.x, saved.saved_data.y,
                "Instances", obj_index)
            LoadInstance(inst, saved)
        }
    }
}

function Detect(inst, saved) {
    var keys = variable_struct_get_names(saved.detect_data);
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        if (!inst_has(inst, key) or (inst_get(inst, key) != saved.detect_data[$ key])) {
            return false;
        }
    }
    return true;
}


function LoadInstance(inst, saved) {
    // Assign data in saved to the instance
    var keys = variable_struct_get_names(saved.saved_data);
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        inst[$ key] = saved.saved_data[$ key];
    }
}

function UnsaveAll() {
    oSaveLevelScope.saved_data = {}
}

oEventSystem.Subscribe(SystemEvents.level_exit, id, UnsaveAll)
oEventSystem.Subscribe(SystemEvents.level_win, id, UnsaveAll)
