#define CUM_TARGET_MOUTH "mouth"
#define CUM_TARGET_THROAT "throat"
#define CUM_TARGET_VAGINA "vagina"
#define CUM_TARGET_ANUS "anus"
#define CUM_TARGET_HAND "hand"
#define CUM_TARGET_BREASTS "breasts"
#define GRINDING_FACE_WITH_ANUS "faceanus"
#define GRINDING_FACE_WITH_FEET "facefeet"
#define GRINDING_MOUTH_WITH_FEET "mouthfeet"

#define NORMAL_LUST 10
#define LOW_LUST 1

/*--------------------------------------------------
  -------------------MOB STUFF----------------------
  --------------------------------------------------
 */
/mob/living
	var/more_lewd_erp = TRUE //tell admins if you want to erp, set this to 1
	var/sexual_potency = 0
	var/lust_tolerance = 100
	var/lust = 0
	var/multiorgasms = 0
	var/refactory_period = 0
	var/lastmoan
	var/moan
	var/last_partner
	var/last_orifice
	var/fucked_amt = 0 //important vv reasons
	var/fucking_someone_amt = 0

/mob/living/carbon/human/New()
	. = ..()
	sexual_potency = (prob(80) ? rand(9, 17) : pick(rand(5, 13), rand(15, 25)))
	lust_tolerance = (prob(80) ? rand(150, 300) : pick(rand(10, 100), rand(350,600)))

/mob/living/Life()
	if(fucked_amt == 150)
		to_chat(world, "<span class='userdanger'><b>[src]</b> has been fucked [fucked_amt] times.</span>")

	if(refactory_period)
		refactory_period--
	return
		..()

/mob/living/proc/is_groin_exposed(var/list/L)
	if(!L)
		L = get_equipped_items()
	for(var/obj/item/I in L)
		if(I.body_parts_covered & GROIN)
			return 0
	return 1

/mob/living/proc/is_chest_exposed(var/list/L)
	if(!L)
		L = get_equipped_items()
	for(var/obj/item/I in L)
		if(I.body_parts_covered & CHEST)
			return 0
	return 1

/mob/living/proc/has_penis()
	return (gender == MALE)

/mob/living/proc/has_vagina()
	return (gender == FEMALE)

/mob/living/proc/has_breasts()
	return (gender == FEMALE)

/mob/living/proc/has_anus()
	return TRUE

/mob/living/list_interaction_attributes()
	var/dat = ..()
	if(refactory_period >= 1)
		dat += "<br>...are sexually exhausted for the time being."
	if(is_chest_exposed() && is_groin_exposed())
		dat += "<br>...are naked."
		if(has_breasts() && is_chest_exposed())
			dat	+= "<br>...have breasts."
		if(has_penis() && is_groin_exposed())
			dat += "<br>...have a penis."
		if(has_vagina() && is_groin_exposed())
			dat += "<br>...have a vagina."
		if(has_anus() && is_groin_exposed())
			dat += "<br>...have an anus."
	else
		dat += "<br>...are clothed."
	return dat

/mob/proc/cum_splatter(target)
	new /obj/effect/decal/cleanable/cum(get_turf(target))
	//C.add_blood_DNA(list(data["blood_DNA"] = data["blood_type"]))

/mob/living/proc/moan()
	if(!(prob(lust / lust_tolerance * 65)))
		return
	if(moan == lastmoan)
		moan--
	if(can_speak_vocal())
		visible_message("<font color=purple><B>\The [src]</B> [pick("moans", "moans in pleasure",)].</font>")
		playsound(get_turf(src), "code/game/lewd/sound/interactions/moan_[gender == FEMALE ? "f" : "m"][rand(1, 7)].ogg", 70, 1, 0)
	if(!can_speak_vocal())
		src.emote("<font color=purple><B>[src]</B> [pick("mimes a pleasured moan","moans in silence")].</font>")

	lastmoan = moan

/mob/living/proc/cum(mob/living/partner, target_orifice)
	var/message
	var/arms = partner.get_num_arms()

	if(has_penis() && is_groin_exposed())
		if(!istype(partner))
			target_orifice = null

		switch(target_orifice)
			if(CUM_TARGET_MOUTH)
				if(partner.is_mouth_covered())
					message = "cums right in \the [partner]'s mouth."
					partner.reagents.add_reagent("cum", rand(8, 11))
				else
					message = "cums on \the [partner]'s face."
					partner.reagents.add_reagent("cum", rand(2, 7))
			if(CUM_TARGET_THROAT)
				if(partner.is_mouth_covered())
					message = "shoves deep into \the [partner]'s throat and cums."
					partner.reagents.add_reagent("cum", rand(10, 16))
				else
					message = "cums on \the [partner]'s face."
					partner.reagents.add_reagent("cum", rand(2, 7))
			if(CUM_TARGET_VAGINA)
				if(partner.is_groin_exposed() && partner.has_vagina())
					message = "cums in \the [partner]'s pussy."
					partner.reagents.add_reagent("cum", rand(10, 15))
				else
					message = "cums on \the [partner]'s belly."
			if(CUM_TARGET_ANUS)
				if(partner.is_groin_exposed() && partner.has_anus())
					message = "cums in \the [partner]'s asshole."
					partner.reagents.add_reagent("cum", rand(10, 15))
				else
					message = "cums on \the [partner]'s backside."
			if(CUM_TARGET_HAND)
				if(arms > 0)
					message = "cums in \the [partner]'s hand."
				else
					message = "cums on \the [partner]."
			if(CUM_TARGET_BREASTS)
				if(partner.is_chest_exposed() && partner.has_vagina())
					message = "cums onto \the [partner]'s breasts."
				else
					message = "cums on \the [partner]'s chest and neck."
			else
				message = "cums on the floor!"
		lust = 5
		lust_tolerance += 50

	else
		message = pick("cums violently!", "twists in orgasm.")
		lust -= rand(10, 20)
	if(gender == MALE)
		playsound(loc, "code/game/lewd/sound/interactions/final_m[rand(1, 3)].ogg", 90, 1, 0)
	else if(gender == FEMALE)
		playsound(loc, "code/game/lewd/sound/interactions/final_f[rand(1, 5)].ogg", 70, 1, 0)

	visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
	multiorgasms += 1

	if(multiorgasms > (sexual_potency*0.34)) //accurate enough, i dont want to get -0 in these
		refactory_period = 100 - sexual_potency //sex cooldown
		src.set_drugginess(rand(30, 40))
	else
		refactory_period = 100 - sexual_potency
		src.set_drugginess(6)

/mob/living/carbon/human/cum(mob/living/partner, target_orifice)
	if(multiorgasms < sexual_potency)
		cum_splatter((gender == MALE && partner) ? partner : src)
	. = ..()

/mob/living/proc/is_fucking(mob/living/partner, orifice)
	if(partner == last_partner && orifice == last_orifice)
		return TRUE
	return FALSE

/mob/living/proc/set_is_fucking(mob/living/partner, orifice)
	last_partner = partner
	last_orifice = orifice

/mob/living/proc/do_fucking_animation(fuckdir)
	if(!fuckdir)
		return

	dir = fuckdir
	var/pixel_x_diff = 0
	var/pixel_y_diff = 0
	var/final_pixel_y = initial(pixel_y)

	if(fuckdir & NORTH)
		pixel_y_diff = 8
	else if(fuckdir & SOUTH)
		pixel_y_diff = -8

	if(fuckdir & EAST)
		pixel_x_diff = 8
	else if(fuckdir & WEST)
		pixel_x_diff = -8

	if(pixel_x_diff == 0 && pixel_y_diff == 0)
		pixel_x_diff = rand(-3,3)
		pixel_y_diff = rand(-3,3)
		animate(src, pixel_x = pixel_x + pixel_x_diff, pixel_y = pixel_y + pixel_y_diff, time = 2)
		animate(pixel_x = initial(pixel_x), pixel_y = initial(pixel_y), time = 2)
		return

	animate(src, pixel_x = pixel_x + pixel_x_diff, pixel_y = pixel_y + pixel_y_diff, time = 2)
	animate(pixel_x = initial(pixel_x), pixel_y = final_pixel_y, time = 2)

/*--------------------------------------------------
  -----------INTERACTION LEWD DATUM-----------------
  --------------------------------------------------
 */

/datum/interaction/lewd
	command = "assslap"
	description = "Slap their ass."
	simple_message = "USER slaps TARGET right on the ass!"
	simple_style = "danger"
	interaction_sound = 'sound/weapons/slap.ogg'
	needs_physical_contact = TRUE
	max_distance = 1

	var/user_not_tired
	var/target_not_tired

	var/require_user_naked
	var/require_target_naked

	var/require_user_penis
	var/require_user_anus
	var/require_user_vagina

	var/require_target_penis
	var/require_target_anus
	var/require_target_vagina

	var/user_refactory_cost
	var/target_refactory_cost

/datum/interaction/lewd/evaluate_user(mob/living/user, silent = TRUE)
	if(..(user, silent))
		if(user_not_tired && user.refactory_period >= 1)
			to_chat(user, "<span class='warning'>You're still exhausted from the last time.</span>")
			return FALSE
		if(require_user_naked && !user.is_groin_exposed() && !user.is_chest_exposed())
			if(!silent)
				to_chat(user, "<span class = 'warning'>Your clothes are in the way.</span>")
			return FALSE
		if(require_user_penis && !user.has_penis())
			if(!silent)
				to_chat(user, "<span class = 'warning'>You don't have a penis.</span>")
			return FALSE
		if(require_user_anus && !user.has_anus())
			if(!silent)
				to_chat(user, "<span class = 'warning'>You don't have an anus.</span>")
			return FALSE
		if(require_user_vagina && !user.has_vagina())
			if(!silent)
				to_chat(user, "<span class = 'warning'>You don't have a vagina.</span>")
			return FALSE
		return TRUE
	return FALSE

/datum/interaction/lewd/evaluate_target(mob/user, mob/living/target, silent = TRUE)
	if(..(user, target, silent))
		if(target_not_tired && target.refactory_period >= 1)
			to_chat(user, "<span class='warning'>They're still exhausted from the last time.</span>")
			return FALSE
		if(require_target_naked && !target.is_groin_exposed() && !target.is_chest_exposed())
			if(!silent)
				to_chat(user, "<span class = 'warning'>Their clothes are in the way.</span>")
			return FALSE
		if(require_target_penis && !target.has_penis())
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have a penis.</span>")
			return FALSE
		if(require_target_anus && !target.has_anus())
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have an anus.</span>")
			return FALSE
		if(require_target_vagina && !target.has_vagina())
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have a vagina.</span>")
			return FALSE
		return TRUE
	return FALSE

/datum/interaction/lewd/post_interaction(mob/living/user, mob/living/target)
	if(user_refactory_cost)
		user.refactory_period += user_refactory_cost
	if(target_refactory_cost)
		target.refactory_period += target_refactory_cost
	return ..()

/datum/interaction/lewd/get_action_link_for(mob/living/user, mob/living/target)
	return "<font color='#FFADFF'><b>LEWD:</b></font> [..()]"
	if(user.stat == DEAD)
		return
