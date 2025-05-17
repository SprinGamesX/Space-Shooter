/// @description
draw_setup(font_menu, c_white,fa_center, fa_top);

draw_text_scribble(room_width/2 + 8, 48 + 8, "[scale, 3][c_black][alpha, 0.75]Space Shooter!");
draw_text_scribble(room_width/2, 48, "[scale, 3][rainbow]Space Shooter!");
selection = -1;
var _space = 96;
for (var i = 0; i < array_length(options); i++){
	
	draw_text_scribble(room_width/2 + 8,256 + _space *i + 8,"[scale, 2][c_black][alpha, 0.75]" + options[i]);
	draw_text_scribble(room_width/2,256 + _space *i,"[scale, 2]" + options[i]);
	
	if (InRange(mouse_y, 256 + _space * i,256 + _space * (i+1))){
		selection = i;
		var _y1 = 256 + _space * i - 16;
		var _y2 = 256 + _space * (i+1) - 24;
		draw_set_alpha(0.5);
		draw_line_width_color(0, _y1, room_width/2, _y1, 5, c_black, c_rainbow);
		draw_line_width_color(0, _y2, room_width/2, _y2, 5, c_black, c_rainbow);
		draw_line_width_color(room_width/2, _y1, room_width, _y1, 5, c_rainbow, c_black);
		draw_line_width_color(room_width/2, _y2, room_width, _y2, 5, c_rainbow, c_black);
		draw_set_alpha(1);
	}
	
}



draw_setup(font_menu, c_white,fa_left, fa_bottom);
draw_text_scribble(16, room_height - 16, "[scale, 0.75]Ver 0.01 - Alpha build");

draw_sprite_stretched_ext(sPixel, 0, 0, 0, room_width, room_height,c_rainbow,0.05);