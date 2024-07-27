/// @description

// Inherit the parent event
event_inherited();
InitiateShip(shipId);

element = ELEMENT.VENOM;


// Ship Specifics
alarm[0] = seconds(2);
charge = 10;
ult_remain = 30;
energy = max_energy;

onBasicAttack = function(){
	CreateLinearProjectile(sVenomGoo, self, x, y, 10, direction, ATTACK_TYPE.BASIC);
	ammo--;
}

onAltAttack = function(){
	for (var i = -10; i <= 10; i += 5){
		CreateLinearProjectile(sVenomGoo, self, x, y, 12, direction+i+random_range(-2, 2), ATTACK_TYPE.ALT);
	}
	ammo -= 5;
}


onSkill = function(){
	CreateLaser(0, 0, true,-4, 2000, ATTACK_TYPE.SKILL, 2, seconds(0.5), sVenomLaser);
	CreateLaser(0, 0, true,4, 2000, ATTACK_TYPE.SKILL, 2, seconds(0.5), sVenomLaser);
	CreateLaser(0, 0, true,-2, 2000, ATTACK_TYPE.SKILL, 2, seconds(0.5), sVenomLaser);
	CreateLaser(0, 0, true,2, 2000, ATTACK_TYPE.SKILL, 2, seconds(0.5), sVenomLaser);
	CreateLaser(0, 0, true,0, 2000, ATTACK_TYPE.SKILL, 2, seconds(0.5), sVenomLaser);
}

onSpecialSkill = function(){
	
}

onUltimate = function(){
	ult_remain = 30;
	alarm[1] = seconds(0.05);
	energy = 0;
}

onPreHit = function(_enemy, _atk_type, _dmg_type){
	if (charge > 0){
		
		if (_atk_type == ATTACK_TYPE.ULTIMATE){
			ApplyStat(_enemy, "Snake bitten",STAT.DEF, -0.05, seconds(10), 1,5,,,true);
		}
		else {
			ApplyStat(_enemy, "Venomus bite",STAT.RES, -0.05, seconds(10), 1,,,,true);
			if(passives[0]) ApplyStat(self, "Poison fuel", STAT.VENOMDMG, 1, 1, 1);
			charge--;
		}
	}
	
	oGameManager.onTeamPreHit(_enemy, _atk_type, self);
	onHit(_enemy, _atk_type, _dmg_type);
}

