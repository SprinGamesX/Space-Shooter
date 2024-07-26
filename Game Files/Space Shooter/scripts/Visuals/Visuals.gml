// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CreateDamageIndicator(_xx, _yy, _text, _element){
	var _inst = instance_create_layer(_xx, _yy, "Misc", oDamageIndicator);
	with(_inst){
		text = _text;
		sc_obj = scribble(text);
		sc_obj.starting_format("font_damage_indicator", ColorForElement(_element));
		sc_obj.align(fa_center, fa_middle);
		typewriter.in(0.5, 2);
	}
	return _inst;
}

function CreateStatIndicator(_ship, _stat, _scale){
	var _inst = noone;
	if (object_is_ancestor(_ship.object_index, oShipObject)){
		var _xy = oGameManager.getShipUiCords(_ship);
		_inst = instance_create_layer(_xy[0], _xy[1], "Misc", oStatIndicator);
	}
	else {
		_inst = instance_create_layer(_ship.x, _ship.y - 32, "Misc", oStatIndicator);
	}
	
	with(_inst){
		text = "[scale, 0.6]" + StatToText(_stat);
		text += (sign(_scale) == -1 ? " -" : " +") + string(abs(_scale*100)) + "%";
		sc_obj = scribble(text);
		sc_obj.starting_format("font_damage_indicator", _scale > 0 ? c_white : c_red);
		sc_obj.align(fa_center, fa_middle);
		typewriter.in(1, 2);
	}
	return _inst;
}

function CreateCustomStatIndicator(_ship, _custom_text, _element){
	var _inst = noone;
	if (object_is_ancestor(_ship.object_index, oShipObject)){
		var _xy = oGameManager.getShipUiCords(_ship);
		_inst = instance_create_layer(_xy[0], _xy[1], "Misc", oStatIndicator);
	}
	else {
		_inst = instance_create_layer(_ship.x, _ship.y - 32, "Misc", oStatIndicator);
	}
	
	with(_inst){
		text = "[scale, 0.6]" + _custom_text;
		sc_obj = scribble(text);
		sc_obj.starting_format("font_damage_indicator", ColorForElement(_element));
		sc_obj.align(fa_center, fa_middle);
		typewriter.in(0.5, 2);
	}
	return _inst;
}

function CreateLaserParticles(_element){
	var _part = part_type_create();
	part_type_sprite(_part, sPixel, 0, 0, 0);
	part_type_color1(_part, ColorForElement(_element));
	part_type_life(_part, seconds(0.8), seconds(1));
	part_type_alpha3(_part, 1, 0.5, 0);
	part_type_orientation(_part, 0, 359, 0.2, false, true);
	part_type_size(_part, 2, 2.5, -0.005, false);
	return _part;
}

function DrawLaserParticle(_ship){
	if (part != undefined){
		var _p = part;
		part_type_speed(_p, 5, 10, -0.05, 0);
		part_type_direction(_p, _ship.direction - 10, _ship.direction + 10, 0, 0);
		part_particles_create(global.battlePartSystem, _ship.x, _ship.y, _p, 3);
	}
}

function CreateProjTrail(_element){
	var _part = part_type_create();
	switch(_element){
		case ELEMENT.ICE:{
			part_type_sprite(_part, sPixel, 0, 0, 0);
			part_type_color3(_part, c_white, c_aqua, c_teal);
			part_type_life(_part, seconds(0.5), seconds(0.75));
			part_type_alpha3(_part, 0.8, 0.5, 0);
			part_type_orientation(_part, 0, 359, 0.2, false, true);
			part_type_size(_part, 1, 1.25, -0.005, false);
		} break;
		case ELEMENT.FIRE:{
			part_type_sprite(_part, sPixel, 0, 0, 0);
			part_type_color3(_part, c_orange, make_color_rgb(255, 100, 61), c_black);
			part_type_life(_part, seconds(0.75), seconds(1));
			part_type_alpha2(_part, 0.75, 0.5);
			part_type_orientation(_part, 0, 359, 1, false, true);
			part_type_size(_part, 1, 1.5, -0.005, false);
		} break;
		case ELEMENT.LIFE:{
			part_type_sprite(_part, sLifeParticle, 0, 0, 0);
			part_type_subimage(_part, irandom(2));
			part_type_life(_part, seconds(0.75), seconds(1));
			part_type_color1(_part, c_white);
			part_type_alpha3(_part, 0.75, 0.6, 0);
			part_type_orientation(_part, 0, 359, 1, false, true);
			part_type_size(_part, 1, 1.5, -0.005, false);
		} break;
	}
	return _part;
}

function DrawProjTrail(_ship){
	if (instance_exists(self)){
		switch(_ship.element){
			case ELEMENT.ICE:{
				var _p = trail;
				part_type_speed(_p, 0.05, 0.08, 0, 0);
				part_type_direction(_p, _ship.direction - 190, _ship.direction - 170, 0, 0);
			
				part_particles_create(global.battlePartSystem, random_range(x - sprite_width/2, x + sprite_width/2), random_range(y - sprite_height/2, y + sprite_height/2), _p, 1);
			} break;
			case ELEMENT.FIRE:{
				var _p = trail;
				part_type_speed(_p, 0.5, 1, -0.01, 0);
				part_type_direction(_p, _ship.direction - 190, _ship.direction - 170, 0, 0);
			
				part_particles_create(global.battlePartSystem, random_range(x - sprite_width/2, x + sprite_width/2), random_range(y - sprite_height/2, y + sprite_height/2), _p, 1);
			} break;
			case ELEMENT.LIFE:{
				var _p = trail;
				part_type_speed(_p, 0.2, 0.5, -0.01, 0);
				part_type_direction(_p, _ship.direction - 200, _ship.direction - 160, 0, 0);
			
			
			
				part_particles_create(global.battlePartSystem, random_range(x - sprite_width/2, x + sprite_width/2), random_range(y - sprite_height/2, y + sprite_height/2), _p, 1);
			} break;
		}
	}
	
}