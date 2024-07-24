/// @description

enum HANGARITEM{
	ARROW_LEFT,
	ARROW_RIGHT,
	BUTTON_SKILLS,
	BUTTON_CHIPS
}

enum HANGARMODE{
	DEFAULT = 0,
	CHIPS = 2,
	SKILLS = 1
}

LoadPassives();

alarm[0] = seconds(0.2);

arc = 0;
rad = 100;

selection = noone;
skill_selection = 0;
ship = 1;
mode = HANGARMODE.DEFAULT;


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
