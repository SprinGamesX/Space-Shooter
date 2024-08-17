/// @description
/// @description Insert description here
// You can write your code in this editor
if (active){
	if (!instance_exists(attacker)){
		instance_destroy();
	}
	else {
		if (!attack_began){
				onAttackBegin();
				attack_began = true;
			}
		if (start_cd > 0 and !attacker.stopped) start_cd -= attacker.slowed ? 0.1 : 1;
		else {
			if (cd > 0 and !attacker.stopped) cd -= attacker.slowed ? 0.1 : 1;
			else {
				attack();
				cd = max_cd;
				repeatAttack--;
			}
			if (repeatAttack == 0) {
				if (instance_exists(attacker)){
					attacker.onAttackFinish();
				
				}
				instance_destroy();
			}
		}
	}
}