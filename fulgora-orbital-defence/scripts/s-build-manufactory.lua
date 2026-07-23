local build = {}
local map_data_string = require("maps.fulgoran-space-manufactory")

function build.build_manufactory()
	local planet = game.planets["fulgoran-space-manufactory"]
	if game.surfaces["fulgoran-space-manufactory"] then return end
	
	-- 1. Surface setup logic
	local settings = {
		terrain_segmentation = "none",
		water = "none",
		autoplace_controls = {},
		cliff_settings = {cliff_elevation_0 = 0, name = "none"},
		default_enable_all_autoplace_controls = false,
		autoplace_settings = {
			["tile"] = { settings = { ["empty-space"] = {} } }
		},
	}

	local new_surface = planet:create_surface("fulgoran-space-manufactory", settings) -- Brand new surface to be created.
	new_surface.daytime = 0.0
	new_surface.freeze_daytime = true 
	new_surface.wind_speed = 0
	new_surface.show_clouds = false
	new_surface.create_global_electric_network()
	
	-- 2. Pre-import map generation, otherwise the tiles turn to void.  Use the enemy force to avoid the player charting it
	new_surface.request_to_generate_chunks({x = 150, y = 100}, 6) -- About the midpoint of the build
	new_surface.force_generate_chunk_requests()
	-- game.forces["fulgoran-spaceship-force"].chart(new_surface, {{-15, -15}, {300, 200}}) -- Use the force to chart, so the player doesn't get advanced notice of it

	local map_data = helpers.json_to_table(map_data_string) -- BIIIG lag spike, so its done on load now to avoid it
	if not map_data then return end

	-- 3. Initialize lookup table for wires and other post import config
	local spawned_entities = {} 

	-- 4. Import Tiles
	if map_data.tiles and #map_data.tiles > 0 then
		-- Pre-calculate the bounds to ensure chunks are mapped
		new_surface.set_tiles(map_data.tiles, true)
		pcall(function()
			new_surface.set_tiles(map_data.tiles, false) -- pls
		end)
	end

	-- 5. PASS 1: Create Entities & Fill Inventories
	local target_force = game.forces["fulgoran-spaceship-force"]
	if map_data.entities then
		for _, entity_config in pairs(map_data.entities) do
			local creation_params = { -- common data set used for each entity.  Using pcall() a bunch just to power through errors should they arise
				name = entity_config.name,
				position = entity_config.position,
				direction = entity_config.direction or 0, -- For the belts
				force = entity_config.force, -- So the escape pod is player
				recipe = entity_config.recipe, -- For the assemblers
				time_to_live = entity_config.time_to_live, -- Everything should live forever
				graphics_variation = entity_config.graphics_variation, -- For the fulgora shattered pods
				type = entity_config.type
			}
			
			local e = new_surface.create_entity(creation_params)
			if e and e.valid then
				if entity_config.index then
					spawned_entities[entity_config.index] = e
				end
				if e.type == "splitter" then -- Because they had to be special along with underground belts
					if entity_config.input_priority then e.splitter_input_priority = entity_config.input_priority end
					if entity_config.output_priority then e.splitter_output_priority = entity_config.output_priority end
				end

				-- Inventory Injection
				if entity_config.contents then -- Gun turrets mainly
					for inv_index, items in pairs(entity_config.contents) do
						local index = tonumber(inv_index) or inv_index  --Safely safely
						local inventory = e.get_inventory(index)
						if inventory then
							for _, item_stack in pairs(items) do
								if item_stack.name then
									pcall(function()
										inventory.insert({
											name = item_stack.name,
											count = item_stack.count or 1,
											quality = item_stack.quality or "normal"
										})
									end)
								end
							end
						end
					end
				end
				if entity_config.graphics_variation then -- Needed for fulgoran pods to look like I want.
					pcall(function()  -- If there are no variants, pcall() can power through
						e.graphics_variation = entity_config.graphics_variation 
					end)
				end
			end
			-- Inventory Injection (infinity special)
			if e and e.valid and entity_config.infinity_filters then
				for _, filter_data in pairs(entity_config.infinity_filters) do
					pcall(function()
						e.set_infinity_container_filter(filter_data.index, {
							name = filter_data.name,
							count = filter_data.count,
							mode = filter_data.mode or "at-least",
							quality = filter_data.quality or "normal"
						})
					end)
				end
				
				-- Inventory filter (infinity special AGAIN)
				if entity_config.name == "infinity-chest" then
					e.infinity_container_logic = {
						remove_unfiltered_items = true
					}
				end
			end
		end
	end

	-- 6. PASS 2: Connect wires. Can only happen pairwise after the previous pass
	if map_data.entities then
		for _, entity_config in pairs(map_data.entities) do
			if entity_config.wires then
				local source_entity = spawned_entities[entity_config.index]
				for _, wire_definition in pairs(entity_config.wires) do -- Tuple of source_index, red/green wire, target_index, red/green wire
					local target_entity = spawned_entities[wire_definition[3]] -- target_index
					
					if source_entity and target_entity and source_entity.valid and target_entity.valid then
						local source_conn = source_entity.get_wire_connector(wire_definition[2], true) -- wire colour
						local target_conn = target_entity.get_wire_connector(wire_definition[4], true) -- wire colour
						
						if source_conn and target_conn then -- If its the same colour, then they connect
							source_conn.connect_to(target_conn)
						end
					end
				end
			end
		end
	end
	-- 7. Mark the central tech hub and escape pods as immortal/unmineable/etc.  Also no changing of the silo recipe
	for _, entity in pairs(spawned_entities) do
		if entity.valid then
			if entity.name == "fod-tech-hub" or entity.name == "fod-cargo-pod-launcher" then
				entity.destructible = false   -- Cannot be destroyed
				entity.minable_flag = false   -- Cannot be mined
				entity.rotatable = false      -- Cannot be rotated with 'R'
			end
		end
	end
	game.forces["player"].set_surface_hidden(new_surface,true) -- Gotta research to see it
	game.forces["player"].set_spawn_position({260,150}, new_surface) -- Spawn on the icy rock in the corner
end

return build