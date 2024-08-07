/// @description
if (!stopped){
	if (broken_time > 0){
		broken_time--;
		if (broken_time <= 0){
			toughness = max_toughtness;
		}
	}
	if (!customMovement){
		if (spin != 0) {
			image_angle += spin;
		}
		else image_angle = direction;
	}
	if (isEntering) onEntrance();
}