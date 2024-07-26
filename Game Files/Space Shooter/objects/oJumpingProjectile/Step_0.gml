/// @description

// Inherit the parent event
event_inherited();

var _col = instance_place(x, y, oBorder);
if (instance_exists(_col)){
	direction = CalculateReflection(direction, _col.vertical) + irandom_range(-offset, offset);
	jumps--;
	if (jumps <= 0) instance_destroy();
}