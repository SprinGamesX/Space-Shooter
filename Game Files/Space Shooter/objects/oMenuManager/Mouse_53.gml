/// @descriptions
switch(selection){
	// Testing
	case 0: {
		room_goto(rBattle);
		global.gamemode = GAMEMODE.TRAINING;
	} break;
	
	case 1: {
		room_goto(rBattle);
		global.gamemode = GAMEMODE.ENDLESS;
	} break;
	
	case 2: {
		room_goto(rHangar);
	} break;
	case 3: {
		room_goto(rParty);
	} break;
	case 4: {
		room_goto(rInventory);
	} break;
	case 5: {
		room_goto(rOptions);
	} break;
}