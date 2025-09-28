/obj/item/hardpoint/support/longstreet/treads
	name = "\improper Treads"
	desc = "Integral to the movement of the tank. Heavy steel-corded polyurethane tracks finished in an acid-resistant coating, pretty damn heavy."

	icon_state = "treads"
	disp_icon = "tank"
	disp_icon_state = "treads"

	slot = HDPT_TREADS
	acid_resistant = TRUE

	health = 500
	point_cost = 300

	//with this settings, takes 4 tiles to reach top speed
	move_delay = 3.5
	move_max_momentum = 4
	move_momentum_build_factor = 1.8
	move_turn_momentum_loss_factor = 0.6

/obj/item/hardpoint/support/longstreet/treads/on_install(obj/vehicle/multitile/V)
	for(var/obj/item/hardpoint/support/longstreet/overdrive/OD in V.hardpoints)
		if(OD.health > 0)
			OD.apply_buff(V)
	if(move_delay)
		V.move_delay = move_delay
	if(move_max_momentum)
		V.move_max_momentum = move_max_momentum
	if(move_momentum_build_factor)
		V.move_momentum_build_factor = move_momentum_build_factor
	if(move_turn_momentum_loss_factor)
		V.move_turn_momentum_loss_factor = move_turn_momentum_loss_factor

/obj/item/hardpoint/support/longstreet/treads/deactivate()
	for(var/obj/item/hardpoint/support/longstreet/overdrive/OD in owner.hardpoints)
		if(OD.health > 0)
			OD.remove_buff(owner)
	owner.move_delay = initial(owner.move_delay)
	owner.move_max_momentum = initial(owner.move_max_momentum)
	owner.move_momentum_build_factor = initial(owner.move_momentum_build_factor)
	owner.move_turn_momentum_loss_factor = initial(owner.move_turn_momentum_loss_factor)
