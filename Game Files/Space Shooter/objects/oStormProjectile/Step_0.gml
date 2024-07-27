/// @description

// Inherit the parent event
event_inherited();
if (radius < max_radius) radius = max_radius * sin(time/100);

rot += rot_spd;

x = base_x + lengthdir_x(radius, rot);
y = base_y + lengthdir_y(radius, rot);

base_x += lengthdir_x(spd, dir);
base_y += lengthdir_y(spd, dir);

direction = rot + 90;

if (time < 100) time++;