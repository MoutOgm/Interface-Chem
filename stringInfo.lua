local m = {}
function m.isNum(string)
    return tonumber(string) == nil
end
function m.charIsNum(string, i)
    return (string:sub(i, i) >= '0' and string:sub(i, i) <= '9')
end
return m