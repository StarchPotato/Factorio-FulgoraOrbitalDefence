--Invisible stuff
local transparent_sprite = {
    filename = "__core__/graphics/empty.png",
    width = 1,
    height = 1,
	direction_count = 1,
    priority = "extra-high"
}

local hidden_flags = { -- Everything to make this squeeze into the model without detection
    "placeable-off-grid",
    "not-on-map",
    "hide-alt-info",
    "not-blueprintable",
    "not-deconstructable"
}
local zero_box = {{0, 0}, {0, 0}}
local collision_box = {{-0.1, -0.1}, {0.1, 0.1}}

-- Hidden infinity chest
local hidden_chest = table.deepcopy(data.raw["infinity-container"]["infinity-chest"])
hidden_chest.name          = "fod-hidden-infinity-chest"
hidden_chest.flags         = hidden_flags
hidden_chest.minable       = nil
hidden_chest.collision_box = collision_box
hidden_chest.selection_box = zero_box
hidden_chest.picture       = transparent_sprite
hidden_chest.collision_mask = {layers = {}}
hidden_chest.hidden_in_factoriopedia = true

-- Hidden inserter
local hidden_inserter = table.deepcopy(data.raw["inserter"]["inserter"])
hidden_inserter.name                = "fod-hidden-inserter"
hidden_inserter.flags               = hidden_flags
hidden_inserter.minable             = nil
hidden_inserter.collision_box       = collision_box
hidden_inserter.selection_box       = zero_box
hidden_inserter.platform_picture    = transparent_sprite
hidden_inserter.hand_base_picture   = transparent_sprite
hidden_inserter.hand_open_picture   = transparent_sprite
hidden_inserter.hand_closed_picture = transparent_sprite
hidden_inserter.collision_mask = {layers = {}}
hidden_inserter.shadow = nil
hidden_inserter.hand_base_shadow = nil
hidden_inserter.hand_outer_shadow = nil
hidden_inserter.hand_side_shadow = nil
hidden_inserter.next_upgrade        = nil
hidden_inserter.draw_held_item = false
hidden_inserter.working_sound = nil
hidden_inserter.open_sound    = nil
hidden_inserter.close_sound   = nil
hidden_inserter.hidden_in_factoriopedia = true

-- Hidden inserter, but long (still slow, but just in case)
local hidden_long_inserter = table.deepcopy(hidden_inserter)
hidden_long_inserter.name = "fod-hidden-long-inserter"
local base_long = data.raw["inserter"]["long-handed-inserter"]
hidden_long_inserter.insert_position = base_long.insert_position
hidden_long_inserter.pickup_position = base_long.pickup_position

-- Hidden Roboport (emulating space platform hub for surface construction/repair)
local hidden_roboport = table.deepcopy(data.raw["roboport"]["roboport"])
hidden_roboport.name = "fod-hidden-roboport"
hidden_roboport.flags = hidden_flags
hidden_roboport.minable = nil
hidden_roboport.collision_box = collision_box
hidden_roboport.selection_box = zero_box
hidden_roboport.collision_mask = {layers = {}}
hidden_roboport.base = { filename = "__core__/graphics/empty.png", width = 1, height = 1 }
hidden_roboport.base_patch = nil
hidden_roboport.base_animation = { filename = "__core__/graphics/empty.png", width = 1, height = 1, frame_count = 1 }
hidden_roboport.door_animation_up = { filename = "__core__/graphics/empty.png", width = 1, height = 1, frame_count = 1 }
hidden_roboport.door_animation_down = { filename = "__core__/graphics/empty.png", width = 1, height = 1, frame_count = 1 }
hidden_roboport.recharge_animation = { filename = "__core__/graphics/empty.png", width = 1, height = 1, frame_count = 1 }
hidden_roboport.working_sound = nil
hidden_roboport.open_door_trigger_effect = nil
hidden_roboport.close_door_trigger_effect = nil
hidden_roboport.recharge_minimum_wire_distance = 0
hidden_roboport.draw_copper_wires = false
hidden_roboport.draw_circuit_wires = false
hidden_roboport.next_upgrade = nil
hidden_roboport.construction_radius = 100 -- Cover the mothership
hidden_roboport.hidden_in_factoriopedia = true

--Hidden construction bot (emulating space platform hub for surface construction/repair)
local hidden_const_bot = table.deepcopy(data.raw["construction-robot"]["construction-robot"])
hidden_const_bot.name = "fod-hidden-construction-robot"
hidden_const_bot.flags = {"placeable-off-grid", "not-on-map", "hide-alt-info"}
hidden_const_bot.working_sound = nil
hidden_const_bot.dying_sound = nil
hidden_const_bot.working_light = nil
hidden_const_bot.sparks = nil
hidden_const_bot.repairing_sound = nil
hidden_const_bot.working_visualisations = nil
hidden_const_bot.idle = transparent_sprite
hidden_const_bot.in_motion = transparent_sprite
hidden_const_bot.working = transparent_sprite
hidden_const_bot.shadow_idle = transparent_sprite
hidden_const_bot.shadow_in_motion = transparent_sprite
hidden_const_bot.shadow_working = transparent_sprite
hidden_const_bot.speed = 100 -- Near instant repair starts
hidden_const_bot.max_speed = 100
hidden_const_bot.max_payload = 10
hidden_const_bot.speed_multiplier_when_out_of_energy = 0.5
hidden_const_bot.max_energy = "1MJ"
hidden_const_bot.energy_per_tick = "0kJ" -- Free bots
hidden_const_bot.energy_per_move = "0kJ" -- Free bots
hidden_const_bot.selection_box = nil
hidden_const_bot.hidden_in_factoriopedia = true

-- Hidden electric energy interface, but keeps accumulators charged
local primary_power = table.deepcopy(data.raw["electric-energy-interface"]["hidden-electric-energy-interface"])
primary_power.name = "fod-primary-power"
primary_power.energy_source.usage_priority = "primary-output" -- Needed to top up accumulators
primary_power.energy_source.output_flow_limit = "50MW" -- Keep ship charged, but the player may sap it down
primary_power.energy_source.buffer_capacity = "50MJ" -- To let the output flow, there needs to be something to draw on
primary_power.hidden_in_factoriopedia = true

data:extend({
    hidden_chest,
    hidden_inserter,
    hidden_long_inserter,
	hidden_roboport,
	hidden_const_bot,
	primary_power,
})