-- Make the ships spawn on all routes near Fulgora, even regenerated ones from RSC
local max_probability = 0.005
local mid_distance = 0.9
local start_spawn = 2000 -- 2000km from Fulgora, start spawning capsules
local fulgora = data.raw["planet"]["fulgora"]
if fulgora then
  fulgora.asteroid_spawn_influence = 0 -- This is only to get the planet spawning in place.  Route is already fully defined
  table.insert(fulgora.asteroid_spawn_definitions, {
  asteroid = "fod-fulgoran-hibernation-capsule",
  angle_when_stopped = 1, probability = max_probability,  speed = 0.01
})
end
if data.raw["planet"]["fulgoran-space-manufactory"] then
  fulgora.asteroid_spawn_influence = 0 -- This is only to get the planet spawning in place.  Route is already fully defined
  table.insert(data.raw["planet"]["fulgoran-space-manufactory"].asteroid_spawn_definitions, {
  asteroid = "fod-fulgoran-hibernation-capsule",
  angle_when_stopped = 1, probability = max_probability*2,  speed = 0.01
})
end

for _, conn in pairs(data.raw["space-connection"]) do
  if conn.asteroid_spawn_definitions ~= nil then -- Don't modify routes that don't have any asteroids on it
    if conn.to == "fulgora" and conn.asteroid_spawn_definitions ~= nil then
      -- if conn.length > start_spawn then mid_distance = (conn.length - start_spawn) / conn.length end
        table.insert(conn.asteroid_spawn_definitions, {
        asteroid = "fod-fulgoran-hibernation-capsule",
        spawn_points = {
          { angle_when_stopped = 1, distance= 0.01,         probability = 0,                speed = 0.01},
          { angle_when_stopped = 1, distance= mid_distance, probability = 0,                speed = 0.01}, -- Spawn within start_spawn unless if its too close (e.g. moons)
          { angle_when_stopped = 1, distance= 1,            probability = max_probability,  speed = 0.01},
        },
      })
    end
    if conn.from == "fulgora" and conn.asteroid_spawn_definitions ~= nil then -- reverse route, with reverse distances to mirror spawning
      -- if conn.length > start_spawn then mid_distance = (start_spawn) / conn.length end
      table.insert(conn.asteroid_spawn_definitions, {
        asteroid = "fod-fulgoran-hibernation-capsule",
	    spawn_points = {
          { angle_when_stopped = 1, distance= 0.01,         probability = max_probability,  speed = 0.01},
          { angle_when_stopped = 1, distance= mid_distance, probability = 0,                speed = 0.01}, -- Spawn within start_spawn unless if its too close (e.g. moons)
	      { angle_when_stopped = 1, distance= 1,            probability = 0,                speed = 0.01},
        },
      })
    end
    if conn.to == "fulgoran-space-manufactory" then
	  table.insert(conn.asteroid_spawn_definitions, {
        asteroid = "fod-fulgoran-hibernation-capsule",
        spawn_points = {
          { angle_when_stopped = 1, distance= 0.01,         probability = 0,                speed = 0.01},
          { angle_when_stopped = 1, distance= mid_distance, probability = 0,                speed = 0.01}, -- Spawn within start_spawn unless if its too close (e.g. moons)
          { angle_when_stopped = 1, distance= 1,            probability = max_probability,  speed = 0.01},
        },
	  })
	end
  end
end

local loc = data.raw["space-location"]["fulgoran-space-manufactory"]
if loc then
    loc.gravity_well = true              -- Enables the "Drop" button
    loc.surface_condition = "fulgoran-space-manufactory" -- Maps orbit to ground
    loc.park_tank = "hub"                -- Targets a Hub for landing pods
end