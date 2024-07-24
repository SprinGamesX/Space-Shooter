// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CreateFollower(_obj_type, _owner, _dix, _diy, _cd, _lifespan, _isFollow = true, _isAim = true){
	
	var _inst = instance_create_depth(_owner.x, _owner.y, _owner.depth-1, _obj_type);
	with (_inst){
		owner = _owner;
		dir = 0;
		disx = _dix;
		disy = _diy;
		cd = _cd;
		cdMax = _cd;
		lifespan = _lifespan;
		isFollow = _isFollow;
		isAim = _isAim;
	}
	
	return _inst;
}