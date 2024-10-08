
if instance_exists(target) {
	var angle = aimAngle()
	var dist = sqrt(aimDist()) * anchor_radius_gain
	rel_xto = lengthdir_x(dist, angle)
	rel_yto = lengthdir_y(dist, angle)
	var rel_hsp = abs(relx - rel_xto)*sp_ratio
	var rel_vsp = abs(rely - rel_yto)*sp_ratio
	relx = Approach(relx, rel_xto, rel_hsp)
	rely = Approach(rely, rel_yto, rel_vsp)
	x = target.x + relx
	y = target.y + rely
}

CameraSetPos(x, y)
