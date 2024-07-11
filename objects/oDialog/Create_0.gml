/*
Dialogs trees and animation.
Dialog objects can be interacted via inventory items (see interact())
*/

depth = global.depths.dialogs
spr_face = noone

enum ExampleEvents {
    non_existing_event
}

dialog_x = room_width * 0.5
dialog_y = room_height * 0.7
row_height = 20
text_length = 0

dialog_tree = undefined

another_dialog = {
    text: "Ok, what have you been up to lately?",
    options: {
        "I'm trying to figure out all that dialog stuff": "[end]"
    },
    id: id,
    // call() will be called when this dialog shoots
    call: function() {
        // redefine dialog_tree to make this dialog always appear
        id.dialog_tree = self
    }
}

// default value for the "root" dialog 
// override this in childs
dialog_tree = {
    // text - is the current replica of an npc
    text: "Who has put a Dialog parent object here?",
    // a player can choose one of the options to answer
    // struct varialbes are options' texts
    options: {
        // option can define next npc's replica directly
        "I don't know": "And who does know, huh?",
        // or it can lead to another dialog struct
        "What is a Dialog parent?": {
            text: "It's the core object for the dialog system",
            options: {
                // remember object's id
                id: id,
                // and use it to loop the dialog
                "And what was your first question?": id.dialog_tree
            }
        },
        // store object's id in a struct like this to have access
        // to the object from the struct
        id: id,
        // Of course you can use other dialog structs defined externally
        "Let's talk about smth else": id.another_dialog,
        // use [end] marker to exit dialog
        "uh...": "[end]",
    },
    // mark events as happened
    event: ExampleEvents.non_existing_event
}
// Dialog also can contain list replicas
// see oMerry for example

is_active = true // can be interacted
is_dialog_running = false
current_dialog = dialog_tree
current_replica = "Default replica"
current_options = []
is_list_replicas = false
list_replicas_index = 0


intro_timer = MakeTimer(8)
draw_text_allowed = false
textbox_alpha = 0
textbox_w = 0

// inactive dialog object is invisible
// and don't respond if you click on it
function setActive(value) {
    is_active = value
    visible = value
}

#region dialog functions
// override this in childs if need
// to choose between various dialogs
function startDialog(dialog = undefined) {
    depth = global.depths.active_dialog
    global.dialog_on = true
    if dialog == undefined {
        dialog = getDialog()
    }
    is_dialog_running = true
    current_dialog = dialog
    dialogCheckCallFunction()
    dialogAddEvent()
    if is_array(current_dialog.text) {
        list_replicas_index = 0
        startListReplicas()
    } else {
        current_replica = current_dialog.text
        current_options_struct = current_dialog.options
        current_options = getKeys(current_options_struct)
        checkAddLeaveOption(current_options, current_options_struct)
    }
}

function chooseOption(option) {
    if option == "leave]" {
        endDialog()
        return
    }
    text_length = 0
    if is_list_replicas {
        nextListReplica()
        return
    }
    current_dialog = current_options_struct[$ option]
    if current_dialog == "[end]" {
        endDialog()
        return
    } else if is_string(current_dialog) {
        current_replica = current_dialog
        return
    } else {
        current_replica = current_dialog.text
        current_options_struct = get(current_dialog, "options")
    }

    dialogAddEvent()
    dialogCheckCallFunction()

    if current_replica == "[end]" {
        endDialog()
        return
    }

    current_options = getKeys(current_options_struct)
    checkAddLeaveOption(current_options, current_options_struct)
}

function endDialog() {
    is_dialog_running = false
    text_length = 0
    depth = global.depths.dialogs
    // reset global flag with delay in 1 frame
    alarm[0] = 1
}
function getDialog() {
    return dialog_tree
}

function startListReplicas() {
    is_list_replicas = true
    list_replicas = current_dialog.text
    current_replica = list_replicas[0]
    current_options = [list_replicas[1]]
    list_replicas_index = 0
}

function nextListReplica() {
    list_replicas_index += 2
    if list_replicas_index >= array_length(list_replicas) {
        is_list_replicas = false
        startDialog(current_dialog.next)
        return
    }
    current_replica = list_replicas[list_replicas_index]
    current_options = [list_replicas[list_replicas_index + 1]]
}

function dialogAddEvent() {
    var event = get(current_dialog, "event")
    if event != undefined and !oGameState.checkEventHappened(event) {
        oGameState.addEventHappened(event)
    }
}

function isEnd(opt, options_struct) {
    var value = options_struct[$ opt]
    return value == "[end]"
            or (is_struct(value)
                and value.text == "[end]")
}

function checkAddLeaveOption(options, options_struct) {
    for (var i = 0; i < array_length(options); i += 1) {
        var opt = options[i]
        if isEnd(opt, options_struct) {
            return;
        }
    }
    array_push(options, "leave]")
}

function dialogCheckCallFunction() {
    var call = get(current_dialog, "call")
    if call != undefined {
        call()
    }
}
#endregion

#region helper functionsg©
function get(struct, key) {
    if !variable_struct_exists(struct, key) {
        return undefined
    }
    return variable_struct_get(struct, key)
}

function getKeys(struct) {
    return struct_get_names(struct)
}

function getFirst(struct) {
    return getKeys(struct)[0]
}
#endregion

function interact(item) {
    // this function is called when dropping an
    // inventory item on dialog object
    // if item.object_index == oNuclearBomb {
    //     instance_destroy()
    // }
}
