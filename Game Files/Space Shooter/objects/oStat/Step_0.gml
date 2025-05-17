/// @description
if (!instance_exists(target)){
	if (room == rBattle) oGameManager.refreshBuffs();
	instance_destroy(self);
}

if (!isInfinite){
	if (time > 0) time--;
	else if (time <= 0 and instance_exists(target)){
		target.onStatOver(self);
	}
}