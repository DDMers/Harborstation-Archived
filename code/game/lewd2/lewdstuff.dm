/mob/living/proc/do_normalfuck(mob/living/partner) //does not require special admin perms
	visible_message("<font color=purple>[partner] lays down as [src] starts to hump [partner]</font>")
	to_chat(world, "<span class='userdanger'>[src] is ERPing with [partner] in [get_area(src)], KILL THEM</span>")
	partner.fucked_amt += 1
	src.fucking_someone_amt += 1
	partner.Knockdown(5)

	partner.dir = get_dir(partner,src)
	do_fucking_animation(get_dir(src, partner))

	sleep(5)
	visible_message("<b>[src]</b> does a backflip as they conclude their erp")
	//cum_splatter(partner)
	var/obj/effect/decal/cleanable/flour/smemen = new(src.loc)
	smemen.name = "white goo shit"
	src.pixel_y = initial(src.pixel_y)
	src.pixel_x = initial(src.pixel_x)
	src.emote("flip")

/* ------------------------------------------------
   -----------ACTUAL ERP CODE BELLOW---------------
   ------------------------------------------------ */

/mob/living/proc/do_oral(mob/living/partner)
	var/message
	var/lust_increase = NORMAL_LUST

	if(more_lewd_erp == TRUE)
		if(partner.is_fucking(src, CUM_TARGET_MOUTH))
			if(prob(partner.sexual_potency * 0.5))
				partner.adjustOxyLoss(3)
				message = "goes in deep on \the [partner]."
				lust_increase += 5
			else
				if(partner.has_vagina())
					message = "licks \the [partner]'s pussy."
				else if(partner.has_penis())
					message = "sucks \the [partner] off."
				else
					message = "licks \the [partner]."
		else
			if(partner.has_vagina())
				message = "buries their face in \the [partner]'s pussy."
			else if(partner.has_penis())
				message = "takes \the [partner]'s cock into their mouth."
			else
				message = "begins to lick \the [partner]."
			partner.set_is_fucking(src, CUM_TARGET_MOUTH)

		playsound(get_turf(src), "code/game/lewd/sound/interactions/bj[rand(1, 11)].ogg", 50, 1, -1)
		visible_message("<b><font color=purple>\The [src]</b> [message]</font>")
		partner.handle_post_sex(lust_increase, CUM_TARGET_MOUTH, src)
		partner.dir = get_dir(partner,src)
		do_fucking_animation(get_dir(src, partner))
		lust_increase = NORMAL_LUST //reset
		partner.fucked_amt += 1
		src.fucking_someone_amt += 1

	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/mob/living/proc/do_facefuck(mob/living/partner)
	var/message
	var/lust_increase = NORMAL_LUST

	if(more_lewd_erp == TRUE)
		if(is_fucking(partner, CUM_TARGET_MOUTH))
			if(has_vagina())
				message = "grinds their pussy into \the [partner]'s face."
			else if(has_penis())
				message = "roughly fucks \the [partner]'s mouth."
			else
				message = "grinds against \the [partner]\s face."
		else
			if(has_vagina())
				message = "forces \the [partner]'s face into their pussy."
			else if(has_penis())
				if(is_fucking(partner, CUM_TARGET_THROAT))
					message = "retracts their dick from \the [partner]'s throat"
				else
					message = "shoves their dick deep into \the [partner]'s mouth"
			else
				message = "shoves their crotch into \the [partner]'s face."
			set_is_fucking(partner , CUM_TARGET_MOUTH)

		playsound(loc, "code/game/lewd/sound/interactions/oral[rand(1, 2)].ogg", 70, 1, -1)
		visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
		handle_post_sex(lust_increase, CUM_TARGET_MOUTH, partner)
		partner.dir = get_dir(partner,src)
		do_fucking_animation(get_dir(src, partner))
		partner.fucked_amt += 1
		src.fucking_someone_amt += 1

	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/mob/living/proc/do_throatfuck(mob/living/partner)
	var/message
	var/lust_increase = 12

	if(more_lewd_erp == TRUE)
		if(is_fucking(partner, CUM_TARGET_THROAT))
			message = "[pick("brutally fucks \the [partner]'s throat.", "chokes \the [partner] on their dick.", "brutally shoves their dick deep into \the [partner]'s mouth.")]"
			if(prob(partner.sexual_potency * 0.6))
				partner.emote("chokes on \The [src]'s dick")
				partner.adjustOxyLoss(5)
				playsound(loc, "lewd/sound/interactions/choke_f1.ogg", 70, 1, -1)
				lust_increase += 5
			else
				partner.emote("gasps")
		if(is_fucking(partner, CUM_TARGET_MOUTH))
			message = "thrusts deeper into \the [partner]'s mouth and down their throat."
		else
			message = "forces their dick deep down \the [partner]'s throat"
			set_is_fucking(partner , CUM_TARGET_THROAT)

		playsound(loc, "code/game/lewd/sound/interactions/oral[rand(1, 2)].ogg", 70, 1, -1)
		visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
		handle_post_sex(lust_increase, CUM_TARGET_THROAT, partner)
		partner.dir = get_dir(partner,src)
		do_fucking_animation(get_dir(src, partner))
		lust_increase = 12 //shitty reset thingyv
		partner.fucked_amt += 1
		src.fucking_someone_amt += 1
	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/mob/living/proc/do_anal(mob/living/partner)
	var/message
	var/lust_increase = 13

	if(more_lewd_erp == TRUE)
		if(is_fucking(partner, CUM_TARGET_ANUS))
			message = "fucks \the [partner]'s ass."
		else
			message = "works their cock into \the [partner]'s asshole."
			set_is_fucking(partner, CUM_TARGET_ANUS)

		playsound(loc, "code/game/lewd/sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)
		visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
		handle_post_sex(lust_increase, CUM_TARGET_ANUS, partner)
		partner.handle_post_sex(lust_increase, null, src)
		partner.dir = get_dir(src, partner)
		do_fucking_animation(get_dir(src, partner))
		partner.fucked_amt += 1
		src.fucking_someone_amt += 1

	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/mob/living/proc/do_vaginal(mob/living/partner)
	var/message
	var/lust_increase = 13

	if(more_lewd_erp == TRUE)
		if(is_fucking(partner, CUM_TARGET_VAGINA))
			message = "[pick("pounds \the [partner]'s pussy.","shoves their dick deep into \the [partner]'s pussy")]"
		else
			message = "slides their cock into \the [partner]'s pussy."
			set_is_fucking(partner, CUM_TARGET_VAGINA)

		playsound(loc, "code/game/lewd/sound/interactions/champ[rand(1, 2)].ogg", 50, 1, -1)
		visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
		handle_post_sex(lust_increase, CUM_TARGET_VAGINA, partner)
		partner.handle_post_sex(lust_increase, null, src)
		partner.dir = get_dir(partner,src)
		do_fucking_animation(get_dir(src, partner))
		partner.fucked_amt += 1
		src.fucking_someone_amt += 1

	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/mob/living/proc/do_mount(mob/living/partner)
	var/message
	var/lust_increase = 13

	if(more_lewd_erp == TRUE)
		if(partner.is_fucking(src, CUM_TARGET_VAGINA))
			message = "[pick("rides \the [partner]'s dick.", "forces [partner]'s cock on their pussy")]"
		else
			message = "slides their pussy onto \the [partner]'s cock."
			partner.set_is_fucking(src, CUM_TARGET_VAGINA)

		playsound(loc, "code/game/lewd/sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)
		visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
		partner.handle_post_sex(lust_increase, CUM_TARGET_VAGINA, src)
		handle_post_sex(lust_increase, null, partner)
		partner.dir = get_dir(partner,src)
		do_fucking_animation(get_dir(src, partner))
		partner.fucked_amt += 1
		src.fucking_someone_amt += 1

	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/mob/living/proc/do_mountass(mob/living/partner)
	var/message
	var/lust_increase = 13

	if(more_lewd_erp == TRUE)
		if(partner.is_fucking(src, CUM_TARGET_ANUS))
			message = "[pick("rides \the [partner]'s dick.", "forces [partner]'s cock on their ass")]"
		else
			message = "lowers their ass onto \the [partner]'s cock."
			partner.set_is_fucking(src, CUM_TARGET_ANUS)

		playsound(loc, "code/game/lewd/sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)
		visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
		partner.handle_post_sex(lust_increase, CUM_TARGET_ANUS, src)
		handle_post_sex(lust_increase, null, partner)
		partner.dir = get_dir(partner,src)
		do_fucking_animation(get_dir(src, partner))
		partner.fucked_amt += 1
		src.fucking_someone_amt += 1

	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/mob/living/proc/do_fingering(mob/living/partner)
	if(more_lewd_erp == TRUE)
		visible_message("<font color=purple><b>\The [src]</b> [pick("fingers \the [partner].", "fingers \the [partner]'s pussy.", "fingers \the [partner]'s pussy hard.")]</font>")
		playsound(loc, "code/game/lewd/sound/interactions/champ_fingering.ogg", 50, 1, -1)
		partner.handle_post_sex(NORMAL_LUST, null, src)
		partner.dir = get_dir(partner, src)
		do_fucking_animation(get_dir(src, partner))
		partner.fucked_amt += 1
		src.fucking_someone_amt += 1

	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/mob/living/proc/do_fingerass(mob/living/partner)
	if(more_lewd_erp == TRUE)
		visible_message("<font color=purple><b>\The [src]</b> [pick("fingers \the [partner].", "fingers \the [partner]'s asshole.", "fingers \the [partner] hard.")]</span></font>")
		playsound(loc, "code/game/lewd/sound/interactions/champ_fingering.ogg", 50, 1, -1)
		partner.handle_post_sex(NORMAL_LUST, null, src)
		partner.dir = get_dir(partner, src)
		do_fucking_animation(get_dir(src, partner))
		partner.fucked_amt += 1
		src.fucking_someone_amt += 1
	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/mob/living/proc/do_rimjob(mob/living/partner)
	if(more_lewd_erp == TRUE)
		visible_message("<font color=purple><b>\The [src]</b> licks \the [partner]'s asshole.</span></font>")
		playsound(loc, "code/game/lewd/sound/interactions/champ_fingering.ogg", 50, 1, -1)
		partner.handle_post_sex(NORMAL_LUST, null, src)
		partner.dir = get_dir(src, partner)
		do_fucking_animation(get_dir(src, partner))

	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/mob/living/proc/do_handjob(mob/living/partner)
	var/message
	var/lust_increase = NORMAL_LUST

	if(more_lewd_erp == TRUE)
		if(partner.is_fucking(src, CUM_TARGET_HAND))
			message = "[pick("jerks \the [partner] off.", "works \the [partner]'s shaft.", "wanks \the [partner]'s cock hard.")]"
		else
			message = "[pick("wraps their hand around \the [partner]'s cock.", "starts playing with \the [partner]'s cock")]"
			partner.set_is_fucking(src, CUM_TARGET_HAND)

		playsound(src, "code/game/lewd/sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)
		visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
		partner.handle_post_sex(lust_increase, CUM_TARGET_HAND, src)
		partner.dir = get_dir(partner,src)
		do_fucking_animation(get_dir(src, partner))

	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/mob/living/proc/do_breastfuck(mob/living/partner)
	var/message
	var/lust_increase = NORMAL_LUST

	if(more_lewd_erp == TRUE)
		if(is_fucking(partner, CUM_TARGET_BREASTS))
			message = "[pick("fucks \the [partner]'s' breasts.", "grinds their cock between \the [partner]'s boobs.", "thrusts into \the [partner]'s tits.", "grabs \the [partner]'s breasts together and presses his dick between them.")]"
		else
			message = "pushes \the [partner]'s breasts together and presses his dick between them."
			set_is_fucking(partner , CUM_TARGET_BREASTS)


		playsound(loc, "code/game/lewd/sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)
		visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
		handle_post_sex(lust_increase, CUM_TARGET_BREASTS, partner)
		partner.dir = get_dir(partner,src)
		do_fucking_animation(get_dir(src, partner))
	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/mob/living/proc/do_mountface(mob/living/partner)
	var/message

	if(more_lewd_erp == TRUE)
		if(is_fucking(partner, GRINDING_FACE_WITH_ANUS))
			message = "[pick(list("grinds their ass into \the [partner]'s face.", "shoves their ass into \the [partner]'s face."))]</span>"
		else
			message = "[pick(list("grabs the back of \the [partner]'s head and forces it into their asscheeks.", "squats down and plants their ass right on \the [partner]'s face"))]</span>"
			set_is_fucking(partner , GRINDING_FACE_WITH_ANUS)

		playsound(loc, "code/game/lewd/sound/interactions/squelch[rand(1, 3)].ogg", 70, 1, -1)
		visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
		handle_post_sex(LOW_LUST, null, src)
		partner.dir = get_dir(src, partner)
		do_fucking_animation(get_dir(src, partner))
	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/* ------------------------------------------------
   ---------Here is where HERESY starts------------
   ------------------------------------------------ */


/mob/living/proc/do_lickfeet(mob/living/partner)
	var/message

	if(more_lewd_erp == TRUE)
		if(partner.get_item_by_slot(SLOT_SHOES) != null)
			message = "licks \the [partner]'s \ [partner.get_item_by_slot(SLOT_SHOES)]."
		else
			message = "licks \the [partner]'s feet."

		playsound(loc, "code/game/lewd/sound/interactions/champ_fingering.ogg", 50, 1, -1)
		visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
		handle_post_sex(LOW_LUST, null, src)
		partner.dir = get_dir(src, partner)
		do_fucking_animation(get_dir(src, partner))

	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/*Grinding YOUR feet in TARGET's face*/
/mob/living/proc/do_grindface(mob/living/partner)
	var/message

	if(more_lewd_erp == TRUE)
		if(is_fucking(partner, GRINDING_FACE_WITH_FEET))
			if(src.get_item_by_slot(SLOT_SHOES) != null)
				message = "[pick(list("grinds their [get_shoes()] into [partner]'s face.", "presses their footwear down hard on [partner]'s face.", "rubs off the dirt from their [get_shoes()] onto [partner]'s face."))]</span>"

			else
				message = "[pick(list("grinds their barefeet into [partner]'s face.", "deviously covers [partner]'s mouth and nose with their barefeet.", "runs the soles of their barefeet against [partner]'s lips."))]</span>"

		if(is_fucking(partner, GRINDING_MOUTH_WITH_FEET))
			if(src.get_item_by_slot(SLOT_SHOES) != null)
				message = "[pick(list("pulls their [get_shoes()] out of [partner]'s mouth and puts them on their face.", "slowly retracts their [get_shoes()] from [partner]'s mouth, putting them on their face instead."))]</span>"
			else
				message = "[pick(list("pulls their barefeet out of [partner]'s mouth and rests them on their face instead.", "retracts their barefeet from [partner]'s mouth and grinds them into their face instead."))]</span>"

			set_is_fucking(partner , GRINDING_FACE_WITH_FEET)
		else
			if(src.get_item_by_slot(SLOT_SHOES) != null)
				message = "[pick(list("plants their [get_shoes()] ontop of [partner]'s face.", "rests their [get_shoes()] on [partner]'s face and presses down hard.", "harshly places their [get_shoes()] atop [partner]'s face."))]</span>"
			else
				message = "[pick(list("plants their barefeet ontop of [partner]'s face.", "rests their massive feet on [partner]'s face, smothering them.", "positions their barefeet atop [partner]'s face."))]</span>"

			set_is_fucking(partner , GRINDING_FACE_WITH_FEET)

		playsound(loc, "code/game/lewd/sound/interactions/foot_dry[rand(1, 4)].ogg", 70, 1, -1)
		visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
		partner.handle_post_sex(LOW_LUST, null, src)
		partner.dir = get_dir(src, partner)
		do_fucking_animation(get_dir(src, partner))

	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

	/*Grinding YOUR feet in TARGET's mouth*/
/mob/living/proc/do_grindmouth(mob/living/partner)
	var/message

	if(more_lewd_erp == TRUE)
		if(is_fucking(partner, GRINDING_MOUTH_WITH_FEET))
			if(src.get_item_by_slot(SLOT_SHOES) != null)
				message = "[pick(list("roughly shoves their [get_shoes()] deeper into [partner]'s mouth.", "harshly forces another inch of their [get_shoes()] into [partner]'s mouth.", "presses their weight down, their [get_shoes()] prying deeper into [partner]'s mouth."))]</span>"
			else
				message = "[pick(list("wiggles their toes deep inside [partner]'s mouth.", "crams their barefeet down deeper into [partner]'s mouth, making them gag.", "roughly grinds their feet on [partner]'s tongue."))]</span>"

		if(is_fucking(partner, GRINDING_FACE_WITH_FEET))
			if(src.get_item_by_slot(SLOT_SHOES) != null)
				message = "[pick(list("decides to force their [get_shoes()] deep into [partner]'s mouth.", "pressed the tip of their [get_shoes()] against [partner]'s lips and shoves inwards."))]</span>"
			else
				message = "[pick(list("pries open [partner]'s mouth with their toes and shoves their barefoot in.", "presses down their foot even harder, cramming their foot into [partner]'s mouth."))]</span>"

			set_is_fucking(partner , GRINDING_MOUTH_WITH_FEET)

		else
			if(src.get_item_by_slot(SLOT_SHOES) != null)
				message = "[pick(list("readies themselves and in one swift motion, shoves their [get_shoes()] into [partner]'s mouth.", "grinds the tip of their [get_shoes()] against [partner]'s mouth before pushing themselves in."))]</span>"
			else
				message = "[pick(list("rubs their dirty barefeet across [partner]'s face before prying them into their muzzle.", "forces their barefeet into [partner]'s mouth.", "covers [partner]'s mouth and nose with their foot until they gasp for breath, then shoving both feet inside before they can react."))]</span>"

			set_is_fucking(partner , GRINDING_MOUTH_WITH_FEET)

		playsound(loc, "code/game/lewd/sound/interactions/foot_wet[rand(1, 3)].ogg", 70, 1, -1)
		visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
		partner.handle_post_sex(LOW_LUST, null, src)
		partner.dir = get_dir(src, partner)
		do_fucking_animation(get_dir(src, partner))

	else
		to_chat(src, "<span class='notice'>You dont have admin erp permission.</span>")

/mob/living/proc/get_shoes()
	var/obj/A = get_item_by_slot(SLOT_SHOES)

	if(findtext (A.name,"the"))
		return copytext(A.name, 3, (lentext(A.name)) + 1)
	else
		return A.name

/mob/living/proc/handle_post_sex(amount, orifice, mob/living/partner)
	sleep(5)

	if(stat != CONSCIOUS)
		return
	if(amount)
		lust += amount
	if (lust >= lust_tolerance)
		cum(partner, orifice)
	else
		moan()