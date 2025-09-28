/obj/item/ammo_magazine/hardpoint/secondary/apc/flare_launcher
	name = "M-87F Flare Launcher Magazine"
	desc = "A support armament grenade magazine. This one is loaded with APC flares packaged in expendable shells."
	caliber = "flare"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	icon_state = "flauncher_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/flare
	max_rounds = 6
	gun_type = /obj/item/hardpoint/support/apc/flare_launcher
	point_cost = 150

/obj/item/ammo_magazine/hardpoint/secondary/apc/flare_launcher/update_icon()
	icon_state = "flauncher_[current_rounds <= 0 ? "0" : "1"]"
