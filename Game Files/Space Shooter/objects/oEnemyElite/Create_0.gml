/// @description

// Inherit the parent event
event_inherited();

attackQueue = ds_queue_create();
attack_cd = 0;
max_attack_cd = 0;
isAttacking = false;
hits = 9999999;

kill_out_of_bounds = false;

max_elmstat = 150;
movement_speed = 0;

onAttackFinish = function(){
	isAttacking = false;
}

movement = function(){
	// this function should contain all movement patterns of the boss
}

cooldowns = function(){
	
}