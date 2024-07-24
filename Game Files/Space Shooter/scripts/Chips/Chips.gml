// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function GetRandomChipSet(){
	
	var _r = irandom_range(1,18);
	switch(_r){
		case 1: return STAT.ICEDMG;
		case 2: return STAT.FIREDMG;
		case 3: return STAT.LIFEDMG;
		case 4: return STAT.VENOMDMG;
		case 5: return STAT.LIGHTNINGDMG;
		case 6: return STAT.STEELDMG;
		case 7: return STAT.QUANTUMDMG;
		case 8: return STAT.ATK;
		case 9: return STAT.HP;
		case 10: return STAT.DEF;
		case 11: return STAT.EFFECTCHANCE;
		case 12: return STAT.ES;
		case 13: return STAT.HEALINGBONUS;
		case 14: return STAT.ASPD;
		case 15: return STAT.SPD;
		case 16: return STAT.BREAKDMG;
		case 17: return STAT.CRIT;
		case 18: return STAT.CRITDMG;
	}
}

function RollStatForChip(_type){
	switch(_type){
		case 1: return choose(STAT.CRIT, STAT.CRITDMG, STAT.ATK, STAT.HP, STAT.DEF, STAT.HEALINGBONUS, STAT.RES);
		case 2: return choose(STAT.ICEDMG, STAT.FIREDMG, STAT.LIFEDMG, STAT.VENOMDMG, STAT.LIGHTNINGDMG, STAT.STEELDMG, STAT.QUANTUMDMG, STAT.ATK, STAT.DEF, STAT.HP, STAT.EFFECTCHANCE, STAT.BREAKDMG, STAT.ASPD);
		case 3: return choose(STAT.ES, STAT.ENERGYREGEN, STAT.BREAKDMG, STAT.EFFECTCHANCE, STAT.SPD, STAT.RES, STAT.CRIT, STAT.CRITDMG);
		case 4: return choose(STAT.ATK, STAT.HP, STAT.DEF);
	}
}

function GetScaleForStat(_type, _stat){
	// Roll a real number between 1.00 and 2.00
	var _sc = random_range(100, 200);
	_sc /= 100;
	
	if (_type == 1){
		switch(_stat){
			case STAT.ATK: return 22 * _sc;
			case STAT.HP: return 24 * _sc;
			case STAT.DEF: return 28 * _sc;
			case STAT.CRITDMG: return 48 * _sc;
			case STAT.CRIT: return 24 * _sc;
			case STAT.RES: return 10 * _sc;
			case STAT.HEALINGBONUS: return 14 * _sc;
		}
	}
	if (_type == 2){
		
		if (InRange(_stat, 8, 14)) return 15 * _sc;
		
		switch(_stat){
			case STAT.ATK: return 15 * _sc;
			case STAT.HP: return 20 * _sc;
			case STAT.DEF: return 22 * _sc;
			case STAT.EFFECTCHANCE: return 16 * _sc;
			case STAT.ASPD: return 8 * _sc;
			case STAT.BREAKDMG: return 23 * _sc;
		}
	}
	if (_type == 3){
		
		switch(_stat){
			case STAT.EFFECTCHANCE: return 12 * _sc;
			case STAT.BREAKDMG: return 15 * _sc;
			case STAT.CRITDMG: return 16 * _sc;
			case STAT.CRIT: return 8 * _sc;
			case STAT.RES: return 6 * _sc;
			case STAT.ES: return 25 * _sc;
			case STAT.ENERGYREGEN: return 14 * _sc;
			case STAT.SPD: return 11 * _sc;
		}
	}
	if (_type == 4){
		switch(_stat){
			case STAT.ATK: return 12 * _sc;
			case STAT.HP: return 13 * _sc;
			case STAT.DEF: return 15 * _sc;
		}
	}
	
}



function GenerateRandomChip(){
	randomize();
	var _chip = instance_create_depth(-999, -999, 0, oChip);
	with(_chip){
		
		set = GetRandomChipSet();
		chiptype = irandom_range(1,4);
		stat = RollStatForChip(chiptype);
		scale = GetScaleForStat(chiptype, stat);
	}
	
	ds_list_add(global.chips, _chip);
	SaveChips();
	return _chip;
}

function GetInventorySection(_spaces, _skips){
	var arr = array_create(_spaces, noone);
	for (var i = _skips; i < _spaces + _skips; i++){
		if (ds_list_size(global.chips) <= i) break;
		arr[i - _skips] = global.chips[|i]
	}
	return arr;
}

function GetChipSetColor(_set){
	
	switch(_set){
		case STAT.ICEDMG: return #20d6c7;
		case STAT.FIREDMG: return #e79618;
		case STAT.LIFEDMG: return #67e03e;
		case STAT.VENOMDMG: return #bc4a9b;
		case STAT.LIGHTNINGDMG: return #f8f530;
		case STAT.STEELDMG: return #99a2c0;
		case STAT.QUANTUMDMG: return #6153a2;
		case STAT.ATK: return #cb001b;
		case STAT.HP: return #13982b;
		case STAT.DEF: return #16396e;
		case STAT.EFFECTCHANCE: return #ff64d1;
		case STAT.ES: return #ffcb8c;
		case STAT.HEALINGBONUS: return #7bff3d;
		case STAT.ASPD: return #ff7663;
		case STAT.SPD: return #ca99ff;
		case STAT.BREAKDMG: return #caff85;
		case STAT.CRIT: return #80ffc3;
		case STAT.CRITDMG: return #ff4d61;
	}
	return c_white;
}


function SaveChips(){
	ini_open("Chip Inventory.ini");
	var _save = ds_list_create();
	
	for (var i = 0; i < ds_list_size(global.chips); i++){
		if (global.chips[|i] != noone) ds_list_add(_save, global.chips[|i].compress());
	}
	
	ini_write_string("Inventory", "Chips", ds_list_write(_save));
	ds_list_destroy(_save);
	ini_close();
}

function DecompressChip(_chipdata){
	// set, stat, chiptype, scale, wearer, wearer_slot
	var _chip = instance_create_depth(-999, -999, 0, oChip);
	with(_chip){
		set = _chipdata[0];
		stat = _chipdata[1];
		chiptype = _chipdata[2];
		scale = _chipdata[3];
		wearer = _chipdata[4];
		wearer_slot = _chipdata[5];
	}
	return _chip;
}

function LoadChips(){
	ini_open("Chip Inventory.ini");
	var _str = ini_read_string("Inventory", "Chips", "");
	if (_str == "") return;
	var _save = ds_list_create();
	ds_list_read(_save, _str);
	
	for (var i = 0; ds_exists(_save, ds_type_list) and i < ds_list_size(_save); i++){
		ds_list_add(global.chips, DecompressChip(_save[|i]));
	}
	
	ds_list_destroy(_save);
	ini_close();
}