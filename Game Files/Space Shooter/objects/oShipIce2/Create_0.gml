/// @description

// Inherit the parent event
event_inherited();
InitiateShip(shipId);

if (passives[2]){
	ds_map_set(scales, ATTACK_TYPE.ULTIMATE, 7.5);
}

element = ELEMENT.ICE;


// Ship Specifics
ult_pulses = 3;
charge_cd = 0;
offensize_mode = true;

echo_skill_id = CreateProjEcho();
echo_ult_id = CreateProjEcho();

onBasicAttack = function(){
	var _dist = 16;
	CreateLinearProjectile(sIceShard2, self, x + lengthdir_x(_dist, direction-90), y + lengthdir_y(_dist, direction-90), 10, direction, ATTACK_TYPE.BASIC,,3);
	CreateLinearProjectile(sIceShard2, self, x + lengthdir_x(_dist, direction+90), y + lengthdir_y(_dist, direction+90), 10, direction, ATTACK_TYPE.BASIC,,3);
	ammo--;
}

onAltAttack = function(){
	CreateBouncingProjectile(sIceShurikens, self, x, y, 30, direction, ATTACK_TYPE.ALT,,3,,10,,5);
	ammo--;
}


onSkill = function(){
	var _count = 3;
	if (passives[0]) _count += 2;
	
	for (var i = 0; i < _count; i++)
		CreateHomingProjectile(sIceShurikens, self, x, y, 20, irandom_range(90, 270), ATTACK_TYPE.SKILL,,3,,10,true,5,,echo_skill_id);
}

onSpecialSkill = function(){
	
}

onUltimate = function(){
	CreateLinearProjectile(sIceShard2, self, x, y, 30, direction, ATTACK_TYPE.ULTIMATE,,3, 3,,,echo_ult_id);
	energy = 0;
}

onBattleStart = function(){

}

onPreHitExtra = function(_enemy, _atk_type,  _dmg_type){
	if (_atk_type == ATTACK_TYPE.ULTIMATE and charge > 0){
		ApplyStat(self, "Charge Bonus - Frost", STAT.ICEDMG, 0.1 * charge, 1, 1);
		alarm[0] = seconds(0.5);
	}
}

onHitExtra = function(_enemy, _atk_type,  _dmg_type){
	
	
	if (charge_cd <= 0){
		charge++;
		charge_cd = seconds(1);
		if (passives[1])
			ApplyStat(self, "ATK PASSIVE - Frost", STAT.ATK, 0.02, 1, 1, max_charge,1);
		
	}
}

onAllyHit = function(_enemy, _atk_type, _ally){
	if (_ally.element == ELEMENT.ICE and charge_cd <= 0){
		charge++;
		charge_cd = seconds(1);
		if (passives[1]) 
			ApplyStat(self, "ATK PASSIVE - Frost", STAT.ATK, 0.02, 1, 1, max_charge,1);
	}
}

onExtraStep = function(){
	if (charge_cd > 0)
		charge_cd--;
}