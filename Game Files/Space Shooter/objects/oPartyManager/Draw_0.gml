/// @description

var xx = 128;

var _s = instance_create_depth(-999, -999, 99, global.ships[global.party[selection]]);



for (var i = 0; i < array_length(global.party); i++){
	
	var _s1 = instance_create_depth(-999, -999, 99, global.ships[global.party[i]]);
	
	if (mouse_check_button_pressed(mb_left) and InRange(mouse_x, (xx + i*256) - 96,(xx + i*256) + 96) and InRange(mouse_y, 128 - 96,128 + 96)){
		selection = i;
		instance_destroy(_s);
		_s = instance_create_depth(-999, -999, 99, global.ships[global.party[selection]]);
		ship_selection = _s.shipId - 1;
	}
	
	draw_sprite_ext(sSkillTreeNode, 0, xx + i*256, 128, 3, 3, 0, ColorForElement(_s1.element), 1);
	draw_sprite_ext(_s1.sprite_index, 0, xx + i*256, 128, 3, 3, 0, c_white, 1);
	
	if (selection == i){
		draw_sprite_ext(sSkillTreeOutline, 0, xx + i*256, 128, 3, 3, 0, c_white, 1);
	}
	
	instance_destroy(_s1);
}

draw_sprite_stretched_ext(sBackgroundUI, 0, room_width / 5 * 3, 32, room_width / 5 * 2 - 64, room_height - 64, c_gray, 1);

xx = room_width / 5 * 3 + 96;
var yy = 144;
for (var i = 0; i < 24; i++){
	var _s2 = noone;
	if (i < array_length(global.ships)-1){
		_s2 = instance_create_depth(-999, -999, 99, global.ships[i+1]);
		if (mouse_check_button_pressed(mb_left) and InRange(mouse_x, (xx) - 64,(xx) + 64) and InRange(mouse_y, yy - 64,yy + 64)){
			ship_selection = i;
		}
	}
	var _color = c_dkgray;
	if (instance_exists(_s2)){
		_color = ColorForElement(_s2.element);
	}
	
	draw_sprite_ext(sSkillTreeNode, 0, xx, yy, 2, 2, 0, _color, 1);
	if (instance_exists(_s2)) draw_sprite_ext(_s2.sprite_index, 0, xx, yy, 1, 1, 0, c_white, 1);
	if (i = ship_selection) draw_sprite_ext(sSkillTreeOutline, 0, xx, yy, 2, 2, 0, _color, 1);
	xx += 160;
	if (i % 4 == 3) {
		xx = room_width / 5 * 3 + 96;
		yy += 160;
	}
	instance_destroy(_s2);
}

instance_destroy(_s);