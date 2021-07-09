--=== Wownero Pick ===

minetest.register_tool('wow:pick',{
     description = 'xmrig',
     inventory_image = 'wow_pick.png',
     tool_capabilities = {
         full_punch_interval = 0.9,
         max_drop_level=3,
         groupcaps={
            cracky = {times={[1]=1.0, [2]=0.5, [3]=0.2}, uses=30, maxlevels=3
             },
         damage_groups = {fleshy=5},
           },
     sound = {breaks = "default_tool_breaks"},
     groups = {pickaxe = 1},
      }
})

minetest.register_craft({
  type = 'shapeless',
  output = 'wow:pick',
  recipe = {
    "group:pickaxe",
    "wow:coin"
     }
})

--random wow drops

local old_handle_node_drops = minetest.handle_node_drops

function minetest.handle_node_drops(pos, drops, digger)
   if not digger or digger:get_wielded_item():get_name() ~= 'wow:pick' then
      return old_handle_node_drops(pos, drops, digger)
   end
   local wow_chance = math.random(1,10) --Increase the second number to decrease the chance.
   if wow_chance == 6 then
      minetest.add_item(pos, 'wow:coin')
   end
end
