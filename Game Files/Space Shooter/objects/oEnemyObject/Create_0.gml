/// @description

// Inherit GameObject
event_inherited();

spin = 0;
customMovement = false;
image_xscale = 0;
image_yscale = 0;
scale = 0;
isEntering = true;

// Stats
b_atk = 0;
b_hp = 0;
b_def = 0;
b_spd = 0;
element = ELEMENT.NONE;

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
