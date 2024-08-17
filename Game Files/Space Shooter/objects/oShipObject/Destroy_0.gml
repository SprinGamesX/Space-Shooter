/// @description

// Inherit the parent event
event_inherited();

ds_map_destroy(scales);
ds_map_destroy(toughs);

// Kill particles 
part_type_destroy(shock_particle);
part_type_destroy(part_invis);
part_type_destroy(part_shockwave);
if (laser_particle != undefined){
	part_type_destroy(laser_particle);
	part_type_destroy(trail_particle);
}