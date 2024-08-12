// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum ATTACK_TYPE{
	BASIC = 0,
	ALT = 1,
	SKILL = 2,
	ULTIMATE = 3,
	SPECIAL = 4,
	ENTRANCE = 5,
	EXIT = 6,
	FOLLOWUP = 7,
	DOT = 8,
	SHOCK = 998,
	FIRE_EXPLOSION = 999
}

function GetDamageBonus(_element, _attribute, _obj = self){
	var _bonus = 0;
	switch(_element){
		case ELEMENT.ICE: _bonus += _obj.getStatBonus(STAT.ICEDMG); break;
		case ELEMENT.FIRE: _bonus += _obj.getStatBonus(STAT.FIREDMG); break;
		case ELEMENT.LIFE: _bonus += _obj.getStatBonus(STAT.LIFEDMG); break;
		case ELEMENT.VENOM: _bonus += _obj.getStatBonus(STAT.VENOMDMG); break;
		case ELEMENT.LIGHTNING: _bonus += _obj.getStatBonus(STAT.LIGHTNINGDMG); break;
		case ELEMENT.STEEL: _bonus += _obj.getStatBonus(STAT.STEELDMG); break;
		case ELEMENT.QUANTUM: _bonus += _obj.getStatBonus(STAT.QUANTUMDMG); break;
	}
	switch(_attribute){
		case ATTACK_TYPE.BASIC: _bonus += _obj.getStatBonus(STAT.BASICATTACKDMG); break;
		case ATTACK_TYPE.ALT: _bonus +=_obj.getStatBonus(STAT.ALTDMG); break;
		case ATTACK_TYPE.SKILL: _bonus += _obj.getStatBonus(STAT.SKILLDMG); break;
		case ATTACK_TYPE.ULTIMATE: _bonus += _obj.getStatBonus(STAT.ULTIMATEDMG); break;
		case ATTACK_TYPE.FOLLOWUP: _bonus += _obj.getStatBonus(STAT.FOLLOWUPDMG); break;
		case ATTACK_TYPE.FIRE_EXPLOSION: _bonus += _obj.getStatBonus(STAT.ES); break;
		case ATTACK_TYPE.DOT: _bonus += _obj.getStatBonus(STAT.DOTDMG); break;
		case ATTACK_TYPE.SHOCK: _bonus += _obj.getStatBonus(STAT.ES); break;
	}
	
	return _bonus;
	
}

function GetCorrispondingRes(_element, _target){
	var _bonus = 0;
	
	switch(_element){
		case ELEMENT.ICE: _bonus += _target.getStatBonus(STAT.ICERES); break;
		case ELEMENT.FIRE: _bonus += _target.getStatBonus(STAT.FIRERES); break;
		case ELEMENT.LIFE: _bonus += _target.getStatBonus(STAT.LIFERES); break;
		case ELEMENT.VENOM: _bonus += _target.getStatBonus(STAT.VENOMRES); break;
		case ELEMENT.LIGHTNING: _bonus += _target.getStatBonus(STAT.LIGHTNINGRES); break;
		case ELEMENT.STEEL: _bonus += _target.getStatBonus(STAT.STEELRES); break;
		case ELEMENT.QUANTUM: _bonus += _target.getStatBonus(STAT.QUANTUMRES); break;
	}
	
	return _bonus;
}

function AdditionalDamage(_enemy, _ship, _scale, _dmg_type){
	if (instance_exists(_enemy)){
		var _basedmg = (_ship.getATK()) * _scale;
	
		var _dmgbonus = 1 + GetDamageBonus(_ship.element, _dmg_type);
	
		var _res = (1 - _enemy.getStatBonus(STAT.RES) - GetCorrispondingRes(_ship.element, _enemy) + _ship.getStatBonus(STAT.RESPEN));
	
		var _def = (1 - ((_enemy.b_def * (1 + _enemy.getStatBonus(STAT.DEF)) * (1 + _ship.getStatBonus(STAT.DEFPEN)))/5000));
	
		var _crit = RollChance(_ship.getStatBonus(STAT.CRIT));
	
	
		// 1 - Lvl multiplier
		var _damage = _basedmg * _dmgbonus * _res * _def * (1 + (_crit ? _ship.getStatBonus(STAT.CRITDMG) : 0)) *(_enemy.toughness == 0 ? 1.15 : 1) * (1 - ((_enemy.lvl - _ship.lvl) * 0.01));

		show_debug_message(string(_damage));
	
		CreateDamageIndicator(_enemy.x + random_range(0, 48) * (_ship.ind_index), _enemy.y - random_range(16, 64), string(round(_damage)) + (_crit ? "!" : ""), _ship.element, !object_is_ancestor(_enemy.object_index, oEnemyElite) ? 0.5 : 1);
		_ship.ind_index *= -1;
		_enemy.onHit(_damage, self);
	}
}

function AdditionalSetDamage(_enemy, _ship, _base_dmg){
	if (instance_exists(_enemy)){
		var _basedmg = _base_dmg;
	
		var _res = (1 - _enemy.getStatBonus(STAT.RES) - GetCorrispondingRes(_ship.element, _enemy) + _ship.getStatBonus(STAT.RESPEN));
	
		var _def = (1 - ((_enemy.b_def * (1 + _enemy.getStatBonus(STAT.DEF)) * (1 + _ship.getStatBonus(STAT.DEFPEN)))/5000));

		// 1 - Lvl multiplier
		var _damage = _basedmg * _res * _def *(_enemy.toughness == 0 ? 1.15 : 1) * (1 - ((_enemy.lvl - _ship.lvl) * 0.01));

		show_debug_message(string(_damage));
	
		CreateDamageIndicator(_enemy.x + random_range(0, 48) * (_ship.ind_index), _enemy.y - random_range(16, 64), string(round(_damage)), _ship.element, !object_is_ancestor(_enemy.object_index, oEnemyElite) ? 0.5 : 1);
		_ship.ind_index *= -1;
		_enemy.onHit(_damage, self);
	}
}