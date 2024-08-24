// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// D1 - 1235/236 D2 - 1747/236 D3 - 1235/364 D4 - 1747/364
// C1 - 1363/44 C2 - 1491/44 C3 - 1619/44
// B1 - 1427/556 B2 - 1555/556
// A - 1415/224
enum CHIPSLOT{
	A = 0,
	B1 = 1,
	B2 = 2,
	C1 = 3,
	C2 = 4,
	C3 = 5,
	D1 = 6,
	D2 = 7,
	D3 = 8,
	D4 = 9
	
}


function GetChipSlotCords(_slot){
	switch(_slot){
		case CHIPSLOT.A:  return [1431, 240];
		case CHIPSLOT.B1: return [1427, 556];
		case CHIPSLOT.B2: return [1555, 556];
		case CHIPSLOT.C1: return [1363, 44];
		case CHIPSLOT.C2: return [1491, 44];
		case CHIPSLOT.C3: return [1619, 44];
		case CHIPSLOT.D1: return [1235, 236];
		case CHIPSLOT.D2: return [1747, 236];
		case CHIPSLOT.D3: return [1235, 364];
		case CHIPSLOT.D4: return [1747, 364];
	}
}


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

function GetInventorySection(_spaces, _skips, _type = -1){
	var arr = array_create(_spaces, noone);
	var _index = 0;
	for (var i = _skips; arr[_spaces-1] == noone; i++){
		if (ds_list_size(global.chips) <= i or i + _skips >= ds_list_size(global.chips)) break;
		if (_type != -1){
			if (_type == global.chips[|i].chiptype) {
				arr[_index] = global.chips[|i];
				_index++;
			}
		}
		else arr[i - _skips] = global.chips[|i]
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

function ConnectChip(_chip, _ship, _slot){
	var _found = noone;
	
	// Check if the slot is occupied
	for (var i = 0; i < ds_list_size(global.chips) and _found == noone; i++){
		var _inst = global.chips[|i];
		if (instance_exists(_inst)){
			if (_inst.wearer == _ship.shipId and _inst.wearer_slot == _slot){
				_found = _inst;
			}
		}
	}
	
	// Slot is not occupied
	if (_found == noone){
		_chip.wearer = _ship.shipId;
		_chip.wearer_slot = _slot;
		SaveChips();
		return true;
	}
	// Slot is occupied
	else {
		// the current chip is also occupied
		if (_chip.wearer != -1){
			_inst.wearer = _chip.wearer;
			_inst.wearer_slot = _chip.wearer_slot;
		}
		else {
			_inst.wearer = -1;
			_inst.wearer_slot = -1;
		}
		_chip.wearer = _ship.shipId;
		_chip.wearer_slot = _slot;
		SaveChips();
		return true;
	}
}

function SeperateChip(_chip){
	if (instance_exists(_chip)){
		_chip.wearer = -1;
		_chip.wearer_slot = -1;
		return true;
	}
	return false;
}

function FindChip(_wearer, _wearer_slot){
	for (var i = 0; i < ds_list_size(global.chips); i++){
		var _chip = global.chips[|i];
		if (instance_exists(_chip) and _chip.wearer = _wearer and _chip.wearer_slot = _wearer_slot) return _chip;
	}
	return noone;
}

function GetShipLoadout(_shipId){
	var arr = array_create(10, noone);
	var _index = 0;
	for (var i = 0; i < global.chips[|i]; i++){
		if (instance_exists(global.chips[|i]) and global.chips[|i].wearer = _shipId) {
			arr[_index] = global.chips[|i]; 
			_index++;
		}
	}
	return arr;
}

function GetSetBuff(_type, _num){
	var _mul = 0;
	
	// Elemental DMG or EFFECT CHANCE
	if (InRange(_type, 8, 14) or _type == STAT.EFFECTCHANCE){
		_mul = 0.05;
	}
	
	// ATK or CRITDMG
	if (_type == STAT.ATK or _type == STAT.CRITDMG){
		_mul = 0.06;
	}
	
	// HP
	if (_type == STAT.HP){
		_mul = 0.07;
	}
	
	// DEF or ES
	if (_type == STAT.DEF or _type == STAT.ES){
		_mul = 0.08;
	}
	
	// HEALING or SPD
	if (_type == STAT.HEALINGBONUS or _type == STAT.SPD){
		_mul = 0.04;
	}
	// ASPD or CRIT
	if (_type == STAT.ASPD or _type == STAT.CRIT){
		_mul = 0.03;
	}
	
	// BREAK
	if (_type == STAT.BREAKDMG){
		_mul = 0.09;
	}
	
	
	if (_num >= 6) _mul *= 2;
	if (_num >= 8) _mul *= 2;
	
	return _mul;
}