/datum/interaction/handshake
	command = "handshake"
	description = "Shake their hand."
	simple_message = "USER shakes the hand of TARGET."
	require_user_hands = TRUE
	needs_physical_contact = TRUE

/datum/interaction/headpat
	command = "headpat"
	description = "Pat their head. Aww..."
	require_user_hands = TRUE
	simple_message = "USER headpats TARGET!"
	needs_physical_contact = TRUE
/*
/datum/interaction/nothing
	command = "nothing"
	description = "do nothing"
	interaction_sound = 'sound/effects/adminhelp.ogg'
	simple_message = "USER got bwoinked for not moving."
*/