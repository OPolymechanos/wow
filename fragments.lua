if WOW_FRAGMENTS == true then
  minetest.register_craftitem("wow:fragment", {
    description = "coin fragment",
    inventory_image = "wow_fragments.png"
  })

  minetest.register_craft({
    type = 'shapeless',
    output = 'wow:coin',
    recipe = {
      'wow:fragment',
      'wow:fragment',
      'wow:fragment',
      'wow:fragment',
      'wow:fragment',
      'wow:fragment',
      'wow:fragment',
      'wow:fragment',
      'wow:fragment',
    }
  })

  local old_handle_node_drops = minetest.handle_node_drops

  function minetest.handle_node_drops(pos, drops, digger)
    if not digger or digger:get_wielded_item():get_name() ~= 'default:pick_mese' then
      return old_handle_node_drops(pos, drops, digger)
    end

    local wow_frag_chance = math.random(1,300)

    if wow_frag_chance == 2 then
      minetest.add_item(pos, {
        name="wow:fragment", 
        count=1, 
        wear=0, 
        metadata=""
      })
      minetest.sound_play("wow_coins", pos)
    end
    return old_handle_node_drops(pos, drops, digger)
  end

end



