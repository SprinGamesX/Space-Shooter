/// @description

event_inherited();

correction = 30;
exclude_normals = false;
time = 0;

die_out_of_bounds = false;

SeekClosestEnemy = function(){
	//var _enemy = _exclude_normals ?  instance_nearest(x,y, oParentElite) : instance_nearest(x,y, oEnemyObject);
	var _enemy =  instance_nearest(x,y, oEnemyObject);
	if (instance_exists(_enemy)){
		direction += correction * sign(angle_difference(point_direction(x, y, _enemy.x, _enemy.y), direction));
	}
	correction += time/10000;
	time++;
}