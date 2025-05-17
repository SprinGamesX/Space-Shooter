/// @description
part_type_color_rgb(part_star, color_get_red(c_rainbow) , color_get_red(c_rainbow), color_get_green(c_rainbow), color_get_green(c_rainbow), color_get_blue(c_rainbow), color_get_blue(c_rainbow));
part_particles_create(menu_particle_system, random_range(0, room_width), random_range(0, room_height), part_star, 1);

c_rainbow = make_color_hsv((time) mod 255,255,255);
time += 0.05;