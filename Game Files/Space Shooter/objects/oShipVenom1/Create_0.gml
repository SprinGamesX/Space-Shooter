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
	
	if (passives[1]){
		ApplyTeamStat("Veneno - Venomous Elixer 1", STAT.ATK, 0.1, seconds(20), 1,,,,,"Venomous Elixer");
		ApplyTeamStat("Veneno - Venomous Elixer 2", STAT.VENOMDMG, 0.1, seconds(20), 1);
	}
}

onPreHitExtra = function(_enemy, _atk_type,  _dmg_type){
	if (charge > 0){
		
		if (_atk_type == ATTACK_TYPE.ULTIMATE){
			ApplyStat(_enemy, "Snake bitten",STAT.DEF, -0.05, seconds(10), 1,5,,,true,,true);
			if (passives[2]){
				ApplyStat(_enemy, "Snake bitten - Poison",STAT.DOT, 0.3, seconds(2), 1,10,,,true,,true);
			}
		}
		else {
			ApplyStat(_enemy, "Venomus bite",STAT.RES, -0.05, seconds(10), 1,5,,,true,,true);
			charge--;
		}
	}
}

onBattleStart = function(){
	if (passives[0]){
		ApplyTeamStat("Deep Infections", STAT.DOTDMG, 0.5, 1, 1,,true);
	}
}