/// @description

//draw_line(x, y, x + lengthdir_x(length, direction), y + lengthdir_y(length, direction));


gpu_set_tex_filter(true);

image_angle = direction;
draw_self();

gpu_set_tex_filter(false);