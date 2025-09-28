/obj/item/ammo_magazine/hardpoint/primary/jeep/m56_cupola
	name = "M56 Vehicle Drum"
	desc = "A heavy drum of 300, 10x28mm caseless tungsten rounds for the M56D heavy machine gun, usually mounted on jeeps that cant take the bigger ammo boxes."
	caliber = "10x28mm" //Correlates to smartguns
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	icon_state = "m56d_drum_large_1"
	w_class = SIZE_LARGE

	max_rounds = 300
	gun_type = /obj/item/hardpoint/primary/jeep/m56
	point_cost = 200

/obj/item/ammo_magazine/hardpoint/primary/jeep/m56_cupola/update_icon()
	icon_state = "m56d_drum_large_[current_rounds <= 0 ? "0" : "1"]"

/obj/item/ammo_magazine/hardpoint/primary/jeep/m56_cupola/hmg
	name = "M2C Vehicle Box"
	desc = "A heavy box of 200, 12x40mm tungsten rounds for the M2C heavy machine gun, usually mounted on jeeps that cant take the bigger ammo boxes."
	caliber = "12x40mm"
	icon_state = "m2c_large_1"

	default_ammo = /datum/ammo/bullet/machinegun/auto

	max_rounds = 200
	gun_type = /obj/item/hardpoint/primary/jeep/m56/hmg
	point_cost = 300

/obj/item/ammo_magazine/hardpoint/m56_cupola/jeep/hmg/update_icon()
	icon_state = "m2c_large_[current_rounds <= 0 ? "0" : "1"]"
