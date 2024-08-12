/// @description Game object Serves as the base for both Ships and Enemies but not for bullets/lasers/followers

// Create Status Lists
dstats = ds_map_create();

// Constants
element = ELEMENT.NONE;
lvl = 1;

ds_map_add(dstats,STAT.ATK, ds_list_create());
ds_map_add(dstats,STAT.HP, ds_list_create());
ds_map_add(dstats,STAT.DEF, ds_list_create());
ds_map_add(dstats,STAT.CRIT, ds_list_create());
ds_map_add(dstats,STAT.CRITDMG, ds_list_create());
ds_map_add(dstats,STAT.ENERGYREGEN, ds_list_create());
ds_map_add(dstats,STAT.AMMO, ds_list_create());
ds_map_add(dstats,STAT.RELOADSPD, ds_list_create());
ds_map_add(dstats,STAT.SPD, ds_list_create());
ds_map_add(dstats,STAT.RES, ds_list_create());
ds_map_add(dstats,STAT.FRIC, ds_list_create());
ds_map_add(dstats,STAT.ES, ds_list_create());
ds_map_add(dstats,STAT.RESPEN, ds_list_create());
ds_map_add(dstats,STAT.DEFPEN, ds_list_create());
ds_map_add(dstats,STAT.BREAKDMG, ds_list_create());
ds_map_add(dstats,STAT.BREAKEFF, ds_list_create());
ds_map_add(dstats,STAT.ICEDMG, ds_list_create());
ds_map_add(dstats,STAT.FIREDMG, ds_list_create());
ds_map_add(dstats,STAT.LIFEDMG, ds_list_create());
ds_map_add(dstats,STAT.VENOMDMG, ds_list_create());
ds_map_add(dstats,STAT.LIGHTNINGDMG, ds_list_create());
ds_map_add(dstats,STAT.STEELDMG, ds_list_create());
ds_map_add(dstats,STAT.QUANTUMDMG, ds_list_create());
ds_map_add(dstats,STAT.BASICATTACKDMG, ds_list_create());
ds_map_add(dstats,STAT.ALTDMG, ds_list_create());
ds_map_add(dstats,STAT.SKILLDMG, ds_list_create());
ds_map_add(dstats,STAT.ULTIMATEDMG, ds_list_create());
ds_map_add(dstats,STAT.FOLLOWUPDMG, ds_list_create());
ds_map_add(dstats,STAT.HEALINGBONUS, ds_list_create());
ds_map_add(dstats,STAT.ASPD, ds_list_create());
ds_map_add(dstats,STAT.EFFECTCHANCE, ds_list_create());
ds_map_add(dstats,STAT.ICERES, ds_list_create());
ds_map_add(dstats,STAT.FIRERES, ds_list_create());
ds_map_add(dstats,STAT.LIFERES, ds_list_create());
ds_map_add(dstats,STAT.VENOMRES, ds_list_create());
ds_map_add(dstats,STAT.LIGHTNINGRES, ds_list_create());
ds_map_add(dstats,STAT.STEELRES, ds_list_create());
ds_map_add(dstats,STAT.QUANTUMRES, ds_list_create());
ds_map_add(dstats,STAT.DOTDMG, ds_list_create());
ds_map_add(dstats,STAT.DOT, ds_list_create());


// Movement
locked = false; // Locked objects will not move or have their cooldowns reduced


getStatBonus = function(_stat){
	var _a = 0;
	var _list = ds_map_find_value(dstats, _stat);
	for (var i = 0; i < ds_list_size(_list); i++){
		var _inst = ds_list_find_value(_list, i);
		if (instance_exists(_inst) and _inst.stat == _stat){
			_a += _inst.getStat();
		}
	}
	return _a;
}

onStatOver = function(_ref){
	var _s = _ref.stat;
	var _list = ds_map_find_value(dstats, _s);
	var _i = ds_list_find_index(_list, _ref);
	ds_list_delete(_list, _i);
	instance_destroy(_ref);
}


getATK = function(){
	return b_atk * (1 + getStatBonus(STAT.ATK));
}

getHP = function(){
	return b_hp * (1 + getStatBonus(STAT.HP));
}

getDEF = function(){
	return b_def * (1 + getStatBonus(STAT.DEF));
}

getSPD = function(){
	return b_spd * (1 + getStatBonus(STAT.SPD));
}
