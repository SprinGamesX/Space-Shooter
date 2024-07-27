// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SummonTrainingEnemy(_sprite, _x, _y, _atk, _hp, _def, _spd, _element = ELEMENT.NONE, _toughness = 1000){
	var _inst = instance_create_layer(_x, _y, "Enemies", oEnemyObject);
	with(_inst){
		sprite_index = _sprite;
		b_atk = _atk;
		b_hp = _hp;
		hp = _hp;
		b_def = _def;
		b_spd = _spd;
		element = _element;
		max_toughtness = _toughness;
		toughness = max_toughtness;
	}
	return _inst;
}