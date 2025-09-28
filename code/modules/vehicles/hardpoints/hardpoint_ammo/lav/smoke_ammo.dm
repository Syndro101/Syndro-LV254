/obj/item/ammo_magazine/hardpoint/secondary/lav/smoke
	name = "M90-L Smoke Grenade Magazine"
	desc = "A smoke grenades magazine used by LAVs."
	caliber = "grenade"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	icon_state = "slauncher_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/grenade_container/smoke
	max_rounds = 6
	gun_type = /obj/item/hardpoint/support/lav/smoke_launcher
	point_cost = 200

/obj/item/ammo_magazine/hardpoint/secondary/lav/smoke/update_icon()
	icon_state = "slauncher_[current_rounds <= 0 ? "0" : "1"]"
