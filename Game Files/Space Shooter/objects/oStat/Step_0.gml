/// @description
if (!instance_exists(target)){
	instance_destroy(self);
}

if (time > 0 and !isInfinite) time--;
else if (time <= 0 and instance_exists(target)){
	target.onStatOver(self);
}