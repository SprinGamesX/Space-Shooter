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

// Check for death
for (var i = 0; i < 3; i++){
	if (team_standing[i] == 1 and team[i].hp <= 0) {
		team_standing[i] = 0;
		forceSwitch();
	}
}

if (!instance_exists(training)){
	training = SummonTrainingEnemy(sEnemiesNormal, room_width/4 * 3, random_range(64, room_height - 64), 10, 500, 0, 0);
}