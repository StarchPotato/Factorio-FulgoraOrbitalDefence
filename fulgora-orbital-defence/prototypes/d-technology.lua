--The tech to unlock it.  Bundled with Fulgora discovery, as only Fulgora routes should be affected.  
local space_platform_tech = data.raw["technology"]["planet-discovery-fulgora"]
if space_platform_tech then
  table.insert(space_platform_tech.effects, {
    type = "unlock-recipe",
    recipe = "fod-fulgoran-spaceship-corpse-chunk-crushing"
  })
end
-- Advanced processing uses the recycler, and it tethered to this technology
local space_platform_tech = data.raw["technology"]["recycling"]
if space_platform_tech then
  table.insert(space_platform_tech.effects, {
    type = "unlock-recipe",
    recipe = "fod-fulgoran-spaceship-corpse-chunk-recycling"
  })
end
-- Learning of the manufactory location
data:extend({
  {
    type = "technology",
    name = "fod-fulgoran-space-manufactory-discovery",
    icon = "__fulgora-orbital-defence__/graphics/icons/space-location-icon.png", -- Location map
    icon_size = 144,
    effects = {
		{
        type = "unlock-space-location",
        space_location = "fulgoran-space-manufactory"
		}
	},
	prerequisites = {
		"destroyer", -- Combat bot upgrade
		"mech-armor", -- Space suit to reach the station
		"rocket-turret" -- Needed to craft, so no point going here before Gleba
		},
    unit = {
      count = 1000,
      ingredients = {
          {"automation-science-pack",1},
          {"logistic-science-pack",1},
		  {"chemical-science-pack",1},
          {"military-science-pack",1},
          {"utility-science-pack",1},
          {"space-science-pack",1},
          {"electromagnetic-science-pack",1}
        },
        time = 60
    },
    order = "z-f-s"
  }
})
-- Stand next to the core for 30s to learn how to make the bots yourself
data:extend({
  {
    type = "technology",
    name = "fod-fulgoran-spaceship-capsule-research",
    icon = "__fulgora-orbital-defence__/graphics/icons/fulgoran-hibernation-capsule-icon.png",
    icon_size = 256,
    effects = {
		{
        type = "unlock-recipe",
        recipe = "fod-fulgoran-spaceship-capsule"
		}
	},
	prerequisites = {
		"fod-fulgoran-space-manufactory-discovery"
		},
    research_trigger = {type = "scripted"},
    order = "z-f-s"
  }
})