-- New Asteroid to generate the enemy
local fulgoranhibernationcapsule = table.deepcopy(data.raw["asteroid"]["small-metallic-asteroid"])
fulgoranhibernationcapsule.name = "fulgoran-hibernation-capsule"
fulgoranhibernationcapsule.icon = "__base__/graphics/icons/destroyer-capsule.png"
fulgoranhibernationcapsule.mass = 1.0 -- negligible platform damage on impact
fulgoranhibernationcapsule.overkill_fraction = 0.0 -- internal bots are fine.  Don't think this does anything, as enemy spawning is handled by control script
fulgoranhibernationcapsule.graphics_set = { -- Mostly lifted from data.lua for asteroids
  rotation_speed = 0.0002,
  normal_strength = 1.2,
  brightness = 0.9,
  specular_strength = 2,
  specular_power = 2,
  specular_purity = 0,
  sss_contrast = 1,
  sss_amount = 0,
  ambient_light = {0.01, 0.01, 0.01},
  lights = {
    { color = {0.96, 1, 0.99}, direction = {0.7, 0.6, -1} },
    { color = {0.57, 0.33, 0.23}, direction = {-0.72, -0.46, 1} },
    { color = {0.1, 0.1, 0.1}, direction = {-0.4, -0.25, -0.5} },
  },
  variations = { --TODO include other capsules for some colour and style diversity
    {
      color_texture = {
        filename = "__base__/graphics/icons/destroyer-capsule.png",
        size = 64,
        scale = 0.5
      },
      normal_map = {
        filename = "__space-age__/graphics/entity/asteroid/metallic/small/asteroid-metallic-small-normal-01.png",
        premul_alpha = false,
        size = 128,
        scale = 0.5
      },
      roughness_map = {
        filename = "__space-age__/graphics/entity/asteroid/metallic/small/asteroid-metallic-small-roughness-01.png",
        premul_alpha = false,
        size = 128,
        scale = 0.5
      },
      shadow_shift = { 0.25, 0.25 }
    }
  }
}
fulgoranhibernationcapsule.dying_trigger_effect = { -- Required to generate chunks through script rather than dying trigger effect, otherwise they are yeeted south due to the unit speed
  {
    entity_name = "carbonic-asteroid-explosion-2",
    only_when_visible = true,
    type = "create-explosion"
  }
}
data:extend({ fulgoranhibernationcapsule })
--TODO factoriopedia entry

--New Asteroid chunks to be harvested from the enemy corpse (use shippy scrap graphics for now)
local fulgoranspaceshipcorpsechunk = table.deepcopy(data.raw["asteroid-chunk"]["metallic-asteroid-chunk"])
fulgoranspaceshipcorpsechunk.name = "fulgoran-spaceship-corpse-chunk"
fulgoranspaceshipcorpsechunk.icon = "__space-age__/graphics/icons/scrap-4.png"
fulgoranspaceshipcorpsechunk.pictures = {
  {
    filename = "__space-age__/graphics/icons/scrap.png",
    size = 64,
    scale = 0.5,
  }
}
fulgoranspaceshipcorpsechunk.minable = {
	mining_particle = "metallic-asteroid-chunk-particle-medium",
	mining_time = 0.2,
	result = "fulgoran-spaceship-corpse-chunk2"
}
--graphics_set lifted form vanilla data.raw (rounded) until proper graphics are implemented.  May look fine enough though
fulgoranspaceshipcorpsechunk.graphics_set = {
  ambient_light = {0.01, 0.01, 0.01},
  brightness = 0.9,
  light_width = 0,
  rotation_speed = 0.0002,
  normal_strength = 1.2,
lights = {
    { color = {0.96, 1, 0.99}, direction = {0.7, 0.6, -1} },
    { color = {0.57, 0.33, 0.23}, direction = {-0.72, -0.46, 1} },
    { color = {0.1, 0.1, 0.1}, direction = {-0.4, -0.25, -0.5} },
  },
	normal_strength = 1.2,
	rotation_speed = 0.001,
	specular_power = 2,
	specular_purity = 0,
	specular_strength = 2,
	sss_amount = 0,
	sss_contrast = 1,
  variations = { -- Only 1 variation, so can add other scrap icons later
    {
      color_texture = {
        filename = "__space-age__/graphics/icons/scrap-4.png",
        scale = 0.5,
        size = 64

      },
      normal_map = {
        filename = "__space-age__/graphics/entity/asteroid/metallic/small/asteroid-metallic-small-normal-01.png",
        premul_alpha = false,
        scale = 0.5,
        size = 128
      },
      roughness_map = {
        filename = "__space-age__/graphics/entity/asteroid/metallic/small/asteroid-metallic-small-roughness-01.png",
        premul_alpha = false,
        scale = 0.5,
        size = 128
      },
      shadow_shift = { 0.5, 0.5 }
    }
  }
}

data:extend({ fulgoranspaceshipcorpsechunk })
--The chunk is also an item, with the same name in vanilla.  No idea how this doesn't conflict, so just make it _2
local fulgoranspaceshipcorpsechunk2 = table.deepcopy(data.raw["item"]["metallic-asteroid-chunk"])
fulgoranspaceshipcorpsechunk2.icon = "__space-age__/graphics/icons/scrap-4.png"
fulgoranspaceshipcorpsechunk2.name = "fulgoran-spaceship-corpse-chunk2"

data:extend({ fulgoranspaceshipcorpsechunk2 })

-- Make the ships spawn on all routes near Fulgora, even regenerated ones from RSC
local max_probability = 0.005
local mid_distance = 0.9
local start_spawn = 2000 -- 500km from Fulgora, start spawning capsules
for _, conn in pairs(data.raw["space-connection"]) do
  if conn.to == "fulgora" then
    if conn.length > start_spawn then mid_distance = (conn.length - start_spawn) / conn.length end
    table.insert(conn.asteroid_spawn_definitions, {
      asteroid = "fulgoran-hibernation-capsule",
	  spawn_points = {
        { angle_when_stopped = 1, distance= 0.01,         probability = 0,                speed = 0.01},
        { angle_when_stopped = 1, distance= mid_distance, probability = 0,                speed = 0.01}, -- Spawn within start_spawn unless if its too close (e.g. moons)
		{ angle_when_stopped = 1, distance= 0.99,         probability = max_probability,  speed = 0.01},
      },
    })
  end
  if conn.from == "fulgora" then -- reverse route, with reverse distances to mirror spawning
    if conn.length > start_spawn then mid_distance = (start_spawn) / conn.length end
    table.insert(conn.asteroid_spawn_definitions, {
      asteroid = "fulgoran-hibernation-capsule",
	  spawn_points = {
        { angle_when_stopped = 1, distance= 0.01,         probability = max_probability,  speed = 0.01},
        { angle_when_stopped = 1, distance= mid_distance, probability = 0,                speed = 0.01}, -- Spawn within start_spawn unless if its too close (e.g. moons)
		{ angle_when_stopped = 1, distance= 0.99,         probability = 0,                speed = 0.01},
      },
    })
  end
end

-- Final asteroid crushing recipe.  
data:extend({
  {
    type = "recipe",
    name = "fulgoran-spaceship-corpse-chunk2-crushing",
    category = "crushing",
	subgroup = "space-crushing",
	order = "b-a-d",
    energy_required = 2,
	icon = "__fulgora-orbital-defence__/graphics/icons/fulgoran-spaceship-corpse-chunk2-crushing.png",
    icon_size = 64,
    ingredients = {
      { type = "item", name = "fulgoran-spaceship-corpse-chunk2", amount = 1 }
    },
    results = { -- Do not want to trivialise part construction, but still be common enough that a platform over fulgora would get it
      { type = "item", name = "space-platform-foundation", amount = 3, probability = 0.2 },
      { type = "item", name = "steel-plate", amount = 20, probability = 0.1 },
      { type = "item", name = "copper-cable", amount = 20, probability = 0.1 }, -- may be crafted into electronic circuits, with metallic asteroids for iron to make gears for repair packs, for rocket damage
	  { type = "item", name = "electronic-circuit", amount = 5, probability = 0.05 },
	  { type = "item", name = "advanced-circuit", amount = 5, probability = 0.01 },
	  { type = "item", name = "asteroid-collector", amount = 1, probability = 0.01},
	  { type = "item", name = "thruster", amount = 1, probability = 0.05},
	  { type = "item", name = "crusher", amount = 1, probability = 0.02},
	  { type = "item", name = "cargo-bay", amount = 1, probability = 0.01}
    }
  }
})

data:extend({
  {
    type = "recipe",
    name = "advanced-fulgoran-spaceship-corpse-chunk2-crushing",
    category = "crushing",
	subgroup = "space-crushing",
	order = "c-a-d",
    energy_required = 2,
	icon = "__fulgora-orbital-defence__/graphics/icons/advanced-fulgoran-spaceship-corpse-chunk2-crushing.png",
    icon_size = 64,
    ingredients = {
      { type = "item", name = "fulgoran-spaceship-corpse-chunk2", amount = 1 }
    },
    results = { -- 50% more useful space platform parts, just no platform foundation (or steel or cable)
	  { type = "item", name = "asteroid-collector", amount = 1, probability = 0.015},
	  { type = "item", name = "thruster", amount = 1, probability = 0.0625},
	  { type = "item", name = "crusher", amount = 1, probability = 0.03},
	  { type = "item", name = "cargo-bay", amount = 1, probability = 0.015},
	  { type = "item", name = "rocket-turret", amount = 1, probability = 0.01}, -- Behind Gleba research anyway
	  { type = "item", name = "advanced-circuit", amount = 5, probability = 0.05 }, -- Better circuits for advanced processing
	  { type = "item", name = "processing-unit", amount = 5, probability = 0.01 },
	  { type = "item", name = "holmium-ore", amount = 1, probability = 0.01} -- Trace holmium not enough to be useful, just to be some ironic waste

    }
  }
})

--The tech to unlock it.  Bundled with the other crushing on Space-Platform just in case, even though only Fulgora routes should be affected.  
local space_platform_tech = data.raw["technology"]["space-platform"]
if space_platform_tech then
  table.insert(space_platform_tech.effects, {
    type = "unlock-recipe",
    recipe = "fulgoran-spaceship-corpse-chunk2-crushing"
  })
end

local space_platform_tech = data.raw["technology"]["advanced-asteroid-processing"]
if space_platform_tech then
  table.insert(space_platform_tech.effects, {
    type = "unlock-recipe",
    recipe = "advanced-fulgoran-spaceship-corpse-chunk2-crushing"
  })
end