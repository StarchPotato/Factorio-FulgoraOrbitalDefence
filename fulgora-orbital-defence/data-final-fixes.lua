-- Make the ships spawn on all routes near Fulgora, even regenerated ones from RSC
local max_probability = 0.005
local mid_distance = 0.9
local start_spawn = 2000 -- 500km from Fulgora, start spawning capsules
local fulgora = data.raw["planet"]["fulgora"]
if fulgora then
  fulgora.asteroid_spawn_influence = 0 -- This is only to get the planet spawning in place.  Route is already fully defined
  table.insert(fulgora.asteroid_spawn_definitions, {
  asteroid = "fulgoran-hibernation-capsule",
  angle_when_stopped = 1, probability = max_probability,  speed = 0.01
})
end
for _, conn in pairs(data.raw["space-connection"]) do
  if conn.to == "fulgora" then
    if conn.length > start_spawn then mid_distance = (conn.length - start_spawn) / conn.length end
	table.insert(conn.asteroid_spawn_definitions, {
      asteroid = "fulgoran-hibernation-capsule",
	  spawn_points = {
        { angle_when_stopped = 1, distance= 0.01,         probability = 0,                speed = 0.01},
        { angle_when_stopped = 1, distance= mid_distance, probability = 0,                speed = 0.01}, -- Spawn within start_spawn unless if its too close (e.g. moons)
		{ angle_when_stopped = 1, distance= 1,            probability = max_probability,  speed = 0.01},
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
		{ angle_when_stopped = 1, distance= 1,            probability = 0,                speed = 0.01},
      },
    })
  end
end

-- Final asteroid crushing recipe.  
data:extend({
  {
    type = "recipe",
    name = "fulgoran-spaceship-corpse-chunk-crushing",
    category = "crushing",
	subgroup = "space-crushing",
	order = "b-a-d",
    energy_required = 2,
	icon = "__fulgora-orbital-defence__/graphics/icons/fulgoran-spaceship-corpse-chunk-crushing.png",
    icon_size = 64,
    ingredients = {
      { type = "item", name = "fulgoran-spaceship-corpse-chunk", amount = 1 }
    },
    results = { -- Do not want to trivialise part construction, but still be common enough that a platform over fulgora would get it
      { type = "item", name = "space-platform-foundation", amount = 3, probability = 0.2 },
	  { type = "item", name = "electronic-circuit", amount = 5, probability = 0.15 },
	  { type = "item", name = "advanced-circuit", amount = 5, probability = 0.01 },
	  { type = "item", name = "asteroid-collector", amount = 1, probability = 0.01},
	  { type = "item", name = "thruster", amount = 1, probability = 0.05},
	  { type = "item", name = "crusher", amount = 1, probability = 0.02},
	  { type = "item", name = "cargo-bay", amount = 1, probability = 0.01},
	  { type = "item", name = "fulgoran-spaceship-corpse-chunk", amount = 1, probability = 0.2 } -- Return base component, like other asteroid crushing
    }
  }
})

data:extend({
  {
    type = "recipe",
    name = "fulgoran-spaceship-corpse-chunk-recycling",
    category = "recycling",
	auto_recycle = false,
	enabled = false,
	subgroup = "space-crushing",
	order = "c-a-d",
    energy_required = 5,
	icon = "__fulgora-orbital-defence__/graphics/icons/fulgoran-spaceship-corpse-chunk-recycling.png",
    icon_size = 64,
    ingredients = {
      { type = "item", name = "fulgoran-spaceship-corpse-chunk", amount = 1 }
    },
    results = { -- 50% more useful space platform parts, just no platform foundation or basic circuits
	  { type = "item", name = "rocket", amount = 5, probability = 0.2}, -- Yes, this is 1 per recycle on average, but it keeps everything probabalistic
	  { type = "item", name = "asteroid-collector", amount = 1, probability = 0.015},
	  { type = "item", name = "thruster", amount = 1, probability = 0.075},
	  { type = "item", name = "crusher", amount = 1, probability = 0.03},
	  { type = "item", name = "cargo-bay", amount = 1, probability = 0.015},
	  --{ type = "item", name = "rocket-turret", amount = 1, probability = 0.01}, -- Behind Gleba research, but still allows not continuing the production
	  { type = "item", name = "advanced-circuit", amount = 5, probability = 0.05 }, -- Better circuits for advanced processing
	  { type = "item", name = "processing-unit", amount = 5, probability = 0.01 },
	  { type = "item", name = "holmium-ore", amount = 1, probability = 0.01} -- Trace holmium not enough to be useful, just to be some ironic waste

    }
  }
})

--The tech to unlock it.  Bundled with Fulgora discovery, as only Fulgora routes should be affected.  
local space_platform_tech = data.raw["technology"]["planet-discovery-fulgora"]
if space_platform_tech then
  table.insert(space_platform_tech.effects, {
    type = "unlock-recipe",
    recipe = "fulgoran-spaceship-corpse-chunk-crushing"
  })
end
-- Advanced processing uses the recycler, and it tethered to this technology
local space_platform_tech = data.raw["technology"]["recycling"]
if space_platform_tech then
  table.insert(space_platform_tech.effects, {
    type = "unlock-recipe",
    recipe = "fulgoran-spaceship-corpse-chunk-recycling"
  })
end