minetest.register_node("wow:donate_sign", {
   drawtype = "mesh",
   mesh = "wow_sign.obj",
   description = "Donate Sign",
   groups = {choppy=3, oddly_breakable_by_hand=2, flammable=3},
   sounds = default.node_sound_wood_defaults(),
   sunlight_propagates = true,
   paramtype = "light",
   paramtype2 = "facedir",
   tiles = {"wow_sign.png"},
   selection_box = {
      type = "fixed",
      fixed = {-.4, -.2, -.1, .4, .4, .1},
      },
   collision_box = {
      type = "fixed",
      fixed = {-.4, -.3, -.1, .4, .4, .1},
      },
   on_construct = function(pos)
      local meta = minetest.get_meta(pos)
      meta:set_string("formspec", "field[text;;${text}]")
      meta:set_string("infotext", "")
   end,
   after_place_node = function(pos, placer)
      local meta = minetest.get_meta(pos)
      meta:set_string("owner",placer:get_player_name())
   end,
   on_receive_fields = function(pos, formname, fields, sender)
      local meta = minetest.get_meta(pos)
      if sender:get_player_name() == meta:get_string("owner") then
         if not fields.text then return end
         meta:set_string("text", fields.text)
         meta:set_string("infotext", fields.text)
      end
   end,
})
