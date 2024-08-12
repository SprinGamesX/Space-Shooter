/// @description


sc_obj.draw(x, y, typewriter);

var typewriter_state = typewriter.get_state();

if (typewriter_state == 1) and (text_state == 1){
	instance_destroy();
}
if (typewriter_state == 1) and (text_state == 0) {
	text_state++;
	typewriter.out(0.2, 3);
	alarm[0] = seconds(3);
}
