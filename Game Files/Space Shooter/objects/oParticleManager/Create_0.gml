/// @description Store all particles here

enum PARTICLE{
	
	TRAIL_FIRE_ENEMY,
	
	FIRE_SPIRIT,
	SMALL_FIRE_SPIRIT
}


// Small Fire Enemy
part_fire_enemy = part_type_create();
part_type_sprite(part_fire_enemy, sPixel, 0, 0, 0);
part_type_alpha2(part_fire_enemy, 0.9, 0);
part_type_life(part_fire_enemy, seconds(0.75), seconds(1));
part_type_color3(part_fire_enemy, make_colour_rgb(255, 123, 0), make_colour_rgb(255, 75, 20), make_colour_rgb(215, 63, 17));
part_type_speed(part_fire_enemy, 2, 3, 0, 0);
part_type_direction(part_fire_enemy, 90, 90, 0, 0);
part_type_orientation(part_fire_enemy, 0, 360, 1, 0, 0);
part_type_size(part_fire_enemy, 1, 2, 0, 0);


// Fire Spirit Particle:
part_fs = part_type_create();
part_type_sprite(part_fs, sPixel, 0, 0, 0);
part_type_alpha2(part_fs, 0.9, 0);
part_type_life(part_fs, seconds(0.75), seconds(1));
part_type_color3(part_fs, make_colour_rgb(255, 123, 0), make_colour_rgb(255, 75, 20), make_colour_rgb(215, 63, 17));
part_type_speed(part_fs, 2, 3, 0, 0);
part_type_direction(part_fs, 90, 90, -0.2, 0);
part_type_orientation(part_fs, 0, 360, 1, 0, 0);
part_type_size(part_fs, 1, 4, 0, 0);

// Small Fire Spirit Particle:
part_sfs = part_type_create();
part_type_sprite(part_sfs, sPixel, 0, 0, 0);
part_type_alpha2(part_sfs, 0.9, 0);
part_type_life(part_sfs, seconds(0.75), seconds(1));
part_type_color3(part_sfs, make_colour_rgb(255, 123, 0), make_colour_rgb(255, 75, 20), make_colour_rgb(215, 63, 17));
part_type_speed(part_sfs, 1, 2, 0, 0);
part_type_direction(part_sfs, 90, 90, -0.2, 0);
part_type_orientation(part_sfs, 0, 360, 1, 0, 0);
part_type_size(part_sfs, 1, 4, 0, 0);


get_particle = function(_name){
	switch(_name){
		case PARTICLE.TRAIL_FIRE_ENEMY: return part_fire_enemy;	
		
		case PARTICLE.FIRE_SPIRIT: return part_fs;	
		case PARTICLE.SMALL_FIRE_SPIRIT: return part_sfs;	
	}
	return noone;
}