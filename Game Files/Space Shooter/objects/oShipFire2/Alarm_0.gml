/// @description
if (skill_shots > 0){
	
	var _d = 18;
	var _displacement = irandom_range(-_d, _d);
	
	
	CreateLinearProjectile(sFireArrow, self, x + lengthdir_x(_displacement, direction+90), y + lengthdir_y(_displacement, direction+90), 15, direction, ATTACK_TYPE.SKILL);
	skill_shots--;
	alarm[0] = seconds(0.05);
}