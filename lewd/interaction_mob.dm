/mob/proc/has_hands()
	return FALSE

/mob/living/carbon/human/has_hands()
	return TRUE

/mob/proc/has_mouth()
	return TRUE

/mob/proc/mouth_is_free()
	return TRUE

/mob/proc/foot_is_free()
	return TRUE

/mob/living/carbon/human/mouth_is_free()
	return !wear_mask

/mob/living/carbon/human/foot_is_free()
	return !shoes
