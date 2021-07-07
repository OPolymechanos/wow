-- === Wownero Ore Generation === 

minetest.register_ore({
     ore_type = "scatter",
     ore = "wow:block",
     wherein = "default:stone",
     clust_scarcity = 36*36*36,
     clust_num_ores = 1,
     clust_size  = 1,
     y_min = -31000,
     y_max = -1024,
 })

minetest.register_ore({
     ore_type = "scatter",
     ore = "wow:block",
     wherein = "default:stone",
     clust_scarcity = 17*17*17,
     clust_num_ores = 1,
     clust_size  = 1,
     y_min = -31000,
     y_max = -4096,
 })


