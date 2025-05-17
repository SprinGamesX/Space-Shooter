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


// Buffs & Debuffs
//draw_text_scribble(xx, yy - 100, "Buffs: " + string(current_buffs_num));
var _extra_dis = 64;
var _starting_dis = (current_buffs_num div 2) * _extra_dis;


if (current_buffs_num mod 2 == 0){
	_starting_dis -= 20;
}

for (var i = 0; i < current_buffs_num; i++){
	var _cb = ColorForElement(current_buffs[i].provider.element);
	var _xplace = xx + _extra_dis*i - _starting_dis;
	draw_sprite_ext(sBuffBox, 0, _xplace, yy - 96, 2, 2, 0, c_dkgray, 1);
	
	var _dur_percent = current_buffs[i].time / current_buffs[i].max_time;
	//draw_sprite_part_ext(sBuffBoxOverlay, 0, 0, 0, sprite_get_width(sBuffBoxOverlay), sprite_get_height(sBuffBoxOverlay) * _dur_percent,_xplace - 20,yy - 96 - 20 + (40 * (1-_dur_percent)),2,2, _cb, 0.9);
	draw_sprite_part_ext(sBuffBoxOverlay, 0, 0, (20 * (1-_dur_percent)), sprite_get_width(sBuffBoxOverlay), sprite_get_height(sBuffBoxOverlay) * _dur_percent,_xplace - 20,yy - 96 - 20 + (40 * (1-_dur_percent)),2,2, _cb, 0.9);
	draw_sprite_ext(sStatIcons, current_buffs[i].stat, _xplace, yy - 96, 1, 1, 0, _cb, 1);
	
	if (current_buffs[i].isNegative){
		draw_sprite_ext(sUIArrow, 0, _xplace + 15, yy - 96 - 10, 1, 1, 270, c_red, 1);
	}
	else{
		draw_sprite_ext(sUIArrow, 0, _xplace + 15, yy - 96 - 10, 1, 1, 90, c_lime, 1);
	}
	
	if (current_buffs[i].max_stacks > 1){
		draw_setup();
		draw_text_scribble(_xplace - 20, yy - 96 + 10, string(current_buffs[i].stacks))
	}
	
}


// Shield stuff
var _over = false;
var _loops = 0;
var _shield = _s.shield;
while(!_over and _s.shield > 0){
	var _shieldSection = _shield;
	while(_shieldSection > _s.getHP()) _shieldSection -= _s.getHP();
	_shieldSection = (_shieldSection/_s.getHP());
	var _color1 = c_orange;
	
	switch(_loops){
		case 1: _color1 = c_yellow; break;
		case 2: _color1 = c_blue; break;
		case 3: _color1 = c_aqua; break;
	}
	
	draw_sprite_stretched_ext(sShipGuiBarBig, 0, xx - 79*4, (yy) - 8*4, 158*4 * _shieldSection, 28, _color1, 1);
	_shield -= _s.getHP();
	if (_shield <= 0) _over = true;
	else _loops++;
}

draw_setup(font_basic_ui, c_white, fa_center, fa_bottom);
draw_text_scribble(xx, yy, string(round(_s.hp)) + "/" + string(round(_s.getHP())));

draw_setup(font_basic_ui, c_white, fa_center, fa_middle);
draw_text_scribble( xx - 180*2, yy - 32,"[scale, 0.5][alpha, 0.5]" + string(ceil(_ult_progress)) + "%");

draw_sprite_ext(sShipGui, 1, xx, yy, 2, 2, 0, c_white, 1);
draw_sprite_ext(sShipGuiUltimate, 1, xx - 180*2, yy, 2, 2, 0, c_white, 1);
draw_sprite_ext(sShipGuiAmmo, 1, xx + 174*2, yy, 2, 2, 0, c_white, 1);


// Draw Teammates

var _inactive = getInactiveShips();
var _inactiveI = getInactiveIndexes();
for(var i = 0; i < 2; i++){
	
	var _index = _inactiveI[i];
	_s = team[_index];
	xx = i == 0 ? 96 : room_width - 96;
	yy = room_height - 16;
	
	draw_sprite_ext(sShipGuiAway, 0, xx, yy, 2, 2, 0, c_white, 1);
	
	if (team_standing[_index]){
		_hp = (_s.hp/_s.getHP())*100;
		_ult_progress = ((_s.energy/_s.max_energy) * 100);
		_color = ColorForElement(_s.element);
		draw_sprite_stretched_ext(sShipGuiBarBig, 0, xx - 15*4, (yy) - 8*4, 30*4 * _hp/100, 28, c_red, 1);
		draw_sprite_stretched_ext(sShipGuiAwayBar, 0, xx - 15*4 , yy - 9*4 - (30*4 * _ult_progress / 100), 30*4, (30*4 * _ult_progress / 100), _color, _ult_progress == 100 ? 1 : 0.5);
	}
	draw_sprite_ext(_s.sprite_index, _s.image_index, xx, yy - 96, 1.5, 1.5, 0, c_white, 1);
	
	draw_sprite_ext(sShipGuiAway, 1, xx, yy, 2, 2, 0, c_white, 1);
	if (!team_standing[_index]) draw_sprite_ext(sBrokenAlly, 1, xx, yy, 2, 2, 0, c_white, 1);
	
}


// Draw boss bar (if boss exists)

var _elite = enemies[0];

if (instance_exists(_elite)){
	var _alpha = 1;
	if (InRange(getActive().x, room_width/2 - 500, room_width/2 + 500) and InRange(getActive().y, 23, 128)){
		_alpha = 0.5;
	}
	
	
	var _xx = room_width/2;
	var _boss = _elite;
	
	var _color_boss_bar = ColorForElement(_boss.element);
	var _hp_percent = _boss.hp / _boss.getHP();
	var _toughness_percent = _boss.toughness / _boss.max_toughness;
	
	draw_sprite_ext(sBossBar, 0, _xx, 64, 4, 4, 0, _color_boss_bar, _alpha);
	draw_sprite_part_ext(sBossBar, 1, 0, 0, 122*2 * _hp_percent + 4*2,48,_xx - 128*4, 64 - 48,4, 4, _color_boss_bar, _alpha);
	var _toughness_color = make_color_hsv(color_get_hue(_color_boss_bar), color_get_saturation(_color_boss_bar)/2, color_get_value(_color_boss_bar)/2)
	draw_sprite_part_ext(sBossBar, 2, 0, 0, 110*2 * _toughness_percent + 9*2,48,_xx - 128*4, 64 - 48,4, 4, _toughness_color, _alpha);
	
	var _isDark = color_get_value(_color_boss_bar) < 50;
	
	draw_setup(font_boss_health, c_white);
	draw_text_scribble(_xx, 16, "LVL: " + string(_boss.lvl));
	draw_text_scribble(_xx, 64, string(round(_boss.hp)) + "/" + string(round(_boss.getHP())));
	
	for (var i = 0; i < array_length(_boss.weaknesses); i++){
		var _icon_scale = 2;
		draw_sprite_ext(sElements, _boss.weaknesses[i], _xx + 460 - i*16*_icon_scale, 16, _icon_scale, _icon_scale, 0, c_white, 1);
	}
	
	
	// Enemy buffs & nerfs
	
	_xx = _xx - 408;
	_extra_dis = 64;
	yy = 148;
	
	for (var i = 0; i < current_enemy_buffs_num; i++){
		if (!instance_exists(current_enemy_buffs[i])) continue;
		var _cb = ColorForElement(current_enemy_buffs[i].provider.element);
		var _xplace = _xx + _extra_dis*i;
		draw_sprite_ext(sBuffBox, 0, _xplace, yy, 2, 2, 0, c_dkgray, 1);
	
		var _dur_percent = current_enemy_buffs[i].time / current_enemy_buffs[i].max_time;
		//draw_sprite_part_ext(sBuffBoxOverlay, 0, 0, 0, sprite_get_width(sBuffBoxOverlay), sprite_get_height(sBuffBoxOverlay) * _dur_percent,_xplace - 20,yy - 96 - 20 + (40 * (1-_dur_percent)),2,2, _cb, 0.9);
		draw_sprite_part_ext(sBuffBoxOverlay, 0, 0, (20 * (1-_dur_percent)), sprite_get_width(sBuffBoxOverlay), sprite_get_height(sBuffBoxOverlay) * _dur_percent,_xplace - 20,yy - 20 + (40 * (1-_dur_percent)),2,2, _cb, 0.9);
		draw_sprite_ext(sStatIcons, current_enemy_buffs[i].stat, _xplace, yy, 1, 1, 0, _cb, 1);
	
		if (current_enemy_buffs[i].isNegative){
			draw_sprite_ext(sUIArrow, 0, _xplace + 15, yy - 8, 1, 1, 270, c_red, 1);
		}
		else{
			draw_sprite_ext(sUIArrow, 0, _xplace + 15, yy, 1, 1, 90, c_lime, 1);
		}
	
		if (current_enemy_buffs[i].max_stacks > 1){
			draw_setup();
			draw_text_scribble(_xplace - 20, yy + 10, string(current_enemy_buffs[i].stacks))
		}
	
	}
}




// Show ship stats
var _tab = keyboard_check(vk_tab);
if (_tab){
	draw_setup(font_debug, c_white, fa_left, fa_top);
	var _text = "ATK: " + string(_s.getATK()) + "\nDEF: " + string(_s.getDEF());
	draw_text_scribble(32, 32, _text);
}

