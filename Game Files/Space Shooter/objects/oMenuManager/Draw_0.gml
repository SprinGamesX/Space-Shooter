/// @description
draw_setup(font_menu, c_white,fa_left, fa_top);

draw_text_scribble(32, 32, "[scale, 3][rainbow]Space Shooter!");
selection = -1;
var _space = 96;
for (var i = 0; i < array_length(options); i++){
	if (InRange(mouse_y, 256 + _space * i,256 + _space * (i+1))){
		selection = i;
		var _y1 = 256 + _space * i - 16;
		var _y2 = 256 + _space * (i+1) - 24;
		draw_line_width_color(0, _y1, room_width, _y1, 5, c_purple, c_black);
		draw_line_width_color(0, _y2, room_width, _y2, 5, c_purple, c_black);
	}
	draw_text_scribble(32,256 + _space *i,"[scale, 2]" + options[i]);
}



draw_setup(font_menu, c_white,fa_left, fa_bottom);
draw_text_scribble(16, room_height - 16, "[scale, 0.75]Ver 0.01 - Alpha build")