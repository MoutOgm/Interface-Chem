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
m.typ = nil
---masse
---@type g
m.masse = nil
---ks
---@type int
m.ks = nil
---donne + typedonne
---@type tableSD
m.donne = nil
---nb atom
---@type tableS
m.atom = nil
---nb liaison
---@type tableSI
m.liaison = nil
function m.new(self)
    return unpack(self)
end
return m