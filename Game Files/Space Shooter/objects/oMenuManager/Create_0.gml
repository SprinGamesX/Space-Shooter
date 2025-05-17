/// @description
options = ["Testing", "Endless", "Hangar", "Party", "Inventory"];
selection = 0;


menu_particle_system = part_system_create();

c_rainbow = c_white;
time = 0;


for (var i = 0; i < 150; i++){
	instance_create_depth(random(room_width), random(room_height), 98, oTwinklingStar)
}

// Particle
part_star = part_type_create();
part_type_shape(part_star, pt_shape_flare);
part_type_alpha3(part_star, 0, 0.1, 0);
part_type_life(part_star, seconds(5), seconds(6));
part_type_speed(part_star, 0.1, 0.5, 0, 0);

part_type_direction(part_star, 0, 359, 0,0);
part_type_size(part_star, 5, 9, 0, 0);
