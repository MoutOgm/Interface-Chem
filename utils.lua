local m = {}
function m.writeL(file, text)
    file:write(text.."\n")
end
function m.write(file, text)
    file:write(text)
end
function m.searchtype(mol, typ)
    for i in pairs(mol.typ) do
        if typ == i then
            return i
        end
    end
    return nil
end
return m