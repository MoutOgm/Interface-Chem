---@type mainClass
local m = {}

---Name molecule brut
---@type brut
m.brut = nil
---'+ , - , ~' int
---@type tableSI
m.positive = nil
---nb molecule
---@type int
m.nbmol = nil
---masse molaire
---@type gmol1
m.mmol = nil
---volume solution
---@type L
m.vol = nil
---mol
---@type mol
m.n = nil
---concentration
---@type molL1
m.conc = nil
---type de la reaction
---@type tableS
m.typ = {}
---masse
---@type g
m.masse = nil
---ks
---@type int
m.ks = nil
---donne + typedonne
---@type tableSD
m.donnes = {number = 0}
---nb atom
---@type tableS
m.atom = nil
---nb liaison
---@type tableSI
m.liaison = nil
function m.register(self, Donnes)
    for i = 1, #Donnes do
        if Donnes[i].typeDonne.t ~= 'null' then
            self.donnes.number = self.donnes.number + 1
            if Donnes[i].typeDonne.t == 'Concentration' then
                self.donnes[#self.donnes+1] = 'Concentration'
                self.conc = tonumber(Donnes[i].t)

            elseif Donnes[i].typeDonne.t == 'Masse Mol' then
                self.donnes[#self.donnes+1] = 'Masse Mol'
                self.mmol = tonumber(Donnes[i].t)

            elseif Donnes[i].typeDonne.t == 'Mol' then
                self.donnes[#self.donnes+1] = 'Mol'
                self.n = tonumber(Donnes[i].t)

            elseif Donnes[i].typeDonne.t == 'Masse' then
                self.donnes[#self.donnes+1] = 'Masse'
                self.masse = tonumber(Donnes[i].t)

            elseif Donnes[i].typeDonne.t == 'Volume' then
                self.donnes[#self.donnes+1] = 'Volume'
                self.vol = tonumber(Donnes[i].t)

            elseif Donnes[i].typeDonne.t == 'Type' then
                self.donnes[#self.donnes+1] = 'Type'
                self.typ[#self.typ+1] = Donnes[i].t -- a bien faire

            elseif Donnes[i].typeDonne.t == 'Ks' then
                self.donnes[#self.donnes+1] = 'Ks'
                self.ks = tonumber(Donnes[i].t)

            elseif Donnes[i].typeDonne.t == 'Positif' then
                self.donnes[#self.donnes+1] = 'Positif'
                self.positive = {n = nil, t = nil} -- a faire
            end
        end
    end
end
function m.new(self)
    return self
end
return m