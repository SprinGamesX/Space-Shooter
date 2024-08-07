/// @description

// Inherit the parent event
event_inherited();
if (!stopped){
	if (attack_cd == 0 and (ds_exists(attackQueue, ds_type_queue)) and (ds_queue_head(attackQueue) != undefined) and !isAttacking){
		var _attack = ds_queue_dequeue(attackQueue);
		_attack.activate();
		attack_cd = max_attack_cd;
		isAttacking = true;
	}
	if (attack_cd > 0){
		attack_cd--;
	}
	
	movement();
	cooldowns();
}