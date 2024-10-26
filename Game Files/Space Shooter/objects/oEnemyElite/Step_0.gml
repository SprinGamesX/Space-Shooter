/// @description

// Inherit the parent event
event_inherited();
if (!stopped){
	
	if (!entered){
		onEntery();
	}
	else {
		if (attack_cd == 0 and (ds_exists(attackQueue, ds_type_queue)) and (ds_queue_head(attackQueue) != undefined) and !isAttacking and !weakness_broken){
			var _attack = ds_queue_dequeue(attackQueue);
			_attack.activate();
			attack_cd = max_attack_cd;
			isAttacking = true;
		}
		if (attack_cd > 0){
			if (slowed) attack_cd -= 0.1;
			else attack_cd--;
		}
	
		movement();
		cooldowns();
	
		if (toughness <= 0 and !weakness_broken){
			onWeaknessBreak();
		}
	
		if (weakness_time > 0){
			weakness_time--;
			if (weakness_time <= 0){
				onWeaknessRecover();
			}
		}
	}
	
}