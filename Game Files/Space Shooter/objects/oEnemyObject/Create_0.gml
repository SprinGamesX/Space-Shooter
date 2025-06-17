/// @description

// Inherit GameObject
event_inherited();

spin = 0;
customMovement = false;
image_xscale = 0;
image_yscale = 0;
scale = 0;
isEntering = true;
ind_index = 1;
ghost = false;
show_trail = false;
part_trail = noone;

// Stats
b_atk = 0;
b_hp = 0;
b_def = 0;
b_spd = 0;
element = ELEMENT.NONE;
hits = 1;

// An enemy can have up to 3 weaknesses
weaknesses = [0,0,0];

// Toughness
toughness = 0;
max_toughness = 0;
broken_time = 0;
stopped = false;
stoptime = -1;
slowed = false;
slowtime = -1;

kill_out_of_bounds = true;

// Elemental Charge
// Each index represents the elemental charge of a corrisponding element aka 0 - Ice, 1 - Fire etc
elemental_status = [0,0,0,0,0,0,0,0];
max_elmstat = 50;
shock_immune = 0;
awaiting_destruction = false;
countered = false;

onDeath = function(_attacker){
	oGameManager.onTeamKill(_attacker);
	awaiting_destruction = true;
}

onHit = function(_damage, _attacker){
	hp -= _damage;
	
	if (hp <= 0){
		onDeath(_attacker);
	}
	
	// effect
	
}

onToughnessReduction = function(_amount, _ship){
	if (toughness > 0 and HasWeakness(_ship.element)){
		toughness -= _amount * (1 + _ship.getStatBonus(STAT.BREAKEFF));
		if (toughness <= 0) {
			toughness = 0;
			broken_time = seconds(5);
			_ship.onBreak(self);
		}
	}
}

onElementalHit = function(_amount, _ship){
	
}

onEntrance = function(){
	
	
	if (scale < 1) scale += 0.1;
	image_xscale = scale;
	image_yscale = scale;
	if (scale >= 1) isEntering = false;
	
}

onShipHit = function(_enemy){
	
	if (_enemy.reactive){
		if (_enemy.element == ELEMENT.LIFE or _enemy.element == ELEMENT.QUANTUM or _enemy.element == ELEMENT.LIGHTNING or _enemy.element == ELEMENT.VENOM) _enemy.onDodge(self);
		else _enemy.onReflect(self);
	}
	else {
		var _basedmg = (getATK());
	
		var _dmgbonus = 1 + GetDamageBonus(element, ATTACK_TYPE.EXIT);
	
		var _res = (1 - _enemy.getStatBonus(STAT.RES) + getStatBonus(STAT.RESPEN));
	
		var _def = (1 - ((_enemy.b_def * (1 + _enemy.getStatBonus(STAT.DEF)) * (1 + getStatBonus(STAT.DEFPEN)))/5000));
	
		var _crit = RollChance(getStatBonus(STAT.CRIT));
	
	
		// 1 - Lvl multiplier
		var _damage = _basedmg * _dmgbonus * _res * _def * (1 + (_crit ? getStatBonus(STAT.CRITDMG) : 0)) * (1 - ((_enemy.lvl - lvl) * 0.01));

		//show_debug_message(string(_damage));
	
		CreateDamageIndicator(_enemy.x + random_range(0, 48) * (ind_index), _enemy.y - random_range(16, 64), string(round(_damage)) + (_crit ? "!" : ""), ELEMENT.NONE);
		ind_index *= -1;
		_enemy.onHitTaken(self, _damage);
		
		hits--;
		if (hits <= 0) instance_destroy();
	}
}

onCustomMovement = function(){
	
}

part_hit = part_type_create();
part_type_sprite(part_hit, sPixel, 0,0,0);
part_type_size(part_hit, 2, 3, 0, 0);
part_type_life(part_hit, seconds(1), seconds(1.5));
part_type_speed(part_hit, 0.5, 1.2, -0.003, 0);
part_type_orientation(part_hit, 0, 359, 0, 0, 0);
part_type_alpha3(part_hit, 1, 0.7, 0);
