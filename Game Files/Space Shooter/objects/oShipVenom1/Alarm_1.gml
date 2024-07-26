/// @description
if (ult_remain > 0){
	ult_remain--;
	
	CreateHomingProjectile(sVenomGoo, self, x, y, 12, direction + random_range(-90, 90), ATTACK_TYPE.ULTIMATE,,,2);
	
	alarm[1] = seconds(0.05);
}