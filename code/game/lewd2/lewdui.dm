/*--------------------------------------------------
  -------------------UI STUFF-----------------------
  --------------------------------------------------
*/
var/list/interactions
/*
/mob/living/carbon/human/ShiftClick(mob/user)
	. = ..()
	if(user in orange(src, 1) && isliving(user))
		user.try_interaction(src)
*/

/mob/living/verb/interact_with()
	set name = "Interact With"
	set desc = "Perform an interaction with someone."
	set category = "IC"
	set src in view()

	if(usr != src && !usr.restrained() && isliving(usr)) //*dab
		usr.try_interaction(src)

	if(!isliving(usr))
		to_chat(usr, "You must be alive to use this!")
		return

/proc/make_interactions(interaction)
	if(!interactions)
		interactions = list()
		for(var/itype in typesof(/datum/interaction)-/datum/interaction)
			var/datum/interaction/I = new itype()
			interactions[I.command] = I

/mob/living/proc/try_interaction()
	return

/mob/living/proc/list_interaction_attributes(mob/living/user)
	var/dat = ""
	if(user.get_num_arms() > 0)
		dat += "...have hands."
	if(!user.wear_mask)
		if(dat != "")
			dat += "<br>"
		dat += "...have a mouth, which is uncovered."
	else
		dat += "...have a mouth, which is covered."
	return dat

/mob/living/carbon/human/MouseDrop_T(mob/living/M as mob, mob/living/user as mob)
	if(M == src || src == usr || M != usr)
		return
	if(usr.restrained())
		return

	user.try_interaction(src)

/mob/living/carbon/human/try_interaction(mob/living/partner)
	var/dat = "<B><HR><FONT size=3>Interacting with \the [partner]...</FONT></B><HR>"

	dat += "You...<br>[list_interaction_attributes()]<hr>"
	dat += "They...<br>[partner.list_interaction_attributes()]<hr>"

	make_interactions()
	for(var/interaction_key in interactions)
		var/datum/interaction/I = interactions[interaction_key]
		if(I.evaluate_user(src) && I.evaluate_target(src, partner))
			dat += I.get_action_link_for(src, partner)

	var/datum/browser/popup = new(usr, "interactions", "Interactions", 340, 480)
	popup.set_content(dat)
	popup.open()

/*--------------------------------------------------
  --------------INTERACTION DATUM-------------------
  --------------------------------------------------
 */

/datum/interaction
	var/command = "interact"
	var/description = "Interact with them."
	var/simple_message
	var/simple_style = "notice"

	var/interaction_sound

	var/max_distance = 1
	var/require_user_mouth
	var/require_user_hands
	var/require_target_mouth
	var/require_target_hands
	var/needs_physical_contact

/datum/interaction/proc/evaluate_user(mob/living/user, silent = TRUE)
	if(require_user_mouth)
		if(!user.wear_mask)
			if(!silent)
				to_chat(user, "<span class = 'warning'>Your mouth is covered.</span>")
			return FALSE
	if(require_user_hands && user.get_num_arms() < 1)
		if(!silent)
			to_chat(user, "<span class = 'warning'>You don't have hands.</span>")
		return FALSE
	return TRUE

/datum/interaction/proc/evaluate_target(mob/living/user, mob/living/target, silent = TRUE)
	if(require_target_mouth)
		if(!target.wear_mask)
			if(!silent)
				to_chat(user, "<span class = 'warning'>Their mouth is covered.</span>")
			return FALSE
	if(require_target_hands && target.get_num_arms() < 1)
		if(!silent)
			to_chat(user, "<span class = 'warning'>They don't have hands.</span>")
		return FALSE
	return TRUE

/datum/interaction/proc/get_action_link_for(mob/living/user, mob/living/target)
	return "<a href='?src=\ref[src];action=1;action_user=\ref[user];action_target=\ref[target]'>[description]</a><br>"
		//pls dont abuse this href! thanks
/datum/interaction/Topic(href, href_list)
	if(..())
		return TRUE
	if(href_list["action"])
		do_action(locate(href_list["action_user"]), locate(href_list["action_target"]))
		return TRUE
	return FALSE

/datum/interaction/proc/do_action(mob/living/user, mob/living/target)
	if(get_dist(user, target) > max_distance)
		user.visible_message("<span class='warning'>They are too far away.</span>")
		return
	if(needs_physical_contact && !(user.Adjacent(target) && target.Adjacent(user)))
		user.visible_message("<span class='warning'>You cannot get to them.</span>")
		return
	if(!evaluate_user(user, silent = FALSE))
		return
	if(!evaluate_target(user, target, silent = FALSE))
		return

	display_interaction(user, target)

	post_interaction(user, target)

/datum/interaction/proc/display_interaction(mob/living/user, mob/living/target)
	if(simple_message)
		var/use_message = replacetext(simple_message, "USER", "\the [user]")
		use_message = replacetext(use_message, "TARGET", "\the [target]")
		user.visible_message("<span class='[simple_style]'>[capitalize(use_message)]</span>")

/datum/interaction/proc/post_interaction(mob/living/user, mob/living/target)
	if(interaction_sound)
		playsound(get_turf(user), interaction_sound, 50, 1, -1)
	return