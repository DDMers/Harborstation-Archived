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
