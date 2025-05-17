/// @description
event_inherited();

// Movement Stuff

image_speed = 0;

move_cd = CreateCooldown(seconds(3), true, seconds(1));
step_cd = CreateCooldown(seconds(0.25), true);
step_limit = 4;

move_border_x = room_width - 400;
move_border_y = 64;

move_x = x;
move_y = y;
look_to = 180;

shoot_direction = 0;

// Attacks
attack_cd1 = CreateCooldown(seconds(5), true, seconds(1));
attack_cd2 = CreateCooldown(seconds(15), true, seconds(5));
attack_cd3 = CreateCooldown(seconds(10), true, seconds(3));

summon_cd1 = CreateCooldown(seconds(2), true, seconds(2));
summon_cd2 = CreateCooldown(seconds(20), true, seconds(2), 1);




onAttackFinish = function(){
	isAttacking = false;
}

movement = function(){
	if (move_cd.execute(1)){
		move_x = irandom_range(move_border_x, room_width - 64);
		move_y = irandom_range(move_border_y, room_height - move_border_y);
		
	}
	else if (step_cd.execute(1)){
		move_x += irandom_range(-step_limit, step_limit);
		move_y += irandom_range(-step_limit, step_limit);
		var _ship = oGameManager.getActive();
		look_to = point_direction(x, y, _ship.x, _ship.y);
	}
	
	move_ease_to(self, move_x, move_y, 100, 20);
	direction = SmoothRotCorrection(self, look_to, direction);
	shoot_direction = direction;
}

cooldowns = function(){
	if (attack_cd1.execute(1)){
		var attack1 = CreateAttack(attackQueue, seconds(0.2), 4,,0);
			
			with (attack1){
				onAttackBegin = function(){
					attacker.sprite_index = sLifeBowShoot;
					attacker.image_index = 0;
				}
				
				attack = function(){
					var1++;
					
					
					if (var1 == 4){
						attacker.sprite_index = sLifeBowIdle;
						attacker.image_index = 0;
						
						SummonEnemyLiner(attacker.x, attacker.y, attacker.getATK(), attacker.getHP()/20, 100, 30, attacker.shoot_direction, attacker.element,,attacker,,sLifeArrow);
					}
					else attacker.image_index = var1;
				}
				
			}
	}
	if (attack_cd2.execute(1)){
		var _attack_count = 10;
		var attack2 = CreateAttack(attackQueue, seconds(0.05), 4 * _attack_count,,0, 10);
			
			with (attack2){
				onAttackBegin = function(){
					attacker.sprite_index = sLifeBowShoot;
					attacker.image_index = 0;
				}
				
				attack = function(){
					var1++;
					
					
					if (var1 == 4){
						attacker.image_index = 0;
						var _miss = 10;
						SummonEnemyLiner(attacker.x, attacker.y, attacker.getATK() * 0.1, attacker.getHP()/20, 100, 20, attacker.shoot_direction + random_range(-_miss, _miss), attacker.element,,attacker,,sLifeArrow);
						var1 = 0;
						var2--;
						if (var2 <= 0){
							attacker.sprite_index = sLifeBowIdle;
						}
					}
					else attacker.image_index = var1;
				}
				
			}
	}
	
	if (attack_cd3.execute(1)){
		var attack1 = CreateAttack(attackQueue, seconds(0.5), 4,,0);
			
			with (attack1){
				onAttackBegin = function(){
					attacker.sprite_index = sLifeBowShoot;
					attacker.image_index = 0;
				}
				
				attack = function(){
					var1++;
					
					
					if (var1 == 4){
						attacker.sprite_index = sLifeBowIdle;
						attacker.image_index = 0;
						
						for (var i = -45; i <= 45; i += 5)
							SummonEnemyLiner(attacker.x, attacker.y, attacker.getATK(), attacker.getHP()/20, 100, 40, attacker.shoot_direction + i, attacker.element,,attacker,,sLifeArrow);
					}
					else attacker.image_index = var1;
				}
				
			}
	}
	
	if (summon_cd1.execute(1)){
		var attack1 = CreateAttack(attackQueue, 1, 1);
			
			with (attack1){
				
				attack = function(){
					var _summon_range_x = 24;
					var _summon_range_y = 128;
					var _summon_y = min(max(attacker.y + irandom_range(-_summon_range_y, _summon_range_y), 64), room_height - 64);
					SummonCustomEnemy(oEnemyLifebowGhost, attacker.x + irandom_range(-_summon_range_x, _summon_range_x), _summon_y, attacker.getATK(), attacker.getHP()/20, 0, 0, attacker.element,,attacker,,,,true);
				}
				
			}
	}
	if (summon_cd2.execute(1)){
		var attack1 = CreateAttack(attackQueue, seconds(0.25), 5,,128);
			
			with (attack1){
				
				attack = function(){
					var _summon_x = room_width - 64;
					SummonCustomEnemy(oEnemyLifebowGhostAimed, _summon_x, var1, attacker.getATK(), attacker.getHP()/20, 0, 0, attacker.element,,attacker,,,,true);
					SummonCustomEnemy(oEnemyLifebowGhostAimed, _summon_x, room_height - var1, attacker.getATK(), attacker.getHP()/20, 0, 0, attacker.element,,attacker,,,,true);
					var1 += 64;
				}
				
			}
	}
}

onWeaknessBreak = function(){
	weakness_broken = true;
}

onWeaknessRecover = function(){
	
	attack_cd = max_attack_cd;
	toughness = max_toughness;
	weakness_broken = false;
}

onEntery = function(){
	entered = true;
}