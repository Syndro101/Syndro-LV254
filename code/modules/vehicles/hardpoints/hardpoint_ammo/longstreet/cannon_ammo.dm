/obj/item/ammo_magazine/hardpoint/primary/longstreet/he
	name = "80mm M74 HE Cannon Shell"
	desc = "A relatively medium-velocity high-explosive cannon round used to clear infantry to devestating effect, not particularly useful against armor."
	caliber = "80mm" //Making this unique on purpose
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	icon_state = "ltbcannon_1"
	w_class = SIZE_LARGE //Heavy fucker
	default_ammo = /datum/ammo/rocket/ltb
	max_rounds = 1
	gun_type = /obj/item/hardpoint/primary/longstreet/cannon
	point_cost = 400

/obj/item/ammo_magazine/hardpoint/primary/longstreet/he/update_icon()
	if(current_rounds <= 0)
		icon_state = "ltbcannon_0"

/obj/item/ammo_magazine/hardpoint/primary/longstreet/ap
	name = "80mm M23 AP Cannon Shell"
	desc = "A high-velocity armor-piercing cannon round used to take out enemy armor."
	caliber = "80mm" //Making this unique on purpose
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	icon_state = "ltbcannon_ap_1"
	w_class = SIZE_LARGE //Heavy fucker
	default_ammo = /datum/ammo/rocket/ap/ltb
	max_rounds = 1
	gun_type = /obj/item/hardpoint/primary/longstreet/cannon
	point_cost = 600

/obj/item/ammo_magazine/hardpoint/primary/longstreet/ap/update_icon()
	if(current_rounds <= 0)
		icon_state = "ltbcannon_0"
