/// @description

// Inherit the parent event
event_inherited();
InitiateShip(shipId);

element = ELEMENT.QUANTUM;


// Ship Specifics

onBasicAttack = function(){
	CreateLinearProjectile(sQuantumBall, self, x, y, 10, direction, ATTACK_TYPE.BASIC);
	ammo--;
}

onAltAttack = function(){
	CreateLaser(0, 0, true, 0, 5000, ATTACK_TYPE.ALT, 1, seconds(0.3), sQuantumLaser);
	ammo -= 2;
}


onSkill = function(){
	for (var i = -90; i <= 90; i+= 90){
		CreateHomingProjectile(sQuantumBall, self, x, y, 20, direction + i, ATTACK_TYPE.SKILL,,5,,15);
	}
}

onSpecialSkill = function(){

}

onUltimate = function(){
	for (var i = 0; i < 360; i += 20){
		CreateStormProjectile(sQuantumBall, self, x, y, 3, direction, 3, i, 128 + irandom(4), ATTACK_TYPE.ULTIMATE,, 10);
		CreateStormProjectile(sQuantumBall, self, x, y, 3, direction, 5, i, 96 + irandom(4), ATTACK_TYPE.ULTIMATE,, 10);
	}
	energy = 0;
}

onEnemyBreak = function(_enemy, _breaker){
	charge++;
	if (charge >= max_charge){
		ApplyTeamStat("Quantumania", STAT.BREAKDMG, 0.1, 1, 1, 10, true,,true, "Quantumania");
	}
}


