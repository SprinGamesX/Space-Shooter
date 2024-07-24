// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information




global.passives = array_create(array_length(global.ships));

for (var i = 1; i < array_length(global.ships); i++){
	global.passives[i] = array_create(14, false);
}



function GetShipST(_id){
	switch(_id){
		case 1: return [[STAT.ATK,STAT.HP,STAT.DEF,STAT.ATK,STAT.ICEDMG,STAT.ENERGYREGEN,STAT.ICEDMG],
						[0.1, 0.1, 0.1, 0.15, 0.08, 0.05, 0.16]];
						
		case 2: return [[STAT.ATK,STAT.HP,STAT.DEF,STAT.ATK,STAT.ASPD,STAT.CRITDMG,STAT.ASPD],
						[0.1, 0.1, 0.1, 0.15, 0.03, 0.15, 0.07]];
						
		case 3: return [[STAT.ATK,STAT.HP,STAT.DEF,STAT.HP,STAT.HEALINGBONUS,STAT.ENERGYREGEN,STAT.HEALINGBONUS],
						[0.1, 0.1, 0.1, 0.15, 0.05, 0.05, 0.1]];
	}
}

function SavePassives(){
	ini_open("Ship Passives.ini");
	
	for (var i = 1; i < array_length(global.passives); i++){
		for(var j = 0; j < array_length(global.passives[1]); j++){
			ini_write_real(i, j, global.passives[i][j]);
		}
	}
	
	ini_close();
}

function LoadPassives(){
	ini_open("Ship Passives.ini");
	
	for (var i = 1; i < array_length(global.passives); i++){
		for(var j = 0; j < array_length(global.passives[1]); j++){
			global.passives[i][j] = ini_read_real(i, j, 0);
		}
	}
	
	ini_close();
}
LoadPassives();