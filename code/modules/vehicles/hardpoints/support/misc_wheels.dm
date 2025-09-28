/obj/item/hardpoint/support/locomotion
	name = "vehicle wheels"
	desc = "Integral to the movement of the van"
	icon = 'icons/obj/vehicles/hardpoints/misc_wheels.dmi'

	icon_state = "tires"
	disp_icon = "van"
	disp_icon_state = "wheels"

	slot = HDPT_WHEELS

	health = 250

	move_delay = VEHICLE_SPEED_VERYFAST

/obj/item/hardpoint/support/locomotion/truck
	name = "military wheels"
	desc = "Integral to the movement of military grade vehicles."
	icon_state = "Military_wheels"
	disp_icon = "truck"
	disp_icon_state = "miltruckwheels"

/obj/item/hardpoint/support/locomotion/minitruck
	name = "Heavy offroad wheels"
	desc = "Integral to the movement of industrial grade vehicles."
	icon_state = "minitruckwheels"
	disp_icon = "minitruck"
	disp_icon_state = "minitruckwheels"

/obj/item/hardpoint/support/locomotion/civtruck
	name = "civilian truck wheels"
	desc = "Integral to the movement of the civilian trucks."
	icon_state = "Civilian_truck_wheels"
	disp_icon = "truck"
	disp_icon_state = "civtruckwheels"

/obj/item/hardpoint/support/locomotion/civvan
	name = "civilian van wheels"
	desc = "Integral to the movement of the civilian van."
	icon_state = "Civilian_van_wheels"
	disp_icon = "truck"
	disp_icon_state = "civvanwheels"
	health = 50

/obj/item/hardpoint/support/locomotion/atruck
	name = "Truck Tires"
	desc = "Integral to the movement of the armored truck."
	icon_state = "atruckwheels"
	disp_icon = "atruckwheels"
	disp_icon_state = "atruckwheels"

	health = 500

/obj/item/hardpoint/support/locomotion/treads
	name = "light treads"
	desc = "Integral to the movement of the military truck."
	icon_state = "Light_treads"
	disp_icon = "truck"
	disp_icon_state = "miltrucktreads"

	health = 500

	//with this settings, takes 3 tiles to reach top speed
	move_delay = 3.8
	move_max_momentum = 3
	move_momentum_build_factor = 1.8
	move_turn_momentum_loss_factor = 0.6

/obj/item/hardpoint/support/locomotion/treads/crane
	name = "crane treads"
	desc = "Integral to the movement of the crane."
	icon_state = "Crane_treads"
	disp_icon = "truck"
	disp_icon_state = "cranetreads"


