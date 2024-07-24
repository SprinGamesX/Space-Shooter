// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum ROLES{
	DPS,
	SUBDPS,
	BUFFER,
	DEBUFFER,
	HEALER,
	SHIELDER,
}


function GenerateEnergy(_energy,_target = self){
	_target.energy += _energy * (1 + _target.getStatBonus(STAT.ENERGYREGEN));
}

function ConsumeHp(_hp, _target = self){
	var _hp_consumed = _target.hp - _hp;
	if (_hp_consumed <= 0) {
		_hp_consumed = _target.hp - 1;
		_target.hp = 1;
	}
	else _target.hp -= _hp;
	_target.onHpReduction(_hp_consumed);
}

function RestoreHp(_hp, _supplier = self, _target = self){
	_target.hp += (_hp * (1 +_supplier.getStatBonus(STAT.HEALINGBONUS)));
	_target.hp = min(_target.hp, _target.getHP());
	
	_target.onHpRestoration(_hp);
	
	CreateCustomStatIndicator(_target, "Heal +" + string(_hp), ELEMENT.LIFE);
}

function RestoreTeamHp(_hp, _supplier = self, _ignore_self = false){
	
	var _targets = noone;
	if (_ignore_self) _targets = oGameManager.getInactiveShips();
	else _targets = oGameManager.getTeam();
	
	for (var i = 0; i < array_length(_targets); i++){
		RestoreHp(_hp, _supplier, _targets[i]);
	}
}




function InitiateShip(_id){
	var _ship = GetShipDetails(_id);
	
	lvl = 1;
	name = _ship.name;
	role = _ship.role;
	
	
	// base stats
	b_atk = _ship.b_atk + _ship.b_atk*(lvl-1)*0.2; // each level increases atk by 50%
	b_hp = _ship.b_hp + _ship.b_hp*(lvl-1)*0.4; // each level increases hp by 40%
	b_def = _ship.b_def + _ship.b_def*(lvl-1)*0.3; // each level increases def by 30%
	b_spd = _ship.b_spd;
	hp = b_hp;
	
	reload_max = _ship.reload_max;

	// basic attack & alternative attack
	max_bcd = _ship.max_bcd;
	max_acd = _ship.max_acd;
	max_ammo = _ship.max_ammo;

	// skill
	max_scd = _ship.max_scd;
	
	max_charge = _ship.max_charge;

	// ultimate
	max_energy = _ship.max_energy;
	energy = max_energy/2;
	ds_map_copy(scales, _ship.scales);
	ApplyStat(self, "Base Crit", STAT.CRIT, 0.05, 1, 1,,true,,false);
	ApplyStat(self, "Base Critdmg", STAT.CRITDMG, 0.5, 1, 1,,true,,false);
	
	passives = [global.passives[shipId][3], global.passives[shipId][9], global.passives[shipId][13]];
	
	instance_destroy(_ship);
}

function GetShipDetails(_id){
	var _inst = noone;
	switch(_id){
		// IceShip1
		case 1:{
			_inst = instance_create_depth(-100,-100,999, oShipObject);
			with(_inst){
				
				name = "Hielo";
				role = ROLES.SUBDPS;
				lvl = 1;

				// base stats
				b_atk = 30;
				b_hp = 100;
				b_def = 34;
				b_spd = 4;

				// Ammo
				reload_max = seconds(2);
				max_ammo = 20;
				
				// Cooldowns
				max_bcd = seconds(0.2);
				max_acd = seconds(0.2);
				max_scd = seconds(4);
				
				max_energy = 50;
				max_charge = 2;
				
				scales = ds_map_create();
				ds_map_add(scales, ATTACK_TYPE.BASIC, 0.1);
				ds_map_add(scales, ATTACK_TYPE.ALT, 0.2);
				ds_map_add(scales, ATTACK_TYPE.SKILL, 0.5);
				ds_map_add(scales, ATTACK_TYPE.SPECIAL, 0.75);
				ds_map_add(scales, ATTACK_TYPE.ULTIMATE, 1);
				ds_map_add(scales, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(scales, ATTACK_TYPE.EXIT, 0);
				ds_map_add(scales, ATTACK_TYPE.FOLLOWUP, 0);
			}
		} break;
		case 2:{
			_inst = instance_create_depth(-100,-100,999, oShipObject);
			with(_inst){
				
				name = "Fuego";
				role = ROLES.DPS;
				lvl = 1;

				// base stats
				b_atk = 30;
				b_hp = 100;
				b_def = 34;
				b_spd = 4;

				// Ammo
				reload_max = seconds(5);
				max_ammo = 150;
				
				// Cooldowns
				max_bcd = seconds(0.1);
				max_acd = seconds(0.2);
				max_scd = seconds(10);
				
				max_energy = 220;
				max_charge = 10;
				
				scales = ds_map_create();
				ds_map_add(scales, ATTACK_TYPE.BASIC, 0.05);
				ds_map_add(scales, ATTACK_TYPE.ALT, 0.8);
				ds_map_add(scales, ATTACK_TYPE.SKILL, 0);
				ds_map_add(scales, ATTACK_TYPE.SPECIAL, 2.5);
				ds_map_add(scales, ATTACK_TYPE.ULTIMATE, 0);
				ds_map_add(scales, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(scales, ATTACK_TYPE.EXIT, 0);
				ds_map_add(scales, ATTACK_TYPE.FOLLOWUP, 0);
			}
		} break;
		case 3:{
			_inst = instance_create_depth(-100,-100,999, oShipObject);
			with(_inst){
				
				name = "Vida";
				role = ROLES.HEALER;
				lvl = 1;

				// base stats
				b_atk = 30;
				b_hp = 100;
				b_def = 34;
				b_spd = 4;

				// Ammo
				reload_max = seconds(4);
				max_ammo = 10;
				
				// Cooldowns
				max_bcd = seconds(0.5);
				max_acd = seconds(1);
				max_scd = seconds(15);
				
				max_energy = 100;
				max_charge = 2;
				
				scales = ds_map_create();
				ds_map_add(scales, ATTACK_TYPE.BASIC, 0.1);
				ds_map_add(scales, ATTACK_TYPE.ALT, 0.1);
				ds_map_add(scales, ATTACK_TYPE.SKILL, 0.15);
				ds_map_add(scales, ATTACK_TYPE.SPECIAL, 0.5);
				ds_map_add(scales, ATTACK_TYPE.ULTIMATE, 0.4);
				ds_map_add(scales, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(scales, ATTACK_TYPE.EXIT, 0);
				ds_map_add(scales, ATTACK_TYPE.FOLLOWUP, 0);
			}
		} break;
	}
	
	return _inst;
}
