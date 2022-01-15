-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local bark = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"

local wick = "nc_flora_wicker.png^(" .. bark .. ")"

minetest.register_node(modname .. ":shelf_wicker", {
		description = "Wicker Shelf",
--		tiles = {bark, wick},
		tiles = {bark, wick},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 2,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_sticky"),
		storebox_access = function(pt) return pt.above.y == pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_wicker" then
				return nodecore.stack_get(pos)
			end
		end
	})
	
minetest.register_node(modname .. ":shelf_wicker_basket", {
		description = "Wicker Basket",
--		tiles = {bark, wick},
		tiles = {wick, wick, bark},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 2,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_sticky"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_wicker_basket" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble wicker shelf",
		action = "stackapply",
		indexkeys = {"nc_woodwork:form"},
		wield = {name = "nc_flora:wicker"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_woodwork:form", empty = true},
				replace = modname .. ":shelf_wicker"
			},
		}
	})

nodecore.register_craft({
		label = "assemble wicker basket",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_wicker"},
		wield = {name = "nc_flora:wicker"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_wicker", empty = true},
				replace = modname .. ":shelf_wicker_basket"
			},
		}
	})
