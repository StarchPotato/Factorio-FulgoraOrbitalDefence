-- Space location and orbital definitions

local manufactory_planet = table.deepcopy(data.raw["surface"]["space-platform"])
manufactory_planet.asteroid_spawn_influence = data.raw["planet"]["fulgora"].asteroid_spawn_influence
manufactory_planet.asteroid_spawn_definitions = table.deepcopy(data.raw["planet"]["fulgora"].asteroid_spawn_definitions)
manufactory_planet.name = "fulgoran-space-manufactory"
manufactory_planet.order = "d[fulgora]-a[manufactory]"
manufactory_planet.icon = "__fulgora-orbital-defence__/graphics/icons/space-location-icon.png"
manufactory_planet.starmap_icon = "__fulgora-orbital-defence__/graphics/icons/space-location-icon.png"
manufactory_planet.icon_size = 144
manufactory_planet.starmap_icon_size = 144
manufactory_planet.type = "planet"
manufactory_planet.label = { "space-location-name.fulgoran-space-manufactory" }
manufactory_planet.hidden = false
manufactory_planet.visible_to_all = true
manufactory_planet.distance = 15
manufactory_planet.orientation = 0.35
manufactory_planet.magnitude = 1.0
manufactory_planet.draw_orbit = true
manufactory_planet.surface_properties = {
    ["day-night-cycle"] = 0,
    ["gravity"] = 0,
    ["magnetic-field"] = 0,
    ["pressure"] = 0
}
manufactory_planet.map_gen_settings = {
    autoplace_controls = {},
    autoplace_settings = {
        ["tile"] = { settings = { ["empty-space"] = {} } }
    }
}
-- Need to customise extensively due to custom silo and potential VPIS interaction
-- manufactory_planet.platform_procession_set = {
	-- arrival = { "planet-to-platform-b" },
	-- departure = { "platform-to-planet-a" },
-- }
-- manufactory_planet.planet_procession_set = {
	-- arrival = { "platform-to-planet-b" },
	-- departure = { "planet-to-platform-a" },
-- }

data:extend({manufactory_planet})


local fulgora_connection = data.raw["space-connection"]["vulcanus-to-fulgora"] -- Any route just to initialise tables
data:extend({
  {
    type = "space-connection",
    name = "fulgora-to-manufactory",
    from = "fulgora",
    to = "fulgoran-space-manufactory",
	subgroup = "planet-connections",
	order = "fa",
    length = 1600, -- twice as far as cerys
    -- Inherit the base Fulgora asteroid behavior
    asteroid_spawn_definitions = {}
  }
})

if mods["visible-planets"] then 
	vp_override_planet_sprite("fulgoran-space-manufactory","__fulgora-orbital-defence__/graphics/space-location-image.png", 938) -- Use the high def sprite if using VPIS
	vp_disable_planet_rotation("fulgoran-space-manufactory")
	vp_override_planet_scale("fulgoran-space-manufactory", 1.0)
	vp_set_planet_rotation_mult("fulgoran-space-manufactory", 0) -- Make it look straight up
end

--PlanetsLib to make it a moon of Fulgora

PlanetsLib:update({
	{
		type = "planet",
		name = "fulgoran-space-manufactory",
		subgroup = "satellites",
		redrawn_connections_exclude = true,
		draw_orbit = false,
		orbit = {
			parent={
				type = "planet",
				name = "fulgora"
			},
			distance = 3.6, -- twice as far as cerys
			orientation = 0.82, -- Stop text overlap from Fulgora
			sprite = {
				type = "sprite",
				filename = "__fulgora-orbital-defence__/graphics/icons/space-location-icon.png",
				size = 64,
				scale = 0.25,
			}
		}
	}
})