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
		if (start_cd > 0) start_cd--;
		else {
			if (cd > 0) cd--;
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