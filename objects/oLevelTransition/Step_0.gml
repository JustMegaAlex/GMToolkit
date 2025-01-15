
if !full_fade_timer.update() {
	fade_alpha += fade_alpha_sp * transition_dir
}

switch transition_dir {
    case 1:
        if fade_alpha >= 1 {
            fade_alpha = 1
            transition_dir = -1
			full_fade_timer.reset()
            if target_room == room {
                room_restart()
            } else {
                oRoomLoader.GoTo(target_room)
            }
        }
    break
    case -1:
        if fade_alpha <= 0 {
            fade_alpha = 0
            transition_dir = 0
        }
    break
}
