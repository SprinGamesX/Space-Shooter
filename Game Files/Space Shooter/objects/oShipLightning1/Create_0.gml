/// @description

// Inherit the parent event
event_inherited();
InitiateShip(shipId);

element = ELEMENT.LIGHTNING;


// Ship Specifics

onBasicAttack = function(){
	
	var _bounces = 2;
	
	if (passives[0]) _bounces += 1;
	
	CreateBouncingProjectile(sLightningCharge, self, x, y, 10, direction, ATTACK_TYPE.BASIC,,_bounces,,,,,true);
	ammo--;
}

onAltAttack = function(){
	
	CreateHomingProjectile(sLightningCharge, self, x, y, 12, direction, ATTACK_TYPE.ALT,,,2);
	ammo--;
	
}


onSkill = function(){
	if (charge >= max_charge/2) onSpecialSkill();
	else {
		for (var i = 0; i < 360; i += 45){
			CreateLinearProjectile(sLightningCharge, self, mouse_x + lengthdir_x(-128, i), mouse_y + lengthdir_y(-128, i), 10, i, ATTACK_TYPE.SKILL,,3);
		}
	}
}

onSpecialSkill = function(){
	for (var i = 0; i < 360; i += 15){
			CreateLinearProjectile(sLightningCharge, self, mouse_x + lengthdir_x(-128, i), mouse_y + lengthdir_y(-128, i), 10, i, ATTACK_TYPE.SKILL,,3);
	}
	charge -= max_charge/2;
	
	if (passives[1]) ApplyStat(self, "High Voltage - Type 1", STAT.LIGHTNINGDMG, 0.1, seconds(20), 1, 2,,,true);
}

onUltimate = function(){
	if (charge >= max_charge/2){
		for (var i = 0; i < 360; i += 10){
			CreateJumpingProjectile(sLightningCharge, self, x, y, 20, i, ATTACK_TYPE.ULTIMATE,, 4,,6, 5);
		}
		charge -= max_charge/2;
		
		if (passives[1]) ApplyStat(self, "High Voltage - Type 1", STAT.LIGHTNINGDMG, 0.1, seconds(20), 1, 2,,,true);
	}
	else {
		for (var i = 0; i < 360; i += 10){
			CreateLinearProjectile(sLightningCharge, self, x, y, 10, i, ATTACK_TYPE.ULTIMATE);
		}
	}
	energy = 0;
}

onPostHitExtra = function(_enemy, _atk_type,  _dmg_type, _damage){
	if (_atk_type == ATTACK_TYPE.BASIC or _atk_type == ATTACK_TYPE.ALT){
		charge++;
	}
}

onBattleStart = function(){
	if (passives[2])
		max_scd = seconds(10);
}