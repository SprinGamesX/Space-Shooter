/// @description

// Inherit the parent event
event_inherited();
ghost = true;
customMovement = true;

image_speed = 0;

animation_timer = CreateCooldown(seconds(0.2), true);

onCustomMovement = function(){
	direction = boss.direction;
	image_angle = direction;
	if (animation_timer.execute(1)){
		image_index++;
		
		if (image_index == image_number-1){
			SummonEnemyLiner(x, y, getATK(), getHP(), getDEF(), 30, direction, element,,,,sLifeArrowGhost,,true);
			awaiting_destruction = true;
		}
	}
}
