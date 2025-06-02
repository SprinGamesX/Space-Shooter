/// @description Insert description here
// You can write your code in this editor

elites = 0;
damage_done = 0;
damage_taken = 0;
enemy_level = 0;



if (instance_exists(oBattleDataCollector)){
	elites = oBattleDataCollector.elites_killed - 1;
	damage_done = oBattleDataCollector.damage_inflicted;
	damage_taken = oBattleDataCollector.damage_taken;
	enemy_level = oBattleDataCollector.enemy_level;
}

room_goto(rEndScreen);

typewriter = scribble_typist();
typewriter.in(0.5, 0);

typewriter2 = scribble_typist();
typewriter2.in(0.5, 0);



text = "[scale, 4]Endless Mode: Complete!\n\n[scale,2]";
text += "Enemies killed: " + string(elites) + "\n\n";
text += "Enemy Level: " + string(enemy_level) + "\n\n";
text += "Damage Inflicted: " + string(damage_done) + "\n\n";
text += "Damage Sustained: " + string(damage_taken);
draw_obj = scribble(text);
show_debug_message(text);

scr_leave_prompt = scribble("[scale,3]Press -Space- or -ESC- to return!");

