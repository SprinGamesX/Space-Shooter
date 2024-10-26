/// @description
// Check Collision with enemies

var _col = ds_list_create();
var _n = instance_place_list(x, y, oEnemyObject, _col, false);


for (var i = 0; i < _n; i++){
	if (ds_list_find_index(hit_list, _col[|i]) == -1){
		owner.onPreHit(_col[|i], atk_type, dmg_type);
		ds_list_add(hit_list, _col[|i]);
	}
}

ds_list_destroy(_col);
if (_n > 20) instance_destroy();