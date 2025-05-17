/// @description
image_blend = oMenuManager.c_rainbow;

time++;


x = base_x + cos(time * mov_spd) * radius;
y = base_y + sin(time * mov_spd) * radius;

if (twinkle) image_speed = spd;
else image_speed = 0;