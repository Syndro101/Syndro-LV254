/obj/item/pamphlet/skill/vc
	name = "vehicle training manual"
	desc = "A manual used to quickly impart vital knowledge on driving vehicles."
	icon_state = "pamphlet_vehicle"
	trait = /datum/character_trait/skills/vc
	bypass_pamphlet_limit = TRUE

/obj/item/vehicle_coupon/attack_self(mob/user)
	if(QDELETED(src))
		return
	if(redeem_vehicle())
		to_chat(user, SPAN_WARNING("\The [src] catches fire as it is read and resets the ASRS Vehicle system! Send the lift down and haul your prize up."))
		qdel(src)
	return ..()

/obj/item/vehicle_coupon/proc/redeem_vehicle(mob/user)
	SHOULD_NOT_SLEEP(TRUE)
	. = FALSE
	var/obj/structure/machinery/computer/supply/asrs/vehicle/comp = GLOB.VehicleElevatorConsole
	var/obj/structure/machinery/cm_vending/gear/vehicle_crew/gearcomp = GLOB.VehicleGearConsole

	if(!comp || !gearcomp)
		return

	. = TRUE

	comp.req_access = list()
	comp.req_one_access = list()

	gearcomp.req_access = list()
	gearcomp.req_one_access = list()
	gearcomp.vendor_role = list()
	gearcomp.available_categories = VEHICLE_ALL_AVAILABLE

	return TRUE
