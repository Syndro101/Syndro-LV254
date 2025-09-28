/obj/item/ammo_magazine/hardpoint/primary/lav/chaingun
	name = "PARS 40/70 Chaingun Box Magazine"
	desc = "A box magazine for 40/70 Boyars Chaingun filled with 40mm rounds. 'Slightly' contuses targets upon hit. Non-IFF, watch your fire."
	caliber = "40mm"
	icon_state = "chaingun_4"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/lav
	max_rounds = 50
	gun_type = /obj/item/hardpoint/primary/lav/chaingun
	point_cost = 400

/obj/item/ammo_magazine/hardpoint/primary/lav/chaingun/update_icon()
	if(current_rounds > 40)
		icon_state = "chaingun_4"
	else if(current_rounds > 30)
		icon_state = "chaingun_3"
	else if(current_rounds > 20)
		icon_state = "chaingun_2"
	else if(current_rounds > 0)
		icon_state = "chaingun_1"
	else
		icon_state = "chaingun_0"

/obj/item/ammo_magazine/hardpoint/primary/lav/chaingun/ap
	name = "PARS 40/70 AP Chaingun Box Magazine"
	desc = "A box magazine for 40/70 Boyars Chaingun filled with armor-piercing 40mm rounds. 'Slightly' contuses targets upon hit. Non-IFF, watch your fire."
	icon_state = "chaingun_ap_4"
	default_ammo = /datum/ammo/bullet/lav/ap
	point_cost = 500

/obj/item/ammo_magazine/hardpoint/primary/lav/chaingun/ap/update_icon()
	if(current_rounds > 40)
		icon_state = "chaingun_ap_4"
	else if(current_rounds > 30)
		icon_state = "chaingun_ap_3"
	else if(current_rounds > 20)
		icon_state = "chaingun_ap_2"
	else if(current_rounds > 0)
		icon_state = "chaingun_ap_1"
	else
		icon_state = "chaingun_ap_0"

/obj/item/ammo_magazine/hardpoint/primary/lav/chaingun/he
	name = "PARS 40/70 HE Chaingun Box Magazine"
	desc = "A box magazine for 40/70 Boyars Chaingun filled with explosive 40mm rounds. 'Slightly' contuses targets upon hit. Non-IFF, watch your fire."
	icon_state = "chaingun_he_4"
	default_ammo = /datum/ammo/bullet/lav/he
	point_cost = 800

/obj/item/ammo_magazine/hardpoint/chaingun/he/update_icon()
	if(current_rounds > 40)
		icon_state = "chaingun_he_4"
	else if(current_rounds > 30)
		icon_state = "chaingun_he_3"
	else if(current_rounds > 20)
		icon_state = "chaingun_he_2"
	else if(current_rounds > 0)
		icon_state = "chaingun_he_1"
	else
		icon_state = "chaingun_he_0"
