/// @description



for (var k = ds_map_find_first(dstats); !is_undefined(k); k = ds_map_find_next(dstats, k)) {
  var v = dstats[? k];
  ds_list_destroy(v);
}

ds_map_destroy(dstats);