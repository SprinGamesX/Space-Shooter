/// @description

event_inherited();

correction = 30;
exclude_normals = false;
time = 0;

die_out_of_bounds = false;
target = noone;

SeekClosestEnemy = function(){
	//var _enemy = _exclude_normals ?  instance_nearest(x,y, oParentElite) : instance_nearest(x,y, oEnemyObject);
	var _enemy = target;
	if (instance_exists(_enemy)){
		direction += correction * sign(angle_difference(point_direction(x, y, _enemy.x, _enemy.y), direction));
	}
	correction += time/10000;
	time++;
}
lockOnEnemies = function(){
	var _enemies = ds_list_create();
	
	if (exclude_normals){
		collision_circle_list(x, y, 3000, oEnemyElite, false, true, _enemies, true);
		if (ds_list_empty(_enemies)){
			collision_circle_list(x, y, 3000, oEnemyObject, false, true, _enemies, true);
		}
	}
	else collision_circle_list(x, y, 3000, oEnemyObject, false, true, _enemies, true);
	
	
	
	var _found = false;
	for (var i = 0; i < ds_list_size(_enemies) and !_found; i++){
		var _e = _enemies[|i];
		if (instance_exists(_e) and ds_list_find_index(hit_list, _e.id) == -1){
			target = _e;
			_found = true;
		}
	}
	
	ds_list_destroy(_enemies);
}