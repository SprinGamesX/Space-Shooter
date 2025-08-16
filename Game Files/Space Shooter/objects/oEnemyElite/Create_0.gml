/// @description

// Inherit the parent event
event_inherited();

active = false;

attackQueue = ds_queue_create();
attack_cd = 0;
max_attack_cd = 0;
isAttacking = false;
hits = 9999999;

kill_out_of_bounds = false;

movement_speed = 0;
weakness_time = 0;
weakness_broken = false;
entered = false;

onAttackFinish = function(){
	isAttacking = false;
}

movement = function(){
	// this function should contain all movement patterns of the boss
}

cooldowns = function(){
	
}

onWeaknessBreak = function(){
	weakness_broken = true;
}

onWeaknessRecover = function(){
	
	attack_cd = max_attack_cd;
	toughness = max_toughness;
	weakness_broken = false;
}

onEntery = function(){
	entered = true;
}

applyStatsForLevel = function(){
	b_atk += b_atk * (0.1*lvl);
	b_hp += b_hp * (0.2*lvl);
	hp = b_hp;
}