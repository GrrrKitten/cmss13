

/mob
	var/list/fullscreens = list()

	///The type of special lighting such as a sunset or lightning is currently active, dont have more than one of these without a special fullscreen framework
	var/special_lighting = null
	///A var to check if there is currently an active special lighting timer already set in order to prevent dupes
	var/special_lighting_active_timer = FALSE

/mob/proc/overlay_fullscreen(category, type, severity)
	var/atom/movable/screen/fullscreen/screen = fullscreens[category]
	if (!screen || screen.type != type)
		// needs to be recreated
		clear_fullscreen(category, FALSE)
		fullscreens[category] = screen = new type()
	else if ((!severity || severity == screen.severity) && (!client || screen.screen_loc != "CENTER-7,CENTER-7" || screen.fs_view == client.view))
		// doesn't need to be updated
		return screen

	screen.icon_state = "[initial(screen.icon_state)][severity]"
	screen.severity = severity
	if (client && screen.should_show_to(src))
		screen.update_for_view(client.view)
		client.add_to_screen(screen)

	return screen

/mob/proc/clear_fullscreen(category, animated = 10)
	var/atom/movable/screen/fullscreen/screen = fullscreens[category]
	if(!screen)
		return

	fullscreens -= category

	if(animated)
		animate(screen, alpha = 0, time = animated)
		addtimer(CALLBACK(src, PROC_REF(clear_fullscreen_after_animate), screen), animated, TIMER_CLIENT_TIME)
	else
		if(client)
			client.remove_from_screen(screen)
		qdel(screen)

/mob/proc/clear_fullscreen_after_animate(atom/movable/screen/fullscreen/screen)
	if(client)
		client.remove_from_screen(screen)
	qdel(screen)

/mob/proc/clear_fullscreens()
	for(var/category in fullscreens)
		clear_fullscreen(category)

/mob/proc/hide_fullscreens()
	if(client)
		for(var/category in fullscreens)
			client.remove_from_screen(fullscreens[category])

/mob/proc/reload_fullscreens()
	if(client)
		var/atom/movable/screen/fullscreen/screen
		for(var/category in fullscreens)
			screen = fullscreens[category]
			if(screen.should_show_to(src))
				screen.update_for_view(client.view)
				client.add_to_screen(screen)
			else
				client.remove_from_screen(screen)

/mob/proc/initialize_special_lighting() //initialized on hud.dm when a new mob is spawned so you can't dodge this unless you dont have a client somehow
	if(!SSticker.mode)
		if(special_lighting)
			return
		SSticker.OnRoundstart(CALLBACK(src, PROC_REF(initialize_special_lighting)))
		special_lighting = "pre_round"	// do not let a special_lighting get called before roundstart
		return
	if(SSticker.mode.flags_round_type & MODE_SUNSET)
		if(!fullscreens["lighting_backdrop"] || special_lighting == "sunset")
			return
		special_lighting = "sunset"
		if(ROUND_TIME < 4 SECONDS) //if you're in before full setup, dont let special lightings get called prior, it gets messy
			addtimer(CALLBACK(src, PROC_REF(special_lighting_animate), "sunset", 30 SECONDS, 9, 10 SECONDS, 0, null, 1, FALSE, TRUE, TRUE), 3 SECONDS)
			addtimer(CALLBACK(src, PROC_REF(special_lighting_register_signals)), 3 SECONDS)
		else if(ROUND_TIME < 280 SECONDS)
			special_lighting_animate("sunset", 30 SECONDS, 9, 10 SECONDS, 0, 0.1 SECONDS, 1, TRUE, TRUE, TRUE)
			special_lighting_register_signals()
		return
	if(GLOB.sunrise_starting_time)
		if(!fullscreens["lighting_backdrop"] || special_lighting == "sunrise")
			return
		special_lighting = "sunrise"
		special_lighting_animate("sunrise", 30 SECONDS, 6, 0, 0.1 SECONDS, -1, TRUE, TRUE, FALSE)
		debug_msg("sunrise proc got called be called on [src] instantly cause sunrise_starting_time was set")
		special_lighting_register_signals() //sunrise is permanent, you wont need to unregister


/atom/movable/screen/fullscreen
	icon = 'icons/mob/hud/screen1_full.dmi'
	icon_state = "default"
	screen_loc = "CENTER-7,CENTER-7"
	layer = FULLSCREEN_LAYER
	plane = FULLSCREEN_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/severity = 0
	var/fs_view = 7
	var/show_when_dead = FALSE
	/// If this should try and resize if the user's view is bigger than the default
	var/should_resize = TRUE

/atom/movable/screen/fullscreen/proc/update_for_view(client_view)
	if (screen_loc == "CENTER-7,CENTER-7" && fs_view != client_view && should_resize)
		var/list/actualview = getviewsize(client_view)
		fs_view = client_view
		transform = matrix(actualview[1]/FULLSCREEN_OVERLAY_RESOLUTION_X, 0, 0, 0, actualview[2]/FULLSCREEN_OVERLAY_RESOLUTION_Y, 0)

/atom/movable/screen/fullscreen/proc/should_show_to(mob/mymob)
	if(!show_when_dead && mymob.stat == DEAD)
		return FALSE
	return TRUE

/atom/movable/screen/fullscreen/Destroy()
	severity = 0
	. = ..()

/atom/movable/screen/fullscreen/brute
	icon_state = "brutedamageoverlay"
	layer = FULLSCREEN_DAMAGE_LAYER

/atom/movable/screen/fullscreen/brute/nvg
	color = COLOR_BLACK

/atom/movable/screen/fullscreen/oxy
	icon_state = "oxydamageoverlay"
	layer = FULLSCREEN_DAMAGE_LAYER

/atom/movable/screen/fullscreen/flash/noise/nvg
	alpha = 27.5

/atom/movable/screen/fullscreen/crit
	icon_state = "passage"
	layer = FULLSCREEN_CRIT_LAYER

/atom/movable/screen/fullscreen/crit/dark
	color = COLOR_GRAY

/atom/movable/screen/fullscreen/blind
	icon_state = "blackimageoverlay"
	layer = FULLSCREEN_BLIND_LAYER

/atom/movable/screen/fullscreen/impaired
	icon_state = "impairedoverlay"
	layer = FULLSCREEN_IMPAIRED_LAYER

/atom/movable/screen/fullscreen/flash
	icon = 'icons/mob/hud/screen1.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "flash"
	layer = FULLSCREEN_FLASH_LAYER

/atom/movable/screen/fullscreen/flash/noise
	icon = 'icons/mob/hud/screen1.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "noise"

/atom/movable/screen/fullscreen/flash/dark
	icon_state = "black"

/atom/movable/screen/fullscreen/high
	icon = 'icons/mob/hud/screen1.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "druggy"
	layer = FULLSCREEN_DRUGGY_LAYER

/atom/movable/screen/fullscreen/blurry
	icon = 'icons/mob/hud/screen1.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "blurry"
	layer = FULLSCREEN_BLURRY_LAYER

/atom/movable/screen/fullscreen/nvg
	icon = 'icons/mob/hud/screen1.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "nvg_hud"
	appearance_flags = NONE

/atom/movable/screen/fullscreen/thermal
	icon = 'icons/mob/hud/screen1.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "thermal_hud"
	appearance_flags = NONE

/atom/movable/screen/fullscreen/meson
	icon = 'icons/mob/hud/screen1.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "meson_hud"
	appearance_flags = NONE

/atom/movable/screen/fullscreen/meson/refurb
	icon_state = "refurb_meson_hud"

/atom/movable/screen/fullscreen/pain
	icon_state = "painoverlay"
	layer = FULLSCREEN_PAIN_LAYER

/atom/movable/screen/fullscreen/xeno_pain
	icon_state = "xeno_painoverlay"
	layer = FULLSCREEN_PAIN_LAYER

/atom/movable/screen/fullscreen/laser_blind
	icon_state = "impairedoverlay1"

/atom/movable/screen/fullscreen/vulture
	icon_state = "vulture_scope_overlay_sniper"
	layer = FULLSCREEN_VULTURE_SCOPE_LAYER

/atom/movable/screen/fullscreen/vulture/spotter
	icon_state = "vulture_scope_overlay_spotter"
	should_resize = FALSE

//Weather overlays//

/atom/movable/screen/fullscreen/weather
	icon_state = "initialize this"
	layer = FULLSCREEN_WEATHER_LAYER
	appearance_flags = NONE
	show_when_dead = TRUE


/atom/movable/screen/fullscreen/weather/low
	icon_state = "impairedoverlay1"

/atom/movable/screen/fullscreen/weather/medium
	icon_state = "impairedoverlay2"

/atom/movable/screen/fullscreen/weather/high
	icon_state = "impairedoverlay3"

/atom/movable/screen/fullscreen/lighting_backdrop
	icon = 'icons/mob/hud/screen1.dmi'
	icon_state = "flash"
	transform = matrix(200, 0, 0, 0, 200, 0)
	plane = LIGHTING_PLANE
	blend_mode = BLEND_OVERLAY
	show_when_dead = TRUE

/atom/movable/screen/fullscreen/lighting_backdrop/update_for_view(client_view)
	return

//Provides darkness to the back of the lighting plane
/atom/movable/screen/fullscreen/lighting_backdrop/lit_secondary
	invisibility = INVISIBILITY_LIGHTING
	layer = BACKGROUND_LAYER + LIGHTING_PRIMARY_DIMMER_LAYER
	color = "#000"
	alpha = 60

/atom/movable/screen/fullscreen/lighting_backdrop/backplane
	invisibility = INVISIBILITY_LIGHTING
	layer = LIGHTING_BACKPLANE_LAYER
	color = "#000"
	blend_mode = BLEND_ADD


/mob/proc/special_lighting_animate(p_special_lighting_type = null, p_stage_time, p_max_stages, p_startup_delay, p_special_start_time, p_special_stage_time = null, p_special_tick_dir, p_special_call = FALSE, p_create_new_lighting_timer = FALSE, p_lighting_deactivates = TRUE)

	var/atom/movable/screen/fullscreen/screen = fullscreens["lighting_backdrop"]
	var/mob/lighting_mob = src
	var/area/lighting_mob_area = get_area(lighting_mob)

	if(p_special_lighting_type != lighting_mob.special_lighting)
		return

	var/lighting_color = "#000" /// used in the animation, set by the special_lighting_type

	var/stage_time = p_stage_time /// how long each stage lasts, don't edit this if you want smooth movement, use special_stage_time instead
	var/max_stages = p_max_stages /// how many stages of special lighting there are, starts at 0

	var/startup_delay = p_startup_delay /// how long the initial stage lasts for, doesn't factor in round start stuff
	var/special_start_time = p_special_start_time /// when the special_lighting starts (use 0 if roundstart)

	var/special_stage_time = p_special_stage_time /// changes animation time without changing stage time, used by special calls and init stages
	var/special_call = p_special_call /// the type of special call
	var/special_tick_dir = p_special_tick_dir /// If it gets a special call, if it ticks up or down in order to prevent advantages

	var/create_new_lighting_timer = p_create_new_lighting_timer /// used to prevent timer dupes, keep this as
	var/lighting_deactivates = p_lighting_deactivates /// If the lighting deactivates


	var/lighting_stage = clamp((floor((ROUND_TIME + stage_time - special_start_time - startup_delay)/stage_time)), 0, max_stages) /// the current stage of the lighting, ticks up by 1 every stagetime after startup_delay + start_time
	//uses formula (x + y - w - z)/(y) with x = round_time, y = stage_time, w = special_start_time, and z being startup_delay

	var/time_til_next_lighting_call = (lighting_stage * stage_time) + startup_delay - special_start_time - ROUND_TIME /// how long until the next sunstage occurs

	if(special_call && lighting_stage != 0) // controls stuff related to special calls, prevents people from getting unfair advantages by getting stages reset, unnecessary for short anims
		lighting_stage = clamp((lighting_stage + special_tick_dir), 0, max_stages)
		if(time_til_next_lighting_call < special_stage_time)
			time_til_next_lighting_call = time_til_next_lighting_call + special_stage_time //delays main anims until the special call anim is done

	if(lighting_mob.special_lighting == "sunset")
		lighting_color = lighting_mob.special_lighting_sunset(lighting_stage)
	if(lighting_mob.special_lighting == "sunrise")
		lighting_color = lighting_mob.special_lighting_sunrise(lighting_stage)

	if(lighting_stage == 0) //there aren't any cases you won't want these coming up fast
		special_stage_time = 0.5 SECONDS
		time_til_next_lighting_call = startup_delay

	if(create_new_lighting_timer) // if create_new_lighting_timer = TRUE, a new timer gets set
		lighting_mob.special_lighting_active_timer = FALSE

	if(!lighting_mob.special_lighting_active_timer)
		if(lighting_stage < max_stages)
			addtimer(CALLBACK(lighting_mob, PROC_REF(special_lighting_animate), special_lighting, stage_time, max_stages, startup_delay, special_start_time, null, special_tick_dir, FALSE, TRUE, TRUE), time_til_next_lighting_call, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_DELETE_ME)
			lighting_mob.special_lighting_active_timer = TRUE
		if(lighting_stage == max_stages && lighting_deactivates) // deactives special lighting when the sun hits #000
			addtimer(CALLBACK(lighting_mob, PROC_REF(special_lighting_unregister_signals)), time_til_next_lighting_call, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_DELETE_ME)

	if(CEILING_IS_PROTECTED(lighting_mob_area?.ceiling, CEILING_PROTECTION_TIER_2)) //if underground, don't animate, this is needed in combo with the special area check
		return
	if(!is_ground_level(lighting_mob.z) && special_call != "z_change") // dont animate if not groundlevel
		return

	if(special_stage_time)
		stage_time = special_stage_time

	animate(screen, color = lighting_color, time = stage_time)


/mob/proc/special_lighting_sunset(lighting_stage)

	var/lighting_color = "#000" /// used in the animation, set by the special_lighting_type

	//if its cold or in space (or chances claim)
	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD || ZTRAIT_IN_SPACE] || SSmapping.configs[GROUND_MAP].map_name == MAP_LV522_CHANCES_CLAIM)
		switch(lighting_stage) //for sun stages, the more you have the better it looks when special called, I recommend choosing cinematic 4 colors then using a gradient tool to pick out the rest
			if(0)
				lighting_color = "#a8c3cf"
			if(1)
				lighting_color = "#7a9abb"
			if(2)
				lighting_color = "#6679a8"
			if(3)
				lighting_color = "#516a8b"
			if(4)
				lighting_color = "#38486e"
			if(5)
				lighting_color = "#2c2f4d"
			if(6)
				lighting_color = "#211b36"
			if(7)
				lighting_color = "#1f1b33"
			if(8)
				lighting_color = "#0c0a1b"
			if(9)
				lighting_color = "#000"
	else //the default, a very warm sunset
		switch(lighting_stage)
			if(0)
				lighting_color = "#e3a979"
			if(1)
				lighting_color = "#e29658"
			if(2)
				lighting_color = "#da8b4a"
			if(3)
				lighting_color = "#a9633c"
			if(4)
				lighting_color = "#90422d"
			if(5)
				lighting_color = "#68333a"
			if(6)
				lighting_color = "#4d2b35"
			if(7)
				lighting_color = "#231935"
			if(8)
				lighting_color = "#050c27"
			if(9)
				lighting_color = "#000"

	return lighting_color


/mob/proc/special_lighting_sunrise(lighting_stage)

	var/lighting_color = "#000" /// used in the animation, set by the special_lighting_type

	if(!GLOB.sunrise_starting_time) //failsafe incase sunrise gets called without a sunrise time set
		(GLOB.sunrise_starting_time = ROUND_TIME)

	switch(lighting_stage)
		if(0)
			lighting_color = "#000"
		if(1)
			lighting_color = "#040712"
		if(2)
			lighting_color = "#111322"
		if(3)
			lighting_color = "#422535"
		if(4)
			lighting_color = "#6a2e37"
		if(5)
			lighting_color = "#a73d3b"
		if(6)
			lighting_color = "#bd502a" //it ends on very orange for cinematics

	return lighting_color


/mob/proc/special_lighting_register_signals()

	var/mob/signaling_mob = src

	RegisterSignal(signaling_mob, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(special_lighting_z_change), TRUE)
	RegisterSignal(signaling_mob, COMSIG_MOVABLE_ENTERED_AREA, PROC_REF(special_lighting_area_change), TRUE)


/mob/proc/special_lighting_unregister_signals()

	var/mob/signaling_mob = src

	signaling_mob.special_lighting = null //clears special lighting

	UnregisterSignal(signaling_mob, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(special_lighting_z_change))
	UnregisterSignal(signaling_mob, COMSIG_MOVABLE_ENTERED_AREA, PROC_REF(special_lighting_area_change))


/mob/proc/special_lighting_z_change(atom/source, old_z, new_z)
	SIGNAL_HANDLER

	var/atom/movable/screen/fullscreen/screen = fullscreens["lighting_backdrop"]

	var/stage_time = 30 SECONDS
	var/max_stages = null
	var/startup_delay = 0
	var/special_start_time = 0
	var/special_stage_time = 0.1 SECONDS
	var/special_tick_dir = 0
	var/special_call = "z_change"
	var/create_new_lighting_timer = FALSE
	var/lighting_deactivates = TRUE

	if(!special_lighting || special_lighting == "pre_round")
		return

	switch(special_lighting) //figure out a way of handling this better if possible
		if("sunset")
			max_stages = 9
			startup_delay = 10 SECONDS
			special_tick_dir = 1
		if("sunrise")
			max_stages = 6
			special_start_time = GLOB.sunrise_starting_time
			lighting_deactivates = FALSE
			special_tick_dir = -1

	if(is_ground_level(new_z))
		special_lighting_animate(special_lighting, stage_time, max_stages, startup_delay, special_start_time, special_stage_time, special_tick_dir, special_call, create_new_lighting_timer, lighting_deactivates)

	if(!is_ground_level(new_z))
		animate(screen, color = "#000", time = 0.1 SECONDS)


/mob/proc/special_lighting_area_change(atom/source, old_area, new_area)
	SIGNAL_HANDLER

	var/atom/movable/screen/fullscreen/screen = fullscreens["lighting_backdrop"]

	var/stage_time = 30 SECONDS
	var/max_stages = null
	var/startup_delay = 0
	var/special_start_time = 0
	var/special_stage_time = 4 SECONDS
	var/special_tick_dir = 0
	var/special_call = "area_change"
	var/create_new_lighting_timer = FALSE
	var/lighting_deactivates = TRUE


	if(!special_lighting || special_lighting == "pre_round")
		return

	switch(special_lighting)
		if("sunset")
			max_stages = 9
			startup_delay = 10 SECONDS
			special_tick_dir = 1
		if("sunrise")
			max_stages = 6
			special_start_time = GLOB.sunrise_starting_time
			lighting_deactivates = FALSE
			special_tick_dir = -1


	var/area/mob_old_area = old_area
	var/area/mob_new_area = new_area

	var/oldloc_incave = null
	var/newloc_incave = null

	if(CEILING_IS_PROTECTED(mob_old_area?.ceiling, CEILING_PROTECTION_TIER_2))
		oldloc_incave = TRUE
	if(CEILING_IS_PROTECTED(mob_new_area?.ceiling, CEILING_PROTECTION_TIER_2))
		newloc_incave = TRUE

	if(newloc_incave && !oldloc_incave) //handles both null old loc and false oldloc
		animate(screen, color = "#000", time = 4 SECONDS, easing = QUAD_EASING | EASE_OUT)
	else if(oldloc_incave && !newloc_incave)
		special_lighting_animate(special_lighting, stage_time, max_stages, startup_delay, special_start_time, special_stage_time, special_tick_dir, special_call, create_new_lighting_timer, lighting_deactivates)


/atom/movable/screen/fullscreen/see_through_darkness
	icon_state = "nightvision"
	plane = LIGHTING_PLANE
	layer = LIGHTING_PRIMARY_LAYER
	blend_mode = BLEND_ADD
	show_when_dead = TRUE
