/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

customMovement = true;
part_spirit = oParticleManager.get_particle(PARTICLE.SMALL_FIRE_SPIRIT);

waiting_time = seconds(2);

target_x = x;
target_y = y;

onCustomMovement = function(){
	if (waiting_time > 0){
		waiting_time--;
		move_ease_to(self, target_x, target_y, 8);
		var _ship = oGameManager.getActive();
		direction = point_direction(x, y, _ship.x, _ship.y);
		image_angle += spin;
	}
	else {
		if (stopped) speed = 0;
		else if (slowed) speed = getSPD() * 0.05;
		else speed = getSPD() ;
	}
	
	// Particles
	
	for (var i = 0; i < 10; i++){
		var _rad = sprite_get_width(sprite_index) * 1.15;
		var _angle = irandom(360);
	
		var _effective_rad = irandom(_rad);
	
		part_particles_create(global.battlePartSystemOverlay, x + lengthdir_x(_effective_rad, _angle), y + lengthdir_y(_effective_rad, _angle), part_spirit, 1);
	}
}