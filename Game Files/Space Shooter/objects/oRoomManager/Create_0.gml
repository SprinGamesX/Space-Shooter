/// @description
global.history = ds_stack_create();
savelast = true;
last_room = 0;


goBack = function(){
	if (ds_stack_size(global.history) > 0){
		var dest = ds_stack_pop(global.history);
		if (dest == rMenu or dest == rBattle) goMain();
		else {
			room_goto(dest);
			savelast = false;
		}	
	}
}

goMain = function(){
	savelast = false;
	ds_stack_clear(global.history);
	room_goto(rMenu);
}

getLastRoom = function(){
	return last_room;
}