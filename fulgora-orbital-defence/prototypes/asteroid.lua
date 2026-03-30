local util = require("util")

-- Deepcopy metallic asteroid
local wreckage = table.deepcopy(data.raw["item"]["metallic-asteroid-chunk"])

-- Rename and modify loot
wreckage.name = "space-platform-wreckage"
wreckage.icon = "__base__/graphics/icons/iron-ore.png" -- replace with custom icon if desired
wreckage.minable = {
    mining_time = 1,
    results = {
        {item = "iron-plate", count = 5, probability = 0.1},
        {item = "steel-plate", count = 2, probability = 0.15},
        {item = "copper-cable", count = 20, probability = 0.2},
        {item = "electronic-circuit", count = 1, probability = 0.1},
        {item = "advanced-circuit", count = 1, probability = 0.05},
        {item = "space-platform-foundation", count = 1, probability = 0.02},
    }
}

data:extend({wreckage})