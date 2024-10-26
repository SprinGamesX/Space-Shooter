/// @description
if (lifetime > 0) lifetime--;
else destruction();

var _col = ds_list_create();
var _n = instance_place_list(x, y, oEnemyObject, _col, false);
for (var i = 0; i < _n; i++){
	
	var _test = _col[|i];
	
	if (object_is_ancestor(_test.object_index, oEnemyConnector)){
		_test = _test.boss;
	}
	if (ds_list_find_index(hit_list, _test) == -1){
		CreateAoe(owner, owner.element, _test.x, _test.y, atk_type,dmg_type, aoe);
		ds_list_add(hit_list, _test);
	}
}

if (show_particles){
	DrawLaserParticle(owner);
}

ds_list_destroy(_col)