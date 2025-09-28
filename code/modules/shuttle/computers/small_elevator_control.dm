/obj/structure/machinery/computer/shuttle/small/elevator_call
	name = "\improper Elevator Call"
	desc = "Control panel for the elevator"
	shuttleId = MOBILE_SMALL_ELEVATOR
	is_call = TRUE
	var/dockId
	var/datum/elevator/destination/site

/obj/structure/machinery/computer/shuttle/small/elevator_call/get_landing_zones()
	return list(SSshuttle.getDock(dockId))

/obj/structure/machinery/computer/shuttle/small/elevator_call/A
	dockId = STAT_SMALL_A

/obj/structure/machinery/computer/shuttle/small/elevator_call/B
	dockId = STAT_SMALL_B

/obj/structure/machinery/computer/shuttle/small/elevator_call/C
	dockId = STAT_SMALL_C

/obj/structure/machinery/computer/shuttle/small
	name = "\improper Elevator Panel"
	desc = "Control panel for the elevator"
	icon = 'icons/obj/structures/machinery/computer.dmi'
	icon_state = "elevator_screen"

	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE
	density = FALSE
	req_access = null
	needs_power = TRUE
	var/is_call = FALSE

/obj/structure/machinery/computer/shuttle/small/proc/get_landing_zones()
	. = list()
	var/obj/docking_port/mobile/small/shuttle = SSshuttle.getShuttle(shuttleId)

	for(var/obj/docking_port/stationary/small/elev in SSshuttle.stationary)
		if(!shuttle.elevator_network)
			. += list(elev)
			continue
		if(shuttle.elevator_network == elev.elevator_network)
			. += list(elev)
			continue

/obj/structure/machinery/computer/shuttle/small/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ElevatorControl", "Elevator Panel")
		ui.open()

/obj/structure/machinery/computer/shuttle/small/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/computer/shuttle/small/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	if(inoperable())
		to_chat(user, SPAN_WARNING("The panel is inoperable."))
		return UI_CLOSE

/obj/structure/machinery/computer/shuttle/small/ui_data(mob/user)
	. = ..()
	var/obj/docking_port/mobile/shuttle = SSshuttle.getShuttle(shuttleId)
	var/obj/docking_port/stationary/dockedAt = shuttle.get_docked()
	.["docked_at"] = list("id"= dockedAt.id, "name" = dockedAt.name)
	.["destination"] = shuttle.destination
	.["mode"] = shuttle.mode
	.["eta"] = shuttle.timeLeft(0)

/obj/structure/machinery/computer/shuttle/small/ui_static_data(mob/user)
	. = ..()
	var/obj/docking_port/mobile/shuttle = SSshuttle.getShuttle(shuttleId)
	var/list/stops = get_landing_zones()
	.["destinations"] = list()
	for(var/obj/docking_port/stationary/dock as anything in stops)
		var/list/dockinfo = list(
			"id" = dock.id,
			"name" = dock.name,
		)
		.["destinations"] += list(dockinfo)
	.["max_flight_duration"] = shuttle.callTime / 10
	.["max_pre_arrival_duration"] = shuttle.prearrivalTime / 10
	.["max_refuel_duration"] = shuttle.rechargeTime / 10
	.["max_engine_start_duration"] = shuttle.ignitionTime / 10
	.["is_call_button"] = is_call

/obj/structure/machinery/computer/shuttle/small/attack_hand(mob/user)
	. = ..(user)
	if(.)
		return TRUE

	tgui_interact(user)

/obj/structure/machinery/computer/shuttle/small/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	var/obj/docking_port/mobile/shuttle = SSshuttle.getShuttle(shuttleId)
	switch(action)
		if("move")
			if(shuttle.mode != SHUTTLE_IDLE)
				return
			var/dockId = params["target"]
			if(!dockId)
				return
			var/obj/docking_port/stationary/dockedAt = shuttle.get_docked()
			if(dockedAt.id == dockId)
				return
			SSshuttle.moveShuttle(shuttle.id, dockId, TRUE)
			return TRUE
		if("button-push")
			playsound(loc, get_sfx("terminal_button"), KEYBOARD_SOUND_VOLUME * 2, 1)
			return FALSE
