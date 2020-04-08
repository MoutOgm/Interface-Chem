local m = {}
function m.writeL(file, text)
    file:write(text.."\n")
end
function m.write(file, text)
    file:write(text)
end
function m.searchtype(mol, type)
    for i in ipairs(mol.typ) do
        if type == mol.typ[i] then
            return i
        end
    end
    return nil
end
return m