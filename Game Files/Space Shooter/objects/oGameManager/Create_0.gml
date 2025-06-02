/// @description

x = -1000;
y = -1000;

// Gamemodes
enemies = array_create(1, noone);
endless_level = 1;

// Particle System
global.battlePartSystem = part_system_create();
global.battlePartSystemOverlay = part_system_create();
part_system_depth(global.battlePartSystem, layer_get_depth("Particles"));
part_system_depth(global.battlePartSystemOverlay, layer_get_depth("Enemies") - 1);
instance_create_depth(-100, -100, 0, oEchoHolder);

// Particle Manager
particle_manager = instance_create_depth(x, y, depth, oParticleManager);

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

// Data Collection
data_collector = instance_create_depth(x, y, depth, oBattleDataCollector);



// Escape
escape_counter = 0;


current_buffs = array_create(10, noone);
current_buffs_num = 0;

current_enemy_buffs = array_create(10, noone);
current_enemy_buffs_num = 0;

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
		
		refreshBuffs();
	}
}

forceSwitch = function(){
	for (var i = 0; i < 3; i++){
		if (team_standing[i] == 1){
			switchShip(i);
			team[i].invisible = true;
			team[i].invis_cd = seconds(2);
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

refreshBuffs = function(){
	for(var i = 0; i < current_buffs_num; i++){
		current_buffs[i] = noone;
	}
	current_buffs_num = 0;
	
	for(var i = 0; i < current_enemy_buffs_num; i++){
		current_enemy_buffs[i] = noone;
	}
	current_enemy_buffs_num = 0;
	
	var _num = instance_number(oStat);
	var _index = 0;
	var _enemy_index = 0;
	for (var i = 0; i < _num; i++){
		var _stat = instance_find(oStat, i);
		
		if (instance_exists(_stat) and instance_exists(_stat.target) and 
			object_is_ancestor(_stat.target.object_index, oShipObject) and 
			_stat.target.id == getActive().id and IsValidStat(_stat))
		{
			current_buffs[_index] = _stat;
			_index++;
		}
		
		if (instance_exists(_stat) and instance_exists(_stat.target) and 
			object_is_ancestor(_stat.target.object_index, oEnemyElite) and 
			_stat.target.id == enemies[0].id and IsValidStat(_stat))
		{
			current_enemy_buffs[_enemy_index] = _stat;
			_enemy_index++;
		}
		
		
	}
	current_buffs_num = _index;
	current_enemy_buffs_num = _enemy_index;
}

// Gamemodes

onModeTraining = function(){
	for (var i = 0; i < array_length(enemies); i++){
		if (!instance_exists(enemies[i])){
			//var _training_enemy = choose(ENEMIES.I9,ENEMIES.GOLON,ENEMIES.LIFEBOW);
			var _training_enemy = ENEMIES.FIRESPIRIT;
		
			var _level = 0;
			for (var j = 0; j < array_length(team); j++){
				_level += team[i].lvl;
			}
			_level = round(_level/3);
		
			enemies[i] = SummonEnemy(_training_enemy, room_width/5 * 4, room_height/2, _level);
		}
	}
}

onModeEndless = function(){
	if (!instance_exists(enemies[0])){
		endless_level += irandom_range(1, 5);
		var _elite = choose(ENEMIES.I9,ENEMIES.GOLON,ENEMIES.LIFEBOW);
		
		enemies[0] = SummonEnemy(_elite, room_width/5 * 4, room_height/2, endless_level);
		
		// Data
		data_collector.elites_killed++;
		data_collector.enemy_level = endless_level;
	}
}


// Start game

team[0] = instance_create_layer(room_width/2, room_height/2, "Ships", global.ships[global.party[0]]);
team[1] = instance_create_layer(x, y, "Ships", global.ships[global.party[1]]);
team[2] = instance_create_layer(x, y, "Ships", global.ships[global.party[2]]);

team[0].active = true;

for (var i = 0; i < 3; i++){
	if (instance_exists(team[i])){
		team[i].onBattleStart();
		team[i].onBattleBegan();
	}
}



part_enemy = part_type_create();
part_type_sprite(part_enemy, sPixel, 0,0,0);
part_type_size(part_enemy, 1, 2, 0, 0);
part_type_life(part_enemy, seconds(1), seconds(2));
part_type_speed(part_enemy, 0.5, 1, -0.003, 0);
part_type_orientation(part_enemy, 0, 359, 0, 0, 0);
part_type_direction(part_enemy, 0, 359, 0, 0);
part_type_alpha2(part_enemy, 1, 0);

part_star = part_type_create();
part_type_sprite(part_star, sStarParticle, 0,0,1);
part_type_size(part_star, 0.5, 1, 0, 0.1);
part_type_life(part_star, seconds(10), seconds(10));
part_type_speed(part_star, 2, 4, 0, 0);
part_type_orientation(part_star, 0, 360, 1, 0, 0);
part_type_alpha1(part_star, 0.35);
part_type_direction(part_star, 179, 181, 0, 1);

