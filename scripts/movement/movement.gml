///@arg speed
///@arg dir
function move(sp, dir) {
	x += lengthdir_x(sp, dir)
	y += lengthdir_y(sp, dir)
}

function move_coord(hsp, vsp) {
	x += hsp
	y += vsp
}

function move_coord_contact_glide(hsp, vsp, obj) {
	x += hsp
	//collision
	var dir = point_direction(0, 0, hsp, vsp)
	while place_meeting(x, y, obj) {
		x -= lengthdir_x(1, dir)
	}
	y += vsp
	while place_meeting(x, y, obj) {
		y -= lengthdir_y(1, dir)
	}
}

function move_coord_contact_obj(hsp, vsp, obj) {
	move_coord(hsp, vsp)
	var contact = instance_place(x, y, obj)
	while contact {
		// compute relative movement
		var relhsp = hsp - contact.hsp
		var relvsp = vsp - contact.vsp
		var reldir = point_direction(0, 0, relhsp, relvsp)
		// move out of an object
		while place_meeting(x, y, contact) {
	        x -= lengthdir_x(1, reldir)
	        y -= lengthdir_y(1, reldir)
		}
		var new_contact = instance_place(x, y, obj)
		if !new_contact {
			return contact
		}
		contact = new_contact
	}
	return contact
}

function move_contact_obj(sp, dir, obj) {
	move(sp, dir)
	//collision
	var contact = instance_place(x, y, obj)
	if contact {
		// move out of an object
		while place_meeting(x, y, contact) {
	        x -= lengthdir_x(1, dir)
	        y -= lengthdir_y(1, dir)
		}
	}
}
