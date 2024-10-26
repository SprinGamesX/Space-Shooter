/// @description

// Inherit the parent event
event_inherited();

sticky = true;

xoffset = 0;
yoffset = 0;

onShipHit = function(_enemy){
	
	boss.onShipHit(_enemy);
}

onElementalHit = function(_amount, _ship){
	boss.onElementalHit(_amount, _ship);
}
onToughnessReduction = function(_amount, _ship){
	boss.onToughnessReduction(_amount, _ship);
}

onHit = function(_damage, _attacker){
	boss.onHit(_damage, _attacker);
	
}

stick = function(){
	x = boss.x + xoffset;
	y = boss.y + yoffset;
}
