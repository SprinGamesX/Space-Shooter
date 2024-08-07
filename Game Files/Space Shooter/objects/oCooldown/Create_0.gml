/// @description
onRepeat = false;
time = 0;
timer = 0;

execute = function(_time){
	var _done = false;
	
	if (time > 0) time -= _time;
	else {
		if (onRepeat){
			time = timer;
		}
		else {
			instance_destroy();
		}
		_done = true;
	}
	return _done;
}

