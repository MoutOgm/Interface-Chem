---@unit :
--[[
    g = gramme
    gmol1 = g . mol -1
    molL1 = mol . L -1
    L = litre
    mol = mol
    mmol = masse molaire M
    int = pas d'unite

]]
---@table :
--[[
    tableSI = [string] = int
    tableS = {string, string, string}
]]
---@var :
--[[

]]

--input truc de base juste voir liste mol etc
--select apres avoir cliquer sur une textzone avec une mole
---@scene :
--[[
    scene 1 : input select
    scene 2 : index textzone
    scene 3 : index button / textzone ?
]]
--@algo :
--[[
    15  Be  16  C   5   H   2  H    5
    Be 16 C 5 H 2 H 5
    12 34 5 6 7 8 9 0
    while
        i = 1
        s:sub(i, i) >= 0, <= 9
        k += s:sub(i, i)
        i++

        k = Be
        16 C 5 H 2 H 5
        i = 1
        tonumber(s:sub(1, i)) ~= nil
        atom["Be"] = s:sub(1, i)



]]

--[[
local s = "Be455H5H1"
local h = s
local i = 1
local at = {}
while i <= h:len() do
    local k = i
    if (not (h:sub(k, k) >= '0' and h:sub(k, k) <= '9')) then
        if (not (h:sub(k + 1, k + 1) >= '0' and h:sub(k + 1, k + 1) <= '9')) then
            k = k + 1
        end
        if at[h:sub(i, k)] == nil then
            at[h:sub(i, k)] = { h:sub(i, k), 0}
        end
    else
        local j = k
        local string = ''
        if h:sub(j-2, j-2) >= '0' and h:sub(j-2, j-2) <= '9' then
            string = h:sub(j-1, j-1)
        else
            string = h:sub(j-2, j-1)
        end
        print(string)
        while (tonumber(h:sub(i, j)) ~= nil) do
            j = j +1
            if j >= h:len() then j = j + 1 break end
        end
        k = j - 1
        at[string][2] = at[string][2] + tonumber(h:sub(i, k))
    end
    i = k
    i = i + 1
end
for k, v in pairs(at) do
    print(k..'  '..v[2])
end
]]
--[[
    get reaction lu
    n
    for i, #mol
    mol.donne.type.react.t = n
    t[#t+1] = n

    return t
]]