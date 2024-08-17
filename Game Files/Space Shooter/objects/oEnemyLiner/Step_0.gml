/// @description

// Inherit the parent event
if (stopped) speed = 0;
else if (slowed) speed = getSPD() * 0.05;
else speed = getSPD() ;
event_inherited();
