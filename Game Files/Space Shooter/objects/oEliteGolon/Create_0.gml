/// @description

// Inherit the parent event
event_inherited();



enum GSTATE{
	REST,
	ATTACK,
	CHARGE,
	CHARGE_PREPARE,
	ENTERING,
	BITE
}

state = GSTATE.REST;
jaw = noone;
jaw_dir = 0;
jaw_max_dir = 5;
mov_time = 0;

eye_flash = false;
eye_frame = 0;

head_dir = 0;

base_x = 0;

track_speed = 1;

body = array_create(10);

// Cooldowns
cd_a1 = CreateCooldown(seconds(4), true);

onAttackFinish = function(){
	isAttacking = false;
	state = GSTATE.REST
}

movement = function(){
	// this function should contain all movement patterns of the boss
	
	if (state == GSTATE.REST){
		
		var target = oGameManager.getActive();
		if (instance_exists(target) and InRange(base_x, base_x-16,base_x+16)){
			y -= track_speed * (sign(y - target.y));
			if (InRange(y, target.y - track_speed, target.y + track_speed)) y = target.y;
		}
		
		if (base_x != x){
			var _x = base_x;
			var correction = 2;
	
			var error_x = abs(x - _x) / 10;
			if (x > _x) x -= correction * sqrt(error_x);
			if (x < _x) x += correction * sqrt(error_x);
		}

		mov_time++;
		
		jaw_dir = sin(mov_time/60) * jaw_max_dir + 5;
		
		jaw.direction = SmoothRotCorrection(jaw, jaw_dir, jaw.direction);
		
		//jaw.direction = jaw_dir;
		
		head_dir = SmoothRotCorrection(self, 0, head_dir);
	}
	
	
	if (state == GSTATE.ATTACK){
		head_dir = SmoothRotCorrection(self, -15, head_dir);
		
		//if (jaw.direction < 25) jaw.direction += 0.5;
		jaw.direction = SmoothRotCorrection(self, 25, jaw.direction);
	}
	
	if (state == GSTATE.CHARGE_PREPARE){
		SmoothMovCorrection(self, room_width - 64, y,,true);
		head_dir = SmoothRotCorrection(self, -25, head_dir);
		jaw.direction = SmoothRotCorrection(self, 35, jaw.direction);
	}
	
	if (state == GSTATE.CHARGE){
		SmoothMovCorrection(self, room_width/4, y,,true, 10);
		head_dir = SmoothRotCorrection(self, 0, head_dir);
		jaw.direction = SmoothRotCorrection(self, 0, jaw.direction);
	}


	image_angle = head_dir;
}

cooldowns = function(){
	
	if (cd_a1.execute(1)){
		state = GSTATE.ATTACK;
		
		
		var rand = irandom(4);
		
		switch(rand){
			
			case 0:{
				ScreenShake(1, 0.5, 0.02);
				var attack1 = CreateAttack(attackQueue, seconds(0.01), 25,,,,,,seconds(0.2));
				with (attack1){
					attack = function(){
						SummonEnemyLiner(attacker.x - 64, attacker.y - 32, attacker.getATK(), attacker.getHP() * 0.2, 100, 15, 180 + random_range(-5, 5), attacker.element,,attacker,true,,true);
					}		
				}
			}break;
			
			case 1:{
				ScreenShake(0.5, 0.5, 0.02);
				var attack1 = CreateAttack(attackQueue, seconds(0.1), 5,,,,,,seconds(0.2));
				with (attack1){
					attack = function(){
						SummonEnemyLiner(attacker.x - 64, attacker.y - 32, attacker.getATK(), attacker.getHP() * 0.4, 100, 9, 180 + 5 + random_range(-1,1), attacker.element,,attacker,false,,true);
						SummonEnemyLiner(attacker.x - 64, attacker.y - 32, attacker.getATK(), attacker.getHP() * 0.4, 100, 9, 180 + random_range(-1,1), attacker.element,,attacker,false,,true);
						SummonEnemyLiner(attacker.x - 64, attacker.y - 32, attacker.getATK(), attacker.getHP() * 0.4, 100, 9, 180 -5 + random_range(-1,1), attacker.element,,attacker,false,,true);
					}		
				}
			}break;
			
			case 2:{
				var attack1 = CreateAttack(attackQueue, seconds(1), 2,self,false,,,,seconds(0.5));
				with (attack1){
					
					onAttackBegin = function(){
						attacker.state = GSTATE.CHARGE_PREPARE;
					}
					
					attack = function(){
						if (!var1){
							attacker.state = GSTATE.CHARGE;
							var1 = true;
							ScreenShake(0.1, 1, 0.25);
						}
							
					}		
				}
			}break;
			
			case 3:{
				var attack1 = CreateAttack(attackQueue, seconds(0.2), 10,self,,,,,seconds(0.2));
				with (attack1){
					
					onAttackBegin = function(){
						attacker.eye_flash = true;
					}
					
					attack = function(){
						for (var i = 0; i < 4; i++){
							var target = oGameManager.getActive();
							var _x = random_range(room_width, room_width - 64);
							var _y = choose(random_range(room_height - 64, room_height + 64), random_range(-64, 64));
							SummonEnemyLiner(_x, _y, attacker.getATK(), attacker.getHP() * 0.1, 100, 12, point_direction(_x, _y, target.x, target.y), attacker.element,,attacker,true,,5);
						}
					}		
				}
			}break;
			
			case 4:{
				ScreenShake(3, 0.75, 0.025);
				var attack1 = CreateAttack(attackQueue, seconds(0.01), 80,,,,,,seconds(0.2));
				with (attack1){
					attack = function(){
						SummonEnemyLiner(attacker.x - 64, attacker.y - 32, attacker.getATK(), attacker.getHP() * 0.2, 100, 30, 180, attacker.element,,attacker,false,,3);
						SummonEnemyLiner(attacker.x - 64, attacker.y - 16, attacker.getATK(), attacker.getHP() * 0.2, 100, 30, 180, attacker.element,,attacker,false,,3);
						SummonEnemyLiner(attacker.x - 64, attacker.y - 48, attacker.getATK(), attacker.getHP() * 0.2, 100, 30, 180, attacker.element,,attacker,false,,3);
					}		
				}
			}break;
		}
		
	}
}


onEntery = function(){
	
	base_x = x;
	
	
	jaw = SummonEnemyConnector(oEliteGolonJaw, 0, 0, self);
	
	for (var i = 0; i < 15; i++){
		body[i] = SummonEnemyConnector(oEnemyGolonBody, (i+1) * 96, 0, self);
		with(body[i]){
			x = room_width;
			y = room_height/2;
			time = i*10;
		}
	}
	
	entered = true;
}