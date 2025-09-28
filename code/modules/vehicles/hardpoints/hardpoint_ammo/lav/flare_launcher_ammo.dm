/obj/item/ammo_magazine/hardpoint/secondary/lav/flare_launcher
	name = "M-87FL Flare Launcher Magazine"
	desc = "A support armament grenade magazine. This one is loaded with LAV flares packaged in expendable shells."
	caliber = "flare"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	icon_state = "flauncher_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/flare
	max_rounds = 6
	gun_type = /obj/item/hardpoint/support/lav/flare_launcher
	point_cost = 200

/obj/item/ammo_magazine/hardpoint/secondary/lav/flare_launcher/update_icon()
	icon_state = "flauncher_[current_rounds <= 0 ? "0" : "1"]"
