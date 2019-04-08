//-------------------------------------------------------

/obj/item/weapon/gun/rifle
	reload_sound = 'sound/weapons/gun_rifle_reload.ogg'
	cocked_sound = 'sound/weapons/gun_cocked2.ogg'
	origin_tech = "combat=4;materials=3"
	flags_equip_slot = SLOT_BACK
	w_class = 4
	force = 15
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK
	aim_slowdown = SLOWDOWN_ADS_RIFLE
	wield_delay = WIELD_DELAY_NORMAL
	gun_skill_category = GUN_SKILL_RIFLES

/obj/item/weapon/gun/rifle/New()
	..()
	if(current_mag && current_mag.current_rounds > 0) load_into_chamber()

/obj/item/weapon/gun/rifle/set_gun_config_values()
	fire_delay = config.mhigh_fire_delay
	burst_amount = config.med_burst_value
	burst_delay = config.mlow_fire_delay
	accuracy_mult = config.base_hit_accuracy_mult
	accuracy_mult_unwielded = config.base_hit_accuracy_mult - config.high_hit_accuracy_mult
	scatter = config.med_scatter_value
	scatter_unwielded = config.max_scatter_value
	damage_mult = config.base_hit_damage_mult
	recoil_unwielded = config.high_recoil_value

/obj/item/weapon/gun/rifle/unique_action(mob/user)
	cock(user)


//-------------------------------------------------------
//M41A PULSE RIFLE

/obj/item/weapon/gun/rifle/m41a
	name = "\improper M41A pulse rifle MK2"
	desc = "The standard issue rifle of the Colonial Marines. Commonly carried by most combat personnel. Uses 10x24mm caseless ammunition."
	icon_state = "m41a"
	item_state = "m41a"
	fire_sound = "gun_pulse"
	current_mag = /obj/item/ammo_magazine/rifle
	attachable_allowed = list(
						/obj/item/attachable/suppressor,
						/obj/item/attachable/bayonet,
						/obj/item/attachable/reddot,
						/obj/item/attachable/reflex,
						/obj/item/attachable/verticalgrip,
						/obj/item/attachable/angledgrip,
						/obj/item/attachable/flashlight/grip,
						/obj/item/attachable/lasersight,
						/obj/item/attachable/gyro,
						/obj/item/attachable/flashlight,
						/obj/item/attachable/bipod,
						/obj/item/attachable/extended_barrel,
						/obj/item/attachable/heavy_barrel,
						/obj/item/attachable/burstfire_assembly,
						/obj/item/attachable/magnetic_harness,
						/obj/item/attachable/stock/rifle,
						/obj/item/attachable/attached_gun/grenade,
						/obj/item/attachable/attached_gun/flamer,
						/obj/item/attachable/attached_gun/shotgun,
						/obj/item/attachable/scope,
						/obj/item/attachable/scope/mini)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade)

/obj/item/weapon/gun/rifle/m41a/New()
	select_gamemode_skin(/obj/item/weapon/gun/rifle/m41a)
	..()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 23, "under_x" = 24, "under_y" = 13, "stock_x" = 24, "stock_y" = 13)

/obj/item/weapon/gun/rifle/m41a/set_gun_config_values()
	fire_delay = config.med_fire_delay
	burst_amount = config.med_burst_value
	burst_delay = config.mlow_fire_delay
	accuracy_mult = config.base_hit_accuracy_mult
	accuracy_mult_unwielded = config.base_hit_accuracy_mult - config.high_hit_accuracy_mult
	scatter = config.med_scatter_value
	burst_scatter_mult = config.med_scatter_value
	scatter_unwielded = config.max_scatter_value
	damage_mult = config.base_hit_damage_mult
	recoil_unwielded = config.high_recoil_value


//variant without ugl attachment
/obj/item/weapon/gun/rifle/m41a/stripped
	starting_attachment_types = list()

/obj/item/weapon/gun/rifle/m41a/stripped/New()
	select_gamemode_skin(/obj/item/weapon/gun/rifle/m41a/stripped)
	. = ..()

//-------------------------------------------------------
//M41A PMC VARIANT

/obj/item/weapon/gun/rifle/m41a/elite
	name = "\improper M41A/2 battle rifle"
	desc = "A reinforced and remachined version of the tried and tested M41A Pulse Rifle MK2. Given only to elite units."
	icon_state = "m41a2"
	item_state = "m41a2"
	origin_tech = "combat=7;materials=5"
	current_mag = /obj/item/ammo_magazine/rifle/ap
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_WY_RESTRICTED


/obj/item/weapon/gun/rifle/m41a/elite/set_gun_config_values()
	fire_delay = config.med_fire_delay
	burst_amount = config.med_burst_value
	burst_delay = config.mlow_fire_delay
	accuracy_mult = config.base_hit_accuracy_mult + config.max_hit_accuracy_mult
	accuracy_mult_unwielded = config.base_hit_accuracy_mult - config.high_hit_accuracy_mult
	scatter = config.med_scatter_value
	burst_scatter_mult = config.med_scatter_value
	scatter_unwielded = config.max_scatter_value
	damage_mult = config.base_hit_damage_mult + config.max_hit_damage_mult
	recoil_unwielded = config.high_recoil_value


//-------------------------------------------------------
//M41A TRUE AND ORIGINAL

/obj/item/weapon/gun/rifle/m41aMK1
	name = "\improper M41A pulse rifle"
	desc = "An older design of the Pulse Rifle commonly used by Colonial Marines. Uses 10x24mm caseless ammunition."
	icon_state = "m41amk1" //Placeholder.
	item_state = "m41amk1" //Placeholder.
	fire_sound = "gun_pulse"
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1
	attachable_allowed = list(
						/obj/item/attachable/bayonet,
						/obj/item/attachable/reddot,
						/obj/item/attachable/reflex,
						/obj/item/attachable/attached_gun/grenade,
						/obj/item/attachable/attached_gun/flamer,
						/obj/item/attachable/attached_gun/shotgun)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER

/obj/item/weapon/gun/rifle/m41aMK1/New()
	..()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 23, "under_x" = 24, "under_y" = 13, "stock_x" = 24, "stock_y" = 13)

/obj/item/weapon/gun/rifle/m41aMK1/set_gun_config_values()
	fire_delay = config.mhigh_fire_delay
	burst_amount = config.high_burst_value
	burst_delay = config.mlow_fire_delay
	accuracy_mult = config.base_hit_accuracy_mult - config.min_hit_accuracy_mult
	accuracy_mult_unwielded = config.base_hit_accuracy_mult - config.high_hit_accuracy_mult
	scatter = config.med_scatter_value
	burst_scatter_mult = config.med_scatter_value
	scatter_unwielded = config.max_scatter_value
	damage_mult = config.base_hit_damage_mult + config.min_hit_damage_mult
	recoil_unwielded = config.high_recoil_value

//----------------------------------------------
//Special gun for the CO to replace the smartgun
//Attachment points need fixing

/obj/item/weapon/gun/rifle/m46c
	name = "\improper M46C pulse rifle"
	desc = "A prototype M46C, an experimental rifle platform built to outperform the standard M41A. Back issue only. Uses standard MK1 & MK2 rifle magazines."
	icon_state = "m46c"
	item_state = "m46c"
	fire_sound = "gun_pulse"
	current_mag = /obj/item/ammo_magazine/rifle/incendiary
	accepted_ammo = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/rifle/extended,
		/obj/item/ammo_magazine/rifle/incendiary,
		/obj/item/ammo_magazine/rifle/ap,
		/obj/item/ammo_magazine/rifle/m41aMK1
	)
	//somewhere in between the mk1 and mk2
	attachable_allowed = list(
						/obj/item/attachable/suppressor,
						/obj/item/attachable/bayonet,
						/obj/item/attachable/reddot,
						/obj/item/attachable/reflex,
						/obj/item/attachable/flashlight,
						/obj/item/attachable/extended_barrel,
						/obj/item/attachable/heavy_barrel,
						/obj/item/attachable/magnetic_harness,
						/obj/item/attachable/scope/mini,
						/obj/item/attachable/verticalgrip,
						/obj/item/attachable/angledgrip,
						/obj/item/attachable/flashlight/grip,
						/obj/item/attachable/attached_gun/grenade,
						/obj/item/attachable/attached_gun/flamer,
						/obj/item/attachable/attached_gun/shotgun)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER

	toggle_burst()
		var/obj/item/weapon/gun/G = get_active_firearm(usr)
		if(!G) return
		src = G
		if(flags_gun_features & GUN_BURST_FIRING)//can't toggle mid burst
			return
		if(burst_amount == config.med_burst_value && (flags_gun_features & GUN_BURST_ON))
			playsound(usr, 'sound/machines/click.ogg', 15, 1)
			usr << "<span class='notice'>\icon[src] You set [src] to full auto mode.</span>"
			burst_amount = config.mhigh_burst_value
			burst_scatter_mult = config.high_scatter_value
			return
		if(burst_amount == config.mhigh_burst_value && !(flags_gun_features & GUN_BURST_ON))
			flags_gun_features |= GUN_BURST_ON
			playsound(usr, 'sound/machines/click.ogg', 15, 1)
			usr << "<span class='notice'>\icon[src] You set [src] to semi auto mode.</span>"
			burst_amount = config.med_burst_value
			burst_scatter_mult = config.low_scatter_value
			return
		. = ..()

/obj/item/weapon/gun/rifle/m46c/New()
	..()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17, "rail_x" = 12, "rail_y" = 18, "under_x" = 24, "under_y" = 12, "stock_x" = 24, "stock_y" = 13)

/obj/item/weapon/gun/rifle/m46c/New()
	..()
	var/obj/item/attachable/stock/rifle/S = new(src)
	S.flags_attach_features &= ~ATTACH_REMOVABLE
	S.attach_icon = ""
	S.icon_state = ""
	S.Attach(src)
	update_attachable(S.slot)
	S.icon_state = initial(S.icon_state)

/obj/item/weapon/gun/rifle/m46c/proc/name_after_co(var/mob/living/carbon/human/H, var/obj/item/weapon/gun/rifle/m46c/I)
	I.desc = "A prototype M46C, an experimental rifle platform built to outperform the standard M41A. Back issue only. Uses standard MK1 & MK2 rifle magazines. Property of [H.real_name]"
	return

/obj/item/weapon/gun/rifle/m46c/set_gun_config_values()
	fire_delay = config.mhigh_fire_delay
	burst_amount = config.mhigh_burst_value
	burst_delay = config.mlow_fire_delay
	accuracy_mult = config.base_hit_accuracy_mult + config.hmed_hit_accuracy_mult
	accuracy_mult_unwielded = config.base_hit_accuracy_mult - config.high_hit_accuracy_mult
	scatter = config.low_scatter_value
	burst_scatter_mult = config.low_scatter_value
	scatter_unwielded = config.max_scatter_value
	damage_mult = config.base_hit_damage_mult + config.min_hit_damage_mult
	recoil_unwielded = config.high_recoil_value

//-------------------------------------------------------
//MAR-40 AK CLONE //AK47 and FN FAL together as one.


/obj/item/weapon/gun/rifle/mar40
	name = "\improper MAR-40 battle rifle"
	desc = "A cheap, reliable assault rifle chambered in 7.62x39mm. Commonly found in the hands of criminals or mercenaries, or in the hands of the UPP or Iron Bears."
	icon_state = "mar40"
	item_state = "mar40"
	origin_tech = "combat=4;materials=2;syndicate=4"
	fire_sound = 'sound/weapons/gun_mar40.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/mar40
	type_of_casings = "cartridge"
	attachable_allowed = list(
						/obj/item/attachable/suppressor,
						/obj/item/attachable/bayonet,
						/obj/item/attachable/reddot,
						/obj/item/attachable/reflex,
						/obj/item/attachable/gyro,
						/obj/item/attachable/flashlight,
						/obj/item/attachable/bipod,
						/obj/item/attachable/extended_barrel,
						/obj/item/attachable/compensator,
						/obj/item/attachable/burstfire_assembly,
						/obj/item/attachable/magnetic_harness,
						/obj/item/attachable/stock/slavic,
						/obj/item/attachable/attached_gun/grenade,
						/obj/item/attachable/attached_gun/flamer,
						/obj/item/attachable/attached_gun/shotgun,
						/obj/item/attachable/scope/slavic)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK

/obj/item/weapon/gun/rifle/mar40/New()
	..()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17,"rail_x" = 13, "rail_y" = 19, "under_x" = 24, "under_y" = 13, "stock_x" = 24, "stock_y" = 13)

/obj/item/weapon/gun/rifle/mar40/set_gun_config_values()
	fire_delay = config.mhigh_fire_delay
	burst_amount = config.high_burst_value
	burst_delay = config.mlow_fire_delay
	accuracy_mult = config.base_hit_accuracy_mult - config.low_hit_accuracy_mult
	accuracy_mult_unwielded = config.base_hit_accuracy_mult - config.high_hit_accuracy_mult
	scatter = config.med_scatter_value
	burst_scatter_mult = config.med_scatter_value
	scatter_unwielded = config.max_scatter_value
	damage_mult = config.base_hit_damage_mult
	recoil_unwielded = config.high_recoil_value


/obj/item/weapon/gun/rifle/mar40/carbine
	name = "\improper MAR-30 battle carbine"
	desc = "A cheap, reliable carbine chambered in 7.62x39mm. Commonly found in the hands of criminals or mercenaries."
	icon_state = "mar30"
	item_state = "mar30"
	fire_sound = 'sound/weapons/gun_ak47.ogg' //Change
	attachable_allowed = list(
					/obj/item/attachable/suppressor,
					/obj/item/attachable/bayonet,
					/obj/item/attachable/reddot,
					/obj/item/attachable/reflex,
					/obj/item/attachable/verticalgrip,
					/obj/item/attachable/angledgrip,
					/obj/item/attachable/lasersight,
					/obj/item/attachable/flashlight,
					/obj/item/attachable/bipod,
					/obj/item/attachable/extended_barrel,
					/obj/item/attachable/heavy_barrel,
					/obj/item/attachable/magnetic_harness,
					/obj/item/attachable/attached_gun/grenade,
					/obj/item/attachable/attached_gun/flamer,
					/obj/item/attachable/attached_gun/shotgun,
					/obj/item/attachable/scope,
					/obj/item/attachable/scope/mini)

/obj/item/weapon/gun/rifle/mar40/carbine/set_gun_config_values()
	fire_delay = config.low_fire_delay
	accuracy_mult = config.base_hit_accuracy_mult + config.min_hit_accuracy_mult
	accuracy_mult_unwielded = config.base_hit_accuracy_mult + config.min_hit_accuracy_mult
	scatter = config.low_scatter_value
	scatter_unwielded = config.max_scatter_value
	damage_mult = config.base_hit_damage_mult
	recoil_unwielded = config.high_recoil_value


//-------------------------------------------------------
//M16 RIFLE

/obj/item/weapon/gun/rifle/m16
	name = "\improper M16 rifle"
	desc = "An old, reliable design first adopted by the U.S. military in the 1960s. Something like this belongs in a museum of war history. It is chambered in 5.56x45mm."
	icon_state = "m16"
	item_state = "m16"
	origin_tech = "combat=4;materials=3"
	fire_sound = 'sound/weapons/gun_mar40.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/m16
	type_of_casings = "cartridge"
	attachable_allowed = list(
						/obj/item/attachable/suppressor,
						/obj/item/attachable/bayonet,
						/obj/item/attachable/reddot,
						/obj/item/attachable/reflex,
						/obj/item/attachable/verticalgrip,
						/obj/item/attachable/angledgrip,
						/obj/item/attachable/flashlight/grip,
						/obj/item/attachable/gyro,
						/obj/item/attachable/flashlight,
						/obj/item/attachable/bipod,
						/obj/item/attachable/extended_barrel,
						/obj/item/attachable/compensator,
						/obj/item/attachable/burstfire_assembly,
						/obj/item/attachable/attached_gun/grenade,
						/obj/item/attachable/attached_gun/flamer,
						/obj/item/attachable/attached_gun/shotgun
						)

	flags_gun_features = GUN_CAN_POINTBLANK

/obj/item/weapon/gun/rifle/m16/New()
	..()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17,"rail_x" = 12, "rail_y" = 22, "under_x" = 24, "under_y" = 14, "stock_x" = 24, "stock_y" = 13)


/obj/item/weapon/gun/rifle/m16/set_gun_config_values()
	fire_delay = config.mhigh_fire_delay
	burst_amount = config.med_burst_value
	burst_delay = config.mlow_fire_delay
	accuracy_mult = config.base_hit_accuracy_mult + config.min_hit_accuracy_mult
	accuracy_mult_unwielded = config.base_hit_accuracy_mult - config.high_hit_accuracy_mult
	scatter = config.med_scatter_value
	burst_scatter_mult = config.med_scatter_value
	scatter_unwielded = config.max_scatter_value
	damage_mult = config.base_hit_damage_mult + config.min_hit_damage_mult
	recoil_unwielded = config.high_recoil_value

//-------------------------------------------------------
//DUTCH'S GEAR

/obj/item/weapon/gun/rifle/m16/dutch
	name = "\improper Dutch's M16A2"
	desc = "A modified M16 employed by Dutch's Dozen mercenaries. It has 'CLOAKER KILLER' printed on a label on the side. Chambered in 5.56x45mm."
	icon_state = "m16"
	item_state = "m16"
	fire_sound = 'sound/weapons/gun_mar40.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/m16/ap
	type_of_casings = "cartridge"
	attachable_allowed = list(
						/obj/item/attachable/suppressor,
						/obj/item/attachable/bayonet,
						/obj/item/attachable/reddot,
						/obj/item/attachable/reflex,
						/obj/item/attachable/verticalgrip,
						/obj/item/attachable/angledgrip,
						/obj/item/attachable/flashlight/grip,
						/obj/item/attachable/gyro,
						/obj/item/attachable/flashlight,
						/obj/item/attachable/bipod,
						/obj/item/attachable/extended_barrel,
						/obj/item/attachable/compensator,
						/obj/item/attachable/burstfire_assembly,
						/obj/item/attachable/attached_gun/grenade,
						/obj/item/attachable/attached_gun/flamer,
						/obj/item/attachable/attached_gun/shotgun
						)

	flags_gun_features = GUN_CAN_POINTBLANK

/obj/item/weapon/gun/rifle/m16/dutch/New()
	..()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17,"rail_x" = 12, "rail_y" = 22, "under_x" = 24, "under_y" = 14, "stock_x" = 24, "stock_y" = 13)

/obj/item/weapon/gun/rifle/m16/set_gun_config_values()
	fire_delay = config.mlow_fire_delay
	burst_amount = config.high_burst_value
	burst_delay = config.mlow_fire_delay
	accuracy_mult = config.base_hit_accuracy_mult + config.high_hit_accuracy_mult
	accuracy_mult_unwielded = config.base_hit_accuracy_mult - config.high_hit_accuracy_mult
	scatter = config.min_scatter_value
	burst_scatter_mult = config.min_scatter_value
	scatter_unwielded = config.max_scatter_value
	damage_mult = config.base_hit_damage_mult + config.med_hit_damage_mult
	recoil_unwielded = config.high_recoil_value

//-------------------------------------------------------
//M41AE2 HEAVY PULSE RIFLE

/obj/item/weapon/gun/rifle/lmg
	name = "\improper M41AE2 heavy pulse rifle"
	desc = "A large weapon capable of laying down supressing fire. Currently undergoing field testing among USCM scout platoons and in mercenary companies. Like it's smaller brother, the M41A MK2, the M41AE2 is chambered in 10mm."
	icon_state = "m41ae2"
	item_state = "m41ae2"
	origin_tech = "combat=5;materials=4"
	fire_sound = 'sound/weapons/gun_rifle.ogg' //Change
	current_mag = /obj/item/ammo_magazine/rifle/lmg
	attachable_allowed = list(
						/obj/item/attachable/suppressor,
						/obj/item/attachable/reddot,
						/obj/item/attachable/reflex,
						/obj/item/attachable/verticalgrip,
						/obj/item/attachable/angledgrip,
						/obj/item/attachable/flashlight/grip,
						/obj/item/attachable/flashlight,
						/obj/item/attachable/bipod,
						/obj/item/attachable/heavy_barrel,
						/obj/item/attachable/quickfire,
						/obj/item/attachable/compensator,
						/obj/item/attachable/burstfire_assembly,
						/obj/item/attachable/magnetic_harness,
						/obj/item/attachable/scope)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY
	gun_skill_category = GUN_SKILL_HEAVY_WEAPONS

	New()
		..()
		attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 23, "under_x" = 24, "under_y" = 12, "stock_x" = 24, "stock_y" = 12)

/obj/item/weapon/gun/rifle/lmg/set_gun_config_values()
	fire_delay = config.high_fire_delay
	burst_amount = config.high_burst_value
	burst_delay = config.mlow_fire_delay
	accuracy_mult = config.base_hit_accuracy_mult
	accuracy_mult_unwielded = config.base_hit_accuracy_mult - config.max_hit_accuracy_mult
	scatter = config.hmed_scatter_value
	burst_scatter_mult = config.hmed_scatter_value
	scatter_unwielded = config.max_scatter_value
	damage_mult = config.base_hit_damage_mult
	recoil_unwielded = config.max_recoil_value



//-------------------------------------------------------


//-------------------------------------------------------
//UPP TYPE 71 RIFLE

/obj/item/weapon/gun/rifle/type71
	name = "\improper Type 71 pulse rifle"
	desc = "The primary service rifle of the UPP forces, the Type 71 is a reliable pulse rifle chambered in 7.62x39mm. Firing in two round bursts to conserve ammunition, the Type 71 was originally designed as an ergonomic, lightweight rifle to be used in outer-space operations. The Type 71 suffers from some reliability issues, and is prone to jamming in terrestrial climates, but makes up for this with a high number of variants and ease of production."
	icon_state = "type71"
	item_state = "type71"
	origin_tech = "combat=4;materials=2;syndicate=4"
	fire_sound = list('sound/weapons/gun_type71.ogg')
	current_mag = /obj/item/ammo_magazine/rifle/type71
	wield_delay = 4
	//type_of_casings = "cartridge"

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_BURST_ON

/obj/item/weapon/gun/rifle/type71/set_gun_config_values()
	fire_delay = config.high_fire_delay
	burst_amount = config.low_burst_value
	burst_delay = config.mlow_fire_delay
	accuracy_mult = config.base_hit_accuracy_mult + config.max_hit_accuracy_mult
	accuracy_mult_unwielded = config.base_hit_accuracy_mult - config.med_hit_accuracy_mult
	scatter = config.med_scatter_value
	burst_scatter_mult = config.hmed_scatter_value
	scatter_unwielded = config.max_scatter_value
	damage_mult = config.base_hit_damage_mult
	recoil_unwielded = config.high_recoil_value


/obj/item/weapon/gun/rifle/type71/toggle_burst()
	usr << "<span class='warning'>This weapon can only fire in bursts!</span>"


/obj/item/weapon/gun/rifle/type71/flamer
	name = "\improper Type 71 pulse rifle"
	desc = " This appears to be a less common variant of the usual Type 71, with an undermounted flamethrower and improved iron sights."
	New()
		..()
		var/obj/item/attachable/attached_gun/flamer/S = new(src)
		attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 23, "under_x" = 20, "under_y" = 13, "stock_x" = 24, "stock_y" = 13)
		S.flags_attach_features &= ~ATTACH_REMOVABLE
		S.Attach(src)
		update_attachable(S.slot)



/obj/item/weapon/gun/rifle/type71/carbine
	name = "\improper Type 71 pulse carbine"
	icon_state = "type71c"
	item_state = "type71c"
	wield_delay = 2 //Carbine is more lightweight


/obj/item/weapon/gun/rifle/type71/carbine/commando
	name = "\improper Type 71 'Commando' pulse carbine"
	desc = "A much rarer variant of the standard Type 71, this version contains an integrated supressor, a scope, and lots of fine-tuning. Many parts have been replaced, filed down, and improved upon. As a result, this variant is rarely seen issued outside of commando units and officer cadres."
	icon_state = "type73"
	item_state = "type73"
	wield_delay = 0 //Ends up being .5 seconds due to scope

/obj/item/weapon/gun/rifle/type71/carbine/commando/New()//Making the gun have an invisible silencer since it's supposed to have one.
	..()
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 22, "under_x" = 21, "under_y" = 18, "stock_x" = 21, "stock_y" = 18)
	//supressor
	var/obj/item/attachable/suppressor/S = new(src)
	S.attach_icon = ""
	S.icon_state = ""
	S.flags_attach_features &= ~ATTACH_REMOVABLE
	S.Attach(src)
	update_attachable(S.slot)
	S.icon_state = initial(S.icon_state)
	//scope
	var/obj/item/attachable/scope/F = new(src)
	F.attach_icon = ""
	F.icon_state = ""
	F.flags_attach_features &= ~ATTACH_REMOVABLE
	F.Attach(src)
	update_attachable(F.slot)
	F.icon_state = initial(F.icon_state)



/obj/item/weapon/gun/rifle/type71/carbine/commando/set_gun_config_values()
	fire_delay = config.high_fire_delay
	burst_amount = config.low_burst_value
	burst_delay = config.mlow_fire_delay
	accuracy_mult = config.base_hit_accuracy_mult + config.max_hit_accuracy_mult + config.max_hit_accuracy_mult
	accuracy_mult_unwielded = config.base_hit_accuracy_mult - config.med_hit_accuracy_mult
	scatter = config.med_scatter_value
	burst_scatter_mult = config.med_scatter_value
	scatter_unwielded = config.max_scatter_value
	damage_mult = config.base_hit_damage_mult
	recoil_unwielded = config.high_recoil_value

//-------------------------------------------------------
//-------------------------------------------------------
//L42 MK1 Pulse Carbine

/obj/item/weapon/gun/rifle/l42mk1
	name = "\improper L42 pulse carbine MK1"
	desc = "A L42 pulse carbine MK1. A non-standard alternative to the standard issue M41A-MK2 available to the jarheads of the USCM. Renowned for its high accuracy, but usually overlooked in favor of firearms with better stopping power. Chambered in 10x24mm caseless."
	icon_state = "l42mk1"
	item_state = "l42mk1"
	fire_sound = 'sound/weapons/gun_carbine.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/l42mk1
	attachable_allowed = list(
						/obj/item/attachable/suppressor,
						/obj/item/attachable/bayonet,
						/obj/item/attachable/reddot,
						/obj/item/attachable/reflex,
						/obj/item/attachable/flashlight,
						/obj/item/attachable/extended_barrel,
						/obj/item/attachable/quickfire,
						/obj/item/attachable/magnetic_harness,
						/obj/item/attachable/stock/carbine,
						/obj/item/attachable/scope,
						/obj/item/attachable/scope/mini,
						/obj/item/attachable/scope/mini_iff)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WIELD_DELAY_VERY_FAST
	aim_slowdown = 0

/obj/item/weapon/gun/rifle/l42mk1/New()
	select_gamemode_skin(/obj/item/weapon/gun/rifle/l42mk1)
	..()
	attachable_offset = list("muzzle_x" = 31, "muzzle_y" = 17,"rail_x" = 18, "rail_y" = 19, "under_x" = 24, "under_y" = 13, "stock_x" = 25, "stock_y" = 10)

/obj/item/weapon/gun/rifle/l42mk1/set_gun_config_values()
	fire_delay = config.high_fire_delay
	burst_amount = 0
	burst_delay = 1
	accuracy_mult = config.base_hit_accuracy_mult - config.low_hit_accuracy_mult
	accuracy_mult_unwielded = config.base_hit_accuracy_mult - config.med_hit_accuracy_mult
	damage_mult = config.base_hit_damage_mult
	recoil_unwielded = config.low_recoil_value
	damage_falloff_mult = 0

/obj/item/weapon/gun/rifle/l42mk1/attach_to_gun(mob/user, obj/item/attachable/attachment)
	if(!can_attach_to_gun(user, attachment))
		return

	var/timer = 20
	if(attachment.slot == "muzzle")
		timer = 5

	user.visible_message("<span class='notice'>[user] begins attaching [attachment] to [src].</span>",
	"<span class='notice'>You begin attaching [attachment] to [src].</span>", null, 4)
	if(do_after(user, timer, TRUE, 2, BUSY_ICON_FRIENDLY))
		if(attachment && attachment.loc)
			user.visible_message("<span class='notice'>[user] attaches [attachment] to [src].</span>",
			"<span class='notice'>You attach [attachment] to [src].</span>", null, 4)
			user.temp_drop_inv_item(attachment)
			attachment.Attach(src)
			update_attachable(attachment.slot)
			playsound(user, 'sound/machines/click.ogg', 15, 1, 4)

/obj/item/weapon/gun/rifle/l42mk1/field_strip()
	set category = "Weapons"
	set name = "Field Strip Weapon"
	set desc = "Remove all attachables from a weapon."
	set src = usr.contents //We want to make sure one is picked at random, hence it's not in a list.

	var/obj/item/weapon/gun/G = get_active_firearm(usr)

	if(!G)
		return

	src = G

	if(usr.action_busy)
		return

	if(zoom)
		usr << "<span class='warning'>You cannot conceviably do that while looking down \the [src]'s scope!</span>"
		return

	if(!rail && !muzzle && !under && !stock)
		usr << "<span class='warning'>This weapon has no attachables. You can only field strip enhanced weapons!</span>"
		return

	var/list/possible_attachments = list()

	if(rail && (rail.flags_attach_features & ATTACH_REMOVABLE))
		possible_attachments += rail
	if(muzzle && (muzzle.flags_attach_features & ATTACH_REMOVABLE))
		possible_attachments += muzzle
	if(under && (under.flags_attach_features & ATTACH_REMOVABLE))
		possible_attachments += under
	if(stock && (stock.flags_attach_features & ATTACH_REMOVABLE))
		possible_attachments += stock

	if(!possible_attachments.len)
		usr << "<span class='warning'>[src] has no removable attachments.</span>"
		return

	var/obj/item/attachable/A
	if(possible_attachments.len == 1)
		A = possible_attachments[1]
	else
		A = input("Which attachment to remove?") as null|anything in possible_attachments

	if(!A)
		return

	if(get_active_firearm(usr) != src)//dropped the gun
		return

	if(usr.action_busy)
		return

	if(zoom)
		return

	if(A != rail && A != muzzle && A != under && A != stock)
		return
	if(!(A.flags_attach_features & ATTACH_REMOVABLE))
		return

	usr.visible_message("<span class='notice'>[usr] begins stripping [A] from [src].</span>",
	"<span class='notice'>You begin stripping [A] from [src].</span>", null, 4)

	var/timer = 35
	if(A == muzzle)
		timer = 10

	if(!do_after(usr,timer, TRUE, 5, BUSY_ICON_FRIENDLY))
		return

	if(A != rail && A != muzzle && A != under && A != stock)
		return
	if(!(A.flags_attach_features & ATTACH_REMOVABLE))
		return

	if(zoom)
		return

	usr.visible_message("<span class='notice'>[usr] strips [A] from [src].</span>",
	"<span class='notice'>You strip [A] from [src].</span>", null, 4)
	A.Detach(src)

	playsound(src, 'sound/machines/click.ogg', 15, 1, 4)
	update_attachables()

/obj/item/weapon/gun/rifle/l42mk1/verb/remove_barrel()
	set category = "Weapons"
	set name = "Remove Barrel from Weapon"
	set desc = "Removes Barrel from Weapon"
	set src = usr.contents //We want to make sure one is picked at random, hence it's not in a list.

	var/obj/item/weapon/gun/G = get_active_firearm(usr)

	if(!G)
		return

	src = G

	if(usr.action_busy)
		return

	if(zoom)
		usr << "<span class='warning'>You cannot conceviably do that while looking down \the [src]'s scope!</span>"
		return

	if(!muzzle)
		usr << "<span class='warning'>This weapon has no barrel attachaments to remove!</span>"
		return

	var/obj/item/attachable/A = muzzle

	if(!A)
		return

	if(get_active_firearm(usr) != src)//dropped the gun
		return

	if(usr.action_busy)
		return

	if(zoom)
		return

	if(A != muzzle)
		return
	if(!(A.flags_attach_features & ATTACH_REMOVABLE))
		return

	usr.visible_message("<span class='notice'>[usr] begins stripping [A] from [src].</span>",
	"<span class='notice'>You begin stripping [A] from [src].</span>", null, 4)

	var/timer = 10

	if(!do_after(usr,timer, TRUE, 5, BUSY_ICON_FRIENDLY))
		return

	if(A != muzzle)
		return
	if(!(A.flags_attach_features & ATTACH_REMOVABLE))
		return

	if(zoom)
		return

	usr.visible_message("<span class='notice'>[usr] strips [A] from [src].</span>",
	"<span class='notice'>You strip [A] from [src].</span>", null, 4)
	A.Detach(src)

	playsound(src, 'sound/machines/click.ogg', 15, 1, 4)
	update_attachables()

