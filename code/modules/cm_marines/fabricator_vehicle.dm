
/obj/structure/machinery/fabricator_vehicle
	name = "USCM vehicle part fabricator"
	desc = "A large automated 3D printer for producing vehicle parts. You can recycle parts or ammo in it, and get 80% of your points back, by clicking it while holding them in a powerloader claw."
	density = TRUE
	anchored = TRUE
	use_power = USE_POWER_IDLE
	unslashable = TRUE
	unacidable = TRUE
	idle_power_usage = 20
	icon = 'icons/obj/structures/machinery/drone_fab.dmi'
	icon_state = "drone_fab_idle"
	var/busy = FALSE
	var/generate_points = TRUE
	var/faction = FACTION_MARINE
	var/datum/controller/supply/linked_supply_controller
	var/list/datum/build_queue_entry/build_queue = list()

	var/selected_vehicle
	var/last_opened_category

	req_access = list(ACCESS_MARINE_CREWMAN)

/obj/structure/machinery/fabricator_vehicle/upp
	name = "UPP vehicle part fabricator"
	faction = FACTION_UPP
	req_access = list(ACCESS_UPP_LEADERSHIP)

/obj/structure/machinery/fabricator_vehicle/get_examine_text(mob/user)
	. = ..()
	to_chat(user, build_queue ? "It has [length(build_queue)] items in the queue" : "the build queue is empty")

/obj/structure/machinery/fabricator_vehicle/New()
	..()
	switch(faction)
		if(FACTION_MARINE)
			linked_supply_controller = GLOB.supply_controller
		if(FACTION_UPP)
			linked_supply_controller = GLOB.supply_controller_upp
		else
			linked_supply_controller = GLOB.supply_controller
	start_processing()

/obj/structure/machinery/fabricator_vehicle
    var/point_store = 8000   // starting budget

/obj/structure/machinery/fabricator_vehicle/proc/get_point_store()
    return point_store

/obj/structure/machinery/fabricator_vehicle/proc/add_to_point_store(number = 1)
    point_store += number
    return point_store

/obj/structure/machinery/fabricator_vehicle/proc/spend_point_store(number = 1)
    point_store = max(0, point_store - number)
    return point_store

/obj/structure/machinery/fabricator_vehicle/ui_data(mob/user)
	var/index = 1
	var/list/build_queue_formatted = list()
	for(var/datum/build_queue_entry/entry in build_queue)
		var/obj/structure/build_item = entry.item
		build_queue_formatted += list(list(
			"name" = build_item.name,
			"cost" = entry.cost,
			"index" = index
		))
		index += 1

	var/list/category_items = list()
	if(last_opened_category)
		category_items = ui_static_data(user)[last_opened_category]

	return list(
		"points" = get_point_store(),
		"BuildQueue" = build_queue_formatted,
		"selected_vehicle" = selected_vehicle,
		"busy" = busy,
		"opened_category" = last_opened_category,
		"category_items" = category_items
	)

/obj/structure/machinery/fabricator_vehicle/power_change()
	..()
	if (stat & NOPOWER)
		icon_state = "drone_fab_nopower"

/obj/structure/machinery/fabricator_vehicle/process()
	if(SSticker.current_state < GAME_STATE_PLAYING)
		return

	if(generate_points)
		add_to_point_store()

	process_build_queue()

	update_icon()

/obj/structure/machinery/fabricator_vehicle/proc/process_build_queue()
	if(stat & NOPOWER)
		return

	if(busy)
		return

	if(length(build_queue))
		busy = TRUE
		var/datum/build_queue_entry/entry = build_queue[1]

		if(get_point_store() < entry.cost)
			if(!TIMER_COOLDOWN_CHECK(src, COOLDOWN_PRINTER_ERROR))
				balloon_alert_to_viewers("out of points - printing paused!")
				visible_message(SPAN_WARNING("[src] flashes a warning light."))
				TIMER_COOLDOWN_START(src, COOLDOWN_PRINTER_ERROR, 20 SECONDS)
			busy = FALSE
			return

		// Deduct points here
		spend_point_store(entry.cost)

		visible_message(SPAN_NOTICE("[src] starts printing something."))
		addtimer(CALLBACK(src, PROC_REF(produce_part), entry), 3 SECONDS)

/obj/structure/machinery/fabricator_vehicle/proc/build_part(part_type, cost, mob/user)
	set waitfor = FALSE
	if(stat & NOPOWER)
		return

	if(get_point_store() < cost)
		to_chat(user, SPAN_WARNING("You don't have enough points to build that."))
		return

	build_queue += new /datum/build_queue_entry(part_type, cost)

/obj/structure/machinery/fabricator_vehicle/proc/produce_part(datum/build_queue_entry/entry)
	build_queue.Remove(entry)

	busy = FALSE
	playsound(src, 'sound/machines/hydraulics_1.ogg', 40, 1)
	new entry.item(get_step(src, SOUTHEAST))
	icon_state = "drone_fab_idle"

/obj/structure/machinery/fabricator_vehicle/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/mob/user = ui.user

	if(action == "select_vehicle")
		selected_vehicle = params["vehicle"]
		return TRUE

	if(action == "open_category")
		last_opened_category = params["category"]
		return TRUE

	if(action == "produce")
		var/category = params["category"]
		var/index = params["index"]

		var/list/category_list = ui_static_data(user)[category]
		if(!category_list || index < 1 || index > length(category_list))
			return

		var/choice = category_list[index]
		var/typepath = choice["path"]

		// Create a dummy reference to check restrictions
		var/obj/item/hardpoint/produce = typepath

		// Always pull the true cost from the type definition
		var/cost = initial(produce.point_cost)

		build_part(typepath, cost, user)
		return TRUE

	if(action == "cancel")
		var/index = params["index"]

		if(length(build_queue))
			if(index == null || index > length(build_queue))
				return

			if(busy && index == 1)
				to_chat(user, SPAN_WARNING("Cannot cancel currently produced item."))
				return

			var/datum/build_queue_entry/entry = build_queue[index]
			build_queue.Remove(entry)
			return

/obj/structure/machinery/fabricator_vehicle/attack_hand(mob/user)
	if(!allowed(user))
		to_chat(user, SPAN_WARNING("Access denied."))
		return TRUE
	tgui_interact(user)

/obj/structure/machinery/fabricator_vehicle/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PartFabricatorVehicle", "Part Fabricator Vehicle")
		ui.open()

/obj/structure/machinery/fabricator_vehicle/update_icon()
	. = ..()
	if(stat & NOPOWER)
		icon_state = "drone_fab_nopower"
		return
	if(busy)
		icon_state = "drone_fab_active"
		return

	icon_state = "drone_fab_idle"

/obj/structure/machinery/fabricator_vehicle/ui_static_data(mob/user)
	var/list/static_data = list()

	// Primary Weapons
	static_data["Primary Weapons"] = list()
	var/index = 1
	for(var/build_type in typesof(/obj/item/hardpoint/primary))
		var/obj/item/hardpoint/primary/data = build_type
		var/build_name = initial(data.name)
		var/build_desc = initial(data.desc)
		var/build_cost = initial(data.point_cost)
		if(build_cost)
			static_data["Primary Weapons"] += list(list(
				"name" = capitalize_first_letters(build_name),
				"desc" = build_desc,
				"cost" = build_cost,
				"path" = build_type,
				"index" = index
			))
		index++

	// Primary Ammunition
	static_data["Primary Ammunition"] = list()
	index = 1
	for(var/build_type in typesof(/obj/item/ammo_magazine/hardpoint/primary))
		var/obj/item/ammo_magazine/hardpoint/primary/data = build_type
		var/build_name = initial(data.name)
		var/build_desc = initial(data.desc)
		var/build_cost = initial(data.point_cost)
		if(build_cost)
			static_data["Primary Ammunition"] += list(list(
				"name" = capitalize_first_letters(build_name),
				"desc" = build_desc,
				"cost" = build_cost,
				"path" = build_type,
				"index" = index
			))
		index++

	// Secondary Weapons
	static_data["Secondary Weapons"] = list()
	index = 1
	for(var/build_type in typesof(/obj/item/hardpoint/secondary))
		var/obj/item/hardpoint/primary/data = build_type
		var/build_name = initial(data.name)
		var/build_desc = initial(data.desc)
		var/build_cost = initial(data.point_cost)
		if(build_cost)
			static_data["Secondary Weapons"] += list(list(
				"name" = capitalize_first_letters(build_name),
				"desc" = build_desc,
				"cost" = build_cost,
				"path" = build_type,
				"index" = index
			))
		index++

	// Secondary Ammunition
	static_data["Secondary Ammunition"] = list()
	index = 1
	for(var/build_type in typesof(/obj/item/ammo_magazine/hardpoint/secondary))
		var/obj/item/ammo_magazine/hardpoint/secondary/data = build_type
		var/build_name = initial(data.name)
		var/build_desc = initial(data.desc)
		var/build_cost = initial(data.point_cost)
		if(build_cost)
			static_data["Secondary Ammunition"] += list(list(
				"name" = capitalize_first_letters(build_name),
				"desc" = build_desc,
				"cost" = build_cost,
				"path" = build_type,
				"index" = index
			))
		index++

	// Support Modules
	static_data["Support Modules"] = list()
	index = 1
	for(var/build_type in typesof(/obj/item/hardpoint/support))
		var/obj/item/hardpoint/support/data = build_type
		var/build_name = initial(data.name)
		var/build_desc = initial(data.desc)
		var/build_cost = initial(data.point_cost)
		if(build_cost)
			static_data["Support Modules"] += list(list(
				"name" = capitalize_first_letters(build_name),
				"desc" = build_desc,
				"cost" = build_cost,
				"path" = build_type,
				"index" = index
			))
		index++

	return static_data

/obj/structure/machinery/fabricator_vehicle/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/powerloader_clamp))
		var/obj/item/powerloader_clamp/powerloader_clamp_used = I
		recycle_equipment(powerloader_clamp_used, user)
		return
	return ..()

/obj/structure/machinery/fabricator_vehicle/proc/recycle_equipment(obj/item/powerloader_clamp/powerloader_clamp_used, mob/living/user)
	if(!powerloader_clamp_used.loaded)
		to_chat(user, SPAN_WARNING("There is nothing loaded in \the [powerloader_clamp_used]."))
		return

	var/recycle_points
	if(istype(powerloader_clamp_used.loaded, /obj/structure/dropship_equipment))
		var/obj/structure/dropship_equipment/sold_eqipment = powerloader_clamp_used.loaded
		recycle_points = sold_eqipment.point_cost
	else if(istype(powerloader_clamp_used.loaded, /obj/structure/ship_ammo))
		var/obj/structure/ship_ammo/sold_eqipment = powerloader_clamp_used.loaded
		if(!sold_eqipment.ammo_count)
			to_chat(user, SPAN_WARNING("\The [sold_eqipment] is empty!"))
			return
		if(sold_eqipment.ammo_count != sold_eqipment.max_ammo_count)
			recycle_points = (sold_eqipment.point_cost * (sold_eqipment.ammo_count / sold_eqipment.max_ammo_count))
			to_chat(user, SPAN_WARNING("\The [sold_eqipment] is not fully loaded, and less points will be able to be refunded."))
		else
			recycle_points = sold_eqipment.point_cost

	if(!recycle_points)
		to_chat(user, SPAN_WARNING("\The [powerloader_clamp_used.loaded] can't be recycled!"))
		return

	var/thing_to_recycle = powerloader_clamp_used.loaded
	to_chat(user, SPAN_WARNING("You start recycling \the [powerloader_clamp_used.loaded]!"))
	playsound(loc, 'sound/machines/hydraulics_1.ogg', 40, 1)
	if(!user || !do_after(user, (3 SECONDS) * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_HOSTILE, powerloader_clamp_used.loaded, INTERRUPT_ALL))
		to_chat(user, SPAN_NOTICE("You stop recycling \the [thing_to_recycle]."))
		return
	for(var/obj/thing as anything in powerloader_clamp_used.loaded)
		thing.forceMove(loc) // no sentries popping out when we qdel please
		qdel(thing)
	qdel(powerloader_clamp_used.loaded)
	powerloader_clamp_used.loaded = null
	to_chat(user, SPAN_NOTICE("You recycle \the [thing_to_recycle] into [src], and get back [floor(recycle_points * 0.8)] points."))
	msg_admin_niche("[key_name(user)] recycled a [thing_to_recycle] into \the [src] for [floor(recycle_points * 0.8)] points.")
	add_to_point_store(floor(recycle_points * 0.8))
	playsound(loc, 'sound/machines/fax.ogg', 40, 1)
	powerloader_clamp_used.update_icon()
