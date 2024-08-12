

function seconds(_time){
	return _time * game_get_speed(gamespeed_fps);
}

function reSeconds(_time){
	return _time / game_get_speed(gamespeed_fps);
}

function minutes(_time){
	return _time * 60 * game_get_speed(gamespeed_fps);
}

function RollChance(_odds){
	randomize();
	return (_odds >= random(1));
}

function InRange(_x, _min, _max){
	return _x >= _min and _x <= _max;
}

function draw_setup(_font = font_basic_ui, _color = c_white, _halign = fa_center, _valign = fa_middle){
	draw_set_font(_font);
	draw_set_color(_color);
	draw_set_halign(_halign);
	draw_set_valign(_valign);
}

function RoundTo(_num, _decimals){
	var _mul = power(10, _decimals);
	
	var _newnum = _num * _mul;
	_newnum = floor(_newnum);
	return _newnum/_mul;
	
}

function CalculateReflection(_direction, _isVertical){
	show_debug_message("Reflection")
	if (InRange(_direction, 0, 90)){
		if (_isVertical){
			return 180 - _direction;
		}
		else {
			_dir = 90 - _direction 
			return 270 + _dir;
		}
	}
	if (InRange(_direction, 90, 180)){
		if (_isVertical){
			return 180 - _direction;
		}
		else {
			return 270 - (_direction - 90);
		}
	}
	if (InRange(_direction, 180, 270)){
		if (_isVertical){
			return 360 - (_direction - 180);
		}
		else {
			return 90 + (270 - _direction);
		}
	}
	if (InRange(_direction, 270, 360)){
		if (_isVertical){
			return 180 + (360 - _direction);
		}
		else {
			return 90 - (_direction - 270);
		}
	}
}

function CreateCooldown(_timer, _repeat){
	var _inst = instance_create_depth(-999, -999, 99, oCooldown);
	with (_inst){
		timer = _timer;
		onRepeat = _repeat;
	}
	return _inst;
}
