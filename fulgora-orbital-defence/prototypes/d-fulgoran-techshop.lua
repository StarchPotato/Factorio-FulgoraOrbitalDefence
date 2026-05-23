-- Custom assets found at the space manufactory (the hub, invisible assets, escape pod)

local fulgoran_technology_hub = {
    type = "simple-entity-with-owner",
    name = "fod-tech-hub",
    icon = "__fulgora-orbital-defence__/graphics/entities/fulgoran-technology-hub.png",
    icon_size = 518,
    flags = {"placeable-neutral", "player-creation", "not-repairable"},
    max_health = 1000,
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    animations = {
        layers = {
            {
                filename = "__fulgora-orbital-defence__/graphics/entities/fulgoran-technology-hub.png",
                priority = "extra-high",
                width = 518,
                height = 623,
                frame_count = 1,
                shift = {0, 0},
                scale = 32*5/518, -- 5 tiles wide
				shift = {0,0}
            }
        }
    },
    
    -- Cleanup and Effects
    dying_explosion = "massive-explosion",
    corpse = "fod-tech-hub-remnants",
    render_layer = "object"
}

data:extend({fulgoran_technology_hub})

local fulgoran_technology_hub_remnants = {
    type = "corpse",
    name = "fod-tech-hub-remnants",
    icon = "__fulgora-orbital-defence__/graphics/entities/fulgoran-technology-hub.png",
    icon_size = 518,
    flags = {"placeable-neutral", "not-on-map"},
    time_before_removed = nil,
    final_render_layer = "remnants",
    animation = {
        layers = {
            {
                filename = "__fulgora-orbital-defence__/graphics/entities/fulgoran-technology-hub-remnants.png",
                width = 657,
                height = 607,
                frame_count = 1,
                direction_count = 1,
                shift = {0, 0},
                scale = 32*5/518 -- 5 tiles wide
            }
        }
    },
    selection_box = {{0, 0}, {0, 0}},
    selectable_in_game = false
}

data:extend({fulgoran_technology_hub_remnants})

local empty_sprite = { filename = "__core__/graphics/empty.png", width = 1, height = 1 }
local empty_animation = {filename = "__core__/graphics/empty.png", width = 1, height = 1,
        frame_count = 1,  line_length = 1,  direction_count = 1, animation_speed = 1 } -- Sprite, but with frames specified


--local cargo_pod_launcher = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
local cargo_pod_launcher = {}
cargo_pod_launcher.type = "rocket-silo"
cargo_pod_launcher.name = "fod-cargo-pod-launcher"
cargo_pod_launcher.icon = "__fulgora-orbital-defence__/graphics/icons/cargo-pod-launcher.png"
cargo_pod_launcher.icon_size = 207
cargo_pod_launcher.energy_usage = "1MW"
cargo_pod_launcher.active_energy_usage = "1MW"
cargo_pod_launcher.lamp_energy_usage = "1MW"
cargo_pod_launcher.rocket_entity = "cargo-pod-container"
cargo_pod_launcher.base_day_sprite = {
    layers = {
        {
            filename = "__base__/graphics/entity/artillery-turret/artillery-turret-base.png",
            width = 207,
            height = 199,
            scale = 0.5,
            shift = {0.1, 0}
        }
    }
}
cargo_pod_launcher.base_front_sprite = {
    layers = {
       	-- { -- Crude attempt at masking over the thruster animation
            -- filename = "__fulgora-orbital-defence__/graphics/entities/concrete-splat.png",
			-- x = 0, y = 0,
            -- width = 512,
            -- height = 1024,
            -- scale = 0.5,
            -- shift = {0, -1},
			-- --render_layer = "ground-layer-5"
        -- },
		{
            filename = "__fulgora-orbital-defence__/graphics/entities/artillery-front-base.png",
            width = 207,
            height = 199,
            scale = 0.5,
            shift = {0.1, 0}
        }
    }
}
cargo_pod_launcher.hole_clipping_box  = {{-1.75, -0.15}, {1.75, 3.25}}
cargo_pod_launcher.door_back_open_offset = {0, 0}
cargo_pod_launcher.door_front_open_offset = {0, 0}
cargo_pod_launcher.silo_fade_out_start_distance = data.raw["rocket-silo"]["rocket-silo"].silo_fade_out_start_distance
cargo_pod_launcher.silo_fade_out_end_distance = data.raw["rocket-silo"]["rocket-silo"].silo_fade_out_end_distance
cargo_pod_launcher.times_to_blink = 1
cargo_pod_launcher.light_blinking_speed = 1
cargo_pod_launcher.door_opening_speed = 1
cargo_pod_launcher.rocket_parts_required = 1
cargo_pod_launcher.rocket_quick_relaunch_start_offset = 0
cargo_pod_launcher.to_be_inserted_to_rocket_inventory_size = 1 -- If its 0, you can't launch to platform.  In retrospect, you can use the one slot to reclaim some turrets or something
cargo_pod_launcher.logistic_trash_inventory_size = 0
cargo_pod_launcher.cargo_station_parameters = data.raw["rocket-silo"]["rocket-silo"].cargo_station_parameters
cargo_pod_launcher.fixed_recipe = "fod-pod-dummy-recipe"
cargo_pod_launcher.crafting_speed = 1
cargo_pod_launcher.crafting_categories = {"fod-cargo-pod-silo"}
cargo_pod_launcher.energy_source = {type = "void"}
cargo_pod_launcher.module_slots = 0
cargo_pod_launcher.show_recipe_icon = false
cargo_pod_launcher.show_recipe_icon_on_map = false
cargo_pod_launcher.hide_recipe_in_gui = true
cargo_pod_launcher.collision_box = data.raw["artillery-turret"]["artillery-turret"].collision_box
cargo_pod_launcher.selection_box = data.raw["artillery-turret"]["artillery-turret"].selection_box
cargo_pod_launcher.launch_to_space_platforms = true
cargo_pod_launcher.rocket_entity = "fod-pod-rocket"
cargo_pod_launcher.can_launch_without_landing_pads = true
data:extend({cargo_pod_launcher})

local pod_rocket = {} --table.deepcopy(data.raw["rocket-silo-rocket"]["rocket-silo-rocket"])
pod_rocket.type =  "rocket-silo-rocket"
pod_rocket.hidden_in_factoriopedia = true
pod_rocket.name = "fod-pod-rocket"
pod_rocket.icon = "__base__/graphics/icons/cargo-pod.png" 
pod_rocket.rocket_sprite = {
    filename = "__base__/graphics/entity/cargo-pod/pod-static-detached.png",
    width = 78,
    height = 172,
    scale = 0.5,
    shift = {-0, -1}
}
pod_rocket.rocket_rise_offset = {0, 0}
pod_rocket.rocket_launch_offset = {0, -256}
pod_rocket.cargo_pod_entity = "cargo-pod"
pod_rocket.rocket_initial_offset = {0, 1}
pod_rocket.rocket_flame_left_rotation = 0
pod_rocket.rocket_flame_right_rotation = 0
pod_rocket.rocket_render_layer_switch_distance = data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].rocket_render_layer_switch_distance
pod_rocket.full_render_layer_switch_distance = data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].full_render_layer_switch_distance
pod_rocket.effects_fade_in_start_distance = data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].effects_fade_in_start_distance
pod_rocket.effects_fade_in_end_distance = data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].effects_fade_in_end_distance
pod_rocket.shadow_fade_out_start_ratio = data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].shadow_fade_out_start_ratio
pod_rocket.shadow_fade_out_end_ratio = data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].shadow_fade_out_end_ratio
pod_rocket.rocket_visible_distance_from_center = data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].rocket_visible_distance_from_center
pod_rocket.rising_speed = 1 --data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].rising_speed
pod_rocket.engine_starting_speed = 1 -- data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].engine_starting_speed
pod_rocket.flying_speed = data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].flying_speed
pod_rocket.flying_acceleration = data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].flying_acceleration
pod_rocket.inventory_size = 1 -- Need at least 1 slot to show the launch pad
pod_rocket.rocket_shadow_sprite = {
		filename = "__base__/graphics/entity/cargo-pod/pod-static-shadow.png",
		width = 174,
		height = 56,
		scale = 0.5,
		draw_as_shadow = true}
pod_rocket.rocket_glare_overlay_sprite = nil
pod_rocket.rocket_smoke_animations = nil
pod_rocket.flying_sound = {
        aggregation = {
          count_already_playing = true,
          max_count = 3,
          priority = "oldest",
          remove = true
        },
        audible_distance_modifier = 6,
        filename = "__base__/sound/silo-rocket.ogg",
        modifiers = {
          type = "main-menu",
          volume_multiplier = 0.6
        },
        volume = 1
      }
pod_rocket.rocket_flame_animation = {
            animation_speed = 0.5,
            blend_mode = "additive",
            draw_as_glow = true,
            filename = "__base__/graphics/entity/cargo-pod/pod-thruster-ignition.png", -- Empty sprite to have it blank at the start
            flags = {
              "group=effect-texture",
              "linear-minification",
              "linear-magnification"
            },
            frame_count = 10,
            height = 256,
			width = 172,
            line_length = 5,
			--lines_per_file = 1,
            priority = "no-atlas",
            scale = 0.2,
            shift = {
              0,
              0.8 -- The only change from cargo-pod animation.  Scaled so the flame doesn't stick out the bottom
            },
			run_mode = "forward-then-backward"
          }

data:extend({pod_rocket})