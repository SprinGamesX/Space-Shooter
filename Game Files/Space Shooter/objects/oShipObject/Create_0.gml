/// @description

// Inherit GameObject 
event_inherited();

// Movement
// if not active the ship will not be able to move or activate abilities but will still have cooldowns
active = false; 
x_spd = 0;
y_spd = 0;
fric = 0.2;
ind_index = 1;
hp = 0;
shield = 0;
invisible = false;
invis_cd = 0;

// Abilities

ammo = 0;
max_ammo = 0;

b_cd = 0; // Basic attack CD
max_bcd = 0;
a_cd = 0; // Alt attack CD
max_acd = 0;
s_cd = 0; // Skill CD
max_scd = 0;

// Reload
reload_time = -1;
reload_max = 0;

// Ultimate
energy = 0;
max_energy = 0;

// Special Skill
charge = 0;
max_charge = 0;

// Get Passives



scales = ds_map_create();
toughs = ds_map_create();

ds_map_add(scales, ATTACK_TYPE.BASIC, 0);
ds_map_add(scales, ATTACK_TYPE.ALT, 0);
ds_map_add(scales, ATTACK_TYPE.SKILL, 0);
ds_map_add(scales, ATTACK_TYPE.SPECIAL, 0);
ds_map_add(scales, ATTACK_TYPE.ULTIMATE, 0);
ds_map_add(scales, ATTACK_TYPE.ENTRANCE, 0);
ds_map_add(scales, ATTACK_TYPE.EXIT, 0);
ds_map_add(scales, ATTACK_TYPE.FOLLOWUP, 0);
ds_map_add(toughs, ATTACK_TYPE.BASIC, 0);
ds_map_add(toughs, ATTACK_TYPE.ALT, 0);
ds_map_add(toughs, ATTACK_TYPE.SKILL, 0);
ds_map_add(toughs, ATTACK_TYPE.SPECIAL, 0);
ds_map_add(toughs, ATTACK_TYPE.ULTIMATE, 0);
ds_map_add(toughs, ATTACK_TYPE.ENTRANCE, 0);
ds_map_add(toughs, ATTACK_TYPE.EXIT, 0);
ds_map_add(toughs, ATTACK_TYPE.FOLLOWUP, 0);



// Executable Skills
onBasicAttack = function(){
	
}

onAltAttack = function(){
	
}

onSkill = function(){
	
}

onUltimate = function(){
	
}

onSpecialSkill = function(){
	
}

onEntranceSkill = function(){
	
}

onExitSkill = function(_next){
	
}

onFollowup = function(){
	
}

// onHits
onPreHit = function(_enemy, _atk_type,  _dmg_type){
	// After it is done call onHit and onAllyPreHit for allies
	_enemy.onToughnessReduction(ds_map_find_value(toughs, _atk_type), self);
	
	oGameManager.onTeamPreHit(_enemy, _atk_type, self);
	onHit(_enemy, _atk_type,  _dmg_type);
}

onHit = function(_enemy, _atk_type, _dmg_type){
	if (instance_exists(_enemy)){
		var _basedmg = (getATK()) * ds_map_find_value(scales,_atk_type);
	
		var _dmgbonus = 1 + GetDamageBonus(element, _dmg_type);
	
		var _res = (1 - _enemy.getStatBonus(STAT.RES) + getStatBonus(STAT.RESPEN));
	
		var _def = (1 - ((_enemy.b_def * (1 + _enemy.getStatBonus(STAT.DEF)) * (1 + getStatBonus(STAT.DEFPEN)))/5000));
	
		var _crit = RollChance(getStatBonus(STAT.CRIT));
	
	
		// 1 - Lvl multiplier
		var _damage = _basedmg * _dmgbonus * _res * _def * (1 + (_crit ? getStatBonus(STAT.CRITDMG) : 0)) *(_enemy.toughness == 0 ? 1.15 : 1) * (1 - ((_enemy.lvl - lvl) * 0.01));

		show_debug_message(string(_damage));
	
		CreateDamageIndicator(_enemy.x + random_range(0, 48) * (ind_index), _enemy.y - random_range(16, 64), string(round(_damage)) + (_crit ? "!" : ""), element, !object_is_ancestor(_enemy.object_index, oEnemyElite) ? 0.5 : 1);
		ind_index *= -1;
		_enemy.onHit(_damage, self);
		oGameManager.onTeamHit(_enemy, _atk_type, self);
		onPostHit(_enemy, _atk_type,  _dmg_type, _damage);
	}
}

onPostHit = function(_enemy, _atk_type, _dmg_type, _damage){
	// After it is done call onAllyPostHit for allies
	if (_atk_type != ATTACK_TYPE.ULTIMATE){
		GenerateEnergy(1);
	}
	oGameManager.onTeamPostHit(_enemy, _atk_type, self, _damage);
}

// allies
onAllyPreHit = function(_enemy, _atk_type, _ally){
	
}

onAllyHit = function(_enemy, _atk_type, _ally){
	
}

onAllyPostHit = function(_enemy, _atk_type, _ally, _damage){
	GenerateEnergy(0.25);
}

// Sustain
onHitTaken = function(_enemy, _damage){
	
	if (shield > 0){
		var _shield = shield;
		if (shield > _damage) {
			shield -= _damage;
			_damage = 0;
		}
		else {
			_damage -= _shield;
			shield = 0;
		}
	}
	
	
	hp -= _damage;
	
	GenerateEnergy(0.5);
}

onAllyHitTaken = function(_enemy, _ally){
	
}

onHpReduction = function(_amount){
	
}

onHpRestoration = function(_amount){
	
}

onShieldGain = function(_amount){
	
}

onShieldHit = function(_amount){
	
}

// Additions
onEnemyKilled = function(_killer){
	
}

onEnergyGained = function(_amount){
	
}

onBreak = function(_enemy){
	
	oGameManager.onTeamBreak(_enemy, self);
	
	// Base dmg for break is 5% of the enemies HP 
	var _basedmg = (1 + getStatBonus(STAT.BREAKDMG)) * (_enemy.getHP() * 0.05);
	
	var _res = (1 - _enemy.getStatBonus(STAT.RES) + getStatBonus(STAT.RESPEN));
	
	var _def = (1 - ((_enemy.b_def * (1 + _enemy.getStatBonus(STAT.DEF)) * (1 + getStatBonus(STAT.DEFPEN)))/5000));
		
	// 1 - Lvl multiplier
	var _damage = _basedmg * _res * _def * (1 - ((_enemy.lvl - lvl) * 0.01));
	
	CreateDamageIndicator(_enemy.x + random_range(0, 48), _enemy.y - random_range(-64, -16), string(round(_damage)) + "-BREAK!", element, !object_is_ancestor(_enemy.object_index, oEnemyElite) ? 0.5 : 1);
	_enemy.onHit(_damage, self);
}

onEnemyBreak = function(_enemy, _breaker){
	
}

onBattleBegan = function(){
	
}



