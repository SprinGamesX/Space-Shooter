/// @description Insert description here
// You can write your code in this editor

show_debug_message(room_get_name(room));

if (room == rEndScreen){
	
	
	draw_obj.starting_format("font_hangar", c_white);
	draw_obj.align(fa_top, fa_left);
	
	draw_obj.draw(32, 32, typewriter);
	
	if(typewriter.get_state() == 1){
		scr_leave_prompt.starting_format("font_hangar", c_white);
		scr_leave_prompt.align(fa_middle, fa_center);
		scribble_anim_pulse(1, 1);
		scr_leave_prompt.draw(room_width/2, room_height - 100, typewriter2);
		scribble_anim_reset();
	}
}

