/// @description Save Everything

SaveChips();
SaveParty();
SavePassives();
SaveShipLevels();

ds_map_destroy(global.settings);
ds_map_destroy(global.keybinds);