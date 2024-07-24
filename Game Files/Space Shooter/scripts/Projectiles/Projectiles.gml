// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CreateLinearProjectile(_sprite, _owner, _x, _y, _spd, _direction, _atk_type, _pierce = 1, _aoe = 1, _spin = false, _trail = true, _echo = false){
	var _inst = instance_create_layer(_x, _y, "Proj", oLinearProjectile);
	with (_inst){
		sprite_index = _sprite;
		speed = _spd;
		direction = _direction;
		image_angle = direction;
		owner = _owner;
		pierce = _pierce;
		aoe = _aoe;
		spin = _spin;
		atk_type = _atk_type;
		
		if (_trail){
			trail = CreateProjTrail(_owner.element);
		}
	}
	return _inst;
}

function CreateLaser(_xx, _yy, _follow, _direction, _length, _attack_type, _aoe, _lifetime, _sprite,_owner = self, _particles = true){
	var _inst = instance_create_layer(_xx, _yy, "Proj", oLaser)
	with(_inst){
		sprite_index = _sprite;
		xx = _xx;
		yy = _yy;
		follow = _follow;
		dir = _direction;
		owner = _owner;
		lifetime = _lifetime;
		aoe = _aoe;
		atk_type = _attack_type;
		length = _length;
		
		if (_particles){
			part = CreateLaserParticles(_owner.element);
		}
		
		image_xscale = (length/sprite_width);
	}
	return _inst;
}

function IsOutOfBounds(_extra){
	return x < -_extra or x > room_width + _extra or y < -_extra or y > room_height + _extra;
}

function GetAoeForElement(_element){
	switch(_element){
		case ELEMENT.ICE: return sAoeIce;
		case ELEMENT.FIRE: return sAoeFire;
		case ELEMENT.LIFE: return sAoeLife;
		case ELEMENT.VENOM: return sAoeVenom;
		case ELEMENT.LIGHTNING: return sAoeLightning;
		case ELEMENT.STEEL: return sAoeSteel;
		case ELEMENT.QUANTUM: return sAoeQuantum;
	}
	return sAoeLightning;
}


function CreateAoe(_owner, _element, _x, _y, _atk_type, _size){
	var _inst = instance_create_layer(_x, _y, "Proj", oAoe)
	with(_inst){
		owner = _owner;
		sprite_index = GetAoeForElement(_element);
		atk_type = _atk_type;
		image_xscale = _size;
		image_yscale = _size;
		image_speed = 1;
	}
	return _inst;
}