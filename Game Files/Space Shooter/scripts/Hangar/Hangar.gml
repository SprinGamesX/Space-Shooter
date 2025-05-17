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
	oShipQuantum1,
	oShipIce2
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
				case ATTACK_TYPE.SPECIAL: return "Charge skill:\nWhen fully charged SKILL will shoot more shards around it and increase ATK for all allies";
				case ATTACK_TYPE.ENTRANCE: return "Entrance skill:\nThis ship does not have an ENTRANCE skill";
				case ATTACK_TYPE.EXIT: return "Exit skills:\nThis ship does not have an EXIT skill";
			}
		}
		case 2: {
			switch(_abilityId){
				case ATTACK_TYPE.BASIC: return "Basic Attack:\nDeals minor FIRE damage";
				case ATTACK_TYPE.ALT: return "Alternative Attack:\nShoot a fireball that deals major FIRE damage and consume one CHARGE";
				case ATTACK_TYPE.SKILL: return "Skill:\nAccumilate 5 Flame charges, Flame stacks up to 10 stacks";
				case ATTACK_TYPE.ULTIMATE: return "Ultimate:\nIncrease ASPD by 100% for 10 seconds, additionally gain max Flame stacks";
				case ATTACK_TYPE.SPECIAL: return "Charge skill:\nWhen possessing max CHARGE ALT ATTACK will shoot three fireballs that deal massive FIRE damage";
				case ATTACK_TYPE.ENTRANCE: return "Entrance skill:\nThis ship does not have an ENTRANCE skill";
				case ATTACK_TYPE.EXIT: return "Exit skills:\nThis ship does not have an EXIT skill";
			}
		}
		case 3: {
			switch(_abilityId){
				case ATTACK_TYPE.BASIC: return "Basic Attack:\nDeals minor LIFE damage, each attack will consume HP, HP cannot go lower then 1% that way";
				case ATTACK_TYPE.ALT: return "Alternative Attack:\nHeals all ships for a small amount of HP and gain one charge";
				case ATTACK_TYPE.SKILL: return "Skill:\nHeals itself for a minor amount of HP";
				case ATTACK_TYPE.ULTIMATE: return "Ultimate:\nHeal all ships for a major amount of HP";
				case ATTACK_TYPE.SPECIAL: return "Charge skill:\nWhen possessing max CHARGE SKILL will heal all allies for a major amount of HP";
				case ATTACK_TYPE.ENTRANCE: return "Entrance skill:\nThis ship does not have an ENTRANCE skill";
				case ATTACK_TYPE.EXIT: return "Exit skills:\nGive the incoming ship HP buff and Heal it for a minor amount of HP";
			}
		}
		case 4: {
			switch(_abilityId){
				case ATTACK_TYPE.BASIC: return "Basic Attack:\nDeals minor VENOM damage";
				case ATTACK_TYPE.ALT: return "Alternative Attack:\nBurst missiles that deal minor VENOM damage";
				case ATTACK_TYPE.SKILL: return "Skill:\nFire 5 lasers that deal mild VENOM damage";
				case ATTACK_TYPE.ULTIMATE: return "Ultimate:\nShoots a lot of homing missiles that deal minor VENOM damage";
				case ATTACK_TYPE.SPECIAL: return "Charge skill:\nWhen possessing at least 1 stack of CHARGE every non ULTIMATE skill will apply a DEF debuff to the enemy it hits, if it is ULTIMATE damage it will instead apply a stacking RES debuff that stacks up to 5";
				case ATTACK_TYPE.ENTRANCE: return "Entrance skill:\nThis ship does not have an ENTRANCE skill";
				case ATTACK_TYPE.EXIT: return "Exit skills:\nThis ship does not have an EXIT skill";
			}
		}
		case 5: {
			switch(_abilityId){
				case ATTACK_TYPE.BASIC: return "Basic Attack:\nShoot a bouncing projectile that bounces 2 times deals minor LIGHTNING damage";
				case ATTACK_TYPE.ALT: return "Alternative Attack:\nShoot a homing projectile that deals minor LIGHTNING damage";
				case ATTACK_TYPE.SKILL: return "Skill:\nStrikes the crosshair with multiple piercing projectiles that deal mild LIGHTNING damage";
				case ATTACK_TYPE.ULTIMATE: return "Ultimate:\nShoots a lot of Bouncing projectiles to all sides dealing minor LIGHTNING damage that can pierce the same enemy multiple times";
				case ATTACK_TYPE.SPECIAL: return "Charge skill:\nWhen possessing half of CHARGE using SKILL or ULTIMATE will increase the amount of projectiles fired";
				case ATTACK_TYPE.ENTRANCE: return "Entrance skill:\nThis ship does not have an ENTRANCE skill";
				case ATTACK_TYPE.EXIT: return "Exit skills:\nThis ship does not have an EXIT skill";
			}
		}
		case 6: {
			switch(_abilityId){
				case ATTACK_TYPE.BASIC: return "Basic Attack:\nDeals minor STEEL damage";
				case ATTACK_TYPE.ALT: return "Alternative Attack:\nGain a small shield based on DEF and gain one stack of CHARGE";
				case ATTACK_TYPE.SKILL: return "Skill:\nGive all allies a shield based on a minor amount of DEF and gain 3 stacks of CHARGE";
				case ATTACK_TYPE.ULTIMATE: return "Ultimate:\nGive all allies a shield based on a major amount of DEF and gain max CHARGE";
				case ATTACK_TYPE.SPECIAL: return "Charge skill:\nWhen possessing one or more CHARGE the next BASIC ATTACK will deal increased damage and have increased AOE";
				case ATTACK_TYPE.ENTRANCE: return "Entrance skill:\nThis ship does not have an ENTRANCE skill";
				case ATTACK_TYPE.EXIT: return "Exit skills:\nThis ship does not have an EXIT skill";
			}
		}
		case 7: {
			switch(_abilityId){
				case ATTACK_TYPE.BASIC: return "Basic Attack:\nDeals minor QUANTUM damage";
				case ATTACK_TYPE.ALT: return "Alternative Attack:\nSummon a laser that deals minor QUANTUM damage";
				case ATTACK_TYPE.SKILL: return "Skill:\nShoot 3 homing missiles that deal mild QUANTUM damage and bounces between 3 enemies";
				case ATTACK_TYPE.ULTIMATE: return "Ultimate:\nShoot a tornado that deals minor QUANTUM damage";
				case ATTACK_TYPE.SPECIAL: return "Charge skill:\nWhen BREAKING an enemy gain one stack of CHARGE, when possessing 3 stacks give all allies BREAK buff";
				case ATTACK_TYPE.ENTRANCE: return "Entrance skill:\nThis ship does not have an ENTRANCE skill";
				case ATTACK_TYPE.EXIT: return "Exit skills:\nThis ship does not have an EXIT skill";
			}
		}
		case 8: {
			switch(_abilityId){
				case ATTACK_TYPE.BASIC: return "Basic Attack:\nDeals minor ICE damage, can also pierce 2 enemies";
				case ATTACK_TYPE.ALT: return "Alternative Attack:\nSummon a shurikan that deals minor ICE damage and bounces 2 times";
				case ATTACK_TYPE.SKILL: return "Skill:\nShoot 5 homing shurikans that deal mild ICE damage and pierces 2 enemies";
				case ATTACK_TYPE.ULTIMATE: return "Ultimate:\nShoot an ICE shard that deals major ICE damage and pierces 2 enemies, additionally for each stack of charge gain ICE damage bonus";
				case ATTACK_TYPE.SPECIAL: return "Charge skill:\nWhen any ship deals ICE damage to an enemy gain 1 stack of charge, this has a 1s cooldown";
				case ATTACK_TYPE.ENTRANCE: return "Entrance skill:\nThis ship does not have an ENTRANCE skill";
				case ATTACK_TYPE.EXIT: return "Exit skills:\nThis ship does not have an EXIT skill";
			}
		}
	}
	
	return "This ship does not possess this abilty";
}


function GetPassiveDescriptions(_ship, _pass_index){
	switch(_ship.shipId){
		case 1: {
			switch(_pass_index){
				case 0: return "Base";
				case 2: return "BOOST:\nIncrease ATK of this ship by 20%";
				case 4: return "Passive:\nIncrease ICE DMG of all ships in the party by 10%";
				case 6: return "MASTERY:\nIncrease the DMG dealt by ALT ATTACK by 25%";
				case 8: return "BOOST:\nIncrease ENERGY REGEN by 15%";
				case 10: return "Passive:\nSwitching to another ship when CHARGE is full increases its ICE DMG by 50% for 10s";
				case 12: return "MASTERY:\nIncrease the DMG dealt by ULTIMATE by 25%";
				case 14: return "Passive:\nWhen hitting an enemy with SKILL or ULTIMATE reduce its ICE RES by 10% for 15s";
			}
		}
		case 2: {
			switch(_pass_index){
				case 0: return "Base";
				case 2: return "BOOST:\nIncrease ATK of this ship by 20%";
				case 4: return "Passive:\nGain a stackable 5% ATK buff for each fireball hit up to 15% for 5s";
				case 6: return "MASTERY:\nIncrease the DMG dealt by ALT ATTACK by 25%";
				case 8: return "BOOST:\nIncrease CRIT DMG by 18%";
				case 10: return "Passive:\nGain a 40% ATK buff for the first 30s of the battle";
				case 12: return "MASTERY:\nIncrease the DMG dealt by SKILL by 25%";
				case 14: return "Passive:\nWhen an enemy is killed gain 15% CRIT RATE for 5s";
			}
		}
		case 3: {
			switch(_pass_index){
				case 0: return "Base";
				case 2: return "BOOST:\nIncrease HP of this ship by 20%";
				case 4: return "Passive:\nGain 20 energy when activating ULTIMATE";
				case 6: return "MASTERY:\nIncrease the DMG dealt by BASIC ATTACK by 25%";
				case 8: return "BOOST:\nIncrease HEALING BONUS by 25%";
				case 10: return "Passive:\nWhen using SKILL give all allies 15% RES for 10s";
				case 12: return "MASTERY:\nIncrease the HEALING of ULTIMATE by 15%";
				case 14: return "Passive:\nHitting an enemy with BASIC ATTACK heals all allies(excluding self) for the HP lost for that attack";
			}
		}
		case 4: {
			switch(_pass_index){
				case 0: return "Base";
				case 2: return "BOOST:\nIncrease ATK of this ship by 20%";
				case 4: return "Passive:\nIncrease all ships DOT damage by 50%";
				case 6: return "MASTERY:\nIncrease the DMG dealt by ALT ATTACK by 25%";
				case 8: return "BOOST:\nIncrease VENOM DMG by 25%";
				case 10: return "Passive:\nUsing ULTIMATE increases all ships ATK by 10% and VENOM DMG by 10% for 20s";
				case 12: return "MASTERY:\nIncrease the DMG dealt of ULTIMATE by 25%";
				case 14: return "Passive:\nHitting an enemy with ULTIMATE applies POISON to the enemy that deals VENOM DMG equal to 30% ATK";
			}
		}
		case 5: {
			switch(_pass_index){
				case 0: return "Base";
				case 2: return "BOOST:\nIncrease ATK of this ship by 20%";
				case 4: return "Passive:\nBasic Attacks bounce 1 additional time";
				case 6: return "MASTERY:\nIncrease the DMG dealt by BASIC ATTACK by 25%";
				case 8: return "BOOST:\nIncrease CRIT DMG by 18%";
				case 10: return "Passive:\nUsing Enhanced SKILL or ULTIMATE increases LIGHTNING DMG by 10% for 20s stacking up to 2 stacks";
				case 12: return "MASTERY:\nIncrease the DMG dealt of SKILL by 25%";
				case 14: return "Passive:\nReduce the cooldown of SKILL by 5s";
			}
		}
		case 6: {
			switch(_pass_index){
				case 0: return "Base";
				case 2: return "BOOST:\nIncrease DEF of this ship by 20%";
				case 4: return "Passive:\nEnhanced BASIC ATTACK now increases DEF by 20% for 5s";
				case 6: return "MASTERY:\nIncrease the DMG dealt by BASIC ATTACK by 25%";
				case 8: return "BOOST:\nIncrease RES by 10%";
				case 10: return "Passive:\nUsing SKILL increases all allies DEF by 40% for 15s";
				case 12: return "MASTERY:\nIncrease the DMG dealt of BASIC ATTACK by 25%";
				case 14: return "Passive:\nShields supplied by this ship will now be multiplied by the amount of RES this ship has";
			}
		}
		case 7: {
			switch(_pass_index){
				case 0: return "Base";
				case 2: return "BOOST:\nIncrease ATK of this ship by 20%";
				case 4: return "Passive:\nWhen an enemy breaks, gain 15% BREAK DMG for 10s";
				case 6: return "MASTERY:\nIncrease the DMG dealt by ALT ATTACK by 25%";
				case 8: return "BOOST:\nIncrease BREAK DMG by 30%";
				case 10: return "Passive:\nIncrease all allies BREAK EFFECT by 10%";
				case 12: return "MASTERY:\nIncrease the DMG dealt of ULTIMATE by 25%";
				case 14: return "Passive:\nWhen an enemy breaks deal additional damage to it based on 50% BREAK DMG";
			}
		}
		case 8: {
			switch(_pass_index){
				case 0: return "Base";
				case 2: return "BOOST:\nIncrease ATK of this ship by 20%";
				case 4: return "Passive:\nSkill shoots 2 additional shurikans";
				case 6: return "MASTERY:\nIncrease the DMG dealt by BASIC ATTACK by 25%";
				case 8: return "BOOST:\nIncrease CRIT RATE by 9%";
				case 10: return "Passive:\nEach stack of charge increases ATK by 2%";
				case 12: return "MASTERY:\nIncrease the DMG dealt of ULTIMATE by 25%";
				case 14: return "Passive:\nIncrease the damage multiplier of ULTIMATE by 250%";
			}
		}
	}
	return "";
}