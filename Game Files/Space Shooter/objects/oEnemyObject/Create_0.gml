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
max_toughtness = 0;
broken_time = 0;
stopped = false;

// Elemental Charge
// Each index represents the elemental charge of a corrisponding element aka 0 - Ice, 1 - Fire etc
elemental_status = [0,0,0,0,0,0,0];

onDeath = function(_attacker){
	oGameManager.onTeamKill(_attacker);
	instance_destroy();
}

onHit = function(_damage, _attacker){
	hp -= _damage;
	
	if (hp <= 0){
		onDeath(_attacker);
	}
}

onToughnessReduction = function(_amount, _ship){
	if (toughness > 0 and HasWeakness(_ship.element)){
		toughness -= _amount;
		if (toughness <= 0) {
			toughness = 0;
			broken_time = seconds(5);
			_ship.onBreak(self);
		}
	}
}

onEntrance = function(){
	
	
	if (scale < 1) scale += 0.1;
	image_xscale = scale;
	image_yscale = scale;
	if (scale >= 1) isEntering = false;
	
}

onShipHit = function(_enemy){
		// Enemies deal 10% of ATK if they are normal enemies and 100% of atk if they are elite
		var _basedmg = (getATK()) * (object_index == oEnemyElite ? 1 : 0.1);
	
		var _dmgbonus = 1 + GetDamageBonus(element, ATTACK_TYPE.EXIT);
	
		var _res = (1 - _enemy.getStatBonus(STAT.RES) + getStatBonus(STAT.RESPEN));
	
		var _def = (1 - ((_enemy.b_def * (1 + _enemy.getStatBonus(STAT.DEF)) * (1 + getStatBonus(STAT.DEFPEN)))/5000));
	
		var _crit = RollChance(getStatBonus(STAT.CRIT));
	
	
		// 1 - Lvl multiplier
		var _damage = _basedmg * _dmgbonus * _res * _def * (1 + (_crit ? getStatBonus(STAT.CRITDMG) : 0)) * (1 - ((_enemy.lvl - lvl) * 0.01));

		show_debug_message(string(_damage));
	
		CreateDamageIndicator(_enemy.x + random_range(0, 48) * (ind_index), _enemy.y - random_range(16, 64), string(round(_damage)) + (_crit ? "!" : ""), ELEMENT.NONE);
		ind_index *= -1;
		_enemy.onHitTaken(self, _damage);
		
		hits--;
		if (hits <= 0) instance_destroy();
}