/// @description

if (!place_meeting(x, y, selected_enemy)){
	var _inst = instance_place(x, y, oEnemyObject)
	if (_inst != noone and instance_exists(_inst)){
		selected_enemy = _inst;
	}
	else selected_enemy = noone;
}