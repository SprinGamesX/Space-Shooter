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
	CreateLinearProjectile(sBigFireball, self, x, y, 10, direction, ATTACK_TYPE.SPECIAL,ATTACK_TYPE.ALT,,2);
	CreateLinearProjectile(sBigFireball, self, x, y, 10, direction - 5, ATTACK_TYPE.SPECIAL,ATTACK_TYPE.ALT,,2);
	CreateLinearProjectile(sBigFireball, self, x, y, 10, direction + 5, ATTACK_TYPE.SPECIAL,ATTACK_TYPE.ALT,,2);
}

onUltimate = function(){
	ApplyStat(self, "Fired Up", STAT.ASPD, 1, seconds(10), 1);
	charge = 10;
	ammo = max_ammo;
	energy = 0;
}

onPostHitExtra = function(_enemy, _atk_type, _dmg_type, _damage){
	count++;
	if (count >= 5){
		count = 0;
		charge++;
	}
	
	if (passives[0] and _dmg_type == ATTACK_TYPE.ALT){
		ApplyStat(self, "Heating Up", STAT.ATK, 0.05, seconds(5), 1, 3,,,true);
	}
}

onBattleStart = function(){
	if (passives[1])
		ApplyStat(self, "Battle Hungry", STAT.ATK, 0.4, seconds(30), 1);
}

onEnemyKilled = function(_killer){
	if(passives[2])
		ApplyStat(self, "Blood Lust - Fuego", STAT.CRIT, 0.15, seconds(5), 1,,,,true);
}