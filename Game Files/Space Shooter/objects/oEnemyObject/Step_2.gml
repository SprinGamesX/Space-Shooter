/// @description
if (awaiting_destruction){
	var _ex = CheckForStat(self, STAT.FIRERES, "Ignite");
	
	if (_ex != noone){
		CreateAoe(_ex.provider, _ex.provider.element, x, y, ATTACK_TYPE.FIRE_EXPLOSION, ATTACK_TYPE.FIRE_EXPLOSION, 1 + (_ex.provider.getStatBonus(STAT.ES)) + _ex.stacks);
	}
	
	EnemyDeathParticles(self);
	instance_destroy();
}