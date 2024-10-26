// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.ships = [
	noone,
	oShipIce1,
	oShipFire1,
	oShipLife1,
	oShipVenom1,
	oShipLightning1,
	oShipSteel1,
	oShipQuantum1
]

function GetStatsString(_ship){
	var str = "\n";
	str += "\nAtk -> " + string(_ship.getATK());
	str += "\nHP  -> " + string(_ship.getHP());
	str += "\nDEF -> " + string(_ship.getDEF());
	str += "\nSPD -> " + string(_ship.getSPD());
	str += "\n";
	str += "\nASPD         -> " + string((1 + _ship.getStatBonus(STAT.ASPD))*100) + "%";
	str += "\nCRIT RATE    -> " + string((_ship.getStatBonus(STAT.CRIT))*100) + "%";
	str += "\nCRIT DMG     -> " + string((_ship.getStatBonus(STAT.CRITDMG))*100) + "%";
	str += "\nRES          -> " + string((_ship.getStatBonus(STAT.RES))*100) + "%";
	str += "\nENERGY REGEN -> " + string((1 + _ship.getStatBonus(STAT.ENERGYREGEN))*100) + "%";
	str += "\nE.SPECIALTY   -> " + string((_ship.getStatBonus(STAT.ES))*100) + "%";
	str += "\nHEALING BONUS -> " + string((_ship.getStatBonus(STAT.HEALINGBONUS))*100) + "%";
	str += "\n";
	str += "\nBASIC ATTACK BONUS -> " + string((_ship.getStatBonus(STAT.BASICATTACKDMG))*100) + "%";
	str += "\nALT ATTACK BONUS   -> " + string((_ship.getStatBonus(STAT.ALTDMG))*100) + "%";
	str += "\nSKILL BONUS        -> " + string((_ship.getStatBonus(STAT.SKILLDMG))*100) + "%";
	str += "\nULTIMATE BONUS     -> " + string((_ship.getStatBonus(STAT.ULTIMATEDMG))*100) + "%";
	str += "\nBREAK DAMAGE       -> " + string((_ship.getStatBonus(STAT.BREAKDMG))*100) + "%";
	str += "\n";
	str += "\nICE DAMAGE		-> " + string((_ship.getStatBonus(STAT.ICEDMG))*100) + "%";
	str += "\nFIRE DAMAGE		-> " + string((_ship.getStatBonus(STAT.FIREDMG))*100) + "%";
	str += "\nLIFE DAMAGE		-> " + string((_ship.getStatBonus(STAT.LIFEDMG))*100) + "%";
	str += "\nVENOM DAMAGE		-> " + string((_ship.getStatBonus(STAT.VENOMDMG))*100) + "%";
	str += "\nLIGHTNING DAMAGE	-> " + string((_ship.getStatBonus(STAT.LIGHTNINGDMG))*100) + "%";
	str += "\nSTEEL DAMAGE		-> " + string((_ship.getStatBonus(STAT.STEELDMG))*100) + "%";
	str += "\nQUANTUM DAMAGE	-> " + string((_ship.getStatBonus(STAT.QUANTUMDMG))*100) + "%";
	str += "\n";
	str += "\nAMMO    -> " + string((_ship.max_ammo));
	str += "\nRELOAD  -> " + string((reSeconds(_ship.reload_max))) +"s";
	str += "\nCHARGES -> " + string((_ship.max_charge));
	
	return str;
}

function GetStringForRole(_role){
	switch(_role){
		case ROLES.DPS: return "Damage Dealer";
		case ROLES.SUBDPS: return "Sub Damage Dealer";
		case ROLES.BUFFER: return "Buffer";
		case ROLES.DEBUFFER: return "De-Buffer";
		case ROLES.HEALER: return "Healer";
		case ROLES.SHIELDER: return "Shielder";
	}
}

function GetDescriptionForShip(_ship, _abilityId){
	
	switch(_ship.shipId){
		case 1: {
			switch(_abilityId){
				case ATTACK_TYPE.BASIC: return "Basic Attack:\nDeals minor ICE damage";
				case ATTACK_TYPE.ALT: return "Alternative Attack:\nBurst ICE shards that deal minor ICE damage";
				case ATTACK_TYPE.SKILL: return "Skill:\nShoots ICE shards around itself / Special skill enhances all ships ATK";
				case ATTACK_TYPE.ULTIMATE: return "Ultimate:\nShoots a frenzy of ICE shards around itself";
			}
		}
		case 2: {
			switch(_abilityId){
				case ATTACK_TYPE.BASIC: return "Basic Attack:\nDeals minor FIRE damage";
				case ATTACK_TYPE.ALT: return "Alternative Attack:\nAccumilate stacks of Flame when hitting an enemy, when stacks are not full shoot a single fireball, when it is full shoot three fireballs. Fireballs deal major FIRE damage";
				case ATTACK_TYPE.SKILL: return "Skill:\nAccumilate 5 Flame charges, Flame stacks up to 10 stacks";
				case ATTACK_TYPE.ULTIMATE: return "Ultimate:\nIncrease ASPD by 100% for 10 seconds, additionally gain max Flame stacks";
			}
		}
		case 3: {
			switch(_abilityId){
				case ATTACK_TYPE.BASIC: return "Basic Attack:\nDeals minor LIFE damage, each attack will consume HP, HP cannot go lower then 1% that way";
				case ATTACK_TYPE.ALT: return "Alternative Attack:\nHeals all ships for a small amount of HP and gain one charge";
				case ATTACK_TYPE.SKILL: return "Skill:\nHeals itself for a minor amount of HP, if this ship has a full charge bar increase the healing and heal all ships";
				case ATTACK_TYPE.ULTIMATE: return "Ultimate:\nHeal all ships for a major amount of HP, additionally when switching ships give the incoming ship HP bonus and heal it";
			}
		}
		case 4: {
			switch(_abilityId){
				case ATTACK_TYPE.BASIC: return "Basic Attack:\nShoot a bouncing projectile that bounces 2 times deals minor LIGHTNING damage";
				case ATTACK_TYPE.ALT: return "Alternative Attack:\nShoot a homing projectile that deals minor LIGHTNING damage";
				case ATTACK_TYPE.SKILL: return "Skill:\nStrikes the crosshair with multiple piercing projectiles that deal mild LIGHTNING damage";
				case ATTACK_TYPE.ULTIMATE: return "Ultimate:\nShoots a lot of Bouncing projectiles to all sides dealing minor LIGHTNING damage that can pierce the same enemy multiple times";
			}
		}
		case 5: {
			switch(_abilityId){
				case ATTACK_TYPE.BASIC: return "Basic Attack:\nShoot a bouncing projectile that bounces 2 times deals minor LIGHTNING damage";
				case ATTACK_TYPE.ALT: return "Alternative Attack:\nShoot a homing projectile that deals minor LIGHTNING damage";
				case ATTACK_TYPE.SKILL: return "Skill:\nStrikes the crosshair with multiple piercing projectiles that deal mild LIGHTNING damage";
				case ATTACK_TYPE.ULTIMATE: return "Ultimate:\nShoots a lot of Bouncing projectiles to all sides dealing minor LIGHTNING damage that can pierce the same enemy multiple times";
			}
		}
	}
	
	return "This Ability was not yet written...";
}