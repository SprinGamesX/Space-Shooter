/// @description
hit_list = ds_list_create();
part = noone;

destruction = function(){
	image_alpha -= 0.05;
	if (image_alpha <= 0) instance_destroy();
}