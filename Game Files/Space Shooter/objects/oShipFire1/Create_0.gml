/// @description

// Inherit the parent event
event_inherited();
InitiateShip(shipId);

element = ELEMENT.FIRE;


// Ship Specifics
count = 0;

onBasicAttack = function(){
	CreateLinearProjectile(sFireball, self, x, y, 10, direction + random_range(-5, 5), ATTACK_TYPE.BASIC);
	ammo--;
}

onAltAttack = function(){
	if (charge == 10){
		onSpecialSkill();
		charge = 0;
	}
	else if (charge > 0){
		CreateLinearProjectile(sBigFireball, self, x, y, 10, direction, ATTACK_TYPE.ALT,,,1.5);
		charge--;
	}
}


onSkill = function(){
	if (ammo > 30){
		ammo -= 30;
		charge += 5;
	}
}

onSpecialSkill = function(){
	CreateLinearProjectile(sBigFireball, self, x, y, 10, direction, ATTACK_TYPE.SPECIAL,,,2);
	CreateLinearProjectile(sBigFireball, self, x, y, 10, direction - 5, ATTACK_TYPE.SPECIAL,,,2);
	CreateLinearProjectile(sBigFireball, self, x, y, 10, direction + 5, ATTACK_TYPE.SPECIAL,,,2);
}

onUltimate = function(){
	ApplyStat(self, "Fired Up", STAT.ASPD, 1, seconds(10), 1);
	charge = 10;
	ammo = max_ammo;
	energy = 0;
}

onPostHit = function(_enemy, _atk_type, _dmg_type, _damage){
	// After it is done call onAllyPostHit for allies
	
	var _shock = CheckForStat(_enemy, STAT.LIGHTNINGRES, "Shocked");
	if (_shock != noone){
		_shock.provider.onShock(_enemy);
	}
	
	count++;
	if (count >= 5){
		count = 0;
		charge++;
	}
	oGameManager.onTeamPostHit(_enemy, _atk_type, self, _damage);
}
