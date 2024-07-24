/// @description
if (selected_enemy != noone){
	draw_sprite(sEnemyGui, 0, x, y - 24);
	
	var _hp = (selected_enemy.hp/selected_enemy.b_hp);
	var _toughness = (selected_enemy.toughness/selected_enemy.max_toughtness);
	
	draw_sprite_stretched_ext(sShipGuiBarBig, 0, x + 2, y - 40, 62*2 * _hp, 14, c_red, 1);
	draw_sprite_stretched_ext(sShipGuiBarSmall, 0, x + 2, y - 48, 62*2 * _toughness, 6, c_purple, 1);
	
	draw_sprite(sEnemyGui, 1, x, y - 24);
}