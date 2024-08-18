/// @description

// Inherit the parent event
event_inherited();

enum IMODE{
	BASE,
	CONTROLLED,
	METEOR,
	CHARGE,
	STUNNED,
	PRAY
}
mode = IMODE.BASE;
image_speed = 0;

base_x = 0;
base_y = 0;

bx = 0;
by = 0;

out_offset = 12;
x_offset = 0;
y_offset = 0;
time = 0;

stuntime = 0;
slam = false;

index = 0;

spinspeed = 5;

follow_base = function(){
	
	var _x = boss.x + base_x;
	var _y = boss.y + base_y;
	var correction = getSPD() * (slowed ? 0.1 : 1);
	
	var error_x = abs(x - _x) / 10;
	if (x > _x) x -= correction * sqrt(error_x);
	if (x < _x) x += correction * sqrt(error_x);
	// y axis
	var error_y = abs(y - _y) / 10;
	if (y > _y) y -= correction * sqrt(error_y);
	if (y < _y) y += correction * sqrt(error_y);
	
	if (direction != 0) direction = 0;
}

follow_target = function(){
	
	var _target = oGameManager.getActive();
	
	var _x = _target.x + base_x;
	var _y = _target.y + base_y;
	var correction = getSPD() * (slowed ? 0.1 : 1);
	
	var error_x = abs(x - _x) / 10;
	if (x > _x) x -= correction * sqrt(error_x);
	if (x < _x) x += correction * sqrt(error_x);
	// y axis
	var error_y = abs(y - _y) / 10;
	if (y > _y) y -= correction * sqrt(error_y);
	if (y < _y) y += correction * sqrt(error_y);
	
	if (direction != 0) direction = 0;
}

movement = function(){
	time += (slowed ? 0.1 : 1);
	if (mode == IMODE.BASE){
		
		
		base_x = bx + sign(bx) * out_offset * sin(time/50);
		base_y = by + sign(by) * out_offset * sin(time/50);
		
		follow_base();
	}
	if (mode == IMODE.PRAY){
		follow_target();
	}
	
	if (mode == IMODE.CONTROLLED){
		follow_base();
	}
	
	if (mode == IMODE.CHARGE){
		speed = getSPD() * 8 * (slowed ? 0.1 : 1);
		
		if (countered){
			countered = false;
			mode = IMODE.BASE;
		}
		
		if (place_meeting(x, y, oBorder)){
			mode = IMODE.STUNNED;
			stuntime = seconds(2);
			speed = 0;
			ScreenShake(1, 0.7, 0.1);
		}
		if (slam and place_meeting(x, y, oEnemyI9Body)){
			mode = IMODE.STUNNED;
			stuntime = seconds(1);
			speed = 0;
			ScreenShake(1, 0.7, 0.1);
			slam = false;
		}
	}
	
	if (mode = IMODE.STUNNED){
		stuntime -= (slowed ? 0.1 : 1);
		if (stuntime <= 0){
			mode = IMODE.BASE;
		}
	}
	if (mode = IMODE.METEOR){
		spin = spinspeed * (slowed ? 0.1 : 1);
		speed = getSPD() * 2 * (slowed ? 0.1 : 1);
		if (place_meeting(x, y, oBorder)){
			boss.onMeteorHit();
		}
	}
	
	if (speed != 0){
		part_type_sprite(part_echo, sprite_index, 0, 0, 0);
		part_particles_create(global.battlePartSystem, x, y, part_echo, 1);
	}
}

onDeath = function(_attacker){
	oGameManager.onTeamKill(_attacker);
	AdditionalSetDamage(boss, _attacker, boss.getHP()*0.05);
	hp = getHP();
}


part_echo = part_type_create();
part_type_sprite(part_echo, sprite_index, 0, 0, 0);
part_type_alpha2(part_echo, 0.2, 0);
part_type_orientation(part_echo, 0,0,0,0,1);
part_type_life(part_echo, seconds(0.5), seconds(0.5));