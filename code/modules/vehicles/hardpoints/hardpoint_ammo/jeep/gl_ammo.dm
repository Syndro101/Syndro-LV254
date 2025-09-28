/obj/item/ammo_magazine/hardpoint/primary/jeep/grenade
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

/obj/item/ammo_magazine/hardpoint/primary/jeep/grenade/update_icon()
	if(current_rounds >= max_rounds)
		icon_state = "glauncher_2"
	else if(current_rounds <= 0)
		icon_state = "glauncher_0"
	else
		icon_state = "glauncher_1"

/obj/item/ammo_magazine/hardpoint/primary/jeep/grenade/teargas
	name = "Dispersal System Magazine (Teargas)"
	desc = "A magazine loaded with M66 Teargas grenades. Used to reload the magazine-fed R10T Dispersal System."
	icon_state = "rlauncher_2"
	default_ammo = /datum/ammo/grenade_container/teargas
	gun_type = /obj/item/hardpoint/primary/jeep/grenade_launcher/riot
	point_cost = 300

/obj/item/ammo_magazine/hardpoint/grenade/teargas/update_icon()
	if(current_rounds >= max_rounds)
		icon_state = "rlauncher_2"
	else if(current_rounds <= 0)
		icon_state = "rlauncher_0"
	else
		icon_state = "rlauncher_1"
