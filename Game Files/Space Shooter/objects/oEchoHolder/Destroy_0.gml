/// @description
for (var i = 0; i < ds_list_size(echo_type_list); i++){
	if (part_type_exists(echo_type_list[|i])){
		part_type_destroy(echo_type_list[|i]);
	}
}
ds_list_destroy(echo_type_list);