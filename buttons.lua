local m = {}
function m:new(x, y, w, h, text, s1, s2)
    self[#self+1] = {x = x, y = y, w = w, h = h, t = text, s1 = s1, s2 = s2}
end
function m.click(self, i, mouse)
    return(mouse.x >= self[i].x and mouse.x <= self[i].x + self[i].w and mouse.y >= self[i].y and mouse.y <= self[i].y + self[i].h)
end
return m