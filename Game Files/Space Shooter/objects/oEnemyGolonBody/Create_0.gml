/// @description

// Inherit the parent event
event_inherited();

time = 0;
base_y = 0;
move_margin = 16;

stick = function(){
	var _x = boss.x + xoffset;
	var _y = boss.y + yoffset;
	var correction = getSPD() * (slowed ? 0.5 : 5);
	
	if (x > room_width/4 * 3) correction /= 5;
	
	var error_x = abs(x - _x) / 10;
	if (x > _x) x -= correction * sqrt(error_x);
	if (x < _x) x += correction * sqrt(error_x);
	// y axis
	var error_y = abs(y - _y) / 10;
	if (base_y > _y) base_y -= correction * sqrt(error_y);
	if (base_y < _y) base_y += correction * sqrt(error_y);
	
	
	
	if (direction != boss.direction) direction = boss.direction;
}

movement = function(){
	time++;
	y = base_y + (sin(time/30) * move_margin); 
}

