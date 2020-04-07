local m = {}
function m.writeL(file, text)
    file:write(text.."\n")
end
function m.write(file, text)
    file:write(text)
end
function m.getReact(Lmol, num)
    local t = {}
    for k, v in pairs(Lmol) do

    end
end
function m.searchtype(mol, type)
    for i in ipairs(mol.typ) do
        if type == mol.typ[i] then
            return i
        end
    end
    return nil
end
function m.search(mol, type)
    for i = 0, #mol.donnes do
        if type == mol.donnes[i] then
            return i
        end
    end
    return nil
end
return m