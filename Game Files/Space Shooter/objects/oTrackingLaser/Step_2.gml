/// @description

if (follow){
	x = owner.x + xx;
	y = owner.y + yy;
}
else {
	x = xx;
	y = yy;

}

if (instance_exists(target)){
	direction = point_direction(owner.x, owner.y, target.x, target.y);
	length = point_distance(owner.x, owner.y, target.x, target.y);
	image_angle = direction;
}