/// @description

// Inherit the parent event
event_inherited();
InitiateShip(shipId);

element = ELEMENT.LIGHTNING;


// Ship Specifics

onBasicAttack = function(){
	CreateBouncingProjectile(sLightningCharge, self, x, y, 10, direction, ATTACK_TYPE.BASIC,2,,,,,true);
	ammo--;
}

onAltAttack = function(){
	
	CreateHomingProjectile(sLightningCharge, self, x, y, 12, direction, ATTACK_TYPE.ALT,,2);
	ammo--;
	
}


onSkill = function(){
	if (charge >= max_charge/2) onSpecialSkill();
	else {
		for (var i = 0; i < 360; i += 45){
			CreateLinearProjectile(sLightningCharge, self, mouse_x + lengthdir_x(-128, i), mouse_y + lengthdir_y(-128, i), 10, i, ATTACK_TYPE.SKILL, 3,,,true);
		}
	}
}

onSpecialSkill = function(){
	for (var i = 0; i < 360; i += 15){
			CreateLinearProjectile(sLightningCharge, self, mouse_x + lengthdir_x(-128, i), mouse_y + lengthdir_y(-128, i), 10, i, ATTACK_TYPE.SKILL, 3,,,true);
	}
	charge -= max_charge/2;
}

onUltimate = function(){
	if (charge >= max_charge/2){
		for (var i = 0; i < 360; i += 10){
			CreateJumpingProjectile(sLightningCharge, self, x, y, 20, i, ATTACK_TYPE.ULTIMATE, 4,,6, 5);
		}
		charge -= max_charge/2;
	}
	else {
		for (var i = 0; i < 360; i += 10){
			CreateLinearProjectile(sLightningCharge, self, x, y, 10, i, ATTACK_TYPE.ULTIMATE);
		}
	}
	energy = 0;
}

onPostHit = function(_enemy, _atk_type, _damage){
	// After it is done call onAllyPostHit for allies
	if (_atk_type == ATTACK_TYPE.BASIC or _atk_type == ATTACK_TYPE.ALT){
		charge++;
	}
	if (_atk_type != ATTACK_TYPE.ULTIMATE){
		GenerateEnergy(1);
	}
}
