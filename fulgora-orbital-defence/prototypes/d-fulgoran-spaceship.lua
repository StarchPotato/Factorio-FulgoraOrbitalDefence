--Fulgoran robots that move/attack like spitters and look like destroyer robots (that are bogey headed rocket turrets)
--Spawned by hibernation pod destruction
local fulgoranspaceship = table.deepcopy(data.raw["unit"]["small-spitter"]) -- Spitters move good, and shoot stuff
fulgoranspaceship.name = "fod-fulgoran-spaceship"
fulgoranspaceship.icon = "__fulgora-orbital-defence__/graphics/icons/fulgoran-spaceship-icon.png"
fulgoranspaceship.movement_type = "flying"
fulgoranspaceship.movement_speed = 0.15
fulgoranspaceship.max_pursue_distance = 100000
fulgoranspaceship.visiondistance = 100000
fulgoranspaceship.collision_mask = { layers = {} }
fulgoranspaceship.collision_box = { { 0, 0 }, { 0, 0 } }
fulgoranspaceship.max_health = 600
fulgoranspaceship.working_sound = nil
fulgoranspaceship.walking_sound = nil
fulgoranspaceship.corpse = nil
fulgoranspaceship.blood_particle = nil
fulgoranspaceship.dying_trigger_effect = {
        {
            type = "create-particle",
			frame_speed = 1,
			frame_speed_deviation = 0.5,
            particle_name = "destroyer-dying-particle",
            initial_height = 1.8,
            initial_vertical_speed = 0,
            speed_from_center = 0,
            speed_from_center_deviation = 0.2,
            offset_deviation = {{-0.01, -0.01}, {0.01, 0.01}},
			offset = {{0, 0.5}}
        }
    }

fulgoranspaceship.resistances = { --Vulnerable to lasers/electricity, but somewhat hardy to physical attacks like bullets and rockets.  Encourage tesla weapons on Fulgora ships after conquoring the planet.
  { decrease = 15, percent = 20, type = "physical" },
  { decrease = 5,  percent = 30, type = "explosion"	},
  { decrease = 0,  percent = 0,  type = "fire" }, -- If you find a way to use flamethrowers in space, you deserve no resistance
  { decrease = 0,  percent = 10, type = "laser"},
  { decrease = 0,  percent = 0,  type = "electric"},  -- Use Fulgora to defeat Fulgora
}
data:extend({  -- To avoid showing up as a player explosive bonus
  {
    type = "ammo-category",
    name = "fod-fulgoran-spaceship-rocket",
    bonus_gui_order = "uf",
    icon = "__base__/graphics/icons/ammo-category/rocket.png",
    icon_size = 64,
    subgroup = "ammo-category",
	hidden = true,
	hidden_in_factoriopedia = true, -- Do not show in factoriopedia, just like with biters/spitters.  Entry has been defined just in case it is ever visible through alternative means.
  }
})
fulgoranspaceship.attack_parameters = {
        ammo_category = "fod-fulgoran-spaceship-rocket",
        ammo_type = {
          action = {
            action_delivery = {
              max_range = 32,
              projectile = "rocket",
              starting_speed = 0.1,
              type = "projectile",
			  source_offset = {0,0}
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
local destroyer = table.deepcopy(data.raw["combat-robot"]["destroyer"]) -- Destroyer capsules look good as a baseline
fulgoranspaceship.idle = destroyer.idle
fulgoranspaceship.in_motion = destroyer.in_motion
fulgoranspaceship.shadow_idle = destroyer.shadow_idle
fulgoranspaceship.shadow_in_motion = destroyer.shadow_in_motion
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
fulgoranspaceship.run_animation = { -- Fully sick rocket turret with a train bogey on it's head
  layers = {
	{
	  priority = "high",
      width = 160,
      height = 164,
      direction_count = 64,
	  frame_count = 1,
      shift = {0.078125, -0.46875},
      scale = 0.25,
      stripes = {
        {
          width_in_frames = 1,
          height_in_frames = 22,
          filename = "__space-age__/graphics/entity/rocket-turret/rocket-turret-shooting-1.png"
        },
        {
          width_in_frames = 1,
          height_in_frames = 22,
          filename = "__space-age__/graphics/entity/rocket-turret/rocket-turret-shooting-2.png"
        },
        {
          width_in_frames = 1,
          height_in_frames = 20,
          filename = "__space-age__/graphics/entity/rocket-turret/rocket-turret-shooting-3.png"
        }
      }
    },
	{
	  priority = "high",
      width = 230,
      height = 228,
      direction_count = 64,
	  frame_count = 1,
      shift = {0.078125, -0.46875},
      scale = 0.25,
      stripes = { -- Only use the first column of the sprite to get 64 rotations.  And I'm scared of util
        {
          width_in_frames = 1,
          height_in_frames = 8,
          filename = "__base__/graphics/entity/train-wheel/train-wheel-1.png"
        },
        {
          width_in_frames = 1,
          height_in_frames = 8,
          filename = "__base__/graphics/entity/train-wheel/train-wheel-2.png"
        },
        {
          width_in_frames = 1,
          height_in_frames = 8,
          filename = "__base__/graphics/entity/train-wheel/train-wheel-3.png"
        },
        {
          width_in_frames = 1,
          height_in_frames = 8,
          filename = "__base__/graphics/entity/train-wheel/train-wheel-4.png"
        },
        {
          width_in_frames = 1,
          height_in_frames = 8,
          filename = "__base__/graphics/entity/train-wheel/train-wheel-5.png"
        },
        {
          width_in_frames = 1,
          height_in_frames = 8,
          filename = "__base__/graphics/entity/train-wheel/train-wheel-6.png"
        },
        {
          width_in_frames = 1,
          height_in_frames = 8,
          filename = "__base__/graphics/entity/train-wheel/train-wheel-7.png"
        },
        {
          width_in_frames = 1,
          height_in_frames = 8,
          filename = "__base__/graphics/entity/train-wheel/train-wheel-8.png"
        }
      }
    },
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

fulgoranspaceship.factoriopedia_simulation = {
  init = [[
	game.simulation.camera_zoom = 1.8
    game.simulation.camera_position = {0, 0}
    for x = -40, 40, 1 do
      for y = -40, 40 do
        game.surfaces[1].set_tiles{{position = {x, y}, name = "empty-space"}}
      end
    end
    enemy = game.surfaces[1].create_entity{name = "fod-fulgoran-spaceship", position = {0, 0}}

    step_0 = function()
      game.simulation.camera_position = {enemy.position.x, enemy.position.y - 0.5}
      script.on_nth_tick(1, function()
          step_0()
      end)
    end

    step_0()
  ]]
}

data:extend({ fulgoranspaceship })