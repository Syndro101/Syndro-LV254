/obj/item/ammo_magazine/hardpoint/secondary/apc/frontalcannon
	name = "RE-RE700 Frontal Cannon magazine"
	desc = "A big box of bullets that looks suspiciously similar to the box you would use to refill a M56 Cupola. The Bleihagel logo sticker has peeled slightly and it looks like there's another logo underneath..."
	caliber = "10x28mm" //Correlates to smartguns
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	icon_state = "frontal_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/machinegun
	max_rounds = 600
	gun_type = /obj/item/hardpoint/secondary/apc/frontalcannon
	point_cost = 150

/obj/item/ammo_magazine/hardpoint/secondary/apc/frontalcannon/update_icon()
	icon_state = "frontal_[current_rounds <= 0 ? "0" : "1"]"
