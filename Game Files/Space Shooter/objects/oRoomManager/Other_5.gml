/// @description
last_room = room;

if (last_room == rBattle) last_room = rMenu;

if (savelast) ds_stack_push(global.history, room);