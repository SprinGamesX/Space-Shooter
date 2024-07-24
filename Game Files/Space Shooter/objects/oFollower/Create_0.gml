/// @description
target = noone;
owner = noone;
dir = 0;
disx = 0;
disy = 0;
cd = 0;
cdMax = 0;
isFollow = true;
isAim = true;
hp = 1;
lifespan = 0;

follow = function(){
	
	if (instance_exists(oGameManager)){
		target = oGameManager.getActive();
	}
	if (instance_exists(target)){
		var _x = target.x + disx;
		var _y = target.y + disy;
		var correction = 2;
	
		var error_x = abs(x - _x) / 10;
		if (x > _x) x -= correction * sqrt(error_x);
		if (x < _x) x += correction * sqrt(error_x);
		// y axis
		var error_y = abs(y - _y) / 10;
		if (y > _y) y -= correction * sqrt(error_y);
		if (y < _y) y += correction * sqrt(error_y);
	}
}

aim = function(){
	direction = point_direction(x, y, mouse_x, mouse_y);
	image_angle = direction;
}

animation = function(){
	// animate
}
skill = function(){
	// skill
}