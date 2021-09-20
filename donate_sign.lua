local esc = minetest.formspec_escape

local edit_info =
   [[Wownero is a Doge-inspired, CPU-mineable, solo-mining only, privacy-centric memecoin. You can learn more by visiting wownero.org or forum.wownero.com

By placing this sign, and providing a valid wownero subaddress people can tip your work with crypto.

What are you waiting for? Fill out the information and save it already.]]

local view_info =
   [[Wownero is a Doge-inspired, CPU-mineable, solo-mining only, privacy-centric memecoin. You can learn more by visiting wownero.org or forum.wownero.com

If you enjoy this players work you could tip them some wow. The address will be longer than what can display at a given time so you'll have to click and drag to highlight it entirly. Copy with Ctrl+C and open your wow wallet. Paste the address into the Pay To field and fill out the rest of the information.
Pro-tip if you leave this window open you'll be able to use your mouse in other programs. :)]]

local sign_formspec =
   'size[11,8]'..
   'no_prepend[]'..
   'bgcolor[#080808BB;true]'..
   'background[0,0;11,8;wow_formspec_bg.png]'

local function edit_sign(title, address)
   local formspec =
      sign_formspec..
      "field[0.75,1;4.75,1;title;Title of build:;"..esc(title).."]"..
      "field[0.75,2;4.75,1;address;Wownero Address:;"..esc(address).."]"..
      'textarea[5.5,0.75;5,5;;;'..edit_info..']'..
      "button_exit[1,6.5;3.5,1;save;Save]"
   return formspec
end

local function view_sign(title, address, owner)
   local formspec =
      sign_formspec..
      'label[0.5,0.5;Title: '..title..']'..
      'label[5.5,0.5;Creator: '..owner..']'..
      "textarea[0.75,1.25;10,.75;;Wownero Wallet Address:;"..esc(address).."]"..
      'textarea[0.75,2;10,5;;;'..view_info..']'
   return formspec
end


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
      meta:set_string('title', '')
      meta:set_string('infotext', 'Empty Sign')
      meta:set_string('address', '')
   end,
   after_place_node = function(pos, placer)
      local meta = minetest.get_meta(pos)
      meta:set_string("owner",placer:get_player_name())
   end,
   on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
      local name = clicker:get_player_name()
      local meta = minetest.get_meta(pos)
      local owner = meta:get_string('owner')
      local title = meta:get_string('title')
      local address = meta:get_string('address')
      if owner == name then
         meta:set_string('formspec', edit_sign(title, address))
      else
         meta:set_string('formspec', view_sign(title, address, owner))
      end
   end,
   on_receive_fields = function(pos, formname, fields, sender)
      local meta = minetest.get_meta(pos)
      if fields ['save'] then
         meta:set_string('infotext', fields.title)
         meta:set_string('title', fields.title)
         meta:set_string('address', fields.address)
      end
   end,
})
