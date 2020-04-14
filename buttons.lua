local m = {}
setmetatable(m, {__index = m})
function m:new(x, y, w, h, text, s1, s2)
    local new = {x = x, y = y, w = w, h = h, t = text, s1 = s1, s2 = s2}
    local meta = getmetatable(self)
    meta.new = nil
    setmetatable(new, meta)
    return new
end
function m.click(self, mouse)
    return(mouse.x >= self.x and mouse.x <= self.x + self.w and mouse.y >= self.y and mouse.y <= self.y + self.h)
end
return m