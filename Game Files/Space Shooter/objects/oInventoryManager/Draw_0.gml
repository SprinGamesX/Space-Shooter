/// @description

draw_sprite_stretched_ext(sBackgroundUI, 0, 32, 32, room_width/5 * 3,room_height - 64, c_gray, 1);
draw_sprite_stretched_ext(sBackgroundUI, 0, room_width/5 * 3 + 64, 32, room_width/5 * 2 - 96,room_height - 64, c_gray, 1);

draw_setup(font_hangar);
var _chips = ds_list_size(global.chips);
var _mul = ceil(_chips / 14);

var _inv = GetInventorySection(14 * _mul, 0);
InventorySort(_inv);


var _limit = _mul - 12;
var _factor = 10
if (mouse_wheel_up() and add-_factor < 0){
	add += _factor;
}
if (mouse_wheel_down() and add > (-_limit * 80) + 30){
	add -= _factor;
}


var _index = 0;

var _row_lim = 14;
var _col_lim = _mul;

var yy = 76;
var xx = 88;

for (var _col = 0; _col < _col_lim; _col++){
	xx = 88
	for (var _row = 0; _row < _row_lim; _row++){
		
		var _yy = yy + add;
		
		var _c = c_ltgray;
		if (InRange(mouse_x, xx - 32, xx + 32) and InRange(mouse_y, _yy - 32, _yy + 32)) {
			if (mouse_check_button_pressed(mb_left)) selected_index = _index;
			_c = c_white;
		}
		draw_sprite_ext(sSkillTreeNode, 0, xx, _yy, 1, 1, 0, _c, 1);		
		if (selected_index == _index) draw_sprite_ext(sSkillTreeOutline, 0, xx, _yy, 1, 1, 0, _c, 1);	
		
		// if there are chips
		if (instance_exists(_inv[_index])){
			var _chip = _inv[_index];
			draw_sprite_ext(sChips, _chip.chiptype-1, xx, _yy, 1, 1, 0, GetChipSetColor(_chip.set), 1);
			draw_sprite_ext(sStatIcons, _chip.stat, xx, _yy+4, 1, 1, 0, GetChipSetColor(_chip.set), 1);
		}
		_index++;
		xx += 80;
	}
	 yy += 80
	 
}

if (array_length(_inv) > selected_index and instance_exists(_inv[selected_index])){
	var _chip = _inv[selected_index];
	var xx = 1552;
	draw_text_scribble(1552, 96, "[scale, 3]Chip Info:");
	draw_text_scribble(1552, 160, "Chip Type - " + chr(64 + _chip.chiptype));
	draw_text_scribble(1552, 224,"[scale, 1.5]"+ StatToText(_chip.stat) + " +" + string_format(RoundTo(_chip.scale, 1), log10(_chip.scale), 1) + "%");
	draw_sprite_ext(sChips, _chip.chiptype-1, xx, 352, 4, 4, 0, GetChipSetColor(_chip.set), 1);
	draw_sprite_ext(sStatIcons, _chip.stat, xx, 352+16, 4, 4, 0, GetChipSetColor(_chip.set), 1);
	draw_text_scribble(1552, 480, "SET: " + StatToText(_chip.set));
}

draw_sprite_stretched_ext(sBackgroundUIBorder, 0, 32, 32, room_width/5 * 3,room_height - 64, c_gray, 1);
draw_sprite_stretched_ext(sBackgroundUIBorder, 0, room_width/5 * 3 + 64, 32, room_width/5 * 2 - 96,room_height - 64, c_gray, 1);
draw_sprite_stretched_ext(sPixel, 0, 32, 0, 1151,32, c_black, 1);
draw_sprite_stretched_ext(sPixel, 0, 32, 1048, 1151,32, c_black, 1);

draw_setup(font_hangar,,fa_left, fa_bottom);
draw_text_scribble(32, room_height, "Chips: " + string(ds_list_size(global.chips)) + "/500");