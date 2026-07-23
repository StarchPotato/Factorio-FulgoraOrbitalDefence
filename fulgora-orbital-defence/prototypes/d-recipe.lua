-- Final asteroid crushing recipe.  
data:extend({
  {
    type = "recipe",
    name = "fod-fulgoran-spaceship-corpse-chunk-crushing",
    categories = {"crushing"},
	subgroup = "space-crushing",
	order = "b-a-d",
    energy_required = 2,
	icon = "__fulgora-orbital-defence__/graphics/icons/fulgoran-spaceship-corpse-chunk-crushing.png",
    icon_size = 64,
    ingredients = {
      { type = "item", name = "fod-fulgoran-spaceship-corpse-chunk", amount = 1 }
    },
    results = { -- Do not want to trivialise part construction, but still be common enough that a platform over fulgora would get it
      { type = "item", name = "space-platform-foundation", amount = 3, independent_probability = 0.2 },
	  { type = "item", name = "electronic-circuit", amount = 5, independent_probability = 0.15 },
	  { type = "item", name = "advanced-circuit", amount = 5, independent_probability = 0.01 },
	  { type = "item", name = "asteroid-collector", amount = 1, independent_probability = 0.01},
	  { type = "item", name = "thruster", amount = 1, independent_probability = 0.05},
	  { type = "item", name = "crusher", amount = 1, independent_probability = 0.02},
	  { type = "item", name = "cargo-bay", amount = 1, independent_probability = 0.01},
	  { type = "item", name = "fod-fulgoran-spaceship-corpse-chunk", amount = 1, independent_probability = 0.2 } -- Return base component, like other asteroid crushing
    }
  }
})

data:extend({
  {
    type = "recipe",
    name = "fod-fulgoran-spaceship-corpse-chunk-recycling",
    categories = {"recycling"},
	auto_recycle = false,
	enabled = false,
	subgroup = "space-crushing",
	order = "c-a-d",
    energy_required = 5,
	icon = "__fulgora-orbital-defence__/graphics/icons/fulgoran-spaceship-corpse-chunk-recycling.png",
    icon_size = 64,
    ingredients = {
      { type = "item", name = "fod-fulgoran-spaceship-corpse-chunk", amount = 1 }
    },
    results = { -- 50% more useful space platform parts, just no platform foundation or basic circuits
	  { type = "item", name = "rocket", amount = 5, independent_probability = 0.2}, -- Yes, this is 1 per recycle on average, but it keeps everything probabalistic
	  { type = "item", name = "asteroid-collector", amount = 1, independent_probability = 0.015},
	  { type = "item", name = "thruster", amount = 1, independent_probability = 0.075},
	  { type = "item", name = "crusher", amount = 1, independent_probability = 0.03},
	  { type = "item", name = "cargo-bay", amount = 1, independent_probability = 0.015},
	  --{ type = "item", name = "rocket-turret", amount = 1, independent_probability = 0.01}, -- Behind Gleba research, but still allows not continuing the production
	  { type = "item", name = "advanced-circuit", amount = 5, independent_probability = 0.05 }, -- Better circuits for advanced processing
	  { type = "item", name = "processing-unit", amount = 5, independent_probability = 0.01 },
	  { type = "item", name = "holmium-ore", amount = 1, independent_probability = 0.01} -- Trace holmium not enough to be useful, just to be some ironic waste

    }
  }
})

data:extend({
  {
    type = "recipe",
    name = "fod-fulgoran-spaceship-capsule",
    categories = {"electromagnetics"},
	auto_recycle = false,
	enabled = false,
	subgroup = "military-equipment",
	order = "g[fulgoran]-b[capsule]",
    energy_required = 5,
	icon = "__fulgora-orbital-defence__/graphics/icons/fulgoran-hibernation-capsule-icon.png",
    icon_size = 64,
    ingredients = {
      { type = "item", name = "destroyer-capsule", amount = 16 },
	  { type = "item", name = "rocket-turret", amount = 1 }, -- Its a flying rocket turret, so no Gleba bypass
	  { type = "fluid", name = "holmium-solution", amount = 80 }
    },
      results = {
        {
          amount = 4,
          name = "fod-fulgoran-spaceship-capsule",
          type = "item"
        }
	}
  }
})

-- Escape rocket doesn't need crafting

data:extend({{type = "recipe-category",name = "fod-cargo-pod-silo"}}) -- Small category to hide the recipe
data:extend({
  {
    type = "recipe",
    name = "fod-pod-dummy-recipe",
    enabled = true,
    hidden = true,
    hide_from_player_crafting = true,
    categories = {"fod-cargo-pod-silo"},
	surface_condition = {{"Pressure", min = 0, max = 0}}, -- Not a valid recipe for any rocket silo, which need >1 hPa Pressure.  Used to lock it to here
    energy_required = 1,
    ingredients = {}, -- Free!
    results = {{type = "item", name = "rocket-part", amount = 1}} -- I'd make this zero if I could
  }
})