local SI = require('stringInfo')
local const = require('const')
local utils = require('utils')
local cal = require('function')
---@type mainClass
local m = {}

---
---

---

---
function m.reaction(reaction)
    local somme = {}
    for i = 1, #reaction do
        somme[i] = {reactifs = {}, produits = {}}
    end
    for i in ipairs(reaction) do
        for k in pairs(reaction[i]) do
            if reaction[i][k]["atom"] then
                for h, v in pairs(reaction[i][k]["atom"]) do
                    if somme[i][k][h] then
                        somme[i][k][h] = somme[i][k][h] + v
                    else
                        somme[i][k][h] = v
                    end
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
function m:getHeader(JsonHeader)
    self.Header = {}
    for k in pairs(JsonHeader) do
        if k ~= "A" then
            self.Header[k] = JsonHeader[k]
        end
    end
end
---
function m.tabAdvance(reaction)
    for k in ipairs(reaction["reactifs"]) do
        if reaction["reactifs"][k].n then
            reaction["reactifs"][k].xmax = cal.xmax(reaction["reactifs"][k].n, reaction["reactifs"][k].nbmol)
        else
            --return "Error"
        end
    end
    local xmaxFinal = 1
    for i = 2, #reaction["reactifs"] do
        if reaction["reactifs"][i].xmax > reaction["reactifs"][xmaxFinal].xmax then
            xmaxFinal = i
        end
    end
    for i in ipairs(reaction["produits"]) do
        reaction["produits"][i].n = cal.calnxmax(reaction["reactifs"][xmaxFinal].xmax, reaction["produits"][i].nbmol)
    end
    return "Work", reaction["reactifs"][xmaxFinal].xmax
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
function m.new(self)
    local t = {}
    ---Name molecule brut
    ---@type brut
    t.brut = nil
    ---'+ , - , ~' int
    ---@type tableSI
    t.positive = nil
    ---nb molecule
    ---@type int
    t.nbmol = nil
    ---masse molaire
    ---@type gmol1
    t.mmol = nil
    ---volume solution
    ---@type L
    t.vol = nil
    ---mol
    ---@type mol
    t.n = nil
    ---concentration
    ---@type molL1
    t.conc = nil
    ---type de la reaction
    ---@type tableS
    t.typ = {}
    ---masse
    ---@type g
    t.masse = nil
    ---ks
    ---@type int
    t.ks = nil
    ---nb atom
    ---@type tableS
    t.atom = {}
    ---nb liaison
    ---@type tableSI
    t.liaison = {double = 0, triple = 0}
    --- molecule existe
    ---@type boolean
    t.exist = nil
    ---
    function t.getMelange(self, m)
        local k = utils.searchtype(self, "melange")
        if k then
            if not m[self.typ["melange"]] then
                m[self.typ["melange"]] = {}
            end
            table.insert(m[self.typ["melange"]], self)
        end
    end
    ---
    function t.getReact(self, r)
        local k = utils.searchtype(self, "reaction")
        if k then
            if not r[self.typ["reaction"]] then
                r[self.typ["reaction"]] = {reactifs = {}, produits = {}}
            end
            local j = utils.searchtype(self, "reactif")
            if j then
                table.insert(r[self.typ["reaction"]].reactifs, self)
            else
                local h = utils.searchtype(self, "produit")
                if h then
                    table.insert(r[self.typ["reaction"]].produits, self)
                end
            end
        end
    end
    ---
    function t.getExist(self)
        local liaisons = 0
        local atoms = 0
        for k, v in pairs(self.atom) do
            local ok = const.isIn(k, const.ATOM)
            if ok == false then return ok end
            atoms = atoms + v
            liaisons = liaisons + const.ATOM[k][3] * v
        end
        atoms = atoms + self.liaison.double + (2 * self.liaison.triple) - 1
        if (math.ceil(liaisons / 2) == atoms) then
            return true
        else
            return false
        end
    end
    ---
    function t.getMasseMol(self)
        self.mmol = 0
        for k, v in pairs(self.atom) do
            self.mmol = self.mmol + (const.ATOM[k][1] * v)
        end
    end
    function t.getAtom(self)
        for k, v in pairs(self.atom) do
            self.atom[k] = 0
        end
        local s = self.brut
        local i = 1
        while i <= s:len() do
            local k = i
            if (not (s:sub(k, k) >= '0' and s:sub(k, k) <= '9')) then
                if (not (s:sub(k + 1, k + 1) >= '0' and s:sub(k + 1, k + 1) <= '9')) then
                    k = k + 1
                end
                if self.atom[s:sub(i, k)] == nil then
                    self.atom[s:sub(i, k)] = 0
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
                    self.atom[string] = self.atom[string] + tonumber(s:sub(i, k))
                end
            end
            i = k + 1
        end
    end
    ---
    function t.getNum(self)
        local s = self.brut
        local haveNum = true
        while SI.isNum(s) do
            s = s:sub(1, -2)
            if s:len() == 0 then
                self.nbmol = 1
                haveNum = false
                break
            end
        end
        if haveNum then
            self.nbmol = tonumber(s)
            self.brut = self.brut:sub(s:len() + 1) --* enlever le nb de mol
        end
    end
    ---
    function t.removeD(self, Donnes, k)
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
    function t.register(self, Donnes)
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
                    local words = {}
                    for word in Donnes[i].t:gmatch("%w+") do table.insert(words, word) end
                    self.positive = {n = tonumber(words[1]), t = tonumber(words[2])}  --a faire
    
                elseif Donnes[i].typeDonne.t == 'liaison2' then
                    self.liaison.double = tonumber(Donnes[i].t)
    
                elseif Donnes[i].typeDonne.t == 'liaison3' then
                    self.liaison.triple = tonumber(Donnes[i].t)
                end
            end
        end
    end

    function t:register_from_json(tablejson, D, s2)
        --create new mol
        --add donnes
        self.brut = tablejson["A"]
        for k in pairs(m.Header) do
            local header = m.Header[k]
            local result = tablejson[k]
    
            if header ~= "Nb Mol" and result ~= nil then --and is in list (conc etc)
                if #D[s2] ~= 0 then
                    --* take les refs du dernier
                    local dT = D[s2][#D[s2]]
                    D[s2][#D[s2] + 1] = {x = dT.x, y = dT.y, w = dT.w, h = dT.h, t = '', s1 = '', s2 = dT.s2, s3 = dT.s3 + 1, dy = dT.dy, typeDonne = {x = 340, y = 0, w = 125, h = 30, t = header}}
                else
                    --* take create first ref
                    D[s2][#D[s2] + 1] = {x = 180, y = 0, w = 150, h = 30, t = '', s1 = '', s2 = s2, s3 = 1, dy = 0, typeDonne = {x = 340, y = 0, w = 125, h = 30, t = header}}
                end
                D[s2][#D[s2]].t = result
            end
            if result ~= nil then
                if header == "Concentration" then
                    self.conc = tonumber(result)
                elseif header == "Masse Mol" then
                    self.mmol = tonumber(result)
                elseif header == "Mol" then
                    self.n = tonumber(result)
                elseif header == "Masse" then
                    self.masse = tonumber(result)
                elseif header == "Nb Mol" then
                    self.nbmol = tonumber(result)
                elseif header == "Volume" then
                    self.vol = tonumber(result)
                elseif header == "Type" then
                    local words = {}
                    for word in result:gmatch("%w+") do table.insert(words, word) end
                    if (words[1] == "reaction" or words[1] == "melange") then
                        self.typ[words[1]] = tonumber(words[2])
                    else
                        self.typ[result] = result
                    end
                elseif header == "ks" then
                    self.ks = tonumber(result)
                elseif header == "Positivite" then
                    local words = {}
                    for word in result:gmatch("%w+") do table.insert(words, word) end
                    self.positive = {n = tonumber(words[1]), t = tonumber(words[2])}
                elseif header == "liaison2" then
                    self.liaison.double = tonumber(result)
                elseif header == "lisaison3" then
                    self.liaison.triple = tonumber(result)
                end
            end
        end
    end
    return t
end
return m