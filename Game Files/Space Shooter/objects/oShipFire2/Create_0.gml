/// @description

// Inherit the parent event
event_inherited();
InitiateShip(shipId);

element = ELEMENT.FIRE;


// Ultimate Particle
part_ult = part_type_create();
part_type_sprite(part_ult, sPixel, 0, 0, 0);
part_type_life(part_ult, seconds(7), seconds(7));
part_type_alpha3(part_ult, 0.8, 0.9, 1);
part_type_speed(part_ult, 15, 20, 0, 0);
part_type_direction(part_ult, 0, 360, 0, 0);
part_type_orientation(part_ult, 0, 360, 0, 0, 0);
part_type_color3(part_ult, make_colour_rgb(255, 123, 0), make_colour_rgb(255, 75, 20), make_colour_rgb(215, 63, 17));


// Ship Specifics
skill_shots = 20;

onBasicAttack = function(){
	CreateLinearProjectile(sFireArrow, self, x, y, 12, direction, ATTACK_TYPE.BASIC,,,2);
	ammo--;
}

onAltAttack = function(){
	for (var i = -30; i <= 30; i += 15)
		CreateLinearProjectile(sFireball, self, x, y, 8, direction + i + irandom_range(-5,5), ATTACK_TYPE.ALT);
	
	ammo -= 5;
}


onSkill = function(){
	skill_shots = 20;
	alarm[0] = 1;
}

onSpecialSkill = function(){
	ApplyTeamStat("Hielo's Icy Support", STAT.ATK, 0.2, seconds(15), 1,,,,true);
	for (var i = 0; i < 360; i += 10){
		CreateLinearProjectile(sIceShard1, self, x, y, 5, i, ATTACK_TYPE.SPECIAL);
	}
	charge = 0;
}

onUltimate = function(){
	var _enemies = ds_list_create();
	var _count = collision_rectangle_list(0, 0, room_width, room_height, oEnemyObject, 0, 1, _enemies, false);
	
	for (var i = 0; i < _count; i++){
		if (instance_exists(_enemies[|i])){
			with(_enemies[|i]){
				// 1 is the index for FIRE
			}
		}
	}
	
	part_particles_create(global.battlePartSystem, x, y, part_ult, 1500);
	
	energy = 0;
}

onBattleStart = function(){
	if (passives[0]){
		
		var _team = oGameManager.getTeam();
		var _count = 0;
		
		for (var i = 0; i < _team; i++){
			if (_team[i].element == ELEMENT.FIRE) _count++;
		}
		
		ApplyTeamStat("Pheonix's Will", STAT.FIREDMG, 0.15 * _count, 1, 1,,true);
	}
	energy = max_energy
}

onExitSkill = function(_next){
	
}


