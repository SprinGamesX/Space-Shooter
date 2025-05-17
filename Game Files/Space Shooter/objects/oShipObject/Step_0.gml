/// @description


// Movement
if (active and !locked){
	var k_right = keyboard_check(ord("D"));
	var k_left = keyboard_check(ord("A"));
	var k_up = keyboard_check(ord("W"));
	var k_down = keyboard_check(ord("S"));
	
	var _speed = getSPD();
	

	var x_move = k_right - k_left;

	if (x_move != 0){
		x_spd = _speed * x_move
	}
	else if (abs(x_spd) > 0) x_spd -= sign(x_spd) * fric;
	if (place_meeting(x + x_spd, y, oBorder)) x_spd = 0;
	x += x_spd;

	var y_move = k_down - k_up;

	if (y_move != 0){
		y_spd = _speed * y_move
	}
	else if (abs(y_spd) > 0) y_spd -= sign(y_spd) * fric;
	if (place_meeting(x, y + y_spd, oBorder)) y_spd = 0;
	y += y_spd;
	
	direction = point_direction(x, y, global.cursor.x, global.cursor.y);
}
image_angle = direction;

// Abilities

// Active
if (active and !locked){
	var _basic = mouse_check_button(mb_left);
	var _alt = mouse_check_button(mb_right);
	var _skill = keyboard_check(ord("E"));
	var _ult = keyboard_check(ord("Q"));
	var _reload = keyboard_check(ord("R"));
	var _react = keyboard_check(vk_space);
	
	
	
	if (_basic and b_cd <= 0 and ammo > 0){
		b_cd = max_bcd;
		onBasicAttack();
	}
	
	if (_alt and a_cd <= 0 and ammo > 0){
		a_cd = max_acd;
		onAltAttack();
	}
	
	if (_skill and s_cd <= 0){
		s_cd = max_scd;
		onSkill();
	}
	
	if (_ult and energy >= max_energy){
		onUltimate();
	}
	
	if (_reload and ammo != max_ammo){
		ammo = 0;
	}
	
	if (_react and react_cooldown <= 0){
		onReact();
	}
	
	onExtraStepActive();
}

// Cooldowns
// Basic Attack
if (b_cd > 0) b_cd -= 1 + (getStatBonus(STAT.ASPD));


// Alt Attack
if (a_cd > 0) a_cd -= 1 + (getStatBonus(STAT.ASPD));


// Skill Attack
if (s_cd > 0) s_cd--;

if (ammo <= 0){
	if (reload_time == -1){
		reload_time = reload_max;
	}
	if (reload_time > 0){
		reload_time--;
	}
	else if (reload_time <= 0){
		ammo = max_ammo;
		reload_time = -1;
	}
}

if (invisible) {
	image_alpha = 0.5;
	
	var part = part_invis;
	part_type_alpha2(part, 0.1, 0);
	part_type_sprite(part, sprite_index, false, false, false);
	part_type_subimage(part, image_index);
	part_type_life(part, seconds(0.5), seconds(0.5));
	part_type_scale(part, image_xscale, image_yscale);
	
	part_particles_create(global.battlePartSystem, x, y, part, 1);
	
	
	
}
else image_alpha = 1;

// Extra
onExtraStep();
