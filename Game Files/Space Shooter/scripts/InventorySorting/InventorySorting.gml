// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function InventorySort(_inventory){
	// Set
	// Type
	// Stat
	// Scale
	
	for(var i = 0; i < array_length(_inventory); i++){
		var _swapped1 = false;
		for (var j = 0; j < array_length(_inventory) - 1 - i; j++){
			
			var _i1 = _inventory[j];
			var _i2 = _inventory[j+1];
			
			if (!instance_exists(_i1) or !instance_exists(_i2)) break;
			
			if (CompareChip(_i1, _i2)){
				_inventory[j] = _i2;
				_inventory[j+1] = _i1;
				_swapped1 = true;
			}			
		}
		if (!_swapped1) break;
	}
	
}

function GlobalInventorySort(){
	for(var i = 0; i < ds_list_size(global.chips); i++){
		var _swapped1 = false;
		for (var j = 0; j < ds_list_size(global.chips) - 1 - i; j++){
			
			var _i1 = global.chips[|j];
			var _i2 = global.chips[|j+1];
			
			if (!instance_exists(_i1) or !instance_exists(_i2)) break;
			
			if (CompareChip(_i1, _i2)){
				global.chips[|j] = _i2;
				global.chips[|j+1] = _i1;
				_swapped1 = true;
			}			
		}
		if (!_swapped1) break;
	}
}

function CompareChip(_c1, _c2){
	
	if (_c1.set > _c2.set) return true;
	if (_c1.set == _c2.set and _c1.chiptype > _c2.chiptype) return true;
	if (_c1.set == _c2.set and _c1.chiptype == _c2.chiptype and _c1.stat < _c2.stat) return true;
	if (_c1.set == _c2.set and _c1.chiptype == _c2.chiptype and _c1.stat == _c2.stat and _c1.scale < _c2.scale) return true;
	
	return false;
}