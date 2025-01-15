/// Collect dialog setup instances
trigger = instance_place(x, y, oDialogTrigger)  /// trigger by colliding with player
/// Collect camera setups
var cameras = ds_list_create()
instance_place_list(x, y, oDialogCameraFocus, cameras, false)
for (var i = 0; i < ds_list_size(cameras); i++) {
    var setup = cameras[| i]
    camera_setups[$ setup.label] = setup
}
ds_list_destroy(cameras)



/// Add the finishing frame
/// which has no text and only smoothly returns camera to player
array_push(frames, {
    text: undefined,
    camera_focus: "__finish",
    sprite: noone,
})
//// This setup's coords are assigned with player's coords on dialog trigger
camera_setups.__finish = instance_create_layer(
    global.player.x, 
    global.player.y,
    layer, oDialogCameraFocus)
