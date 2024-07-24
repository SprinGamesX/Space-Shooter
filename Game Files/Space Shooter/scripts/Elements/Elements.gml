// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum ELEMENT{
	ICE = 1,
	FIRE = 2,
	LIFE = 3,
	VENOM = 4,
	LIGHTNING = 5,
	STEEL = 6,
	QUANTUM = 7,
	NONE = 0
}

function ColorForElement(_element){
	switch(_element){
		case ELEMENT.ICE: return make_color_rgb(121, 236, 238);
		case ELEMENT.FIRE: return make_color_rgb(238, 137, 64);
		case ELEMENT.LIFE: return make_color_rgb(75, 221, 80);
		case ELEMENT.LIGHTNING: return make_color_rgb(238, 235, 48);
		case ELEMENT.STEEL: return make_color_rgb(176, 172, 158);
		case ELEMENT.QUANTUM: return make_color_rgb(79,53,165);
		case ELEMENT.VENOM: return make_color_rgb(190, 83, 190);
		case ELEMENT.NONE: return make_color_rgb(192, 32, 43);
	}
}