/// @description

// Inherit the parent event
event_inherited();

customMovement = true;

cd_a1 = CreateCooldown(seconds(3), true);
cd_a2 = CreateCooldown(seconds(5), true);

movement = function(){
	image_angle += (movement_speed) * (1 + getStatBonus(STAT.SPD));
}

cooldowns = function(){
	if (cd_a1.execute(1)){
		var attack1 = CreateAttack(attackQueue, seconds(0.2), 5);
		with (attack1){
			attack = function(){
				// Do attack
				SummonEnemyLiner(attacker.x, attacker.y, attacker.getATK(), attacker.b_hp/20, 100, 5,180 + irandom_range(-5, 5),,,attacker,true,, 3);
			}
		}
	}
	if (cd_a2.execute(1)){
		var attack1 = CreateAttack(attackQueue, seconds(0.05), 5,,-10);
		with (attack1){
			attack = function(){
				// Do attack
				SummonEnemyLiner(attacker.x, attacker.y, attacker.getATK(), attacker.b_hp/20, 100, 5,180 + var1,,,attacker,true,, 3);
				var1 += 5;
			}
		}
	}
}