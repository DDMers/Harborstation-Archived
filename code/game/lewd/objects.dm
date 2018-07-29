/* ------------------------------------------------
   -----------------MISC STUFF --------------------
   ------------------------------------------------ */

/obj/item/dildo
	name = "dildo"
	desc = "Hmmm, deal throw."
	icon = 'code/game/lewd/icons/obj/items/dildo.dmi'
	icon_state = "dildo"
	item_state = "c_tube"
	throwforce = 0
	force = 0
	throw_speed = 3
	throw_range = 7
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("slammed", "bashed", "whipped")

	var/hole = CUM_TARGET_VAGINA

/obj/item/dildo/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	var/message = ""
	if(istype(M, /mob/living/carbon/human) && user.zone_selected == "groin" && M.is_groin_exposed())
		if (hole == CUM_TARGET_VAGINA && M.has_vagina())
			message = (user == M) ? pick("fucks their own pussy with \the [src]","shoves the [src] into their pussy", "jams the [src] into their pussy") : pick("fucks [M] right in the pussy with \the [src]", "jams \the [src] right into [M]'s pussy")
		else if (hole == CUM_TARGET_ANUS && M.has_anus())
			message = (user == M) ? pick("fucks their own ass with \the [src]","shoves the [src] into their ass", "jams the [src] into their ass") : pick("fucks [M]'s asshole with \the [src]", "jams \the [src] into [M]'s ass")
	if(message)
		user.visible_message("<font color=purple><b>[user]</b> [message].</font>")
		M.handle_post_sex(pick(3,4,5,6,7), null, user)
		playsound(loc, "code/game/lewd/sound/interactions/bang[rand(4, 6)].ogg", 70, 1, -1)
	else
		return ..()

/obj/item/dildo/attack_self(mob/user)
	if(hole == CUM_TARGET_VAGINA)
		hole = CUM_TARGET_ANUS
	else
		hole = CUM_TARGET_VAGINA

	to_chat(user, "<span class='warning'>Hmmm. Maybe we should put it in \a [hole]?</span>")

//collar
/obj/item/electropack/shockcollar
	name = "shock collar"
	desc = "A reinforced metal collar. It seems to have some form of wiring near the front. Strange.."
	icon = 'code/game/lewd/icons/obj/items/collar.dmi'
	icon_state = "shockcollar_ico"
	item_state = "shockcollar"
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK | ITEM_SLOT_DENYPOCKET   //no more pocket shockers
	w_class = WEIGHT_CLASS_SMALL
	strip_delay = 60
	equip_delay_other = 60
	materials = list(MAT_METAL=5000, MAT_GLASS=2000)
	var/tagname = null

/datum/design/electropack/shockcollar
	name = "Shockcollar"
	id = "shockcollar"
	build_type = AUTOLATHE
	build_path = /obj/item/electropack/shockcollar
	materials = list(MAT_METAL=5000, MAT_GLASS=2000)
	category = list("hacked", "Misc")

/obj/item/electropack/shockcollar/attack_hand(mob/user)
	if(loc == user && user.get_item_by_slot(SLOT_NECK))
		to_chat(user, "<span class='warning'>The collar is fastened tight! You'll need help taking this off!</span>")
		return
	..()

/obj/item/electropack/shockcollar/receive_signal(datum/signal/signal)
	if(!signal || signal.data["code"] != code)
		return

	if(isliving(loc) && on)
		if(shock_cooldown != 0)
			return
		shock_cooldown = 1
		spawn(100)
			shock_cooldown = 0
		var/mob/living/L = loc
		step(L, pick(GLOB.cardinals))

		to_chat(L, "<span class='danger'>You feel a sharp shock from the collar!</span>")
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(3, 1, L)
		s.start()

		L.Knockdown(100)

	if(master)
		master.receive_signal()
	return

/obj/item/electropack/shockcollar/attack_self(mob/user) //Turns out can't fully source this from the parent item, spritepath gets confused if power toggled. Will come back to this when I know how to code better and readd powertoggle..

	if(!ishuman(user))
		return
	user.set_machine(src)
	var/dat = {"<SK><BR>
		<B>Frequency/Code</B> for shock collar:<BR>
		Frequency:
		<A href='byond://?src=\ref[src];freq=-10'>-</A>
		<A href='byond://?src=\ref[src];freq=-2'>-</A> [format_frequency(frequency)]
		<A href='byond://?src=\ref[src];freq=2'>+</A>
		<A href='byond://?src=\ref[src];freq=10'>+</A><BR>
		Code:
		<A href='byond://?src=\ref[src];code=-5'>-</A>
		<A href='byond://?src=\ref[src];code=-1'>-</A> [code]
		<A href='byond://?src=\ref[src];code=1'>+</A>
		<A href='byond://?src=\ref[src];code=5'>+</A><BR>
		</SK>"}

	user << browse(dat, "window=radio")
	onclose(user, "radio")
	return

/obj/item/electropack/shockcollar/ShiftClick(mob/user)
	if(user in orange(src, 1) && ishuman(user))
		var/t = input(user, "Would you like to change the name on the tag?", "Name your new pet", tagname ? tagname : "Spot") as null|text
		if(t)
			tagname = copytext(sanitize(t), 1, MAX_NAME_LEN)
			name = "[initial(name)] - [tagname]"
	else
		return

//reagent here
/datum/reagent/consumable/cum
	name = "cum"
	id = "cum"
	description = "Where you found this is your own business."
	color = "#AAAAAA77"
	taste_description = "something with a tang"
	data = list("donor"=null,"viruses"=null,"donor_DNA"=null,"blood_type"=null,"resistances"=null,"trace_chem"=null,"mind"=null,"ckey"=null,"gender"=null,"real_name"=null)
	taste_mult = 2
	reagent_state = LIQUID
	nutriment_factor = 0.5 * REAGENTS_METABOLISM

/datum/reagent/consumable/cum/reaction_turf(turf/T, reac_volume)
	if(!istype(T))
		return
	if(reac_volume < 3)
		return

	var/obj/effect/decal/cleanable/cum/S = locate() in T
	if(!S)
		S = new(T)
	S.reagents.add_reagent("cum", reac_volume)
	if(data["blood_DNA"])
		S.add_blood_DNA(list(data["blood_DNA"] = data["blood_type"])) //yes. STD

//cleanable here
/obj/effect/decal/cleanable/cum
	name = "cum"
	desc = "It's pie cream from a cream pie. Or not..."
	gender = PLURAL
	layer = ABOVE_NORMAL_TURF_LAYER
	density = 0
	icon = 'code/game/lewd/icons/effects/cum.dmi'
	random_icon_states = list("cum1", "cum3", "cum4", "cum5", "cum6", "cum7", "cum8", "cum9", "cum10", "cum11", "cum12")
	mergeable_decal = FALSE
	blood_state = null
	bloodiness = null
	//var/blood_DNA = list()

/obj/effect/decal/cleanable/cum/New()
	..()
	dir = pick(1,2,4,8)
	add_blood_DNA(list("Unknown DNA" = "O+"))