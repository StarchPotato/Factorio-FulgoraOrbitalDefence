--Fulgoran robots that are unlocked by the player.  Comes out of capsules
--Spawned by hibernation pod destruction
local fulgoranspaceship_clone = table.deepcopy(data.raw["unit"]["fod-fulgoran-spaceship"]) -- Giving the player of making combat versions of these units
local fulgoranspaceship_bot = table.deepcopy(data.raw["combat-robot"]["destroyer"]) -- Good for 90% of config
fulgoranspaceship_bot.name = "fod-fulgoran-spaceship-robot"
fulgoranspaceship_bot.icons = {
  {
    icon = "__fulgora-orbital-defence__/graphics/icons/fulgoran-spaceship-icon.png",
    icon_size = 64
  }
}
fulgoranspaceship_bot.idle = fulgoranspaceship_clone.run_animation
fulgoranspaceship_bot.in_motion = fulgoranspaceship_clone.run_animation


-- Weapon stats
fulgoranspaceship_bot.attack_parameters = { -- taken from data.raw for combat bots and rocket turrets
    type = "projectile",
    ammo_category = "rocket", -- Associates it with rocket tech/bonuses
    cooldown = 30,            -- Much slower than a defender (1 shot per second)
    range = 25,
    min_range = 3,            -- Prevents the robot from blowing itself up
    ammo_type = {
        target_type = "entity",
        action = {
            type = "direct",
            action_delivery = {
                type = "projectile",
                projectile = "rocket", -- Uses the vanilla rocket entity
                starting_speed = 0.1,
				damage_modifier = 0.25, -- You get free rockets, so set it to 25% damage for "balance".  This is different to vanilla capsules which don't scale
                source_effects = {
                    {
                        type = "create-entity",
                        entity_name = "explosion-gunshot" -- Small visual cue when firing
                    }
                },
				source_offset = {0,0}
            }
        }
    }
}

-- Unit stats
fulgoranspaceship_bot.max_health = 200
fulgoranspaceship_bot.alert_when_damaged = true
fulgoranspaceship_bot.time_to_live = 9000 -- 2.5min, roughly extrapolating the 45s, 90s, 2min pattern from earlier combat bots
fulgoranspaceship_bot.speed = 0.01
fulgoranspaceship_bot.range_from_player = 6
fulgoranspaceship_bot.resistances = {
        {type = "fire", percent = 95},
        {type = "acid", percent = 80,decrease = 0}
      }
fulgoranspaceship_bot.friction = 0.01
data:extend({fulgoranspaceship_bot})

-- Craftable capsule holding the robot
local fulgoranspaceship_capsule = table.deepcopy(data.raw["capsule"]["defender-capsule"])
fulgoranspaceship_capsule.name = "fod-fulgoran-spaceship-capsule"
fulgoranspaceship_capsule.icons = {
    {
        icon = "__fulgora-orbital-defence__/graphics/icons/fulgoran-hibernation-capsule-icon.png",
        icon_size = 64
    }
}
fulgoranspaceship_capsule.capsule_action.attack_parameters.ammo_type.action[1].action_delivery.projectile = "fod-fulgoran-spaceship-capsule-projectile" -- Capsule make bots
data:extend({fulgoranspaceship_capsule})

-- Define the Projectile between throwing the capsule, and spawning the bot
local fulgoranspaceship_projectile = table.deepcopy(data.raw["projectile"]["defender-capsule"])
fulgoranspaceship_projectile.name = "fod-fulgoran-spaceship-capsule-projectile"

fulgoranspaceship_projectile.action = {
    type = "direct",
    action_delivery = {
        type = "instant",
        target_effects = {
            {
                type = "create-entity",
                entity_name = "fod-fulgoran-spaceship-robot",
                show_in_tooltip = true,
                offsets = {{0, 0}}
            },
        }
    }
}

data:extend({fulgoranspaceship_projectile})