/// @description

x = -1000;
y = -1000;

// Particle System
global.battlePartSystem = part_system_create();
part_system_depth(global.battlePartSystem, layer_get_depth("Particles"));

// Switch timers
switch_cd = seconds(1);
switch_cd_max = switch_cd;

// Game Timer in case its neccessery
time = 0;

// Debug mode - Shows FPS and more
global.debug = false;

// Array of the team of ships
team = [noone, noone, noone];
active_index = 0; // the index of the current active ship in the team
team_standing = [1,1,1]; // Array that stores a boolean that indicates if the ship is dead or not

team[0] = instance_create_layer(room_width/2, room_height/2, "Ships", global.ships[global.party[0]]);
team[1] = instance_create_layer(x, y, "Ships", global.ships[global.party[1]]);
team[2] = instance_create_layer(x, y, "Ships", global.ships[global.party[2]]);

team[0].active = true;

training = array_create(1, noone);

getActive = function(){
	return team[active_index];
}

getTeam = function(){
	return team;
}

switchShip = function(_num){
	if (team_standing[_num] == 1){
		
		
		var _prev = active_index;
		
		// Copy position
		team[_num].x = team[active_index].x;
		team[_num].y = team[active_index].y;
	
		// Reset inactive ship
		team[active_index].x = x;
		team[active_index].y = y;
	
		// Switch active
		team[active_index].active = false;
		active_index = _num;
		team[_num].active = true;
		
		// Trigger exit skill if the ship is alive
		if (team_standing[_prev]){
			team[_prev].onExitSkill(team[_num]);
		}
		
		// Trigger entrance skill
		team[_num].onEntranceSkill();
		
		switch_cd = switch_cd_max;
	}
}

forceSwitch = function(){
	for (var i = 0; i < 3; i++){
		if (team_standing[i] == 1){
			switchShip(i);
			return true;
		}
	}
	return false;
}

getInactiveShips = function(){
	var _team = [noone, noone];
	for (var i = 0; i < 3; i++){
		if (i != active_index) {
			if (_team[0] == noone) _team[0] = team[i];
			else _team[1] = team[i];
		}
	}
	return _team;
}

isTeamDead = function(){
	return team_standing[0] + team_standing[1] + team_standing[2] == 0;
}

getInactiveIndexes = function(){
	if (team_standing[0] == 0){
		if (active_index == 1) return [2,0];
		if (active_index == 2) return [1,0];
	}
	if (team_standing[1] == 0){
		if (active_index == 0) return [2,1];
		if (active_index == 2) return [0,1];
	}
	if (team_standing[2] == 0){
		if (active_index == 0) return [1,2];
		if (active_index == 1) return [0,2];
	}
	else {
		if (active_index == 0) return [1,2];
		if (active_index == 1) return [0,2];
		if (active_index == 2) return [0,1];
	}
}

getShipUiCords = function(_ship){
	if (_ship.id == oGameManager.getActive().id){
		return [room_width/2, room_height - 100];
	}
	if (_ship.id == oGameManager.getInactiveShips()[0].id){
		return [96, room_height  - 200];
	}
	return [room_width - 96, room_height - 200];
}

onTeamKill = function(_killer){
	for (var i = 0; i < 3; i++){
		team[i].onEnemyKilled(_killer);
	}
}

onTeamPreHit = function(_enemy, _atk_type, _ally){
	var _team = getInactiveShips();
	for (var i = 0; i < array_length(_team); i++){
		_team[i].onAllyPreHit(_enemy, _atk_type, _ally);
	}
	
}
onTeamHit = function(_enemy, _atk_type, _ally){
	var _team = getInactiveShips();
	for (var i = 0; i < array_length(_team); i++){
		_team[i].onAllyHit(_enemy, _atk_type, _ally);
	}
}
onTeamPostHit = function(_enemy, _atk_type, _ally, _damage){
	var _team = getInactiveShips();
	for (var i = 0; i < array_length(_team); i++){
		_team[i].onAllyPostHit(_enemy, _atk_type, _ally, _damage);
	}
}

onTeamBreak = function(_enemy, _breaker){
	for (var i = 0; i < array_length(team); i++){
		team[i].onEnemyBreak(_enemy, _breaker);
	}
}


for (var i = 0; i < 3; i++){
	if (instance_exists(team[i])){
		team[i].onBattleBegan();
	}
}
