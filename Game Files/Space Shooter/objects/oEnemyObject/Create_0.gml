/// @description

// Inherit GameObject
event_inherited();

// Toughness
toughness = 0;
max_toughtness = 0;
broken_time = 0;

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
	if (toughness > 0){
		toughness -= _amount;
		if (toughness <= 0) {
			toughness = 0;
			broken_time = seconds(5);
			_ship.onBreak(self);
		}
	}
}
