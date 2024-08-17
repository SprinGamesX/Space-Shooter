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
	
	if (object_is_ancestor(_col.object_index, oEnemyElite)){
		var _part = _col.part_hit;
		part_type_direction(_part, direction + 170, direction + 190, 0, 0);
		part_particles_create_color(global.battlePartSystem, x + lengthdir_x(sprite_width/2, direction), y + lengthdir_y(sprite_width/2, direction), _part, ColorForElement(_col.element), 15);
	}
	
	if (pierce <= 0) instance_destroy();
}

// Particles
if (trail){
	DrawProjTrail(owner);
}