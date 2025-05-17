/// @description
ARR_SIZE = 100;
inds = array_create(ARR_SIZE, noone);
idle_index = ds_queue_create();
count = 0;


add_indicator = function(){
	// Creates new damage indicators
	if (count < ARR_SIZE){
		var _inst = instance_create_layer(-200, -200, "Misc", oDamageIndicator);
		_inst.index = count;
		inds[count] = _inst;
		count++;
		return _inst;
	}
	return noone;
}

assign_indicator = function(_xx, _yy, _text, _element, _size = 1){
	// Activate inactive indicators
	var _inst = noone;
	if (ds_queue_empty(idle_index)){
		_inst = add_indicator()
	}
	else{
		_inst = inds[ds_queue_dequeue(idle_index)];
	}
	
	if (_inst != noone){
		with (_inst){
			typewriter.reset();
			typewriter.ease(SCRIBBLE_EASE.CIRC, 0, -32, 0, 0, 0 ,1);
			text_state = 0;
			text = _text;
			sc_obj = scribble(text);
			sc_obj.scale(_size);
			sc_obj.starting_format("font_damage_indicator", ColorForElement(_element));
			sc_obj.align(fa_center, fa_middle);
			typewriter.in(0.5, 2);
			active = true;
			x = _xx;
			y = _yy;
		}
	}
	else {
		show_debug_message("Couldn't create indicator");
	}
	
}

release_indicator = function(_index){
	ds_queue_enqueue(idle_index, _index);
}