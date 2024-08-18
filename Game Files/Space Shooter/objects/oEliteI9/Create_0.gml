/// @description

// Inherit the parent event
event_inherited();

// Movement stuff
time = 0;
base_x = room_width/5 * 4;
base_y = room_height/2;
yoffset = 256;

meteorhit = false;

// Array of Eight bodies
bodies = array_create(8);


// Cooldowns
cd_a1 = CreateCooldown(seconds(6), true);
cd_a1.time = cd_a1.timer;

cd_ultimate = CreateCooldown(seconds(60), true);
cd_ultimate.time = cd_ultimate.timer;
cd_flank = CreateCooldown(seconds(0.1), true);

// this function should contain all movement patterns of the boss
movement = function(){
	time += getSPD() * slowed ? 0.1 : 1;
	
	y = base_y + (sin(time/90) * yoffset);
	
	var _part = part_aura;
	
	if (RollChance(0.5)){
		part_type_color2(_part, #b3fff1, #b3fff1);
	}
	
	part_particles_create(global.battlePartSystem, x, y, part_aura, 10);
}

onMeteorHit = function(){
	for (var i = 0; i < 8; i++){
		bodies[i].mode = IMODE.CHARGE;
		bodies[i].direction = random(360);
		bodies[i].spin = 0;
	}
	for (var i = 0; i < 360; i+=5){
		SummonEnemyLiner(bodies[0].x, bodies[0].y, getATK(), getHP()/20, 100, 5, i, element,,,true);
	}
	meteorhit = true;
}

cooldowns = function(){
	
	if (oGameManager.getActive().x >= x and (cd_flank.execute(1))){
		SummonEnemyLiner(random_range(x, room_width-16), 0, getATK(), getHP()*0.15, 100, 20, 270, element,,,true,,10);
		SummonEnemyLiner(random_range(x, room_width-16), room_height, getATK(), getHP()*0.15, 100, 20, 90, element,,,true,,10);
	}
	
	var ready = true;
	for (var i = 0; i < 8; i++){
		if (bodies[i].mode != IMODE.BASE) ready = false;
	}
	
	if (cd_ultimate.execute(1)){
		meteorhit = false;
		var attack1 = CreateAttack(attackQueue, seconds(3), 1,,false,,,,seconds(1));
				with (attack1){
					
					onAttackBegin = function(){
						with(attacker){
							bodies[0].mode = IMODE.CONTROLLED;
							bodies[0].base_x = -128;
							bodies[0].base_y = 0;
				
							bodies[1].mode = IMODE.CONTROLLED;
							bodies[1].base_x = -152;
							bodies[1].base_y = 0;
								
							bodies[2].mode = IMODE.CONTROLLED;
							bodies[2].base_x = -144;
							bodies[2].base_y = -16;
								
							bodies[3].mode = IMODE.CONTROLLED;
							bodies[3].base_x = -112;
							bodies[3].base_y = -16;
							
							bodies[4].mode = IMODE.CONTROLLED;
							bodies[4].base_x = -96;
							bodies[4].base_y = 0;
								
							bodies[5].mode = IMODE.CONTROLLED;
							bodies[5].base_x = -72;
							bodies[5].base_y = 0;
								
							bodies[6].mode = IMODE.CONTROLLED;
							bodies[6].base_x = -144;
							bodies[6].base_y = 16;
								
							bodies[7].mode = IMODE.CONTROLLED;
							bodies[7].base_x = -112;
							bodies[7].base_y = 16;
						}
					}
					
					attack = function(){
						// Do attack
						with(attacker){
							for (var i = 0; i < 8; i++){
								bodies[i].mode = IMODE.METEOR;
								bodies[i].direction = 180;
							}
							
						}
						if (var1 and !attacker.meteorhit){
							attacker.onMeteorHit();
						}
						var1 = true;	
							
					}
				}
	}
	
	if (cd_a1.execute(1) and ready){
		
		attack_num = irandom(4);
		switch(attack_num){
			case 0:
				var attack1 = CreateAttack(attackQueue, 0, 1);
				with (attack1){
					attack = function(){
						// Do attack
						with(attacker){
							bodies[0].mode = IMODE.CHARGE;
							bodies[0].direction = 170;
				
							bodies[7].mode = IMODE.CHARGE;
							bodies[7].direction = 190;
				
							bodies[3].mode = IMODE.CHARGE;
							bodies[3].direction = 180;
						}
					}
				}
			break;
			
			case 1:
				var attack1 = CreateAttack(attackQueue, seconds(2), 2,,false);
				with (attack1){
					attack = function(){
						// Do attack
						
						if (!var1){
							with(attacker){
								bodies[0].mode = IMODE.CONTROLLED;
								bodies[0].base_x = -64;
								bodies[0].base_y = 0;
				
								bodies[1].mode = IMODE.CONTROLLED;
								bodies[1].base_x = -64;
								bodies[1].base_y = -48;
								
								bodies[2].mode = IMODE.CONTROLLED;
								bodies[2].base_x = -64;
								bodies[2].base_y = -96;
								
								bodies[3].mode = IMODE.CONTROLLED;
								bodies[3].base_x = -64;
								bodies[3].base_y = -144;
								
								bodies[5].mode = IMODE.CONTROLLED;
								bodies[5].base_x = -64;
								bodies[5].base_y = 144;
								
								bodies[6].mode = IMODE.CONTROLLED;
								bodies[6].base_x = -64;
								bodies[6].base_y = 96;
								
								bodies[7].mode = IMODE.CONTROLLED;
								bodies[7].base_x = -64;
								bodies[7].base_y = 48;
							}
							var1 = true;
						}
						else {
							with (attacker){
								for (var i = 0; i < array_length(bodies); i++){
									if (i != 4){
										bodies[i].mode = IMODE.CHARGE;
										bodies[i].direction = 180;
									}
								}
							}
						}
					}
				}
			break;
			
			case 2:
				var attack1 = CreateAttack(attackQueue, seconds(0.2), 20,,0,,,,seconds(1));
				with (attack1){
					
					onAttackBegin = function(){
						with(attacker){
								bodies[0].mode = IMODE.CONTROLLED;
								bodies[0].base_x = -32;
								bodies[0].base_y = 0;
				
								bodies[1].mode = IMODE.CONTROLLED;
								bodies[1].base_x = 0;
								bodies[1].base_y = -64;
								
								bodies[2].mode = IMODE.CONTROLLED;
								bodies[2].base_x = 0;
								bodies[2].base_y = -32;
								
								bodies[3].mode = IMODE.CONTROLLED;
								bodies[3].base_x = 64;
								bodies[3].base_y = 0;
								
								bodies[4].mode = IMODE.CONTROLLED;
								bodies[4].base_x = 32;
								bodies[4].base_y = 0;
								
								bodies[5].mode = IMODE.CONTROLLED;
								bodies[5].base_x = 96;
								bodies[5].base_y = 0;
								
								bodies[6].mode = IMODE.CONTROLLED;
								bodies[6].base_x = 0;
								bodies[6].base_y = 32;
								
								bodies[7].mode = IMODE.CONTROLLED;
								bodies[7].base_x = 0;
								bodies[7].base_y = 64;
							}
					}
					
					attack = function(){
						// Do attack
						with(attacker){
							SummonEnemyLiner(x - 48, y + 48, getATK(), getHP()*0.05, 100, 20, 180, element, 500,,true,,5);
							SummonEnemyLiner(x - 48, y - 48, getATK(), getHP()*0.05, 100, 20, 180, element, 500,,true,,-5);
							
						}
						var1++;
						if (var1 == 20){
							for (var i = 0; i < array_length(attacker.bodies); i++){
								attacker.bodies[i].mode = IMODE.BASE;
							}
						}
					}
				}
			break;
			
			case 3:
				var attack1 = CreateAttack(attackQueue, seconds(0.1), 10,,0,,,,seconds(1));
				with (attack1){
					
					onAttackBegin = function(){
						with(attacker){
								bodies[0].mode = IMODE.CONTROLLED;
								bodies[0].base_x = -32;
								bodies[0].base_y = -64;
				
								bodies[1].mode = IMODE.CONTROLLED;
								bodies[1].base_x = 0;
								bodies[1].base_y = -64;
								
								bodies[2].mode = IMODE.CONTROLLED;
								bodies[2].base_x = 0;
								bodies[2].base_y = -32;
								
								bodies[3].mode = IMODE.CONTROLLED;
								bodies[3].base_x = 64;
								bodies[3].base_y = 0;
								
								bodies[4].mode = IMODE.CONTROLLED;
								bodies[4].base_x = 32;
								bodies[4].base_y = 0;
								
								bodies[5].mode = IMODE.CONTROLLED;
								bodies[5].base_x = 0;
								bodies[5].base_y = 64;
								
								bodies[6].mode = IMODE.CONTROLLED;
								bodies[6].base_x = 0;
								bodies[6].base_y = 32;
								
								bodies[7].mode = IMODE.CONTROLLED;
								bodies[7].base_x = -32;
								bodies[7].base_y = 64;
							}
					}
					
					attack = function(){
						// Do attack
						with(attacker){
							SummonEnemyLiner(x - 48, y, getATK(), getHP()*0.15, 100, 20, 180 + random_range(-10,10), element,,,false,,5);
						}
						var1++;
						if (var1 == 10){
							for (var i = 0; i < array_length(attacker.bodies); i++){
								attacker.bodies[i].mode = IMODE.BASE;
							}
						}
					}
				}
			break;
			
			case 4:
				var attack1 = CreateAttack(attackQueue, 0, 1,,0,,,,seconds(5));
				with (attack1){
					
					onAttackBegin = function(){
						with(attacker){
							bodies[1].mode = IMODE.PRAY;
							bodies[1].base_x = -32;
							bodies[1].base_y = -256;
							
							bodies[2].mode = IMODE.PRAY;
							bodies[2].base_x = 0;
							bodies[2].base_y = -256;
								
							bodies[3].mode = IMODE.PRAY;
							bodies[3].base_x = 32;
							bodies[3].base_y = -256;
			
							bodies[5].mode = IMODE.PRAY;
							bodies[5].base_x = 32;
							bodies[5].base_y = 256;
								
							bodies[6].mode = IMODE.PRAY;
							bodies[6].base_x = 0;
							bodies[6].base_y = 256;
								
							bodies[7].mode = IMODE.PRAY;
							bodies[7].base_x = -32;
							bodies[7].base_y = 256;
						}
					}
					
					attack = function(){
						// Do attack
						with(attacker){
							for (var i = 0; i < 8; i++){
								if (i > 0 and i < 4){
									bodies[i].mode = IMODE.CHARGE;
									bodies[i].direction = 270;
									bodies[i].slam = true;
								}
								if (i > 4){
									bodies[i].mode = IMODE.CHARGE;
									bodies[i].direction = 90;
									bodies[i].slam = true;
								}
							}
							
						}
					}
				}
			break;
			
		}
	}
}

onDeath = function(_attacker){
	oGameManager.onTeamKill(_attacker);
	awaiting_destruction = true;
	for (var i = 0; i < array_length(bodies); i++){
		bodies[i].awaiting_destruction = true;
	}
}

part_aura = part_type_create();
part_type_sprite(part_aura, sPixel, 0,0,0);
part_type_alpha3(part_aura, 0.3,0.7, 0);
part_type_life(part_aura, seconds(10), seconds(12));
part_type_color2(part_aura,#45fffc, #199695);
part_type_direction(part_aura, 0, 360, 0.2, 0);
part_type_orientation(part_aura, 0, 360, 1, 0,0);
part_type_speed(part_aura, 3, 5, 0, 0);
part_type_size(part_aura, 1, 2, 0, 0);
