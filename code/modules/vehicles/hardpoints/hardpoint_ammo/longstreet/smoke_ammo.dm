/obj/item/ammo_magazine/hardpoint/secondary/longstreet/smoke
	name = "Turret Smoke Screen Magazine"
	desc = "A smoke grenades magazine used by tanks."
	caliber = "grenade"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	icon_state = "slauncher_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/grenade_container/smoke
	max_rounds = 6
	gun_type = /obj/item/hardpoint/support/longstreet/tank_turret
	point_cost = 200

/obj/item/ammo_magazine/hardpoint/secondary/longstreet/smoke/update_icon()
	icon_state = "slauncher_[current_rounds <= 0 ? "0" : "1"]"
