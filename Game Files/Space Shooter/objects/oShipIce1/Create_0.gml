/// @description

// Inherit the parent event
event_inherited();
InitiateShip(shipId);

element = ELEMENT.ICE;


// Ship Specifics
ult_pulses = 3;

onBasicAttack = function(){
	CreateLinearProjectile(sIceShard1, self, x, y, 10, direction, ATTACK_TYPE.BASIC);
	ammo--;
}

onAltAttack = function(){
	CreateLaser(0, 0, true, 0, 5000, ATTACK_TYPE.ALT, 1, seconds(0.2), sIceLaser,,,true);
	ammo -= 2;
}


onSkill = function(){
	if (charge == max_charge){
		onSpecialSkill();
	}
	else {
		for (var i = 0; i < 360; i += 20){
			CreateLinearProjectile(sIceShard1, self, x, y, 5, i, ATTACK_TYPE.SKILL);
		}
		if (charge < max_charge) charge++;
	}
}

onSpecialSkill = function(){
	ApplyTeamStat("Hielo's Icy Support", STAT.ATK, 0.2, seconds(15), 1,,,,true);
	for (var i = 0; i < 360; i += 10){
		CreateLinearProjectile(sIceShard1, self, x, y, 5, i, ATTACK_TYPE.SPECIAL);
	}
	if (passives[0]) CreateFollower(oTestFollower, self, 0, -48, seconds(0.5), seconds(2)+1, true);
	charge = 0;
}

onUltimate = function(){
	for (var i = 0; i < 360; i += 10){
		CreateLinearProjectile(sIceShard1, self, x, y, 10, i, ATTACK_TYPE.ULTIMATE);
	}
	ult_pulses = 3;
	alarm[0] = seconds(0.5);
	energy = 0;
}

