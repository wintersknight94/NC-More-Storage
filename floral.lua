-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local bark = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"

local wick = "nc_tree_bud_top.png^(" .. bark .. ")"

minetest.register_node(modname .. ":shelf_floral", {
		description = "Floral Basket",
--		tiles = {bark, wick},
		tiles = {wick, wick, bark},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 3,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			basketable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_terrain_swishy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_floral" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble floral basket",
		action = "stackapply",
		indexkeys = {"nc_woodwork:form"},
		wield = {name = "nc_tree:peat"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_woodwork:form", empty = true},
				replace = modname .. ":shelf_floral"
			},
		}
	})
