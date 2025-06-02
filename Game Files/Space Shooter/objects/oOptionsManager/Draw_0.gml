/// @description Insert description here
// You can write your code in this editor

draw_setup(font_menu, c_white, fa_left, fa_top);

var _settings = ds_map_values_to_array(global.settings);
var _len = array_length(menu_options);

var _text = "";
for (var i = 0; i < _len; i++){
	_text += menu_options[i] + string(_settings[i]) + "\n\n";
}

draw_text_scribble(32, 32, _text);