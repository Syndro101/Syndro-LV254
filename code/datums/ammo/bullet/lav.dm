/*
//======
					Chaingun Ammo
//======
*/


// Normal limited-AP, non-explosive rounds
/datum/ammo/bullet/lav
	name = "40mm Chaingun round"
	icon_state = "autocannon"
	sound_hit  = 'sound/weapons/sting_boom_small1.ogg'
	damage_falloff = 2
	flags_ammo_behavior = AMMO_BALLISTIC
	accurate_range_min = 2
	accuracy = HIT_ACCURACY_TIER_8
	scatter = 1
	damage = 90
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	penetration = ARMOR_PENETRATION_TIER_10
	vehicle_pen = VEHICLE_PEN_MEDIUM_ARMOR
	accurate_range = 14
	max_range = 24
	shell_speed = AMMO_SPEED_TIER_8
	at_shell = TRUE

/datum/ammo/bullet/lav/ap
	name = "40mm AP Chaingun round"
	damage = 80
	vehicle_pen = VEHICLE_PEN_HEAVY_ARMOR

/datum/ammo/bullet/lav/he
	name = "40mm HE Chaingun round"
	damage = 80
	vehicle_pen = VEHICLE_PEN_HEAVY_ARMOR
	he_shell = TRUE
	heat_shell = TRUE

/datum/ammo/bullet/lav/he/on_hit_mob(mob/mob, obj/projectile/projectile)
	cell_explosion(get_turf(mob), 30, 100, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL, null, projectile.weapon_cause_data)

	for(var/mob/living/carbon/L in get_turf(mob))
		if(L.stat == CONSCIOUS && L.mob_size <= MOB_SIZE_XENO)
			shake_camera(L, 1, 1)

/datum/ammo/bullet/lav/he/on_hit_turf(turf/turf,obj/projectile/projectile)
	cell_explosion(get_turf(turf), 30, 100, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL, null, projectile.weapon_cause_data)

	for(var/mob/living/carbon/L in turf)
		if(L.stat == CONSCIOUS && L.mob_size <= MOB_SIZE_XENO)
			shake_camera(L, 1, 1)

// Plasma Cannon

/datum/ammo/bullet/lav_plasma
	name = "medium plasma bolt"
	icon_state = "pulse"
	sound_hit  = 'sound/weapons/alien_acidstrike1.ogg'
	damage_falloff = 2
	damage_type = BURN
	flags_ammo_behavior = AMMO_ENERGY || AMMO_HITS_TARGET_TURF
	accurate_range_min = 2
	accuracy = HIT_ACCURACY_TIER_8
	scatter = 1
	damage = 120
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	penetration = ARMOR_PENETRATION_TIER_10
	vehicle_pen = VEHICLE_PEN_HEAVY_ARMOR
	accurate_range = 16
	max_range = 24
	shell_speed = AMMO_SPEED_TIER_8
	plasma_he_shell = TRUE
	plasma_shell = TRUE

/datum/ammo/bullet/lav_plasma/on_hit_mob(mob/mob, obj/projectile/projectile)
	cell_explosion(get_turf(mob), 150, 60, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)

	for(var/mob/living/carbon/L in get_turf(mob))
		if(L.stat == CONSCIOUS && L.mob_size <= MOB_SIZE_XENO)
			shake_camera(L, 1, 1)

/datum/ammo/bullet/lav_plasma/on_hit_turf(turf/turf,obj/projectile/projectile)
	cell_explosion(get_turf(turf), 150, 60, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)

	for(var/mob/living/carbon/L in turf)
		if(L.stat == CONSCIOUS && L.mob_size <= MOB_SIZE_XENO)
			shake_camera(L, 1, 1)

