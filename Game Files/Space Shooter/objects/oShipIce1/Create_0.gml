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
	CreateLinearProjectile(sIceShard1, self, x, y, 15, direction+5, ATTACK_TYPE.ALT,,2);
	CreateLinearProjectile(sIceShard1, self, x, y, 15, direction, ATTACK_TYPE.ALT,,2);
	CreateLinearProjectile(sIceShard1, self, x, y, 15, direction-5, ATTACK_TYPE.ALT,,2);
	
	ammo -= 3;
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

onBattleStart = function(){
	if (passives[0]){
		ApplyTeamStat("Heilo's Ice Spirit", STAT.ICEDMG, 0.1, 1, 1,,true);
	}
}

onExitSkill = function(_next){
	if (passives[1] and charge == max_charge){
		ApplyStat(_next, "Heilo's Frosted Support", STAT.ICEDMG, 0.5, seconds(10), 1,,,,true);
		charge = 0;
	}
}

onPreHitExtra = function(_enemy, _atk_type,  _dmg_type){
	if (passives[2] and (_atk_type == ATTACK_TYPE.SKILL or _atk_type == ATTACK_TYPE.ULTIMATE))
		ApplyStat(_enemy, "Heilo's Frostbite", STAT.ICERES, -0.1, seconds(15), 1,,,,true,,true);
}
