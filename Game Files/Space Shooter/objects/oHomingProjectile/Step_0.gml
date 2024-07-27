/// @description
if (!instance_exists(target) or ds_list_find_index(hit_list, target.id) != -1) lockOnEnemies();
// Inherit the parent event
event_inherited();


SeekClosestEnemy();
