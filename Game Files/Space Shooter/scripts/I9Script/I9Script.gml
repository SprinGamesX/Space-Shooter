// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CreateI9Body(_index, _parent = self){
	var _inst = instance_create_depth(_parent.x, _parent.y, _parent.depth-1, oEnemyI9Body);
	
	with(_inst){
		index = _index;
		mode = IMODE.BASE;
		b_atk = _parent.b_atk;
		b_hp = _parent.b_hp/4;
		hp = b_hp;
		b_def = _parent.b_def;
		b_spd = 3;
		element = ELEMENT.ICE;
		max_toughtness = _parent.max_toughtness/2;
		toughness = max_toughtness;
		boss = _parent;
		
		sprite_index = sI9Bodies;
		image_index = index;
		
		switch(_index){
			case 0: base_x = -32; base_y = -32; break;
			case 1: base_x = 0;   base_y = -32; break;
			case 2: base_x = 32;  base_y = -32; break;
			case 3: base_x = -32; base_y = 0;   break;
			case 4: base_x = 32;  base_y = 0;   break;
			case 5: base_x = 32;  base_y = 32;  break;
			case 6: base_x = 0;	  base_y = 32;  break;
			case 7: base_x = -32; base_y = 32;  break;
		}
		
		bx = base_x;
		by = base_y;
		
		weaknesses = _parent.weaknesses;
		GainElementalRes(weaknesses);
	}
	return _inst;
}