/// @description

// Switch CD
if (switch_cd > 0) switch_cd--;

// Check for inputs if cooldown is up
if (switch_cd <= 0){
	if (keyboard_check_pressed(ord("1")) and (instance_exists(team[getInactiveIndexes()[0]]))){
		switchShip(getInactiveIndexes()[0]);
		switch_cd = switch_cd_max;
	}
	if (keyboard_check_pressed(ord("2")) and (instance_exists(team[getInactiveIndexes()[1]]))){
		switchShip(getInactiveIndexes()[1]);
		switch_cd = switch_cd_max;
	}
}

switch(global.gamemode){
	case GAMEMODE.TRAINING: onModeTraining(); break;
	case GAMEMODE.ENDLESS:  onModeEndless();  break;
}


// Check for death

for (var i = 0; i < 3; i++){
	if (team_standing[i] == 1 and team[i].hp <= 0) {
		team_standing[i] = 0;
		forceSwitch();
	}
}

if (keyboard_check(vk_escape)){
	escape_counter++;
	if (escape_counter == seconds(2)){
		oRoomManager.goMain();
	}
}
else if (escape_counter > 0) escape_counter = 0;

part_type_alpha1(part_star, random_range(0.35, 0.6));
part_particles_create(global.battlePartSystem, room_width + 10, random_range(0, room_height), part_star, 1);