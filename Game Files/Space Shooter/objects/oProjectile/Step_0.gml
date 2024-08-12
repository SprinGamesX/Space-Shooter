/// @description

// Rotation Control
if (spin){
	image_angle += spin;
}
else image_angle = direction;


// Killing out of bounds projectiles
if (die_out_of_bounds and IsOutOfBounds(50)){
	instance_destroy();
}

// Collision with enemies
var _col = instance_place(x, y, oEnemyObject);
if (instance_exists(_col) and _col != noone and ds_list_find_index(hit_list, _col.id) == -1){
	CreateAoe(owner, owner.element, x, y, atk_type, dmg_type,aoe);
	pierce--;
	ds_list_add(hit_list, _col.id);
	
	if (pierce <= 0) instance_destroy();
}

// Particles
if (trail){
	DrawProjTrail(owner);
}