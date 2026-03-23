--Fulgoran robots that move/attack like spitters and look like destroyer robots
--Spawned by hibernation pod destruction
local fulgoranspaceship = table.deepcopy(data.raw["unit"]["small-spitter"]) -- Spitters move good, and shoot stuff
fulgoranspaceship.name = "fulgoran-spaceship"
fulgoranspaceship.icon = "__base__/graphics/icons/destroyer.png"
fulgoranspaceship.movement_type = "flying"
fulgoranspaceship.movement_speed = 0.15
fulgoranspaceship.max_pursue_distance = 100000
fulgoranspaceship.visiondistance = 100000
fulgoranspaceship.collision_mask = { layers = {} }
fulgoranspaceship.collision_box = { { 0, 0 }, { 0, 0 } }
fulgoranspaceship.max_health = 600
fulgoranspaceship.resistances = { --Vulnerable to lasers/electricity, but somewhat hardy to physical attacks like bullets and rockets.  Encourage tesla weapons on Fulgora ships after conquoring the planet.
  { decrease = 15, percent = 20, type = "physical" },
  { decrease = 5,  percent = 30, type = "explosion"	},
  { decrease = 0,  percent = 0,  type = "fire" }, -- If you find a way to use flamethrowers in space, you deserve no resistance
  { decrease = 0,  percent = 10, type = "laser"},
  { decrease = 0,  percent = 0,  type = "electric"},  -- Use Fulgora to defeat Fulgora
}
fulgoranspaceship.attack_parameters = {
        ammo_category = "rocket",
        ammo_type = {
          action = {
            action_delivery = {
              max_range = 32,
              projectile = "rocket",
              starting_speed = 0.1,
              type = "projectile"
            },
            type = "direct"
          }
        },
        cooldown = 120,
		damage_modifier = 0.25, -- Weaken the damage.  Asteroids are impact damage, so need to make projectiles less effective to balance it
        range = 15,
        sound = {
          filename = "__base__/sound/fight/rocket-launcher.ogg",
          modifiers = {
            type = "main-menu",
            volume_multiplier = 0.9
          },
		  volume = 0.7 -- both multiplier and flat value are used in data.raw
		  },
        type = "projectile",
        use_shooter_direction = true
      }
local destroyer = data.raw["combat-robot"]["destroyer"] -- Destroyer capsules look good
fulgoranspaceship.idle = table.deepcopy(destroyer.idle)
fulgoranspaceship.in_motion = table.deepcopy(destroyer.in_motion)
fulgoranspaceship.shadow_idle = table.deepcopy(destroyer.shadow_idle)
fulgoranspaceship.shadow_in_motion = table.deepcopy(destroyer.shadow_in_motion)
fulgoranspaceship.dying_sound = {
  aggregation = {
    max_count = 3,
    remove = true
  },
  variations = {
    { filename = "__base__/sound/fight/robot-explosion-1.ogg", volume = 1.0 },
    { filename = "__base__/sound/fight/robot-explosion-2.ogg", volume = 1.0 },
    { filename = "__base__/sound/fight/robot-explosion-3.ogg", volume = 1.0 },
    { filename = "__base__/sound/fight/robot-explosion-4.ogg", volume = 1.0 },
    { filename = "__base__/sound/fight/robot-explosion-5.ogg", volume = 1.0 },
  }
}
fulgoranspaceship.attack_parameters.animation = nil
fulgoranspaceship.alternative_attacking_frame_sequence = nil
fulgoranspaceship.run_animation = {
  layers = {
    {
      filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot.png",
      priority = "high",
      line_length = 32,
      width = 88,
      height = 77,
      direction_count = 32,
      shift = {0.078125, -0.015625},
      scale = 0.5
    },
    {
      filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot-mask.png",
      priority = "high",
      line_length = 32,
      width = 52,
      height = 42,
      direction_count = 32,
      shift = {0.078125, -0.109375},
      apply_runtime_tint = true,
      scale = 0.5
    }
  }
}
fulgoranspaceship.attack_parameters.animation = table.deepcopy(data.raw["spider-unit"]["small-strafer-pentapod"].graphics_set.animation) -- Strafer attacks look good
fulgoranspaceship.dying_trigger_effect = {
        {
          entity_name = "carbonic-asteroid-explosion-2",
          only_when_visible = true,
          type = "create-explosion"
        }
      }
data:extend({ fulgoranspaceship })
--TODO: factoriopedia entry

-- New small Asteroid to generate the enemy
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
      }, -- Its the wrong normal/roughness maps, but it still looks fine
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
--TODO: factoriopedia entry

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
--graphics_set lifted form vanilla data.raw (rounded) until custom graphics are implemented.  May look fine enough though
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
  variations = { -- Only 1 variation, so can add other scrap icons later if needed
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
