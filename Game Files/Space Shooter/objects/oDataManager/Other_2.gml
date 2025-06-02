/// @description Load Everything

LoadChips();
LoadParty();
LoadPassives();
LoadShipLevels();

// Settings
global.settings = ds_map_create();
ds_map_add(global.settings,"volume", 1);
ds_map_add(global.settings,"resolution",0);
ds_map_add(global.settings,"fullscreen",1);

global.keybinds = ds_map_create();
ds_map_add(global.keybinds, "up", ord("W"));
ds_map_add(global.keybinds, "left", ord("A"));
ds_map_add(global.keybinds, "down", ord("S"));
ds_map_add(global.keybinds, "right", ord("D"));
ds_map_add(global.keybinds, "basic attack", mb_left);
ds_map_add(global.keybinds, "alt attack", mb_right);
ds_map_add(global.keybinds, "skill", ord("E"));
ds_map_add(global.keybinds, "ultimate", ord("Q"));
ds_map_add(global.keybinds, "dodge counter", vk_space);
ds_map_add(global.keybinds, "team 1", ord("1"));
ds_map_add(global.keybinds, "team 2", ord("2"));