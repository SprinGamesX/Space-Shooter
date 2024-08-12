/// @description

getStat = function(){
	return scale;
}


trigger = function(){
	
	var _enemy = target;
	
	var _basedmg = (provider.getATK()) * scale;
	
	var _dmgbonus = 1 + GetDamageBonus(provider.element, ATTACK_TYPE.DOT, provider);
	
	var _res = (1 - _enemy.getStatBonus(STAT.RES) - GetCorrispondingRes(provider.element, _enemy) + provider.getStatBonus(STAT.RESPEN));
	
	var _def = (1 - ((_enemy.b_def * (1 + _enemy.getStatBonus(STAT.DEF)) * (1 + provider.getStatBonus(STAT.DEFPEN)))/5000));
		
	// 1 - Lvl multiplier
	var _damage = _basedmg * _dmgbonus * _res * _def * (_enemy.toughness == 0 ? 1.15 : 1) * (1 - ((_enemy.lvl - provider.lvl) * 0.01));

	show_debug_message(string(_damage));
	
	CreateDamageIndicator(_enemy.x + random_range(0, 48) * (provider.ind_index), _enemy.y - random_range(16, 64), "<" + string(round(_damage)) + ">", provider.element, !object_is_ancestor(_enemy.object_index, oEnemyElite) ? 0.5 : 1);
	provider.ind_index *= -1;
	_enemy.onHit(_damage, provider);	
	
}
