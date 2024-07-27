/// @description Cleaning and Bordering

// Basic, Alt & Skill
if (a_cd > max_acd) a_cd = max_acd;
if (b_cd > max_bcd) b_cd = max_bcd;
if (s_cd > max_scd) s_cd = max_scd;

if (charge > max_charge) charge = max_charge;
if (hp > getHP()) hp = getHP();
if (shield > getHP()*4) shield = getHP()*4;

// Ultimate Attack
if (energy < 0) energy = 0;
if (energy > max_energy) energy = max_energy;

