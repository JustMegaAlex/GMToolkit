
function aimDist() {
	return point_distance(CamXCent(), CamYCent(), mouse_x, mouse_y)
}

function aimAngle() {
	return point_direction(CamXCent(), CamYCent(), mouse_x, mouse_y)
}

anchor_radius_gain = 2
target = oTopDownMove
sp_ratio = 0.125
rel_xto = x
rel_yto = y
relx = 0
rely = 0
