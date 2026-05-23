
local build = require("scripts.s-build-manufactory")

local function force_setup() -- Common setup for init and config changes
  if not game.forces["fulgoran-spaceship-force"] then -- custom force to avoid issues with PollutionSolution and other mods messing with Enemy force
    local force = game.create_force("fulgoran-spaceship-force")
    force.set_cease_fire(game.forces["player"], false)
    force.set_cease_fire(game.forces["enemy"], true)
    game.forces["player"].set_cease_fire(force, false)
    game.forces["enemy"].set_cease_fire(force, true)
  end
  build.build_manufactory()
  storage.proximity_timers = {} -- used for 30s research timer
  for _, surface in pairs(game.surfaces) do
        local launchers = surface.find_entities_filtered{name = "fod-cargo-pod-launcher"}
        for _, launcher in pairs(launchers) do
            launcher.rocket_parts = launcher.prototype.rocket_parts_required
        end
    end
end

-- Brute force initialise whenever possible
script.on_init(force_setup)
script.on_configuration_changed(force_setup)

script.on_event(defines.events.on_entity_died, function(event) -- Scripted action on either asteroid death, or enemy death
  local entity = event.entity
  local surface = entity.surface
  local platform = surface.platform
  local position = entity.position
  if entity.name == "fod-fulgoran-hibernation-capsule" then
    local spawned = surface.create_entity{
      name = "fod-fulgoran-spaceship",
      position = position,
      force = "fulgoran-spaceship-force"
    }
	--TODO: give the spitters more floaty AI.  Or kill them if they exist for too long (only enact if there are bug reports/lag complaints)
     if spawned and spawned.commandable then
         spawned.commandable.set_command({
		   type = defines.command.wander,
		   distraction = defines.distraction.by_enemy,
		   wander_in_group = false,
         })
       end
    -- end
  elseif entity.name == "fod-fulgoran-spaceship" and platform ~= nil then
  local platform_speed = platform.speed or 0
  platform.create_asteroid_chunks({
    {
      name = "fod-fulgoran-spaceship-corpse-chunk",
      position = position,
      movement = {  -- Need to regenerate a speed to avoid falling south too fast from the spitter stats
      (math.random() - 0.5) * 4/60,
      (math.random() - 0.5) * 4/60 + platform.speed/60
      }
  },
  { -- 2x scrap please
      name = "fod-fulgoran-spaceship-corpse-chunk",
      position = position,
      movement = {  -- Need to regenerate a speed to avoid falling south too fast from the spitter stats
      (math.random() - 0.5) * 4/60,
      (math.random() - 0.5) * 4/60 + platform.speed/60
      }
  }
  })
end
end)

script.on_event(defines.events.on_rocket_launched, function(event) -- Keep the fulgoran escape pod ready to go at all times
    local silo = event.rocket_silo
    if silo and silo.name == "fod-cargo-pod-launcher" then
        silo.rocket_parts = 1 -- I'd make this zero if I could.  
    end
end)

 script.on_event(defines.events.on_research_finished, function(event)
     if event.research.name == "fod-fulgoran-space-manufactory-discovery" then -- I'll admit this feel's like doing it twice, but at least this way I can be sure you don't see it in the planet list until the research is done
		local surface = game.surfaces["fulgoran-space-manufactory"]
		if surface then event.research.force.set_surface_hidden(surface, false)
        end
	end
end)

script.on_nth_tick(60, function(event)
    local target_surface = game.get_surface("fulgoran-space-manufactory")
    if not target_surface then return end -- Check only running for new location
    for _, player in pairs(game.connected_players) do
        local tech_name = "fod-fulgoran-spaceship-capsule-research"
        local tech = player.force.technologies[tech_name]
        if tech and not tech.researched then
            if player.surface.name == target_surface.name then -- check if player needs tech, and they are on the surface
                -- Stand next to the middle of the platform, and there is only 1 of these
                local hub = player.surface.find_entities_filtered{
                    name = "fod-tech-hub",
                    position = player.position,
                    radius = 6 -- Close enough to the red marker
                }[1]

                if hub then
                    local p_idx = player.index
                    storage.proximity_timers[p_idx] = (storage.proximity_timers[p_idx] or 0) + 1

                    -- Cute little progress bar
                    if storage.proximity_timers[p_idx] % 5 == 0 then
                        player.create_local_flying_text{
                            text = "Researching hub data: " .. math.floor((storage.proximity_timers[p_idx] / 30) * 100) .. "%",
                            position = hub.position,
                            color = {r = 0.5, g = 0.8, b = 1}
                        }
                    end

                    -- 30s to unlock
                    if storage.proximity_timers[p_idx] >= 30 then
                        tech.enabled = true
                        player.force.script_trigger_research(tech_name)
						hub.destructable =  true -- you can destroy it after completing the research.  Good luck to any other forces that want to research it
                        -- No need to count when researched
                        storage.proximity_timers[p_idx] = nil
                    end
                else
                    -- Reset progress if they leave the hub area
                    storage.proximity_timers[player.index] = 0
                end
            end
        end
    end
end)

-- Set the spawn position for a surface.  Should not be needed with spawn defined
-- script.on_event(defines.events.on_player_changed_surface, function(event)
    -- local player = game.get_player(event.player_index)
    -- if player.surface.name == "fod-fulgoran-space-manufactory" then
        -- player.teleport({x = 200, y = 100}, player.surface)
    -- end
-- end)