/// @description
if (lifetime > 0) lifetime--;
else instance_destroy();

var _col = ds_list_create();
var _n = instance_place_list(x, y, oEnemyObject, _col, false);
for (var i = 0; i < _n; i++){
	if (ds_list_find_index(hit_list, _col[|i]) == -1){
		CreateAoe(owner, owner.element, _col[|i].x, _col[|i].y, atk_type, aoe);
		ds_list_add(hit_list, _col[|i]);
	}
}

if (part != noone){
	DrawLaserParticle(owner);
}

ds_list_destroy(_col)