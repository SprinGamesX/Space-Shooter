

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

function CreateCooldown(_timer, _repeat, _randomness = 0, _start_time = -1){
	var _inst = instance_create_depth(-999, -999, 99, oCooldown);
	with (_inst){
		timer = _timer;
		time = _timer;
		onRepeat = _repeat;
		randomness = _randomness;
		
		if (_start_time != -1){
			time = _start_time;
		}
	}
	return _inst;
}

function ScreenShake(_time, _magnitude, _fade)
{
   with (oScreenShake)
   {
      shake = true;
      shake_time = seconds(_time);
      shake_magnitude = _magnitude;
      shake_fade = _fade;
   }
}

function SmoothMovCorrection(_obj, _dest_x, _dest_y, _exclude_x = false, _exclude_y = false, _correction = 2){
	if (instance_exists(_obj)){
		var _x = _dest_x;
		var _y = _dest_y;
		
		if (!_exclude_x){
			var error_x = abs(_obj.x - _x) / 10;
			if (_obj.x > _x) _obj.x -= _correction * sqrt(error_x);
			if (_obj.x < _x) _obj.x += _correction * sqrt(error_x);
		}
		if (!_exclude_y){
			var error_y = abs(_obj.y - _y) / 10;
			if (_obj.y > _y) _obj.y -= _correction * sqrt(error_y);
			if (_obj.y < _y) _obj.y += _correction * sqrt(error_y);
		}
	}
}

function SmoothMovCorrection2(_obj, _dest_x, _dest_y, _exclude_x = false, _exclude_y = false, _correction = 2){
	if (instance_exists(_obj)){
		var _x = _dest_x;
		var _y = _dest_y;
		
		if (!_exclude_y and !_exclude_x){
			var error_x = abs(_obj.x - _x);
			var error_y = abs(_obj.y - _y);
			
			// Make into a vector
			var _dist = sqrt(power(error_x, 2) + power(error_y, 2));
			var _ang = arctan2(error_y, error_x);
			
			var _movement_speed = (_dist / 10) * _correction;
			
			_obj.x += lengthdir_x(_movement_speed, _ang);
			_obj.y += lengthdir_y(_movement_speed, _ang);
			
		}
		else {
			if (!_exclude_x){
				var error_x = abs(_obj.x - _x) / 10;
				if (_obj.x > _x) _obj.x -= _correction * sqrt(error_x);
				if (_obj.x < _x) _obj.x += _correction * sqrt(error_x);
			}
			if (!_exclude_y){
				var error_y = abs(_obj.y - _y) / 10;
				if (_obj.y > _y) _obj.y -= _correction * sqrt(error_y);
				if (_obj.y < _y) _obj.y += _correction * sqrt(error_y);
			}
		}
	}
}

function move_ease_to(_obj, x_target, y_target, max_speed, easing = 2) {
    var dist = point_distance(_obj.x, _obj.y, x_target, y_target);
    var dir  = point_direction(_obj.x, _obj.y, x_target, y_target);

    // Speed scales with distance but is clamped by max_speed
    var _speed = min(dist / easing, max_speed);

    if (dist < 0.5) {
        // Snap to target if close enough
        _obj.x = x_target;
        _obj.y = y_target;
    } else {
        // Move toward target with easing
        _obj.x += lengthdir_x(_speed, dir);
        _obj.y += lengthdir_y(_speed, dir);
    }
}

function SmoothRotCorrection(_obj, _dest_rot, _rot, _correction = 0.02){
	var _error = abs(_rot - _dest_rot);
	
	if (_rot > _dest_rot) return _rot - (_correction * sqr(_error));
	if (_rot < _dest_rot) return _rot + (_correction * sqr(_error));
	
	return _rot;
}

function smooth_number_to(_current, _target, _speed) {
    return lerp(_current, _target, clamp(_speed, 0, 1));
}