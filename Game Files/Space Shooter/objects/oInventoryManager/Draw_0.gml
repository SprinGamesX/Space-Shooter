/// @description

draw_sprite_stretched_ext(sBackgroundUI, 0, 32, 32, room_width/5 * 3,room_height - 64, c_gray, 1);
draw_sprite_stretched_ext(sBackgroundUI, 0, room_width/5 * 3 + 64, 32, room_width/5 * 2 - 96,room_height - 64, c_gray, 1);

draw_setup(font_hangar);
draw_text_scribble(room_width/2, room_height - 64, "Chips: " + string(ds_list_size(global.chips)));

var _inv = GetInventorySection(168, 0);

var _index = 0;
for (var yy = 76; yy < room_height - 64; yy += 80){
	for (var xx = 88; xx < room_width/5 * 3; xx += 80;){
		var _c = c_ltgray;
		if (InRange(mouse_x, xx - 32, xx + 32) and InRange(mouse_y, yy - 32, yy + 32)) {
			if (mouse_check_button_pressed(mb_left)) selected_index = _index;
			_c = c_white;
		}
		draw_sprite_ext(sSkillTreeNode, 0, xx, yy, 1, 1, 0, _c, 1);		
		if (selected_index == _index) draw_sprite_ext(sSkillTreeOutline, 0, xx, yy, 1, 1, 0, _c, 1);	
		
		// if there are chips
		if (instance_exists(_inv[_index])){
			var _chip = _inv[_index];
			draw_sprite_ext(sChips, _chip.chiptype-1, xx, yy, 1, 1, 0, GetChipSetColor(_chip.set), 1);
			draw_sprite_ext(sStatIcons, _chip.stat, xx, yy+4, 1, 1, 0, GetChipSetColor(_chip.set), 1);
		}
		_index++;
	}
}

if (instance_exists(_inv[selected_index])){
	var _chip = _inv[selected_index];
	var xx = 1552;
	draw_text_scribble(1552, 96, "[scale, 3]Chip Info:");
	draw_text_scribble(1552, 160, "Chip Type - " + chr(64 + _chip.chiptype));
	draw_text_scribble(1552, 224,"[scale, 1.5]"+ StatToText(_chip.stat) + " +" + string_format(RoundTo(_chip.scale, 1), log10(_chip.scale), 1) + "%");
	draw_sprite_ext(sChips, _chip.chiptype-1, xx, 352, 4, 4, 0, GetChipSetColor(_chip.set), 1);
	draw_sprite_ext(sStatIcons, _chip.stat, xx, 352+16, 4, 4, 0, GetChipSetColor(_chip.set), 1);
	draw_text_scribble(1552, 480, "SET: " + StatToText(_chip.set));
}