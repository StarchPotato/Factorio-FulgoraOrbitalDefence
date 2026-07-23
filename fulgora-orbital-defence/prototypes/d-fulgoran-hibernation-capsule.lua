-- New small Asteroid to generate the enemy
local fulgoranhibernationcapsule = table.deepcopy(data.raw["asteroid"]["small-metallic-asteroid"])
fulgoranhibernationcapsule.name = "fod-fulgoran-hibernation-capsule"
fulgoranhibernationcapsule.icon = "__fulgora-orbital-defence__/graphics/icons/fulgoran-hibernation-capsule-icon.png"
fulgoranhibernationcapsule.icon_size = 64
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
        filename = "__fulgora-orbital-defence__/graphics/icons/fulgoran-hibernation-capsule-icon.png",
        size = 64,
        scale = 1
      }, -- Its the wrong normal/roughness maps, but it still looks fine
      normal_map = {
        filename = "__space-age__/graphics/entity/asteroid/metallic/small/asteroid-metallic-small-normal-01.png",
        premul_alpha = false,
        size = 128,
        scale = 1
      },
      roughness_map = {
        filename = "__space-age__/graphics/entity/asteroid/metallic/small/asteroid-metallic-small-roughness-01.png",
        premul_alpha = false,
        size = 128,
        scale = 1
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

fulgoranhibernationcapsule.factoriopedia_simulation = { -- copied from the standard asteroid animation, but with an atomosphere tint
  init = [[
  require("__core__/lualib/story")
  game.simulation.camera_position = {0,0}
    for x = -8, 8, 1 do
      for y = -3, 3 do
        game.surfaces[1].set_tiles{{position = {x, y}, name = "empty-space"}}
      end
    end

    for x = -1, 0, 1 do
      for y = -1, 0 do
        game.surfaces[1].set_chunk_generated_status({x, y}, defines.chunk_generated_status.entities)
      end
    end

    local story_table =
    {
      {
        {
          name = "start",
          action = function() game.surfaces[1].create_entity{name="fod-fulgoran-hibernation-capsule", position = {0, 0}, velocity = {0, 0.011}} end
        },
        {
          condition = story_elapsed_check(7),
          action = function() story_jump_to(storage.story, "start") end
        }
      }
    }
    tip_story_init(story_table)
  ]]
}

data:extend({ fulgoranhibernationcapsule })