/obj/item/ammo_magazine/hardpoint/primary/lav/plasma
	name = "PARS 20mW Hydrogen Fuel Cell"
	desc = "A self-contained hydrogen fuel cell that powers the inner workings of plasma-based weaponry, with the resulting bolts roasting anything in their path. Non-IFF, watch your fire."
	caliber = "20mW"
	icon_state = "plasma_cell_4"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/lav_plasma
	max_rounds = 10
	gun_type = /obj/item/hardpoint/primary/lav/plasma
	point_cost = 600

/obj/item/ammo_magazine/hardpoint/primary/lav/plasma/update_icon()
	if(current_rounds > 8)
		icon_state = "plasma_cell_4"
	else if(current_rounds > 5)
		icon_state = "plasma_cell_3"
	else if(current_rounds > 2)
		icon_state = "plasma_cell_2"
	else if(current_rounds > 0)
		icon_state = "plasma_cell_1"
	else
		icon_state = "plasma_cell_0"
