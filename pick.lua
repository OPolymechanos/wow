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
 
