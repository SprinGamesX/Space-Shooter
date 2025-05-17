/// @description

enum HANGARITEM{
	ARROW_LEFT,
	ARROW_RIGHT,
	BUTTON_SKILLS,
	BUTTON_CHIPS,
	INV_LEFT,
	INV_RIGHT
}

enum HANGARMODE{
	DEFAULT = 0,
	CHIPS = 2,
	SKILLS = 1
}


alarm[0] = seconds(0.2);

arc = 0;
rad = 100;

selection = noone;
skill_selection = 0;
chipslot_selection = 0;
chip_selection = -1;
preview_chip = noone;
show_extra_skills = false;
ship = 1;
mode = HANGARMODE.DEFAULT;

chip_page = 1;


moveLeft = function(){
	ship--;
	if (ship <= 0){
		ship = array_length(global.ships) - 1;
	}
}

moveRight = function(){
	ship++;
	if (ship >= array_length(global.ships)){
		ship = 1;
	}
}
switchMode = function(_mode){
	mode = _mode;
}

time = 0;

GlobalInventorySort();