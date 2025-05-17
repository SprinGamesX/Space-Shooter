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

reactive = false;
react_time = 0;
react_cooldown = 0;

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

// Particles
laser_particle = undefined;
trail_particle = undefined;

// Get Passives



scales = ds_map_create();
toughs = ds_map_create();
elmacc = ds_map_create();

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


ds_map_add(elmacc, ATTACK_TYPE.BASIC, 0);
ds_map_add(elmacc, ATTACK_TYPE.ALT, 0);
ds_map_add(elmacc, ATTACK_TYPE.SKILL, 0);
ds_map_add(elmacc, ATTACK_TYPE.SPECIAL, 0);
ds_map_add(elmacc, ATTACK_TYPE.ULTIMATE, 0);
ds_map_add(elmacc, ATTACK_TYPE.ENTRANCE, 0);
ds_map_add(elmacc, ATTACK_TYPE.EXIT, 0);
ds_map_add(elmacc, ATTACK_TYPE.FOLLOWUP, 0);




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
	
	onPreHitExtra(_enemy, _atk_type,  _dmg_type);
	
	_enemy.onToughnessReduction(ds_map_find_value(toughs, _atk_type), self);
	_enemy.onElementalHit(ds_map_find_value(elmacc, _atk_type), self);
	
	oGameManager.onTeamPreHit(_enemy, _atk_type, self);
	onHit(_enemy, _atk_type,  _dmg_type);
}

onHit = function(_enemy, _atk_type, _dmg_type){
	if (instance_exists(_enemy)){
		
		onHitExtra(_enemy, _atk_type,  _dmg_type)
		
		var _basedmg = (getATK()) * ds_map_find_value(scales,_atk_type);
	
		var _dmgbonus = 1 + GetDamageBonus(element, _dmg_type);
	
		var _res = (1 - _enemy.getStatBonus(STAT.RES) - GetCorrispondingRes(element, _enemy) + getStatBonus(STAT.RESPEN));
	
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
	
	onPostHitExtra(_enemy, _atk_type,  _dmg_type, _damage);
	
	var _shock = CheckForStat(_enemy, STAT.LIGHTNINGRES, "Shocked");
	if (_shock != noone){
		_shock.provider.onShock(_enemy);
	}
	
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
	ScreenShake(0.3, 1.2, 0.1);
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
	
	var _res = (1 - _enemy.getStatBonus(STAT.RES) - GetCorrispondingRes(element, _enemy) + getStatBonus(STAT.RESPEN));
	
	var _def = (1 - ((_enemy.b_def * (1 + _enemy.getStatBonus(STAT.DEF)) * (1 + getStatBonus(STAT.DEFPEN)))/5000));
		
	// 1 - Lvl multiplier
	var _damage = _basedmg * _res * _def * (1 - ((_enemy.lvl - lvl) * 0.01));
	
	CreateDamageIndicator(_enemy.x + random_range(0, 48), _enemy.y - random_range(-64, -16), string(round(_damage)) + "-BREAK!", element, !object_is_ancestor(_enemy.object_index, oEnemyElite) ? 0.5 : 1);
	_enemy.onHit(_damage, self);
}

onEnemyBreak = function(_enemy, _breaker){
	
}

onBattleBegan = function(){
	// Only for technical setup
	trail_particle = CreateProjTrail(element);
	laser_particle = CreateLaserParticles(element);
}

onBattleStart = function(){
	
}

onReact = function(){
	reactive = true;
	react_time = 7;
	react_cooldown = seconds(0.5);
}

onDodge = function(_enemy){
	invisible = true;
	invis_cd = seconds(1);
	reactive = false;
	ApplyStat(self, "Dodged", STAT.SPD, 0.2, invis_cd, 1);
	
	GenerateEnergy(10);
	
	// Effects
	SlowAllEnemies(seconds(1));
	ScreenShake(0.05, 0.5, 0.01);
}

onReflect = function(_enemy){
	invisible = true;
	invis_cd = seconds(0.5);
	_enemy.countered = true;
	if (!object_is_ancestor(_enemy.object_index, oEnemyElite)){
		_enemy.direction -= 180;
		reactive = false;
	}
	
	GenerateEnergy(10);
	
	// Effects
	SlowAllEnemies(seconds(0.1));
	ScreenShake(1, 1, 0.1);
	part_particles_create(global.battlePartSystem, (x + _enemy.x)/2, (y + _enemy.y)/2, part_shockwave, 3);
}

onIceReaction = function(_enemy){
	
}

onFireReaction = function(_enemy){
	
}

onLifeReaction = function(_enemy){
	
}

onVenomReaction = function(_enemy){
	
}

onLightningReaction = function(_enemy){
	
}

onSteelReaction = function(_enemy){
	
}

onQuantumReaction = function(_enemy){
	
}

onShock = function(_enemy){
	
	
	
	// Base Radius is 256 pixels
	
	var _list = ds_list_create();
	var _nearby = collision_circle_list(_enemy.x, _enemy.y, 256 * (1 + getStatBonus(STAT.ES)), oEnemyObject, 0, 0, _list, false);
	
	for (var i = 0; i < _nearby; i++){
		if (_list[|i].id != _enemy.id and _list[|i].shock_immune <= 0){
			AdditionalDamage(_list[|i], self, 0.1, ATTACK_TYPE.SHOCK);
			
			var _dist = point_distance(_enemy.x, _enemy.y, _list[|i].x, _list[|i].y);
			var _dir = point_direction(_enemy.x, _enemy.y, _list[|i].x, _list[|i].y);
			var _divider = _dist/10;
			while(_dist >= 0 and _divider != 0){
				part_particles_create(global.battlePartSystem, _enemy.x + lengthdir_x(_dist + random_range(-32, 32), _dir), _enemy.y + lengthdir_y(_dist + random_range(-32, 32), _dir), shock_particle, 3);
				_dist -= _divider;
			}
			
		}
	}
	ds_list_destroy(_list);
	
	
}

onPreHitExtra = function(_enemy, _atk_type,  _dmg_type){
	
}

onHitExtra = function(_enemy, _atk_type,  _dmg_type){

}

onPostHitExtra = function(_enemy, _atk_type,  _dmg_type, _damage){
	
}

onExtraStep = function(){
	
}

onExtraStepActive = function(){
	
}

part_invis = part_type_create();

shock_particle = part_type_create();
part_type_sprite(shock_particle, sPixel, 0, 0, 0);
part_type_color2(shock_particle, #e8e873,ColorForElement(ELEMENT.LIGHTNING));
part_type_life(shock_particle, seconds(0.3), seconds(0.5));
part_type_alpha3(shock_particle, 1, 0.7, 0);
part_type_orientation(shock_particle, 0, 359, 0.2, false, true);
part_type_size(shock_particle, 1.5, 1.75, -0.005, 0.5);

part_shockwave = part_type_create();
part_type_sprite(part_shockwave,sShockwaveParticle,0,0,0);
part_type_life(part_shockwave, seconds(0.5), seconds(0.5));
part_type_alpha2(part_shockwave, 0.9, 0);
part_type_size(part_shockwave, 0, 0.8, 0.8, 0);
