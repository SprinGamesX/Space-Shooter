/// @description
draw_self();
// x-132, y-156

var dir = 0;
var _target = oGameManager.getActive();
if (instance_exists(_target)){
	dir = point_direction( x + lengthdir_x(200,head_dir+130), y + lengthdir_y(200,head_dir+130), _target.x, _target.y);
}

draw_sprite_ext(sGolonEye, 0, x + lengthdir_x(200,head_dir+130), y + lengthdir_y(200,head_dir+130), 1, 1, dir-180, c_white, 1);

if (eye_flash){
	draw_sprite_ext(sGolonEyeFlash, floor(eye_frame), x + lengthdir_x(200,head_dir+130), y + lengthdir_y(200,head_dir+130), 1, 1, 0, c_white, 1);
	eye_frame += 0.1;
	if (eye_frame >= 5) {
		eye_flash = false;
		eye_frame = 0;
	}
}