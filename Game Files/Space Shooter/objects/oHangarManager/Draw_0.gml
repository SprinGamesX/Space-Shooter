/// @description
var _alpha = 0.9;
var _s = instance_create_depth(-100, -100, 999, global.ships[ship]);
var _color = ColorForElement(_s.element);
selection = noone;

// Background for ship display
draw_sprite_stretched_ext(sBackgroundUI, 0, 32, 32, 256,256, _color, _alpha);
draw_sprite_ext(sElements, _s.element, 160, 160, 15, 15, 0, c_white, 0.2);
draw_sprite_ext(_s.sprite_index, 0, 160, 160, 2, 2, 0, c_white, 1);
//  ship name, element and rarity
draw_sprite_stretched_ext(sBackgroundUI, 0, 320, 224, 554,64, _color, _alpha);
draw_sprite_stretched_ext(sBackgroundUI, 0, 320, 144, 554,64, _color, _alpha);
draw_setup(font_hangar, c_black, fa_left, fa_middle);
draw_text_scribble(320 + 16, 180, "ROLE: " + GetStringForRole(_s.role));
draw_text_scribble(320 + 16, 260, "CN: " + _s.name);
	


var _color1 = _color;
var _color2 = _color;

if (InRange(mouse_y, 288,352)){
	if (InRange(mouse_x, 24, 88)) {
		selection = HANGARITEM.ARROW_LEFT;
		_color1 = c_white;
	}
	if (InRange(mouse_x, 232, 296)) {
		selection = HANGARITEM.ARROW_RIGHT;
		_color2 = c_white;
	}
}
draw_sprite_ext(sUIArrow, 0, 264, 320,2, 2, 0, _color2, _alpha);
draw_sprite_ext(sUIArrow, 1, 56, 320, 2, 2, 0, _color1, _alpha);

// Background for descriptions
draw_sprite_stretched_ext(sBackgroundUI, 0, 32, room_height/3, room_width/5 *3,room_height/3 * 2 - 32, _color, _alpha);

// Draw stat background
draw_sprite_stretched_ext(sBackgroundUI, 0, room_width/5 * 3 + 64, 32, room_width/5 * 2 - 96,room_height - 64, _color, _alpha);

if (mode == HANGARMODE.DEFAULT){
	// Draw Ship stats
	draw_setup(font_hangar, c_black, fa_left, fa_top);
	draw_text_scribble(room_width/5 * 3 + 80, 48, "Ship Statistics:" + GetStatsString(_s));
	// Draw Descriptions
	var _colorSwitch = _color;
	if (InRange(mouse_y, room_height/3 + 16, room_height/3 + 80) and InRange(mouse_x, room_width/5 * 3 - 48, room_width/5 * 3 + 16)){
		_colorSwitch = c_white;
	}
	
	draw_sprite_ext(sAddDetails, 0, room_width/5 * 3 - 48, room_height/3 + 16, 2, 2, 0, _colorSwitch, 1);
	
	var yy = room_height/3 + 40;
	
	for (var i = 0; i < 4; i++){
		draw_setup(font_hangar, c_black, fa_left, fa_top);
		draw_sprite_ext(sSAbilityButtons, i, 64, yy, 2, 2, 0, _color, 1);
		draw_text_scribble_ext(208, yy, GetDescriptionForShip(_s, i),900);
		yy += 128;
		draw_setup(font_hangar, c_black, fa_center, fa_top);
		switch(i){
			case 0: draw_text_scribble(132, yy + 4, "CD: " + string(reSeconds(_s.max_bcd)) + "s"); break;
			case 1: draw_text_scribble(132, yy + 4, "CD: " + string(reSeconds(_s.max_acd)) + "s"); break;
			case 2: draw_text_scribble(132, yy + 4, "CD: " + string(reSeconds(_s.max_scd)) + "s"); break;
			case 3: draw_text_scribble(132, yy + 4, "E: "  + string(_s.max_energy)); break;
		}
		
		yy += 32;
	}
}

if (mode == HANGARMODE.SKILLS){
	var st = GetShipST(_s.shipId);
	var yy = room_height - 156;
	var _index = 0;
	var _stIndex = 0;
	
	for (var i = 5; i > 0; i--){
		
		var d = (i % 2 == 1);
		
		var xx = room_width / 5 * 3 + 208 + (!d * 192*2);
		
		if (d == 0) d = -1;
		var j = d == 1 ?  0 : 2;
		for (; j >= 0 and j <= 2; j += d){
			var _c = _color;
			var _cnext = _color;
			var _size = ((((j+1) + (5 - i))) % 2 == 1) + 1;
			if (_size == 1) _size += 0.5;
			
			if ( _index > 0 and !global.passives[_s.shipId][_index-1]){
				_c = c_gray;
			}
			if (_c == c_gray) _cnext = _c;
			else if (_index < 14 and !global.passives[_s.shipId][_index]) _cnext = c_gray;
			
			if (j < 2 or i > 1) {
				if (d == 1) draw_line_width_color(xx, yy, j != 2 ? xx + 192*d : xx, j == 2 ? yy - 192 : yy, 4, _c, _cnext);
				if (d == -1)draw_line_width_color(xx, yy, j != 0 ? xx + 192*d : xx, j == 0 ? yy - 192 : yy, 4, _c, _cnext);
			}
			draw_sprite_ext(sSkillTreeNode, 0, xx, yy, _size, _size, 0, _c, 1);
			
			if (_index % 2 == 1){
				draw_sprite_ext(sStatIcons, st[0][_stIndex], xx, yy, 2, 2, 0, _c, 1);
				_stIndex++;
			}
			if (_index == 0 or _index == 4 or _index == 10 or _index == 14){
				draw_sprite_ext(sPassiveIcons, 0, xx, yy, 3, 3, 0, _c, 1);
			}
			if (_index == 2 or _index == 8){
				draw_sprite_ext(sPassiveIcons, 1, xx, yy, 3, 3, 0, _c, 1);
			}
			if (_index == 6 or _index == 12){
				draw_sprite_ext(sPassiveIcons, 2, xx, yy, 3, 3, 0, _c, 1);
			}
			
			if(InRange(mouse_x, xx - 64, xx + 64) and InRange(mouse_y, yy - 64, yy + 64)){
				if (mouse_check_button_pressed(mb_left)){ 
					if (skill_selection != _index){
						show_debug_message("Press" + string(_index));
						skill_selection = _index;
					}
					else {
						if ( _index != 0 and (_index-1 == 0 or global.passives[ship][_index - 2])){
							global.passives[ship][_index-1] = true;
							SavePassives();
							show_debug_message("Unlocked" + string(_index));
						}
					}
				}
				draw_sprite_ext(sSkillTreeOutline, 0, xx, yy, _size, _size, 0, _color, 1);
			}
			xx += 192*d;
			
			
			
			_index++;
		}
		yy -= 192;
		
		
	}
	draw_text_scribble(room_width/5 * 4, room_height - 64, "Index: " + string(skill_selection));
	
	// Descriptions
	draw_setup(font_hangar, c_black, fa_left, fa_top);
	draw_text_scribble(64, room_height/3 + 32, "[scale, 2]Description: ");
	
	// If stat
	if (skill_selection % 2 == 1){
		var _stat = st[0][skill_selection div 2];
		var _scale = st[1][skill_selection div 2];
		draw_text_scribble(64, room_height/3 + 96, StatToText(_stat) + " +" + string(round(_scale * 100)) + "%");
	}
	// If passive
	
	
}

if (mode == HANGARMODE.CHIPS){
	
	var _inv = GetInventorySection(32, 0);
	
	var yy = room_height/3 + 176;
	var _index = 0;
	
	for (var dy = 0; dy < 4 ;dy++){
		var xx = 132;
		for (var dx = 0; dx < 8; dx++){
			
			draw_sprite_ext(sSkillTreeNode, 0, xx, yy, 2, 2, 0, _color, 1);
			if (instance_exists(_inv[_index])){
				var _chip = _inv[_index];
				draw_sprite_ext(sChips, _chip.chiptype-1, xx, yy, 2, 2, 0, GetChipSetColor(_chip.set), 1);
				draw_sprite_ext(sStatIcons, _chip.stat, xx, yy+8, 2, 2, 0, GetChipSetColor(_chip.set), 1);
			}
			
			xx += 136;
			_index++;
		}
		yy += 136;
	}
}


// Draw Icons for skill tree and chips

var _colSkills = _color;
var _colChips = _color;
if (InRange(mouse_x, room_width/5 * 3 - 96,room_width/5 * 3 + 32)){
	if (InRange(mouse_y, 32 ,160)){
		selection = HANGARITEM.BUTTON_SKILLS;
		_colSkills = c_white;
	}
	if (InRange(mouse_y, 192 ,320)){
		selection = HANGARITEM.BUTTON_CHIPS;
		_colChips = c_white;
	}
}

draw_sprite_ext(sHangarButtons, mode != 0 ? 0 : 1, room_width/5 * 3 - 96, 32, 2, 2, 0, _colSkills, _alpha);
draw_sprite_ext(sHangarButtons, mode <= 1 ? 2 : 1, room_width/5 * 3 - 96, 192, 2, 2, 0, _colChips, _alpha);


instance_destroy(_s);