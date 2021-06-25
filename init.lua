wow = {}
wow.mod_path = minetest.get_modpath("wow")

dofile(wow.mod_path.."/shop.lua")
dofile(wow.mod_path.."/pick.lua")
dofile(wow.mod_path.."/mg.lua")

-- === Wow Coins ===

minetest.register_craftitem("wow:coin", {
	description = "Wownero Coin",
	inventory_image = "wow.png", 
	groups = {flammable = 1},
	})

minetest.register_craftitem("wow:baked_coin", {
	description = ("Baked Wownero"),
	inventory_image = "wow_baked.png",
	groups = {food_bread = 1},
	on_use = minetest.item_eat(5),
    })

minetest.register_craft({
        type = "cooking",
        cooktime = 15,
        output = "wow:baked_coin",
        recipe = "wow:coin",
        })

-- === Defining Wow burntime ===

minetest.register_craft({
	type = "fuel",
	recipe = "wow:coin",
	burntime = 69, --For comparison, the burntime of coal is 40.
	})
	
-- === Wownero Block ===

minetest.register_node("wow:block", {
        description = ("Wownero Block"),
        tiles = {"default_stone.png^mineral_wow.png"},
        groups = {cracky = 3},
        drop = "wow:coin",
        is_ground_content = true,
        light_source = 5,
})
                                        
-- Set necessary privileges for shop

function wow.has_access(owner, player_name)
	if player_name == owner or owner == "" then
		return true
	end
	local privs = minetest.get_player_privs(player_name)
	return privs.server or privs.protection_bypass
end

