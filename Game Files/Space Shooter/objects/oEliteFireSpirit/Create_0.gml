/// @description Insert description here
// You can write your code in this editor
event_inherited();

part_spirit = oParticleManager.get_particle(PARTICLE.FIRE_SPIRIT);


attack_cd1 = CreateCooldown(seconds(10), true,,);
attack_cd2 = CreateCooldown(seconds(30), true,,);
attack_cd3 = CreateCooldown(seconds(15), true,,);
attack_cd4 = CreateCooldown(seconds(60), true,,);
attack_cd5 = CreateCooldown(seconds(12), true,, 0);

move_mode = 0;
move_to = [x, y];
mode1_resting = true;
mode1_attacking = true;
mode1_count = 0;

mode2_acc = 0.05;
mode2_cd = 0;
mode2_max_cd = seconds(0.2);

mode2_time = 0;

spin_spd = 3;



movement = function(){
	// this function should contain all movement patterns of the boss
	switch(move_mode){
		case 0:
			spin_spd = smooth_number_to(spin_spd, 3, 0.05);
			direction += spin_spd;
			move_ease_to(self, room_width/5 * 4, room_height/2, getSPD());
		
		break;
		
		case 1:
		
			isAttacking = true;
			move_ease_to(self, move_to[0], move_to[1], getSPD(), 5);
			if (!mode1_attacking and x == move_to[0] and y == move_to[1]){
				mode1_resting = true;
			}
			if (mode1_resting){
				mode1_resting = false;
				mode1_attacking = true;
				for (var i = 0; i < 360; i += 15)
					SummonEnemyLiner(x, y, getATK(), getHP()/100, getDEF(), 15, i, element,,,,sFireSpiritSmall);
				sprite_index = sFireSpiritExplode;
				image_index = 0;
			}
			if (mode1_attacking and image_index == 7){
				sprite_index = sEliteFireSpirit;
				image_index = 0;
				mode1_attacking = false;
				mode1_count--;
				if (mode1_count == 0){
					isAttacking = false;
					move_mode = 0;
					RemoveStatByName(self, STAT.SPD, "Attack 3 - Speed Boost");
				}
				else {
					move_to = [irandom_range(room_width/4, room_width/4 * 3), irandom_range(room_height/4, room_height/4 * 3)];
				}
			}
			
			if (weakness_broken){
				isAttacking = false;
				move_mode = 0;
				RemoveStatByName(self, STAT.SPD, "Attack 3 - Speed Boost");
			}
			
			break;
			
			case 2:
				isAttacking = true;
				sprite_index = sFireSpiritExplode;
				image_speed = spin_spd div 3;
				
				spin_spd += mode2_acc;
				direction += spin_spd;
				
				if (spin_spd > 10){
					if (mode2_cd >= 0){
						mode2_cd = mode2_max_cd;
						SummonEnemyLiner(x, y, getATK(), getHP()/50, getDEF(), spin_spd, direction, element,,,,sFireSpiritSmall, spin_spd,,true);
						SummonEnemyLiner(x, y, getATK(), getHP()/50, getDEF(), spin_spd, direction-180, element,,,,sFireSpiritSmall, spin_spd,,true);
						
						ApplyStat(self, "Attack 4 - Volcanic Eruption", STAT.ATK, 0.1, seconds(0.3), 1, 100,,,false);
					}
				}
				
				mode2_time--;
				if (mode2_time <= 0 or weakness_broken){
					image_index = 0;
					sprite_index = sEliteFireSpirit;
					move_mode = 0;
					isAttacking = false;
					image_speed = 1;
				}
				
			
			break;
	}
	
	
	// Particles
	
	var _part_num = 20;
	
	if (move_mode == 2){
		_part_num += spin_spd;
	}
	
	for (var i = 0; i < _part_num; i++){
		var _rad = sprite_get_width(sprite_index) * 1.5;
		var _angle = irandom(360);
	
		var _effective_rad = irandom(_rad);
	
		part_particles_create(global.battlePartSystemOverlay, x + lengthdir_x(_effective_rad, _angle), y + lengthdir_y(_effective_rad, _angle), part_spirit, 1);
	}
}

cooldowns = function(){
	if (attack_cd1.execute(1)){
		var attack1 = CreateAttack(attackQueue, seconds(0.5), 3);
			
		with (attack1){	
			attack = function(){
			with(SummonCustomEnemy(oEnemySmallFireSpirit, attacker.x, attacker.y, attacker.getATK(), attacker.getHP()/100, 0, 20, attacker.element,,attacker,,,10)){
				var _r = 128;
				var _d = irandom(360);
				target_x = x + lengthdir_x(_r, _d);
				target_y = y + lengthdir_y(_r, _d);
				}
			}
		}
	}
	if (attack_cd2.execute(1)){
		var attack1 = CreateAttack(attackQueue, seconds(0.5), 9,, room_height/2 - 4 * 72);
			
		with (attack1){	
			attack = function(){
			SummonCustomEnemy(oEnemySmallFireSpirit, room_width - 32, var1, attacker.getATK(), attacker.getHP()/100, 0, 20, attacker.element,,attacker,,,10);
			var1 += 72;
			}
		}
	}
	if (attack_cd3.execute(1)){
		var attack1 = CreateAttack(attackQueue, 0, 1);
			
		with (attack1){	
			attack = function(){
				attacker.move_mode = 1;
				attacker.mode1_count = 3;
				attacker.move_to = [irandom_range(room_width/4, room_width/4 * 3), irandom_range(room_height/4, room_height/4 * 3)];
				ApplyStat(attacker, "Attack 3 - Speed Boost", STAT.SPD, 1, 1, 1,,true,attacker,false);
			}
		}
	}
	if (attack_cd4.execute(1)){
		var attack1 = CreateAttack(attackQueue, 0, 1);
			
		with (attack1){	
			attack = function(){
				attacker.move_mode = 2;
				attacker.mode2_time = seconds(5);
			}
		}
	}
	if (attack_cd5.execute(1)){
		var attack1 = CreateAttack(attackQueue, seconds(0.1), 5,,,,,,0);
			
		with (attack1){	
			attack = function(){
				with(SummonCustomEnemy(oEnemyFireExplosiveSpirit, attacker.x, attacker.y, attacker.getATK(), attacker.getHP()/100, 0, 12, attacker.element,,attacker,,,10)){
					var _r = 196;
					var _d = irandom(360);
					target_x = x + lengthdir_x(_r, _d);
					target_y = y + lengthdir_y(_r, _d);
					direction = irandom_range(170, 190);
					fuse_time = irandom_range(seconds(0.5), seconds(1.2));
				}
			}
		}
	}
}