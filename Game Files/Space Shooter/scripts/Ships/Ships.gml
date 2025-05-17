// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.ship_levels = array_create(array_length(global.ships), 1);

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
	var _re = _hp;
	if (_hp_consumed <= 0) {
		_re = _hp_consumed * (-1)
		_hp_consumed = _target.hp - 1;
		_target.hp = 1;
	}
	else _target.hp -= _hp;
	_target.onHpReduction(_hp_consumed);
	return _re;
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

function ProvideShield(_shield, _supplier = self, _target = self){
	_target.shield += _shield;
	_target.onShieldGain(_shield);
	
	CreateCustomStatIndicator(_target, "Shield +" + string(_shield), ELEMENT.STEEL);
}

function ProvideTeamShield(_shield, _supplier = self, _ignore_self = false){
	
	var _targets = noone;
	if (_ignore_self) _targets = oGameManager.getInactiveShips();
	else _targets = oGameManager.getTeam();
	
	for (var i = 0; i < array_length(_targets); i++){
		ProvideShield(_shield, _supplier, _targets[i]);
	}
}

function TriggerElementalReaction(_enemy, _ship){
	
	switch(_ship.element){
		case ELEMENT.ICE: {
			// effect
			StopEnemy(_enemy, seconds(5) * (1 + _ship.getStatBonus(STAT.ES)));
			ApplyStat(_enemy, "Cryoarrested", STAT.ICERES, -0.05, 1, 1, 10, true, _ship,true, "Cryoarrested", true);
			
			// Notify team
			var _team = oGameManager.getTeam();
			for (var i = 0; i < array_length(_team); i++){
				_team[i].onIceReaction(_enemy);
			}
		} break;
		
		case ELEMENT.FIRE: {
			// effect
			ApplyStat(_enemy, "Volatogenic", STAT.FIRERES, 0, 1, 1, 100, true, _ship,true, "Volatogenic", true);
			
			// Notify team
			var _team = oGameManager.getTeam();
			for (var i = 0; i < array_length(_team); i++){
				_team[i].onFireReaction(_enemy);
			}
		} break;
		
		case ELEMENT.LIFE: {
			// effect
			RestoreTeamHp((_ship.getHP() / 10)* _ship.getStatBonus(STAT.ES), _ship, false);
			
			// Notify team
			var _team = oGameManager.getTeam();
			for (var i = 0; i < array_length(_team); i++){
				_team[i].onLifeReaction(_enemy);
			}
		} break;
		
		case ELEMENT.VENOM: {
			// effect
			// Apply DoT
			ApplyStat(_enemy, "Incised", STAT.ATK, -0.2, seconds(15), 1,,, _ship,true, "Incised",true);
			ApplyStat(_enemy, "Incised 2", STAT.SPD, -0.2, seconds(15), 1,,, _ship,,,true);
			
			ApplyStat(_enemy, "Incised DoT", STAT.DOT, 0.5 + (0.5 * _ship.getStatBonus(STAT.ES)), seconds(2), 5,50,,_ship,,,true);
			
			
			// Notify team
			var _team = oGameManager.getTeam();
			for (var i = 0; i < array_length(_team); i++){
				_team[i].onVenomReaction(_enemy);
			}
		} break;
		
		case ELEMENT.LIGHTNING: {
			// effect
			ApplyStat(_enemy, "Electrostruck", STAT.LIGHTNINGRES, -0.3, seconds(15), 1,,, _ship,true, "Electrostruck", true);
			
			// Notify team
			var _team = oGameManager.getTeam();
			for (var i = 0; i < array_length(_team); i++){
				_team[i].onLightningReaction(_enemy);
			}
		} break;
		
		case ELEMENT.STEEL: {
			// effect
			ApplyStat(_enemy, "Fractured", STAT.DEF, -0.5, seconds(15), 1,,,_ship,true, "Fractured", true);
			_enemy.onToughnessReduction(_enemy.max_toughness * 0.15, _ship);
			
			// Notify team
			var _team = oGameManager.getTeam();
			for (var i = 0; i < array_length(_team); i++){
				_team[i].onSteelReaction(_enemy);
			}
		} break;
		
		case ELEMENT.QUANTUM: {
			// effect
			
			ApplyStat(_enemy, "Decoherence", STAT.QUANTUMRES, 0, 1, 1,,,_ship,true, "Decoherence", true);
			AdditionalSetDamage(_enemy, _ship, _enemy.b_hp * 0.01);
			if (!object_is_ancestor(_enemy.object_index, oEnemyElite)){
				_enemy.direction += irandom_range(0, 360);
				_enemy.x += random(500);
				_enemy.y += random_range(-500,500);
			}
			
			
			// Notify team
			var _team = oGameManager.getTeam();
			for (var i = 0; i < array_length(_team); i++){
				_team[i].onQuantumReaction(_enemy);
			}
		} break;
	}	
}

function SaveShipLevels(){
	ini_open("Ship Levels.ini");
	
	for (var i = 0; i < array_length(global.ship_levels); i++){
		ini_write_real("Ship Levels", i, global.ship_levels[i]);
	}
	
	ini_close();
}

function LoadShipLevels(){
	ini_open("Ship Levels.ini");
	
	for (var i = 0; i < array_length(global.ship_levels); i++){
		global.ship_levels[i] = ini_read_real("Ship Levels", i, 1);
	}
	
	ini_close();
}



function InitiateShip(_id){
	var _ship = GetShipDetails(_id);
	
	lvl = global.ship_levels[_id-1];
	name = _ship.name;
	role = _ship.role;
	
	
	// base stats
	b_atk = _ship.b_atk + _ship.b_atk*(lvl-1)*0.2; // each level increases atk by 50%
	b_hp = _ship.b_hp + _ship.b_hp*(lvl-1)*0.4; // each level increases hp by 40%
	b_def = _ship.b_def + _ship.b_def*(lvl-1)*0.3; // each level increases def by 30%
	b_spd = _ship.b_spd;
	
	
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
	ds_map_copy(toughs, _ship.toughs);
	ds_map_copy(elmacc, _ship.elmacc);
	
	ds_map_add(scales, ATTACK_TYPE.FIRE_EXPLOSION, 0.5);
	ds_map_add(toughs, ATTACK_TYPE.FIRE_EXPLOSION, 0);
	ds_map_add(elmacc, ATTACK_TYPE.FIRE_EXPLOSION, 0);
	
	ApplyStat(self, "Base Crit", STAT.CRIT, 0.05, 1, 1,,true,,false);
	ApplyStat(self, "Base Critdmg", STAT.CRITDMG, 0.5, 1, 1,,true,,false);
	
	passives = [global.passives[shipId][3], global.passives[shipId][9], global.passives[shipId][13]];
	boosts = [global.passives[shipId][1], global.passives[shipId][7]];
	mastery = [global.passives[shipId][5], global.passives[shipId][11]];
	
	var pass = global.passives[shipId];
	var _ind = 0;
	var _st = GetShipST(shipId);
	for (var i = 0; i < array_length(pass); i += 2){
		if (pass[i]){
			ApplyStat(self, "ST " + string(i), _st[0][_ind], _st[1][_ind], 1, 1,,true,,false);
			_ind++;
		}
	}
	var _chips = GetShipLoadout(_id);
	var _set_list = array_create(10, -1);
	var _count = 0;
	
	for (var i = 0; i < array_length(_chips); i++){
		if (instance_exists(_chips[i]) and _chips[i].chiptype == 1) _set = _chips[i].set;
	}
	
	for (var i = 0; i < array_length(_chips); i++){
		if (instance_exists(_chips[i])){
			ApplyStat(self, "CHIP " + string(i), _chips[i].stat, _chips[i].scale/100, 1, 1,,true,,false);
			_set_list[i] = _chips[i].set
		}
	}
	// Apply set buff
	if (!array_equals(_set_list, array_create(10, -1))){
		ApplySetBuffs(self, _set_list);
	}
	
	// Apply Additional buffs
	GetAdditionalBuffs(self, mastery, boosts);
	
	// Particles
	
	
	hp = getHP();
	ammo = max_ammo;
	
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
				max_acd = seconds(0.4);
				max_scd = seconds(4);
				
				max_energy = 120;
				max_charge = 2;
				
				scales = ds_map_create();
				ds_map_add(scales, ATTACK_TYPE.BASIC, 0.1);
				ds_map_add(scales, ATTACK_TYPE.ALT, 0.1);
				ds_map_add(scales, ATTACK_TYPE.SKILL, 0.5);
				ds_map_add(scales, ATTACK_TYPE.SPECIAL, 0.75);
				ds_map_add(scales, ATTACK_TYPE.ULTIMATE, 1);
				ds_map_add(scales, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(scales, ATTACK_TYPE.EXIT, 0);
				ds_map_add(scales, ATTACK_TYPE.FOLLOWUP, 0);
				
				toughs = ds_map_create();
				ds_map_add(toughs, ATTACK_TYPE.BASIC, 20);
				ds_map_add(toughs, ATTACK_TYPE.ALT, 20);
				ds_map_add(toughs, ATTACK_TYPE.SKILL, 40);
				ds_map_add(toughs, ATTACK_TYPE.SPECIAL, 40);
				ds_map_add(toughs, ATTACK_TYPE.ULTIMATE, 20);
				ds_map_add(toughs, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(toughs, ATTACK_TYPE.EXIT, 0);
				ds_map_add(toughs, ATTACK_TYPE.FOLLOWUP, 0);
				
				elmacc = ds_map_create();
				ds_map_add(elmacc, ATTACK_TYPE.BASIC, 1);
				ds_map_add(elmacc, ATTACK_TYPE.ALT, 1);
				ds_map_add(elmacc, ATTACK_TYPE.SKILL, 2);
				ds_map_add(elmacc, ATTACK_TYPE.SPECIAL, 2);
				ds_map_add(elmacc, ATTACK_TYPE.ULTIMATE, 3);
				ds_map_add(elmacc, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(elmacc, ATTACK_TYPE.EXIT, 0);
				ds_map_add(elmacc, ATTACK_TYPE.FOLLOWUP, 0);
				
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
				
				toughs = ds_map_create();
				ds_map_add(toughs, ATTACK_TYPE.BASIC, 20);
				ds_map_add(toughs, ATTACK_TYPE.ALT, 40);
				ds_map_add(toughs, ATTACK_TYPE.SKILL, 0);
				ds_map_add(toughs, ATTACK_TYPE.SPECIAL, 40);
				ds_map_add(toughs, ATTACK_TYPE.ULTIMATE, 0);
				ds_map_add(toughs, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(toughs, ATTACK_TYPE.EXIT, 0);
				ds_map_add(toughs, ATTACK_TYPE.FOLLOWUP, 0);
				
				elmacc = ds_map_create();
				ds_map_add(elmacc, ATTACK_TYPE.BASIC, 1);
				ds_map_add(elmacc, ATTACK_TYPE.ALT, 2);
				ds_map_add(elmacc, ATTACK_TYPE.SKILL, 0);
				ds_map_add(elmacc, ATTACK_TYPE.SPECIAL, 2);
				ds_map_add(elmacc, ATTACK_TYPE.ULTIMATE, 0);
				ds_map_add(elmacc, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(elmacc, ATTACK_TYPE.EXIT, 0);
				ds_map_add(elmacc, ATTACK_TYPE.FOLLOWUP, 0);
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
				
				max_energy = 125;
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
				
				toughs = ds_map_create();
				ds_map_add(toughs, ATTACK_TYPE.BASIC, 20);
				ds_map_add(toughs, ATTACK_TYPE.ALT, 0);
				ds_map_add(toughs, ATTACK_TYPE.SKILL, 0);
				ds_map_add(toughs, ATTACK_TYPE.SPECIAL, 0);
				ds_map_add(toughs, ATTACK_TYPE.ULTIMATE, 0);
				ds_map_add(toughs, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(toughs, ATTACK_TYPE.EXIT, 0);
				ds_map_add(toughs, ATTACK_TYPE.FOLLOWUP, 0);
				
				elmacc = ds_map_create();
				ds_map_add(elmacc, ATTACK_TYPE.BASIC, 1);
				ds_map_add(elmacc, ATTACK_TYPE.ALT, 0);
				ds_map_add(elmacc, ATTACK_TYPE.SKILL, 0);
				ds_map_add(elmacc, ATTACK_TYPE.SPECIAL, 0);
				ds_map_add(elmacc, ATTACK_TYPE.ULTIMATE, 0);
				ds_map_add(elmacc, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(elmacc, ATTACK_TYPE.EXIT, 0);
				ds_map_add(elmacc, ATTACK_TYPE.FOLLOWUP, 0);
			}
		} break;
		case 4:{
			_inst = instance_create_depth(-100,-100,999, oShipObject);
			with(_inst){
				
				name = "Veneno";
				role = ROLES.DEBUFFER;
				lvl = 1;

				// base stats
				b_atk = 30;
				b_hp = 100;
				b_def = 34;
				b_spd = 4;

				// Ammo
				reload_max = seconds(1.5);
				max_ammo = 15;
				
				// Cooldowns
				max_bcd = seconds(0.5);
				max_acd = seconds(1.5);
				max_scd = seconds(12);
				
				max_energy = 150;
				max_charge = 20;
				
				scales = ds_map_create();
				ds_map_add(scales, ATTACK_TYPE.BASIC, 0.1);
				ds_map_add(scales, ATTACK_TYPE.ALT, 0.1);
				ds_map_add(scales, ATTACK_TYPE.SKILL, 0.5);
				ds_map_add(scales, ATTACK_TYPE.SPECIAL, 0);
				ds_map_add(scales, ATTACK_TYPE.ULTIMATE, 0.2);
				ds_map_add(scales, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(scales, ATTACK_TYPE.EXIT, 0);
				ds_map_add(scales, ATTACK_TYPE.FOLLOWUP, 0);
				
				toughs = ds_map_create();
				ds_map_add(toughs, ATTACK_TYPE.BASIC, 20);
				ds_map_add(toughs, ATTACK_TYPE.ALT, 20);
				ds_map_add(toughs, ATTACK_TYPE.SKILL, 40);
				ds_map_add(toughs, ATTACK_TYPE.SPECIAL, 0);
				ds_map_add(toughs, ATTACK_TYPE.ULTIMATE, 20);
				ds_map_add(toughs, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(toughs, ATTACK_TYPE.EXIT, 0);
				ds_map_add(toughs, ATTACK_TYPE.FOLLOWUP, 0);
				
				elmacc = ds_map_create();
				ds_map_add(elmacc, ATTACK_TYPE.BASIC, 1);
				ds_map_add(elmacc, ATTACK_TYPE.ALT, 1);
				ds_map_add(elmacc, ATTACK_TYPE.SKILL, 2);
				ds_map_add(elmacc, ATTACK_TYPE.SPECIAL, 0);
				ds_map_add(elmacc, ATTACK_TYPE.ULTIMATE, 2);
				ds_map_add(elmacc, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(elmacc, ATTACK_TYPE.EXIT, 0);
				ds_map_add(elmacc, ATTACK_TYPE.FOLLOWUP, 0);
			}
		} break;
		case 5:{
			_inst = instance_create_depth(-100,-100,999, oShipObject);
			with(_inst){
				
				name = "Ligera";
				role = ROLES.DPS;
				lvl = 1;

				// base stats
				b_atk = 30;
				b_hp = 100;
				b_def = 34;
				b_spd = 4;

				// Ammo
				reload_max = seconds(0.5);
				max_ammo = 3;
				
				// Cooldowns
				max_bcd = seconds(0.1);
				max_acd = seconds(0.5);
				max_scd = seconds(15);
				
				max_energy = 100;
				max_charge = 10;
				
				scales = ds_map_create();
				ds_map_add(scales, ATTACK_TYPE.BASIC, 0.1);
				ds_map_add(scales, ATTACK_TYPE.ALT, 0.25);
				ds_map_add(scales, ATTACK_TYPE.SKILL, 0.2);
				ds_map_add(scales, ATTACK_TYPE.SPECIAL, 0.3);
				ds_map_add(scales, ATTACK_TYPE.ULTIMATE, 0.2);
				ds_map_add(scales, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(scales, ATTACK_TYPE.EXIT, 0);
				ds_map_add(scales, ATTACK_TYPE.FOLLOWUP, 0);
				
				toughs = ds_map_create();
				ds_map_add(toughs, ATTACK_TYPE.BASIC, 20);
				ds_map_add(toughs, ATTACK_TYPE.ALT, 40);
				ds_map_add(toughs, ATTACK_TYPE.SKILL, 10);
				ds_map_add(toughs, ATTACK_TYPE.SPECIAL, 10);
				ds_map_add(toughs, ATTACK_TYPE.ULTIMATE, 20);
				ds_map_add(toughs, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(toughs, ATTACK_TYPE.EXIT, 0);
				ds_map_add(toughs, ATTACK_TYPE.FOLLOWUP, 0);
				
				elmacc = ds_map_create();
				ds_map_add(elmacc, ATTACK_TYPE.BASIC, 1);
				ds_map_add(elmacc, ATTACK_TYPE.ALT, 1);
				ds_map_add(elmacc, ATTACK_TYPE.SKILL, 1);
				ds_map_add(elmacc, ATTACK_TYPE.SPECIAL, 1);
				ds_map_add(elmacc, ATTACK_TYPE.ULTIMATE, 1);
				ds_map_add(elmacc, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(elmacc, ATTACK_TYPE.EXIT, 0);
				ds_map_add(elmacc, ATTACK_TYPE.FOLLOWUP, 0);
			}
		} break;
		case 6:{
			_inst = instance_create_depth(-100,-100,999, oShipObject);
			with(_inst){
				
				name = "Acero";
				role = ROLES.SHIELDER;
				lvl = 1;

				// base stats
				b_atk = 30;
				b_hp = 100;
				b_def = 34;
				b_spd = 4;

				// Ammo
				reload_max = seconds(2);
				max_ammo = 5;
				
				// Cooldowns
				max_bcd = seconds(0.5);
				max_acd = seconds(2);
				max_scd = seconds(22);
				
				max_energy = 130;
				max_charge = 10;
				
				scales = ds_map_create();
				ds_map_add(scales, ATTACK_TYPE.BASIC, 0.1);
				ds_map_add(scales, ATTACK_TYPE.ALT, 0);
				ds_map_add(scales, ATTACK_TYPE.SKILL, 0);
				ds_map_add(scales, ATTACK_TYPE.SPECIAL, 0.3);
				ds_map_add(scales, ATTACK_TYPE.ULTIMATE, 0);
				ds_map_add(scales, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(scales, ATTACK_TYPE.EXIT, 0);
				ds_map_add(scales, ATTACK_TYPE.FOLLOWUP, 0);
				
				toughs = ds_map_create();
				ds_map_add(toughs, ATTACK_TYPE.BASIC, 20);
				ds_map_add(toughs, ATTACK_TYPE.ALT, 0);
				ds_map_add(toughs, ATTACK_TYPE.SKILL, 0);
				ds_map_add(toughs, ATTACK_TYPE.SPECIAL, 40);
				ds_map_add(toughs, ATTACK_TYPE.ULTIMATE, 0);
				ds_map_add(toughs, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(toughs, ATTACK_TYPE.EXIT, 0);
				ds_map_add(toughs, ATTACK_TYPE.FOLLOWUP, 0);
				
				elmacc = ds_map_create();
				ds_map_add(elmacc, ATTACK_TYPE.BASIC, 1);
				ds_map_add(elmacc, ATTACK_TYPE.ALT, 0);
				ds_map_add(elmacc, ATTACK_TYPE.SKILL, 0);
				ds_map_add(elmacc, ATTACK_TYPE.SPECIAL, 0);
				ds_map_add(elmacc, ATTACK_TYPE.ULTIMATE, 0);
				ds_map_add(elmacc, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(elmacc, ATTACK_TYPE.EXIT, 0);
				ds_map_add(elmacc, ATTACK_TYPE.FOLLOWUP, 0);
			}
		} break;
		case 7:{
			_inst = instance_create_depth(-100,-100,999, oShipObject);
			with(_inst){
				
				name = "Cuantico";
				role = ROLES.BUFFER;
				lvl = 1;

				// base stats
				b_atk = 30;
				b_hp = 100;
				b_def = 34;
				b_spd = 4;

				// Ammo
				reload_max = seconds(2);
				max_ammo = 30;
				
				// Cooldowns
				max_bcd = seconds(0.2);
				max_acd = seconds(0.3);
				max_scd = seconds(5);
				
				max_energy = 200;
				max_charge = 3;
				
				scales = ds_map_create();
				ds_map_add(scales, ATTACK_TYPE.BASIC, 0.1);
				ds_map_add(scales, ATTACK_TYPE.ALT, 0.1);
				ds_map_add(scales, ATTACK_TYPE.SKILL, 0.1);
				ds_map_add(scales, ATTACK_TYPE.SPECIAL, 0);
				ds_map_add(scales, ATTACK_TYPE.ULTIMATE, 0.05);
				ds_map_add(scales, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(scales, ATTACK_TYPE.EXIT, 0);
				ds_map_add(scales, ATTACK_TYPE.FOLLOWUP, 0);
				
				toughs = ds_map_create();
				ds_map_add(toughs, ATTACK_TYPE.BASIC, 20);
				ds_map_add(toughs, ATTACK_TYPE.ALT, 30);
				ds_map_add(toughs, ATTACK_TYPE.SKILL, 60);
				ds_map_add(toughs, ATTACK_TYPE.SPECIAL, 0);
				ds_map_add(toughs, ATTACK_TYPE.ULTIMATE, 20);
				ds_map_add(toughs, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(toughs, ATTACK_TYPE.EXIT, 0);
				ds_map_add(toughs, ATTACK_TYPE.FOLLOWUP, 0);
				
				elmacc = ds_map_create();
				ds_map_add(elmacc, ATTACK_TYPE.BASIC, 1);
				ds_map_add(elmacc, ATTACK_TYPE.ALT, 1);
				ds_map_add(elmacc, ATTACK_TYPE.SKILL, 2);
				ds_map_add(elmacc, ATTACK_TYPE.SPECIAL, 0);
				ds_map_add(elmacc, ATTACK_TYPE.ULTIMATE, 1);
				ds_map_add(elmacc, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(elmacc, ATTACK_TYPE.EXIT, 0);
				ds_map_add(elmacc, ATTACK_TYPE.FOLLOWUP, 0);
			}
		} break;
		case 8:{
			_inst = instance_create_depth(-100,-100,999, oShipObject);
			with(_inst){
				
				name = "Frost";
				role = ROLES.DPS;
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
				max_acd = seconds(0.4);
				max_scd = seconds(10);
				
				max_energy = 300;
				max_charge = 20;
				
				scales = ds_map_create();
				ds_map_add(scales, ATTACK_TYPE.BASIC, 0.1);
				ds_map_add(scales, ATTACK_TYPE.ALT, 0.1);
				ds_map_add(scales, ATTACK_TYPE.SKILL, 0.25);
				ds_map_add(scales, ATTACK_TYPE.SPECIAL, 0);
				ds_map_add(scales, ATTACK_TYPE.ULTIMATE, 1);
				ds_map_add(scales, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(scales, ATTACK_TYPE.EXIT, 0);
				ds_map_add(scales, ATTACK_TYPE.FOLLOWUP, 0);
				
				toughs = ds_map_create();
				ds_map_add(toughs, ATTACK_TYPE.BASIC, 10);
				ds_map_add(toughs, ATTACK_TYPE.ALT, 20);
				ds_map_add(toughs, ATTACK_TYPE.SKILL, 20);
				ds_map_add(toughs, ATTACK_TYPE.SPECIAL, 0);
				ds_map_add(toughs, ATTACK_TYPE.ULTIMATE, 100);
				ds_map_add(toughs, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(toughs, ATTACK_TYPE.EXIT, 0);
				ds_map_add(toughs, ATTACK_TYPE.FOLLOWUP, 0);
				
				elmacc = ds_map_create();
				ds_map_add(elmacc, ATTACK_TYPE.BASIC, 1);
				ds_map_add(elmacc, ATTACK_TYPE.ALT, 1);
				ds_map_add(elmacc, ATTACK_TYPE.SKILL, 1);
				ds_map_add(elmacc, ATTACK_TYPE.SPECIAL, 0);
				ds_map_add(elmacc, ATTACK_TYPE.ULTIMATE, 5);
				ds_map_add(elmacc, ATTACK_TYPE.ENTRANCE, 0);
				ds_map_add(elmacc, ATTACK_TYPE.EXIT, 0);
				ds_map_add(elmacc, ATTACK_TYPE.FOLLOWUP, 0);
			}
		} break;
	}
	
	return _inst;
}

function GetAdditionalBuffs(_ship, _mastery, _boost){
	switch(_ship.shipId){
		case 1:
			
			if (_mastery[0]) ApplyStat(_ship, "MASTERY 1", STAT.ALTDMG, 0.25, 1, 1,,true,_ship,false);
			if (_mastery[1]) ApplyStat(_ship, "MASTERY 2", STAT.ULTIMATEDMG, 0.25, 1, 1,,true,_ship,false);
			
			if (_boost[0]) ApplyStat(_ship, "BOOST 1", STAT.ATK, 0.20, 1, 1,,true,_ship,false);
			if (_boost[1]) ApplyStat(_ship, "BOOST 2", STAT.ENERGYREGEN, 0.15, 1, 1,,true,_ship,false);
			
		break;
		
		case 2:
			
			if (_mastery[0]) ApplyStat(_ship, "MASTERY 1", STAT.ALTDMG, 0.25, 1, 1,,true,_ship,false);
			if (_mastery[1]) ApplyStat(_ship, "MASTERY 2", STAT.SKILLDMG, 0.25, 1, 1,,true,_ship,false);
			
			if (_boost[0]) ApplyStat(_ship, "BOOST 1", STAT.ATK, 0.20, 1, 1,,true,_ship,false);
			if (_boost[1]) ApplyStat(_ship, "BOOST 2", STAT.CRITDMG, 0.18, 1, 1,,true,_ship,false);
			
		break;
		
		case 3:
			
			if (_mastery[0]) ApplyStat(_ship, "MASTERY 1", STAT.BASICATTACKDMG, 0.25, 1, 1,,true,_ship,false);
			if (_mastery[1]) ApplyStat(_ship, "MASTERY 2", STAT.HEALINGBONUS, 0.25, 1, 1,,true,_ship,false);
			
			if (_boost[0]) ApplyStat(_ship, "BOOST 1", STAT.HP, 0.20, 1, 1,,true,_ship,false);
			if (_boost[1]) ApplyStat(_ship, "BOOST 2", STAT.HEALINGBONUS, 0.15, 1, 1,,true,_ship,false);
			
		break;
		case 4:
			
			if (_mastery[0]) ApplyStat(_ship, "MASTERY 1", STAT.ALTDMG, 0.25, 1, 1,,true,_ship,false);
			if (_mastery[1]) ApplyStat(_ship, "MASTERY 2", STAT.ULTIMATEDMG, 0.25, 1, 1,,true,_ship,false);
			
			if (_boost[0]) ApplyStat(_ship, "BOOST 1", STAT.ATK, 0.20, 1, 1,,true,_ship,false);
			if (_boost[1]) ApplyStat(_ship, "BOOST 2", STAT.VENOMDMG, 0.25, 1, 1,,true,_ship,false);
			
		break;
		case 5:
			
			if (_mastery[0]) ApplyStat(_ship, "MASTERY 1", STAT.BASICATTACKDMG, 0.25, 1, 1,,true,_ship,false);
			if (_mastery[1]) ApplyStat(_ship, "MASTERY 2", STAT.SKILLDMG, 0.25, 1, 1,,true,_ship,false);
			
			if (_boost[0]) ApplyStat(_ship, "BOOST 1", STAT.ATK, 0.20, 1, 1,,true,_ship,false);
			if (_boost[1]) ApplyStat(_ship, "BOOST 2", STAT.CRITDMG, 0.18, 1, 1,,true,_ship,false);
			
		break;
		case 6:
			
			if (_mastery[0]) ApplyStat(_ship, "MASTERY 1", STAT.BASICATTACKDMG, 0.25, 1, 1,,true,_ship,false);
			if (_mastery[1]) ApplyStat(_ship, "MASTERY 2", STAT.BASICATTACKDMG, 0.25, 1, 1,,true,_ship,false);
			
			if (_boost[0]) ApplyStat(_ship, "BOOST 1", STAT.DEF, 0.20, 1, 1,,true,_ship,false);
			if (_boost[1]) ApplyStat(_ship, "BOOST 2", STAT.RES, 0.10, 1, 1,,true,_ship,false);
			
		break;
		case 7:
			
			if (_mastery[0]) ApplyStat(_ship, "MASTERY 1", STAT.ALTDMG, 0.25, 1, 1,,true,_ship,false);
			if (_mastery[1]) ApplyStat(_ship, "MASTERY 2", STAT.ULTIMATEDMG, 0.25, 1, 1,,true,_ship,false);
			
			if (_boost[0]) ApplyStat(_ship, "BOOST 1", STAT.ATK, 0.20, 1, 1,,true,_ship,false);
			if (_boost[1]) ApplyStat(_ship, "BOOST 2", STAT.BREAKDMG, 0.30, 1, 1,,true,_ship,false);
			
		break;
		case 8:
			
			if (_mastery[0]) ApplyStat(_ship, "MASTERY 1", STAT.BASICATTACKDMG, 0.25, 1, 1,,true,_ship,false);
			if (_mastery[1]) ApplyStat(_ship, "MASTERY 2", STAT.ULTIMATEDMG, 0.25, 1, 1,,true,_ship,false);
			
			if (_boost[0]) ApplyStat(_ship, "BOOST 1", STAT.ATK, 0.20, 1, 1,,true,_ship,false);
			if (_boost[1]) ApplyStat(_ship, "BOOST 2", STAT.CRIT, 0.09, 1, 1,,true,_ship,false);
			
		break;
	}
}
