// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum ENEMIES{
	EXPERIMENTAL
}


function SummonEnemy(_enemy, _x, _y, _level){
	var _inst = noone;
	
	switch(_enemy){
		case ENEMIES.EXPERIMENTAL: {
			_inst = instance_create_layer(_x, _y, "Enemies", oExperimentalElite);
			with(_inst){
				lvl = _level;
				b_atk = 100;
				b_hp = 1500;
				hp = b_hp;
				b_def = 300;
				b_spd = 1;
				movement_speed = 3;
				element = ELEMENT.NONE;
				max_toughtness = 3000;
				toughness = max_toughtness;
				
				weaknesses = [ELEMENT.ICE, ELEMENT.FIRE, ELEMENT.QUANTUM];
				GainElementalRes(weaknesses);
			}
			
		}
		break;
	}
	
	
	return _inst;
	
}

function SummonCustomEnemy(_obj, _x, _y, _atk, _hp, _def, _spd, _element = ELEMENT.NONE, _toughness = 200, _boss = self, _isSmall = false, _customSprite = noone, _spin = false){
	var _inst = instance_create_layer(_x, _y, "Enemies", _obj);
	
	with(_inst){
		
		if (_customSprite != noone) sprite_index = _customSprite;
		else {
			if (_isSmall){
				sprite_index = sEnemiesSmall;
			}
			else sprite_index = sEnemiesNormal;
			image_index = _element;
		}
		
		b_atk = _atk;
		b_hp = _hp;
		hp = _hp;
		b_def = _def;
		b_spd = _spd;
		element = _element;
		max_toughtness = _toughness;
		toughness = max_toughtness;
		boss = _boss;
		spin = _spin;
		if (instance_exists(boss)){
			weaknesses = boss.weaknesses;
		}
		else weaknesses = [ELEMENT.ICE, ELEMENT.FIRE, ELEMENT.LIFE, ELEMENT.LIGHTNING, ELEMENT.VENOM, ELEMENT.STEEL, ELEMENT.QUANTUM];
	}
	
	return _inst;
}

function SummonEnemyLiner(_x, _y, _atk, _hp, _def, _spd, _direction, _element = ELEMENT.NONE, _toughness = 200, _boss = self, _isSmall = false, _customSprite = noone, _spin = false){
	var _inst = SummonCustomEnemy(oEnemyLiner, _x, _y, _atk, _hp, _def, _spd, _element, _toughness, _boss, _isSmall, _customSprite, _spin);
	_inst.direction = _direction;
	return _inst;
}

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

function HasWeakness(_weakness, _enemy = self){
	for (var i = 0; i < array_length(_enemy.weaknesses); i++){
		if (_enemy.weaknesses[i] == _weakness) return true;
	}
	return false;
}

function CreateAttack(_queue, _cd, _repeat = 1, _attacker = self, _var1 = 0, _var2 = 0, _var3 = 0, _var4 = 0, _start_cd = 0){
	var _inst = instance_create_layer(100, -100, "Misc", oEnemyAttack);
	with (_inst){
		repeatAttack = _repeat;
		cd = _cd;
		max_cd = _cd;
		attacker = _attacker;
		active = false;
		var1 = _var1;
		var2 = _var2;
		var3 = _var3;
		var4 = _var4;
		start_cd = _start_cd;
	}
	ds_queue_enqueue(_queue, _inst);
	return _inst;
}

function GainElementalRes(_weaknesses){
	for (var i = 1; i < 8; i++){
		var _has_weakness = false;
		for (var j = 0; j < array_length(_weaknesses) and !_has_weakness; j++){
			if (_weaknesses[j] == i) _has_weakness = true;
		}
		if (!_has_weakness){
			ApplyStat(self,"RES " + string(i), ElementToRes(i), 0.25, 1, 1,,true);
		}
	}
}

// if stop time is -1 it will stop permenently until release
function StopEnemy(_enemy, _stoptime = -1){
	_enemy.stopped = true;
	_enemy.stoptime = _stoptime;
}