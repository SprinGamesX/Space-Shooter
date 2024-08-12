// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum STAT{
	ATK = 0,
	HP = 1,
	DEF = 2,
	CRIT = 3,
	CRITDMG = 4,
	ENERGYREGEN = 5,
	AMMO = 20,
	RELOADSPD = 21,
	SPD = 6,
	RES = 7,
	FRIC = 22,
	ES = 19,
	RESPEN = 23,
	DEFPEN = 24,
	ICEDMG = 8,
	FIREDMG = 9,
	LIFEDMG = 10,
	VENOMDMG = 11,
	LIGHTNINGDMG = 12,
	STEELDMG = 13,
	QUANTUMDMG = 14,
	BREAKDMG = 15,
	BREAKEFF = 25,
	BASICATTACKDMG = 26,
	ALTDMG = 27,
	SKILLDMG = 28,
	ULTIMATEDMG = 29,
	FOLLOWUPDMG = 30,
	HEALINGBONUS = 16,
	ASPD = 17,
	EFFECTCHANCE = 18,
	DOTDMG = 31,
	ICERES = 32,
	FIRERES = 33,
	LIFERES = 34,
	VENOMRES = 35,
	LIGHTNINGRES = 36,
	STEELRES = 37,
	QUANTUMRES = 38,
	DOT = 999
}

function StatToText(_stat){
	switch(_stat){
		case STAT.ATK: return "ATK";
		case STAT.HP: return "HP";
		case STAT.DEF: return "DEF";
		case STAT.CRIT: return "CRIT RATE";
		case STAT.CRITDMG: return "CRIT DMG";
		case STAT.ENERGYREGEN: return "ENERGY REGEN";
		case STAT.AMMO: return "MAX AMMO";
		case STAT.RELOADSPD: return "RELOAD SPEED";
		case STAT.SPD: return "SPD";
		case STAT.RES: return "RESISTANCE";
		case STAT.FRIC: return "FRICTION";
		case STAT.ES: return "ELEMENTAL SPECIALTY";
		case STAT.RESPEN: return "RES PEN";
		case STAT.DEFPEN: return "DEF PEN";
		case STAT.ICEDMG: return "ICE DMG";
		case STAT.FIREDMG: return "FIRE DMG";
		case STAT.LIFEDMG: return "LIFE DMG";
		case STAT.VENOMDMG: return "VENOM DMG";
		case STAT.LIGHTNINGDMG: return "LIGNTNING DMG";
		case STAT.STEELDMG: return "STEEL DMG";
		case STAT.QUANTUMDMG: return "QUANTUM DMG";
		case STAT.BREAKDMG: return "BREAK DMG";
		case STAT.BREAKEFF: return "BREAK EFFICIANCY";
		case STAT.BASICATTACKDMG: return "BASIC ATTACK DMG";
		case STAT.ALTDMG: return "ALT ATTACK DMG";
		case STAT.SKILLDMG: return "SKILL ATTACK DMG";
		case STAT.ULTIMATEDMG: return "ULTIMATE DMG";
		case STAT.FOLLOWUPDMG: return "FOLLOW-UP ATTACK DMG";
		case STAT.HEALINGBONUS: return "HEALING BONUS";
		case STAT.ASPD: return "ATTACK SPEED";
		case STAT.EFFECTCHANCE: return "EFFECT-CHANCE";
		case STAT.DOT: return "DoT";
	}
	return "Forgor :(";
}

function ApplyStat(_target, _name, _stat, _scale, _lifetime, _stacks, _max_stacks = 1, _isInfinite = false, _supplier = self, _show_indicator = false, _custom_indicator = ""){
	var _inst = noone;
	
	if (_show_indicator){
		if (_custom_indicator != "") CreateCustomStatIndicator(_target, _custom_indicator, _supplier.element);
		else CreateStatIndicator(_target, _stat, _scale);
	}
	var _list = ds_map_find_value(_target.dstats, _stat);
	// Check if the buff exists already
	var _buff_exists = false;
	for (var i = 0; i < ds_list_size(_list); i++){
		if (instance_exists(_list[|i])) and (_list[|i].name == _name) {
			_buff_exists = true; 
			_inst = ds_list_find_value(_list, i);
			break;
		}
		else if (!instance_exists(_list[|i])){
			ds_list_delete(_list, i);
		}
	}
	// Apply buff if it doesnt exists
	if (!_buff_exists){
		if (_stat == STAT.DOT) _inst = instance_create_depth(-1000, -1000, 999, oDamageOverTime);
		else _inst = instance_create_depth(-1000, -1000, 999, oStat);
		with(_inst){
			name = _name;
			target = _target;
			stat = _stat;
			scale = _scale;
			provider = _supplier;
			time = _lifetime;
			isInfinite = _isInfinite;
			max_stacks = _max_stacks;
			stacks = _stacks;
			if (_stat == STAT.DOT) max_time = _lifetime;
		}
		ds_list_add(_list, _inst);
		return _inst;
	}
	// if the buff exists
	else {
		// if stackable
		if (_inst.max_stacks > 1){
			// if stacks are not maxed
			if (_inst.stacks < _inst.max_stacks) {
				_inst.stacks += _stacks;
				if (_inst.stacks > _inst.max_stacks) _inst.stacks = _inst.max_stacks;
				if (_stat == STAT.DOT and _inst.max_time > _lifetime) _inst.max_time = _lifetime;
				else _inst.time = _lifetime;
				return noone;
			}
			// if stacks are maxed refresh time
			else {
				if (_stat == STAT.DOT and _inst.max_time > _lifetime) _inst.max_time = _lifetime;
				else _inst.time = _lifetime;
				return noone;
			}
		}
		// if not stackable
		else {
			// if currenct buff is bigger
			if (_inst.scale < _scale){
				_inst.scale = _scale;
				if (_stat == STAT.DOT and _inst.max_time > _lifetime) _inst.max_time = _lifetime;
				else _inst.time = _lifetime;
				return noone;
			}
			// if it is exactly the same buff refresh its time
			else {
				if (_stat == STAT.DOT and _inst.max_time > _lifetime) _inst.max_time = _lifetime;
				else _inst.time = _lifetime;
				return noone;
			}
		}
	}
	
}

function ApplyTeamStat(_name, _stat, _scale, _lifetime, _stacks, _max_stacks = 1, _isInfinite = false, _supplier = self, _show_indicator = false, _custom_indicator = "", _excludeself = false){
	var _team = noone;
	if (!_excludeself) _team = oGameManager.getTeam();
	else _team = oGameManager.getInactiveShips();
	
	for (var i = 0; i < array_length(_team); i++){
		ApplyStat(_team[i], _name, _stat, _scale, _lifetime, _stacks, _max_stacks, _isInfinite, _supplier, _show_indicator, _custom_indicator);
	}
}
	
function CheckForStat(_gameobject, _type, _name){
	var _list = ds_map_find_value(_gameobject.dstats, _type);
	if (ds_list_size(_list) <= 0) return noone;
	for (var i = 0; i < ds_list_size(_list); i++){
		if (_list[|i].name == _name) return _list[|i];
	}
	
	return noone;
}
