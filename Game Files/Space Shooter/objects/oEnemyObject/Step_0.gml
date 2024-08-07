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
	
	
	var _ship = instance_place(x, y, oShipObject);
	if (instance_exists(_ship) and !_ship.invisible){
		onShipHit(_ship);
	}
}