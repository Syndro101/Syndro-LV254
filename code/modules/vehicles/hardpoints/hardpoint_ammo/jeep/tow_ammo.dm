/obj/item/ammo_magazine/hardpoint/primary/jeep/missile
	name = "TOW Missile"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	desc = "A large anti-tank guided missile offering serious performance against heavy armor."
	caliber = "rocket" //correlates to any rocket mags
	icon_state = "tow_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/rocket/ap/tank_towlauncher
	max_rounds = 1
	gun_type = /obj/item/hardpoint/primary/jeep/towlauncher || /obj/item/hardpoint/secondary/longstreet/towlauncher
	point_cost = 600

/obj/item/ammo_magazine/hardpoint/primary/jeep/missile/update_icon()
	if(current_rounds > 0)
		icon_state = "tow_1"
	else
		name = "Spent TOW Missile"
		desc = "A large anti-tank guided missile offering serious performance against heavy armor, all that remains is the rear cap."
		icon_state = "tow_0"
