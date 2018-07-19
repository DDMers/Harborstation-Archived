/*
fish
*/

/mob/living/carbon/human/ShiftClick(mob/user)
	. = ..()
	if(user in orange(src, 1))
		fuck(user, src)

/obj/item/clothing/under/rank/fishman
	icon_state = "fisherman"
	desc = "fish"
	name = "fishman suit wear this"


/mob/living/carbon/human/proc/fuck(mob/living/user, mob/living/target)
	visible_message("[target] lays down as [user] starts to hump [target]")
	to_chat(world, "<span class='userdanger'>[user] is ERPing with [target] in area [get_area(user)], KILL THEM</span>")
	target.Knockdown(60 * 12)
	sleep(5)
	user.pixel_y += 5
	user.pixel_x += 5
	sleep(5)
	user.pixel_y -= 5
	sleep(5)
	user.pixel_y += 10
	user.pixel_x -= 15
	sleep(5)
	user.pixel_y -= 5
	sleep(5)
	user.pixel_y += 8
	user.pixel_x += 10
	sleep(5)
	user.pixel_y += 5
	user.pixel_x += 5
	sleep(5)
	user.pixel_y -= 5
	sleep(5)
	user.pixel_y += 10
	user.pixel_x -= 15
	sleep(5)
	user.pixel_y -= 5
	sleep(5)
	user.pixel_y += 8
	user.pixel_x += 10
	sleep(5)
	user.pixel_y += 5
	user.pixel_x += 5
	sleep(5)
	user.pixel_y -= 5
	sleep(5)
	user.pixel_y += 10
	user.pixel_x -= 15
	sleep(5)
	user.pixel_y -= 5
	sleep(5)
	user.pixel_y += 8
	user.pixel_x += 10
	sleep(5)
	user.pixel_y -= 10
	visible_message("[user] does a backflip as they conclude their erp")
	var/obj/effect/decal/cleanable/flour/smemen = new(src.loc)
	smemen.name = "white goo shit"
	user.pixel_y = initial(user.pixel_y)
	user.pixel_x = initial(user.pixel_x)
	user.say("*flip")

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

/obj/item/zombie_hand/fish
	name = "fin"
	desc = "eat fish with it :)"
	force = 10


/obj/item/zombie_hand/fish/attack_self(mob/user)
	if(user.z == 2)
		to_chat(user, "You swim down")
		user.z = 3
	else
		to_chat(user, "You swim up!")
		user.z = 2

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
	backpack_contents = list(/obj/item/zombie_hand/fish = 2,/obj/item/clothing/glasses/night=1,/obj/item/tank/internals/oxygen/fish_lungs=2)
	backpack = /obj/item/storage/backpack/cultpack
	satchel = /obj/item/storage/backpack/cultpack
	suit = /obj/item/clothing/suit/space/hardsuit/carp/foiosh
	mask = /obj/item/clothing/mask/gas/syndicate/fish
	l_hand = /obj/item/zombie_hand/fish
	r_hand = /obj/item/zombie_hand/fish
