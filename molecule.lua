local SI = require('stringInfo')
local const = require('const')
local utils = require('utils')
local cal = require('function')
---@type mainClass
local m = {}
---
function m.tabAdvance(reaction)
    for i in ipairs(reaction) do
        for k in pairs(reaction[i]) do
        end
    end
end
---
function m.CV(melange)
    local vtot = {}
    for i in ipairs(melange) do
        vtot[i] = 0
        if melange[i].conc and melange[i].vol then
            vtot[i] = vtot[i] + melange[i].vol
        else
            return "Error"
        end 
    end
    for i in ipairs(melange) do
        melange[i].conc = cal.conccv(melange[i].conc, melange[i].vol, vtot[i])
    end
    return "Work"
end
---
function m.getMelange(mol, m)
    local k = utils.searchtype(mol, "melange")
    if k then
        if not m[mol.typ["melange"]] then
            m[mol.typ["melange"]] = {}
        end
        table.insert(m[mol.typ["melange"]], mol)
    end
end
---
function m.getReact(mol, r)
    local k = utils.searchtype(mol, "reaction")
    local j = utils.searchtype(mol, "reactif")
    if k then
        if not r[mol.typ["reaction"]] then
            r[mol.typ["reaction"]] = {reactifs = {}, produits = {}}
        end
        if j then
            table.insert(r[mol.typ["reaction"]].reactifs, mol)
        else
            j = utils.searchtype(mol, "produit")
            if j then
                table.insert(r[mol.typ["reaction"]].produits, mol)
            end
        end
    end
end
---
function m.reaction(reaction)
    local somme = {}
    for i = 1, #reaction do
        somme[i] = {reactifs = {}, produits = {}}
    end
    for i in ipairs(reaction) do
        for k in pairs(reaction[i]) do
            for h, v in pairs(reaction[i][k]["atom"]) do
                if somme[i][k][h] then
                    somme[i][k][h] = somme[i][k][h] + v
                else
                    somme[i][k][h] = v
                end
            end
        end
    end
    local boolReact = {}
    for i in ipairs(somme) do
        boolReact[i] = true
        for j, v in pairs(somme[i].reactifs) do
            if somme[i].produits[j] then
                if v ~= somme[i].produits[j] then
                    boolReact[i] = false
                end
            else
                boolReact[i] = false
            end
        end
    end
    return boolReact
end
---
function m.exist(mol)
    local liaisons = 0
    local atoms = 0
    for k, v in pairs(mol.atom) do
        atoms = atoms + v
        liaisons = liaisons + const.ATOM[k][3] * v
    end
    atoms = atoms + mol.liaison.double + (2 * mol.liaison.triple) - 1
    if (math.ceil(liaisons / 2) == atoms) then
        return true
    else
        return false
    end
end
---
function m.getMasseMol(mol)
    mol.mmol = 0
    for k, v in pairs(mol.atom) do
        mol.mmol = mol.mmol + (const.ATOM[k][1] * v)
    end
end
---
function m.getAtom(mol)
    for k, v in pairs(mol.atom) do
        mol.atom[k] = 0
    end
    local s = mol.brut
    local i = 1
    while i <= s:len() do
        local k = i
        if (not (s:sub(k, k) >= '0' and s:sub(k, k) <= '9')) then
            if (not (s:sub(k + 1, k + 1) >= '0' and s:sub(k + 1, k + 1) <= '9')) then
                k = k + 1
            end
            if mol.atom[s:sub(i, k)] == nil then
                mol.atom[s:sub(i, k)] = 0
            end
        else
            local j = k
            local string = ''
            if s:sub(j-2, j-2) >= '0' and s:sub(j-2, j-2) <= '9' then
                string = s:sub(j-1, j-1)
            else
                string = s:sub(j-2, j-1)
            end
            while (tonumber(s:sub(i, j)) ~= nil) do
                j = j +1
                if j >= s:len() then j = j + 1 break end
            end
            k = j - 1
            if string ~= '' then
                mol.atom[string] = mol.atom[string] + tonumber(s:sub(i, k))
            end
        end
        i = k + 1
    end
end
---
function m.getNum(mol)
    local s = mol.brut
    local haveNum = true
    while SI.isNum(s) do
        s = s:sub(1, -2)
        if s:len() == 0 then
            mol.nbmol = 1
            haveNum = false
            break
        end
    end
    if haveNum then
        mol.nbmol = tonumber(s)
        mol.brut = mol.brut:sub(s:len() + 1) --* enlever le nb de mol
    end
end
---
function m.removeD(self, Donnes, k)
    if Donnes[k].typeDonne.t ~= 'null' then
        if Donnes[k].typeDonne.t == 'Concentration' then
            self.conc = nil
        elseif Donnes[k].typeDonne.t == 'Masse Mol' then
            self.mmol = nil
        elseif Donnes[k].typeDonne.t == 'Mol' then
            self.mol = nil
        elseif Donnes[k].typeDonne.t == 'Masse' then
            self.masse = nil
        elseif Donnes[k].typeDonne.t == 'Volume' then
            self.vol = nil
        elseif Donnes[k].typeDonne.t == 'Type' then
            local words = {}
            for word in Donnes[k].t:gmatch("%w+") do table.insert(words, word) end
            if (words[1] == "reaction" or words[1] == "melange") then
                self.typ[words[1]] = nil
            else
                self.typ[Donnes[k].t] = nil
            end
        elseif Donnes[k].typeDonne.t == 'Ks' then
            self.ks = nil
        elseif Donnes[k].typeDonne.t == 'Positif' then
            self.positive = nil
        elseif Donnes[k].typeDonne.t == 'liaison2' then
            self.liaison.double = 0
        elseif Donnes[k].typeDonne.t == 'liaison3' then
            self.liaison.double = 0
        end
    end
end
---
function m.register(self, Donnes)
    self.liaison.double = 0
    self.liaison.triple = 0
    for i = 1, #Donnes do
        if Donnes[i].typeDonne.t ~= 'null' then
            if Donnes[i].typeDonne.t == 'Concentration' then
                self.conc = tonumber(Donnes[i].t)

            elseif Donnes[i].typeDonne.t == 'Masse Mol' then
                self.mmol = tonumber(Donnes[i].t)

            elseif Donnes[i].typeDonne.t == 'Mol' then
                self.n = tonumber(Donnes[i].t)

            elseif Donnes[i].typeDonne.t == 'Masse' then
                self.masse = tonumber(Donnes[i].t)

            elseif Donnes[i].typeDonne.t == 'Volume' then
                self.vol = tonumber(Donnes[i].t)

            elseif Donnes[i].typeDonne.t == 'Type' then
                local words = {}
                for word in Donnes[i].t:gmatch("%w+") do table.insert(words, word) end
                if (words[1] == "reaction" or words[1] == "melange") then
                    self.typ[words[1]] = tonumber(words[2])
                else
                    self.typ[Donnes[i].t] = Donnes[i].t
                end
            elseif Donnes[i].typeDonne.t == 'Ks' then
                self.ks = tonumber(Donnes[i].t)

            elseif Donnes[i].typeDonne.t == 'Positif' then
                self.positive = {n = nil, t = nil}  --a faire

            elseif Donnes[i].typeDonne.t == 'liaison2' then
                self.liaison.double = tonumber(Donnes[i].t)

            elseif Donnes[i].typeDonne.t == 'liaison3' then
                self.liaison.triple = tonumber(Donnes[i].t)
            end
        end
    end
end
---
function m.new(self)
    return {
    ---Name molecule brut
    ---@type brut
    brut = nil,
    ---'+ , - , ~' int
    ---@type tableSI
    positive = nil,
    ---nb molecule
    ---@type int
    nbmol = nil,
    ---masse molaire
    ---@type gmol1
    mmol = nil,
    ---volume solution
    ---@type L
    vol = nil,
    ---mol
    ---@type mol
    n = nil,
    ---concentration
    ---@type molL1
    conc = nil,
    ---type de la reaction
    ---@type tableS
    typ = {},
    ---masse
    ---@type g
    masse = nil,
    ---ks
    ---@type int
    ks = nil,
    ---nb atom
    ---@type tableS
    atom = {},
    ---nb liaison
    ---@type tableSI
    liaison = {double = 0, triple = 0},
    --- molecule existe
    ---@type boolean
    exist = nil,
    }
end
return m