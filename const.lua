---@type mainClass
local m = {}
--[[
    name =>
        mmol
        elec
        liaisons
]]
m.ATOM = {
    --1 carac
	["H"] = { 1, 2.2, 1},
	["C"] = { 12, 2.55, 4},
	["N"] = { 14, 3.04, 3},
	["O"] = { 16, 3.44, 2},
	["K"] = { 39, 0.82, 1},
	["B"] = { 10.8, 2.04, 3},
	["F"] = { 19.9, 3.98, 1},
	--2 carac
	["Li"] = { 6.94, 0.98, 1},
	["Be"] = { 9, 1.57, 2},
	["Na"] = { 23, 0.93, 1},
	["Mg"] = { 24.3, 1.31, 2},
	["Ca"] = { 40, 1, 2},
	["Cr"] = { 52, 1.66, 2},
	["Cl"] = { 35.5, 3.16, 1},
	["Fe"] = { 56, 1.83, 2},
	["Ag"] = { 108, 1.93, 1},
	["Al"] = { 26.9, 1.61, 3},
}
return m