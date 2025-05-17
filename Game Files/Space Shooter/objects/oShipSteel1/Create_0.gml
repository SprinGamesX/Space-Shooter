/// @description

// Inherit the parent event
event_inherited();
InitiateShip(shipId);

element = ELEMENT.STEEL;

shield_res_multiplier = 1;


onBasicAttack = function(){
	if (charge > 0){
		CreateLinearProjectile(sSteelShuriken, self, x, y, 10, direction, ATTACK_TYPE.SPECIAL,ATTACK_TYPE.BASIC,,1,3);
		if (passives[0]) ApplyStat(self, "Will of Iron", STAT.DEF, 0.2, seconds(5), 1,,,,true);
		charge--;
	}
	else {
		CreateLinearProjectile(sSteelShuriken, self, x, y, 10, direction, ATTACK_TYPE.BASIC,,,2,3);
	}
	ammo--;
}

onAltAttack = function(){
	ProvideShield(getDEF() * 0.2 * shield_res_multiplier);
	charge+=1;
	ammo -= 5;
}


onSkill = function(){
	ProvideTeamShield(getDEF() * 0.35 * shield_res_multiplier);
	if (passives[1]) ApplyTeamStat("Will of Steel - Acero", STAT.DEF, 0.4, seconds(15), 1,,,,true);
	charge+= 3;
}

onSpecialSkill = function(){
	
}

onUltimate = function(){
	ProvideTeamShield(getDEF() * 0.5 * shield_res_multiplier);
	energy = 0;
	charge = max_charge;
}

onBattleStart = function(){
	if (passives[2]) shield_res_multiplier += getStatBonus(STAT.RES);
}
