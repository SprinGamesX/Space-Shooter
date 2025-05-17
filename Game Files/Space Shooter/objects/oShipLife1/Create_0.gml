/// @description

// Inherit the parent event
event_inherited();
InitiateShip(shipId);

element = ELEMENT.LIFE;


// Ship Specifics

onBasicAttack = function(){
	CreateLinearProjectile(sLifeball, self, x, y, 10, direction, ATTACK_TYPE.BASIC);
	ammo--;
	var _hp_consumed = ConsumeHp(getHP()/100);
	if (passives[2]){
		RestoreTeamHp(_hp_consumed,,true);
	}
}

onAltAttack = function(){
	if (ammo > 4){
		RestoreTeamHp(getHP() * ds_map_find_value(scales, ATTACK_TYPE.ALT));
		ammo -= 5;
		charge++;
	}
	else a_cd = 0;
}


onSkill = function(){
	
	if (passives[1]){
		ApplyTeamStat("Guarding Nature", STAT.RES, 0.15, seconds(10), 1,,,,true);
	}
	
	if (charge == max_charge){
		onSpecialSkill();
	}
	else RestoreHp(getHP() * ds_map_find_value(scales, ATTACK_TYPE.SKILL));
}

onSpecialSkill = function(){
	RestoreTeamHp(getHP() * ds_map_find_value(scales, ATTACK_TYPE.SPECIAL));
	charge = 0;
}

onUltimate = function(){
	RestoreTeamHp(getHP() * ds_map_find_value(scales, ATTACK_TYPE.ULTIMATE));
	energy = 0;
	if (passives[0])
		GenerateEnergy(20);
}

onExitSkill = function(_next){
	ApplyStat(_next, "Vida's Blessing", STAT.HP, 0.15, seconds(10), 1);
	RestoreHp(getHP() * 0.1,,_next);
}


