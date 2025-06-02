// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum ENEMIES{
	EXPERIMENTAL,
	I9,
	GOLON,
	LIFEBOW,
	FIRESPIRIT
}


function SummonEnemy(_enemy, _x, _y, _level){
	var _inst = noone;
	
	switch(_enemy){
		case ENEMIES.EXPERIMENTAL: {
			_inst = instance_create_layer(_x, _y, "Enemies", oExperimentalElite);
			with(_inst){
				lvl = _level;
				b_atk = 50;
				b_hp = 1500;
				hp = b_hp;
				b_def = 300;
				b_spd = 1;
				movement_speed = 3;
				element = ELEMENT.NONE;
				max_toughness = 3000;
				toughness = max_toughness;
				
				weaknesses = [ELEMENT.ICE, ELEMENT.FIRE, ELEMENT.LIFE, ELEMENT.VENOM, ELEMENT.LIGHTNING, ELEMENT.STEEL,ELEMENT.QUANTUM];
				GainElementalRes(weaknesses);
			}
			
		}
		break;
		
		case ENEMIES.I9: {
			_inst = instance_create_layer(_x, _y, "Enemies", oEliteI9);
			with(_inst){
				lvl = _level;
				b_atk = 50;
				b_hp = 1500;
				hp = b_hp;
				b_def = 300;
				b_spd = 1;
				element = ELEMENT.ICE;
				max_toughness = 3000;
				toughness = max_toughness;
				
				weaknesses = [ELEMENT.FIRE, ELEMENT.LIGHTNING, ELEMENT.QUANTUM];
				GainElementalRes(weaknesses);
				
				// Create all bodies
				for (var i = 0; i < array_length(bodies); i++){
					bodies[i] = CreateI9Body(i, self);
				}
			}
			
		}
		break;
		
		case ENEMIES.GOLON: {
			_inst = instance_create_layer(_x, _y, "Enemies", oEliteGolon);
			with(_inst){
				lvl = _level;
				b_atk = 50;
				b_hp = 2250;
				hp = b_hp;
				b_def = 300;
				b_spd = 1;
				element = ELEMENT.LIGHTNING;
				max_toughness = 3000;
				toughness = max_toughness;
				
				weaknesses = [ELEMENT.ICE, ELEMENT.LIFE, ELEMENT.STEEL];
				GainElementalRes(weaknesses);
				
				
			}
			
		}
		break;
		case ENEMIES.LIFEBOW: {
			_inst = instance_create_layer(_x, _y, "Enemies", oEliteLifeBow);
			with(_inst){
				lvl = _level;
				b_atk = 100;
				b_hp = 1250;
				hp = b_hp;
				b_def = 300;
				b_spd = 1;
				element = ELEMENT.LIFE;
				max_toughness = 3000;
				toughness = max_toughness;
				
				weaknesses = [ELEMENT.FIRE, ELEMENT.VENOM, ELEMENT.QUANTUM];
				GainElementalRes(weaknesses);
				
				
			}
			
		}
		break;
		case ENEMIES.FIRESPIRIT: {
			_inst = instance_create_layer(_x, _y, "Enemies", oEliteFireSpirit);
			with(_inst){
				lvl = _level;
				b_atk = 25;
				b_hp = 1500;
				hp = b_hp;
				b_def = 300;
				b_spd = 10;
				element = ELEMENT.FIRE;
				max_toughness = 3000;
				toughness = max_toughness;
				
				weaknesses = [ELEMENT.ICE, ELEMENT.LIGHTNING, ELEMENT.QUANTUM];
				GainElementalRes(weaknesses);
			}
			
		}
		break;
	}
	
	if (instance_exists(_inst)) {
		_inst.active = true;
		_inst.applyStatsForLevel();
	}
	return _inst;
	
}

function SummonCustomEnemy(_obj, _x, _y, _atk, _hp, _def, _spd, _element = ELEMENT.NONE, _toughness = 200, _boss = self, _isSmall = false, _customSprite = noone, _spin = false, _ghost = false, _trail = false){
	var _inst = instance_create_layer(_x, _y, "Enemies", _obj);
	
	with(_inst){
		
		if (object_index == oEnemyObject or object_index == oEnemyLiner){
			if (_customSprite != noone) sprite_index = _customSprite;
			else {
				if (_isSmall){
					sprite_index = sEnemiesSmall;
				}
				else sprite_index = sEnemiesNormal;
				image_index = _element;
			}
		}
		
		b_atk = _atk;
		b_hp = _hp;
		hp = _hp;
		b_def = _def;
		b_spd = _spd;
		element = _element;
		max_toughness = _toughness;
		toughness = max_toughness;
		boss = _boss;
		
		spin = _spin;
		ghost = _ghost;
		show_trail = _trail;
		if (show_trail) part_trail = oParticleManager.get_particle(PARTICLE.TRAIL_FIRE_ENEMY);
		if (instance_exists(boss)){
			weaknesses = boss.weaknesses;
			if (boss.stopped) {
				stopped = true;
				stoptime = boss.stoptime;
			}
			if(boss.slowed){
				slowed = true;
				slowtime = boss.slowtime;
			}
		}
		else weaknesses = [ELEMENT.ICE, ELEMENT.FIRE, ELEMENT.LIFE, ELEMENT.LIGHTNING, ELEMENT.VENOM, ELEMENT.STEEL, ELEMENT.QUANTUM];
	}
	
	return _inst;
}

function SummonEnemyLiner(_x, _y, _atk, _hp, _def, _spd, _direction, _element = ELEMENT.NONE, _toughness = 200, _boss = self, _isSmall = false, _customSprite = noone, _spin = false, _ghost = false, _trail = false){
	var _inst = SummonCustomEnemy(oEnemyLiner, _x, _y, _atk, _hp, _def, _spd, _element, _toughness, _boss, _isSmall, _customSprite, _spin, _ghost, _trail);
	_inst.direction = _direction;
	return _inst;
}

function SummonEnemyConnector(_obj, _x, _y, _boss, _above = true){
	var _inst = SummonCustomEnemy(_obj, _x, _y, _boss.b_atk, _boss.b_hp, _boss.b_def, _boss.b_spd, _boss.element,, _boss);
	_inst.xoffset = _x;
	_inst.yoffset = _y;
	if (_above) _inst.depth = _boss.depth-1;
	else _inst.depth = _boss.depth+1;
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
		max_toughness = _toughness;
		toughness = max_toughness;
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

function StopAllEnemies(_stoptime = -1){
	oEnemyObject.stopped = true;
	oEnemyObject.stoptime = _stoptime;
}

function SlowAllEnemies(_slowtime = -1){
	oEnemyObject.slowed = true;
	oEnemyObject.slowtime = _slowtime;
}