/// @description

// Inherit the parent event
event_inherited();
InitiateShip(shipId);

element = ELEMENT.STEEL;


// Ship Specifics
ult_pulses = 3;

onBasicAttack = function(){
	CreateLinearProjectile(sSteelShuriken, self, x, y, 10, direction, ATTACK_TYPE.BASIC,,,2,3);
	ammo--;
}

onAltAttack = function(){
	ProvideShield(getDEF() * 0.2);
	ammo -= 5;
}


onSkill = function(){
	ProvideTeamShield(getDEF() * 0.35);
}

onSpecialSkill = function(){
	ProvideTeamShield(getDEF());
}

onUltimate = function(){
	ProvideTeamShield(getDEF() * 0.5);
	if (passives[0]) ApplyTeamStat("Defensive Steel", STAT.DEF, 0.3, seconds(20), 1);
	energy = 0;
}

// Add on hit taken which gives charge and gives shield once charge is full

onExitSkill = function(_next){
	if (passives[1]) ProvideShield(getDEF() * 0.35,,_next);
}

onEntranceSkill = function(){
	if (passives[2]){
		ProvideShield(getDEF() * 0.2);
		ApplyStat(self, "Bulked up", STAT.ATK, (getDEF() div 100) * 0.01, seconds(10), 1,,,,true, "Bulked up");
	}
}

