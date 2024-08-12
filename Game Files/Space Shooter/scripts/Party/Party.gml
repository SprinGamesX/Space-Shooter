// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.party = [1,2,3];

function SaveParty(){
	ini_open("Party.ini");
	
	for (var i = 0; i < array_length(global.party); i++){
		ini_write_real("Current", i, global.party[i]);
	}
	
	ini_close();
}

function LoadParty(){
	ini_open("Party.ini");
	
	for (var i = 0; i < array_length(global.party); i++){
		global.party[i] = ini_read_real("Current", i, i+1);
	}
	
	ini_close();
}

// Load Party
LoadParty();