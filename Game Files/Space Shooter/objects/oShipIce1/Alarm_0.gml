/// @description
if (ult_pulses > 0){
	for (var i = 0; i < 360; i += 20){
		CreateLinearProjectile(sIceShard1, self, x, y, 10, i, ATTACK_TYPE.ULTIMATE);
	}
	ult_pulses--;
	alarm[0] = seconds(0.1);
}