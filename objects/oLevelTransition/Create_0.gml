
EnsureSingleton()

fade_alpha = 0
fade_alpha_sp = 0.025
fade_color = c_black
transition_dir = false
full_fade_timer = MakeTimer(40)
target_room = noone


function GameOver(_fade_alpha=0) {
    fade_color = c_black
    StartTransition(room, _fade_alpha)
}

function StartTransition(_target_room, _fade_alpha=0, win=false) {
    fade_color = c_black
	if transition_dir != 0 {
		return
	}
    if win {
        oEventSystem.Notify(SystemEvents.level_win)
    }
	target_room = _target_room
	transition_dir = 1
	fade_alpha = _fade_alpha
}

function StartTransitionToNextLevel() {
	if transition_dir != 0 {
		return
	}
    StartTransition(level_order[current_level])
}

function StartFadingIn() {
    fade_alpha = 1
    transition_dir = -1
}

oEventSystem.Subscribe(SystemEvents.level_start, id, 
	function() {
		oLevelTransition.alarm[1] = 1
	}
)

oEventSystem.Subscribe(SystemEvents.level_exit, id, 
	function() {
		oLevelTransition.current_level = -1
	}
)