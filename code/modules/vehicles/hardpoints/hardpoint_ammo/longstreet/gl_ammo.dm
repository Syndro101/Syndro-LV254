/obj/item/ammo_magazine/hardpoint/secondary/longstreet/grenade
	name = "Grenade Launcher Magazine"
	desc = "A magazine loaded with M40 grenades. Used to reload the magazine-fed M92T or FRA9-V Grenade launcher."
	caliber = "grenade"
	icon_state = "glauncher_2"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/grenade_container/grenade
	max_rounds = 20
	gun_type = /obj/item/hardpoint/primary/jeep/grenade_launcher || /obj/item/hardpoint/secondary/longstreet/grenade_launcher
	point_cost = 400

/obj/item/ammo_magazine/hardpoint/secondary/longstreet/grenade/update_icon()
	if(current_rounds >= max_rounds)
		icon_state = "glauncher_2"
	else if(current_rounds <= 0)
		icon_state = "glauncher_0"
	else
		icon_state = "glauncher_1"
