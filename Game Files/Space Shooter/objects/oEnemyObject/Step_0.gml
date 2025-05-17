/// @description
if (!stopped){
	if (broken_time > 0 and !object_is_ancestor(object_index, oEnemyElite)){
		broken_time--;
		if (broken_time <= 0){
			toughness = max_toughness;
		}
	}
	if (!customMovement){
		if (spin != 0) {
			if (slowed) image_angle += spin / 10;
			else image_angle += spin;
		}
		else image_angle = direction;
	}
	else {
		onCustomMovement();
	}
	
	if (isEntering) onEntrance();
	
	if (countered){
		var _enemy = instance_place(x, y, oEnemyObject);
		if (instance_exists(_enemy)){
			if (object_is_ancestor(_enemy.object_index, oEnemyElite)){
				AdditionalSetDamage(_enemy, oGameManager.getActive(), _enemy.getHP()/100);
			}
			else {
				var _damage = _enemy.hp;
				_enemy.hp -= hp;
				hp -= _damage;
				
				if (_enemy.hp <= 0) _enemy.awaiting_destruction = true;
				if (hp <= 0) awaiting_destruction = true;
			}
		}
	}
	
	
	var _ship = instance_place(x, y, oShipObject);
	if (instance_exists(_ship) and !_ship.invisible){
		onShipHit(_ship);
	}
}

if (stoptime > 0) {
	stoptime--;
	stoptime = round(stoptime);
}
if (slowtime > 0) {
	slowtime--;
	slowtime = round(slowtime);
}
if (stoptime == 0) stopped = false;
if (slowtime == 0) slowed = false;

if (shock_immune){
	shock_immune--;
}

if (kill_out_of_bounds and IsOutOfBounds(128)){
	instance_destroy();
}
