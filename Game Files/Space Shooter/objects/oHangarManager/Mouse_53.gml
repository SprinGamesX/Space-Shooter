/// @description
if (selection == HANGARITEM.ARROW_RIGHT){
	moveRight();
}
if (selection == HANGARITEM.ARROW_LEFT){
	moveLeft();
}

if (selection = HANGARITEM.BUTTON_CHIPS){
	if (mode != HANGARMODE.CHIPS) switchMode(HANGARMODE.CHIPS);
	else switchMode(HANGARMODE.SKILLS);
}
if (selection = HANGARITEM.BUTTON_SKILLS){
	if (mode == HANGARMODE.DEFAULT) switchMode(HANGARMODE.SKILLS);
	else switchMode(HANGARMODE.DEFAULT);
}

if (selection == HANGARITEM.INV_RIGHT){
	chip_page += 1;
}
if (selection == HANGARITEM.INV_LEFT and chip_page > 1){
	chip_page -= 1;
}