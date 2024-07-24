/// @description
set = STAT.ATK;
stat = STAT.ATK;
chiptype = 1;
scale = 0;


wearer = noone;
wearer_slot = -1;


compress = function(){
	return [set, stat, chiptype, scale, wearer, wearer_slot];
}

getScale = function(){
	return scale;
}

getSet = function(){
	return set;
}

getStat = function(){
	return stat;
}