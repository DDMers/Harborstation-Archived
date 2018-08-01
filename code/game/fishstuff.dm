/*
fish
*/
/obj/effect/mob_spawn/human/fisherman
	name = "fisherman"
	outfit = /datum/outfit/job/fisherman
	death = FALSE
	roundstart = FALSE
	random = TRUE
	flavour_text = "<span class='big bold'>You are a fisherman! KILL FISH AND EAT THEM YOU HAVE A FAMILY TO FEED YOU FUCKWIT</span>"
	assignedrole = "fuckwit"
	name = "sleeper"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/obj/effect/mob_spawn/human/fish
	name = "fish"
	outfit = /datum/outfit/job/assistant
	flavour_text = "<span class='big bold'>KILL THE FISHERMEN</span>"

/datum/outfit/job/fisherman
	name = "fisherman"
	jobtype = /datum/job/captain
	belt = /obj/item/pda/chaplain
	uniform = /obj/item/clothing/under/rank/fishman
	backpack = /obj/item/storage/backpack/cultpack
	satchel = /obj/item/storage/backpack/cultpack
	l_hand = /obj/item/twohanded/required/chainsaw/meme

/obj/item/twohanded/required/chainsaw/meme
	name = "fishing rod"
	desc = "It fishes things :)"


/datum/job/assistant
	title = "Fish"
	flag = ASSISTANT
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	supervisors = "fucking youre a fucking fish ok?"
	selection_color = "#dddddd"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit = /datum/outfit/job/assistant
	antag_rep = 7

/obj/item/clothing/under/rank/fishman
	icon_state = "fisherman"
	desc = "fish"
	name = "fishman suit wear this"

/obj/item/zombie_hand/fish
	name = "fin"
	desc = "eat fish with it :)"
	force = 10


/obj/item/zombie_hand/fish/attack_self(mob/user)
	var/turf/t = get_turf(user)
	var/user_x = t.x
	var/user_y = t.y

	if(user.z == 2)
		if(istype(t, /turf/open/floor/plating/beach/water))// >swimming on rock
			to_chat(user, "<span class='notice'>You swim down</span>")
			user.z = 3
		else
			to_chat(user, "<span class='warning'>YOU CANT SWIM HERE THIS ISNT WATER!!!</span>")
			return

	else if(user.z == 3)
		var/turf/T2 = locate(user_x, user_y, 2)

		if(istype(T2, /turf/open/floor/plating/beach/water) || istype(T2, /turf/open/floor/plating/ashplanet/wateryrock))
			to_chat(user, "<span class='notice'>You swim up!</span>")
			user.z = 2
		else
			to_chat(user, "<span class='warning'>YOU CANT SWIM UP HERE THIS ISNT WATER!!!</span>")
			return
	else
		to_chat(user, "<span class='warning'>wait how did you got into z[num2text(user.z)]?</span>")

/obj/item/clothing/suit/space/hardsuit/carp/foiosh
	name = "fish skin"
	flags_1 = NODROP

/obj/item/clothing/mask/gas/syndicate/fish
	flags_1 = NODROP

/obj/item/tank/internals/oxygen/fish_lungs
	name = "fish lungs"
	icon_state = "lungs"
	icon = 'icons/obj/surgery.dmi'
	desc = "ew what the fuck is this shit"

/datum/outfit/job/assistant
	name = "fish level 1"
	jobtype = /datum/job/assistant
	belt = /obj/item/pda/chaplain
	uniform = /obj/item/clothing/under/rank/chaplain
	backpack_contents = list(/obj/item/clothing/glasses/night=1,/obj/item/tank/internals/oxygen/fish_lungs=2)
	backpack = /obj/item/storage/backpack/cultpack
	satchel = /obj/item/storage/backpack/cultpack
	suit = /obj/item/clothing/suit/space/hardsuit/carp/foiosh
	mask = /obj/item/clothing/mask/gas/syndicate/fish
	l_hand = /obj/item/tank/jetpack/oxygen
	r_hand = /obj/item/zombie_hand/fish

//////////////////////////////////
//////////dakimakuras/////////////
//////////////////////////////////
obj/item/storage/daki
	name = "dakimakura"
	desc = "A large pillow depicting a girl in a compromising position. Featuring as many dimensions as you."
	icon = 'icons/daki.dmi'
	icon_state = "daki_base"
	slot_flags = SLOT_BACK
	var/cooldowntime = 20
	var/static/list/dakimakura_options = list("Callie","Casca","Chaika","Elisabeth","Foxy Grandpa","Haruko","Holo","Ian","Jolyne","Kurisu","Marie","Mugi","Nar'Sie","Patchouli","Plutia","Rei","Reisen","Naga","Squid","Squigly","Tomoko","Toriel","Umaru","Yaranaika","Yoko") //Kurisu is the ideal girl." - Me, Logos.

/obj/item/storage/daki/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.max_combined_w_class = 21
	STR.max_items = 3
	STR.cant_hold = typecacheof(list(/obj/item/disk/nuclear)) //haha, nuke disk

/obj/item/storage/daki/attack_self(mob/living/user)
	var/body_choice
	var/custom_name

	if(icon_state == "daki_base")
		body_choice = input("Pick a body.") in dakimakura_options
		icon_state = "daki_[body_choice]"
		custom_name = stripped_input(user, "What's her name?")
		if(length(custom_name) > MAX_NAME_LEN)
			to_chat(user,"<span class='danger'>Name is too long!</span>")
			return FALSE
		if(custom_name)
			name = custom_name
			desc = "A large pillow depicting [custom_name] in a compromising position. Featuring as many dimensions as you."
	else
		switch(user.a_intent)
			if(INTENT_HELP)
				user.visible_message("<span class='notice'>[user] hugs the [name].</span>")
				playsound(src, "rustle", 50, 1, -5)
			if(INTENT_DISARM)
				user.visible_message("<span class='notice'>[user] kisses the [name].</span>")
				playsound(src, "rustle", 50, 1, -5)
			if(INTENT_GRAB)
				user.visible_message("<span class='warning'>[user] holds the [name]!</span>")
				playsound(src, 'sound/items/bikehorn.ogg', 50, 1)
			if(INTENT_HARM)
				user.visible_message("<span class='danger'>[user] punches the [name]!</span>")
				playsound(src, 'sound/effects/shieldbash.ogg', 50, 1)
		user.changeNext_move(CLICK_CD_MELEE)
