--New Asteroid chunks to be harvested from the enemy corpse (use shippy scrap graphics for now)
local fulgoranspaceshipcorpsechunk = table.deepcopy(data.raw["asteroid-chunk"]["metallic-asteroid-chunk"])
fulgoranspaceshipcorpsechunk.name = "fod-fulgoran-spaceship-corpse-chunk"
fulgoranspaceshipcorpsechunk.icon = "__space-age__/graphics/icons/scrap-4.png"
fulgoranspaceshipcorpsechunk.pictures = {
  {
    filename = "__space-age__/graphics/icons/scrap-4.png",
    size = 64,
    scale = 0.5
  }
}
fulgoranspaceshipcorpsechunk.minable = {
	mining_particle = "metallic-asteroid-chunk-particle-medium",
	mining_time = 0.2,
	result = "fod-fulgoran-spaceship-corpse-chunk"
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
local fulgoranspaceshipcorpsechunkitem = table.deepcopy(data.raw["item"]["metallic-asteroid-chunk"])
fulgoranspaceshipcorpsechunkitem.icon = "__space-age__/graphics/icons/scrap-4.png"
fulgoranspaceshipcorpsechunkitem.name = "fod-fulgoran-spaceship-corpse-chunk"
fulgoranspaceshipcorpsechunkitem.pictures = {
  {
    filename = "__space-age__/graphics/icons/scrap-4.png",
    size = 64,
    scale = 0.5
  }
}
data:extend({ fulgoranspaceshipcorpsechunkitem })