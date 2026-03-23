script.on_event(defines.events.on_entity_died, function(event)
  local entity = event.entity
  local surface = entity.surface
  local platform = surface.platform
  local position = entity.position
  if entity.name == "fulgoran-hibernation-capsule" then
    local spawned = surface.create_entity{
      name = "fulgoran-spaceship",
      position = position,
      force = "enemy"
    }
	--TODO: give the spitters more floaty AI.  Hub targeting was a fallback in case they were out of range from turrets
     if spawned and spawned.commandable then
      -- local hubs = surface.find_entities_filtered{ name = "space-platform-hub", limit = 1 }
      -- if hubs[1] then
         spawned.commandable.set_command({
		   type = defines.command.wander,
		   distraction = defines.distraction.by_enemy,
		   wander_in_group = false,
          -- type = defines.command.attack,
          -- target = hubs[1],
          -- distraction = defines.distraction.by_enemy,
         })
       end
    -- end
  elseif entity.name == "fulgoran-spaceship" then
  local platform_speed = platform.speed or 0
  platform.create_asteroid_chunks({
    {
      name = "fulgoran-spaceship-corpse-chunk",
      position = position,
      movement = {  -- Need to regenerate a speed to avoid falling south too fast from the spitter stats
      (math.random() - 0.5) * 4/60,
      (math.random() - 0.5) * 4/60 + platform.speed/60
      }
  },
  {
      name = "fulgoran-spaceship-corpse-chunk",
      position = position,
      movement = {  -- Need to regenerate a speed to avoid falling south too fast from the spitter stats
      (math.random() - 0.5) * 4/60,
      (math.random() - 0.5) * 4/60 + platform.speed/60
      }
  }
  })
end
end)