/// @description

// Rotation Control
if (spin){
	image_angle += spin;
}
else image_angle = direction;


// Killing out of bounds projectiles
if (IsOutOfBounds(50)){
	instance_destroy();
}

// Collision with enemies
var _col = instance_place(x, y, oEnemyObject);
if (instance_exists(_col) and _col != noone){
	CreateAoe(owner, owner.element, x, y, atk_type, aoe);
	pierce--;
	
	if (pierce <= 0) instance_destroy();
}

// Particles
if (trail != noone){
	DrawProjTrail(owner);
}