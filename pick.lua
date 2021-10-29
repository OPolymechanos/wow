--=== Wownero Pick ===

minetest.register_tool('wow:pick',{
     description = 'WOW pick',
     inventory_image = 'wow_pick.png',
     tool_capabilities = {
         full_punch_interval = 0.9,
         max_drop_level=3,
         groupcaps={
            cracky = {times={[1]=1.0, [2]=0.5, [3]=0.2}, uses=60, maxlevels=3
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
   local wow_chance = math.random(1,300) --Increase the second number to decrease the chance.
   if wow_chance == 69 then
      minetest.add_item(pos, {name="wow:coin", count=3, wear=0, metadata=""})
      --[[
      The drop count is currently set at 3, making the payout approximately 200% of 
      the cost-investment in producing the wow pick when the wow_chance is set to (1,300).
      One payout costs approximately 1.65 coins in pick materials. At a payout of 3 coins,
      the player will double their holdings every 300 blocks.

      This is probably unbalanced. Depending on how many players are mining wow coins,
      this rate may lead to wild inflation on a server. It may be better to increase
      the wow_chance to (1, 1000), (increasing the cost-per-payout to approx. 5.5 coins)
      and increasing the drop count from 3 to 8. 

      ]]--
      minetest.sound_play("wow_coins", pos)
   end
   if WOW_ENTROPY == false then
     return old_handle_node_drops(pos, drops, digger)
   end
end
