// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum ATTACK_TYPE{
	BASIC = 0,
	ALT = 1,
	SKILL = 2,
	ULTIMATE = 3,
	SPECIAL = 4,
	ENTRANCE = 5,
	EXIT = 6,
	FOLLOWUP = 7
}

function GetDamageBonus(_element, _attribute){
	var _bonus = 0;
	switch(_element){
		case ELEMENT.ICE: _bonus += getStatBonus(STAT.ICEDMG); break;
		case ELEMENT.FIRE: _bonus += getStatBonus(STAT.FIREDMG); break;
		case ELEMENT.LIFE: _bonus += getStatBonus(STAT.LIFEDMG); break;
		case ELEMENT.VENOM: _bonus += getStatBonus(STAT.VENOMDMG); break;
		case ELEMENT.LIGHTNING: _bonus += getStatBonus(STAT.LIGHTNINGDMG); break;
		case ELEMENT.STEEL: _bonus += getStatBonus(STAT.STEELDMG); break;
		case ELEMENT.QUANTUM: _bonus += getStatBonus(STAT.QUANTUMDMG); break;
	}
	switch(_attribute){
		case ATTACK_TYPE.BASIC: _bonus += getStatBonus(STAT.BASICATTACKDMG); break;
		case ATTACK_TYPE.ALT: _bonus += getStatBonus(STAT.ALTDMG); break;
		case ATTACK_TYPE.SKILL: _bonus += getStatBonus(STAT.SKILLDMG); break;
		case ATTACK_TYPE.ULTIMATE: _bonus += getStatBonus(STAT.ULTIMATEDMG); break;
		case ATTACK_TYPE.FOLLOWUP: _bonus += getStatBonus(STAT.FOLLOWUPDMG); break;
	}
	
	return _bonus;
	
}