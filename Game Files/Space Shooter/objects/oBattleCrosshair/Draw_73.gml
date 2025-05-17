/// @description

if (instance_exists(selected_enemy) and object_is_ancestor(selected_enemy.object_index,oEnemyConnector)){
		selected_enemy = selected_enemy.boss;
}

if (instance_exists(selected_enemy)){
	
	
	
	draw_sprite(sEnemyGui, 0, x, y - 24);
	
	var _hp = (selected_enemy.hp/selected_enemy.b_hp);
	var _toughness = (selected_enemy.toughness/selected_enemy.max_toughness);
	
	draw_sprite_stretched_ext(sShipGuiBarBig, 0, x + 2, y - 40, 62*2 * _hp, 14, c_red, 1);
	draw_sprite_stretched_ext(sShipGuiBarSmall, 0, x + 2, y - 48, 62*2 * _toughness, 6, c_purple, 1);
	for (var i = 0; i < array_length(selected_enemy.weaknesses); i++){
		draw_sprite_ext(sElements, selected_enemy.weaknesses[i], x + 62*2 - 8 - i*16, y - 60, 1, 1, 0, c_white, 1);
	}
	
	draw_sprite(sEnemyGui, 1, x, y - 24);
}