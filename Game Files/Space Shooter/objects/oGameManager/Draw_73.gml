/// @description
var _s = team[active_index];
var xx = room_width/2;
var yy = room_height - 16;


draw_sprite_ext(sShipGui, 0, xx, yy, 2, 2, 0, c_white, 1);
draw_sprite_ext(sShipGuiUltimate, 0, xx - 180*2, yy, 2, 2, 0, c_white, 1);
draw_sprite_ext(sShipGuiAmmo, 0, xx + 174*2, yy, 2, 2, 0, c_white, 1);


// Drawing Bars

var _skill_cd_progress = 100 - ((_s.s_cd/_s.max_scd) * 100);
var _charge_progress = ((_s.charge/_s.max_charge) * 100);
var _ammo_progress = ((_s.ammo/_s.max_ammo) * 100);
var _ult_progress = ((_s.energy/_s.max_energy) * 100);

var _hp = (_s.hp/_s.getHP())*100;

var _color = ColorForElement(_s.element);

draw_sprite_stretched_ext(sShipGuiBarSmall, 0, xx - 79*4, (yy) - 24*2, 158*4 * _skill_cd_progress/100, 12, _color, 0.8);
draw_sprite_stretched_ext(sShipGuiBarSmall, 0, xx - 63*4, (yy) - 32*2, 126*4 * _charge_progress/100, 12, _color, 1);
// Ammo
draw_sprite_stretched_ext(sShipGuiABar, 0, xx + 166*2 , yy - 4 - (14*4 * _ammo_progress / 100), 32, (14*4 * _ammo_progress / 100), _color,1);
draw_sprite_stretched_ext(sShipGuiUBar, 0, xx - 194*2 , yy - 4 - (14*4 * _ult_progress / 100), 14*4, (14*4 * _ult_progress / 100), _color, _ult_progress == 100 ? 1 : 0.5);
draw_setup(,,fa_left, fa_bottom);
draw_text_scribble(xx + 185*2, yy, max(_s.ammo, 0));

draw_sprite_stretched_ext(sShipGuiBarBig, 0, xx - 79*4, (yy) - 8*4, 158*4 * _hp/100, 28, c_red, 1);
draw_setup(font_basic_ui, c_white, fa_center, fa_bottom);
draw_text_scribble(xx, yy, string(_s.hp) + "/" + string(_s.getHP()));

draw_setup(font_basic_ui, c_white, fa_center, fa_middle);
draw_text_scribble( xx - 180*2, yy - 32,"[scale, 0.5][alpha, 0.5]" + string(ceil(_ult_progress)) + "%");

draw_sprite_ext(sShipGui, 1, xx, yy, 2, 2, 0, c_white, 1);
draw_sprite_ext(sShipGuiUltimate, 1, xx - 180*2, yy, 2, 2, 0, c_white, 1);
draw_sprite_ext(sShipGuiAmmo, 1, xx + 174*2, yy, 2, 2, 0, c_white, 1);


// Draw Teammates

var _inactive = getInactiveShips();
for(var i = 0; i < 2; i++){
	_s = _inactive[i];
	xx = i == 0 ? 96 : room_width - 96;
	yy = room_height - 16;
	
	draw_sprite_ext(sShipGuiAway, 0, xx, yy, 2, 2, 0, c_white, 1);
	
	_hp = (_s.hp/_s.getHP())*100;
	_ult_progress = ((_s.energy/_s.max_energy) * 100);
	_color = ColorForElement(_s.element);
	
	
	draw_sprite_stretched_ext(sShipGuiBarBig, 0, xx - 15*4, (yy) - 8*4, 30*4 * _hp/100, 28, c_red, 1);
	
	draw_sprite_stretched_ext(sShipGuiAwayBar, 0, xx - 15*4 , yy - 9*4 - (30*4 * _ult_progress / 100), 30*4, (30*4 * _ult_progress / 100), _color, _ult_progress == 100 ? 1 : 0.5);
	draw_sprite_ext(_s.sprite_index, _s.image_index, xx, yy - 96, 1.5, 1.5, 0, c_white, 1);
	
	draw_sprite_ext(sShipGuiAway, 1, xx, yy, 2, 2, 0, c_white, 1);
	
}

var _tab = keyboard_check(vk_tab);
if (_tab){
	draw_setup(font_debug, c_white, fa_left, fa_top);
	var _text = "ATK: " + string(_s.getATK()) + "\nDEF: " + string(_s.getDEF());
	draw_text_scribble(32, 32, _text);
}	

