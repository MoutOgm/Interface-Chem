local c = require('Color')
---@type mainClass
local m = {}

---@param masse g
---@param mmol gmol1
---@return mol
---calcul n avec g and M
m.calnmasse = function (masse, mmol)
    --TODO print verif
    print(c.blue_fg("FUNCTION").." calnmasse : [masse] = " .. masse .. " [mmol] = " .. mmol)
    --? masse[1] * masse[2] / mmol[1] * mmol[2]
    return masse / mmol
end
---@param conc molL1
---@param vol L
---@return mol
---calcul n avec molL1 and L
m.calnconc = function (conc, vol)
    --TODO print verif
    print("FUNCTION calnconc : [conc] = " .. conc .. " [vol] = " .. vol)
    --? conc[1] * conc[2] * vol[1] * vol[2]
    return conc * vol
end
---@param xmax mol
---@param nbmol int
---@return mol
---calcul n avec xmax and nbmol
m.calnxmax = function (xmax, nbmol)
    --TODO print verif
    print("FUNCTION calnxmax : [xmax] = " .. xmax .. " [nbmol] = " .. nbmol)
    --? xmax[1] * xmax[2] * nbmol
    return xmax * nbmol
end
---@param n mol
---@param vol L
---@return conc
---calcul concentration avec mol and L
m.conc = function (n, vol)
    --TODO print verif
    print("FUNCTION conc : [n] = " .. n .. " [vol] = " .. vol)
    --? n[1] * n[2] * vol[1] * vol[2]
    return n / vol
end
---@param n mol
---@param mmol gmol1
---@return masse
---calcul masse avec mol and M
m.masse = function (n, mmol)
    --TODO print verif
    print("FUNCTION masse : [n] = " .. n .. " [mmol] = " .. mmol)
    --? n[1] * n[2] * mmol[1] * mmol[2]
    return n * mmol
end
---@param n mol
---@param conc molL1
---@return vol
---calcul vol avec mol and molL1
m.volconc = function (n, conc)
    --TODO print verif
    print("FUNCTION volconc : [n] = " .. n .. " [conc] = " .. conc)
    --? n[1] * n[2] / conc[1] * conc[2]
    return n / conc
end
---@param conc molL1
---@param vol L
---@param vtot L
---@return conc
---calcul concentration avec molL1 and L and Ltot
m.conccv = function (conc, vol, vtot)
    --TODO print verif
    print("FUNCTION conccv : [conc] = " .. conc .. " [vol] = " .. vol .. " [vtot] = " .. vtot)
    --? conc[1] * conc[2] * vol[1] * vol[2] / vtot[1] * vtot[2]
    return (conc * vol) / vtot
end
---@param n mol
---@param nbmol int
---@return xmax
---calcul xmax avec mol and nb molecule
m.xmax = function (n, nbmol)
    --TODO print verif
    print("FUNCTION xmax : [n] = " .. n .. " [nbmol] = " .. nbmol)
    --? n[1] * n[2] * nbmol
    return n / nbmol
end
return m