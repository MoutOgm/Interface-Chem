local fonc = require('function')
local const = require('const')
local molecule = require('molecule')
local scene = {'select', nil, nil} --* scene input/select, index Mol, index Donnes
local mouse = {x = nil, y = nil} --* pos mouse
local Mol = {} --* liste des molecules
local TextZone = {} --* liste de zone de text pour molecule
local Donnes = {} --* liste de textzone mais specialement pour les donners
local Buttons = {} --* liste des bouttons
local ClistMol = love.graphics.newCanvas(160, 450) --* canvas molecules
local ClistDonne = love.graphics.newCanvas(475, 450) --* canvas Donnes
local C1 = { x = 10, y = 70 } --* pos canvas Mol
local C2 = { x = 170, y = 70 } --* pos canvas Donnes
local Scenter = {} --* liste center text buttons / textzone (doesn't need refresh)
local font = love.graphics.newFont(16) --* load a font
function love.load()
    --* Load TextZone et Buttons
    TextZone[0] = {x = 10, y = 10, w = 500, h = 25, t = '', s1 = '', s2 = ''}
    Buttons[1] = {x = 550, y = 10, w = 25, h = 25, t = "+", s1 = '', s2 = ''}
    Buttons[2] = {x = 550, y = 475, w = 50, h = 25, t = "save", s1 = 'select', s2 = ''}
    Buttons[3] = {x = 550, y = 440, w = 50, h = 25, t = 'supp', s1 = 'select', s2 = ''}
    Buttons[4] = {x = 580, y = 80, w = 25, h = 25, t = '+', s1 = 'select', s2 = ''}
    Buttons[5] = {x = 610, y = 80, w = 25, h = 25, t = '-', s1 = 'select', s2 = ''}
    Buttons[6] = {x = 750, y = 460, w = 40, h = 25, t = 'calcul', s1 = '', s2 = ''}
    --* Load center text doesn't need refresh
    Scenter["1"] = {x = TextZone[0].x + 5, y = TextZone[0].y + (TextZone[0].h - font:getHeight(TextZone[0].t)) / 2}
    Scenter["2"] = {x = Buttons[2].x + (Buttons[2].w - font:getWidth(Buttons[2].t)) / 2 - C2.x, y = Buttons[2].y + (Buttons[2].h - font:getHeight(Buttons[2].t)) / 2 - C2.y}
    Scenter["3"] = {x = Buttons[3].x + (Buttons[3].w - font:getWidth(Buttons[3].t)) / 2 - C2.x, y = Buttons[3].y + (Buttons[3].h - font:getHeight(Buttons[3].t)) / 2 - C2.y}
    Scenter["4"] = {x = Buttons[4].x + (Buttons[4].w - font:getWidth(Buttons[4].t)) / 2 - C2.x, y = Buttons[4].y + (Buttons[4].h - font:getHeight(Buttons[4].t)) / 2 - C2.y}
    Scenter["5"] = {x = Buttons[5].x + (Buttons[5].w - font:getWidth(Buttons[5].t)) / 2 - C2.x, y = Buttons[5].y + (Buttons[5].h - font:getHeight(Buttons[5].t)) / 2 - C2.y}

    --TODO setcanvas
    love.graphics.setCanvas(ClistMol)
        love.graphics.setFont(font)
        love.graphics.setLineWidth(2)
    love.graphics.setCanvas(ClistDonne)
        love.graphics.setFont(font)
        love.graphics.setLineWidth(2)
    love.graphics.setCanvas()

end
function love.update(dt)
    --? get x y mouse
    mouse.x = love.mouse.getX()
    mouse.y = love.mouse.getY()
    --? reset cursor
    love.mouse.setCursor()
    for i = 0, #TextZone do
        if TextZone[i].s1 == '' or TextZone[i].s1 == scene[1] then
            --TODO change cursor si il est sur une textzone qui appartient a la scene
            if mouse.x >= TextZone[i].x and mouse.x <= TextZone[i].x + TextZone[i].w and mouse.y >= TextZone[i].y and mouse.y <= TextZone[i].y + TextZone[i].h then
                love.mouse.setCursor(love.mouse.getSystemCursor("ibeam"))
            end
        end
    end
    for i = 1, #Buttons do
        if Buttons[i].s1 == '' or Buttons[i].s1 == scene[1] then
            --TODO change cursor si il est sur un boutton qui appartient a la scene
            if mouse.x >= Buttons[i].x and mouse.x <= Buttons[i].x + Buttons[i].w and mouse.y >= Buttons[i].y and mouse.y <= Buttons[i].y + Buttons[i].h then
                love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
            end
        end
    end
    if scene[2] ~= nil and scene[1] == 'select' then
        for i = 1, #Donnes[scene[2]] do
            --TODO change cursor si il est sur une textzone qui appartient a la scene
            if mouse.x >= Donnes[scene[2]][i].x and mouse.x <=Donnes[scene[2]][i].x + Donnes[scene[2]][i].w and mouse.y >= Donnes[scene[2]][i].y and mouse.y <= Donnes[scene[2]][i].y + Donnes[scene[2]][i].h then
                love.mouse.setCursor(love.mouse.getSystemCursor("ibeam"))
            end
        end
        love.graphics.setCanvas(ClistDonne)
            love.graphics.clear()

            love.graphics.rectangle("line", 0, 0, 475, 450)
            --! save
            love.graphics.rectangle("line", Buttons[2].x - C2.x, Buttons[2].y - C2.y, Buttons[2].w, Buttons[2].h)
            love.graphics.print(Buttons[2].t, Scenter["2"].x, Scenter["2"].y)
            --! supp
            love.graphics.rectangle("line", Buttons[3].x - C2.x, Buttons[3].y - C2.y, Buttons[3].w, Buttons[3].h)
            love.graphics.print(Buttons[3].t, Scenter["3"].x, Scenter["3"].y)
            --! +
            love.graphics.rectangle("line", Buttons[4].x - C2.x, Buttons[4].y - C2.y, Buttons[4].w, Buttons[4].h)
            love.graphics.print(Buttons[4].t, Scenter["4"].x, Scenter["4"].y)
            --! -
            love.graphics.rectangle("line", Buttons[5].x - C2.x, Buttons[5].y - C2.y, Buttons[5].w, Buttons[5].h)
            love.graphics.print(Buttons[5].t, Scenter["5"].x, Scenter["5"].y)

            for i = 1, #Donnes[scene[2]] do
                local x, y
                --[[
                    * set Donnes y with diff y
                    * x = text pos x
                    * y = text pos y
                ]]
                x = Donnes[scene[2]][i].x
                Donnes[scene[2]][i].y = 80 + (30 + 5) * (i - 1) + Donnes[scene[2]][i].dy
                love.graphics.rectangle("line", x - C2.x, Donnes[scene[2]][i].y  - C2.y, Donnes[scene[2]][i].w, Donnes[scene[2]][i].h)
                x = Donnes[scene[2]][i].x + 5
                y = Donnes[scene[2]][i].y + (Donnes[scene[2]][i].h - font:getHeight(Donnes[scene[2]][i].t)) / 2
                love.graphics.print(Donnes[scene[2]][i].t, x - C2.x, y - C2.y)
            end

        love.graphics.setCanvas()
    end
    love.graphics.setCanvas(ClistMol)
        love.graphics.clear()
        for i in ipairs(TextZone) do
            if i > 0 then
                --[[
                    * set TextZone y with diff y
                    * x = text pos x
                    * y = text pos y
                ]]
                local x, y
                x = TextZone[i].x
                TextZone[i].y = 70 + (30 + 5)* (i - 1) + TextZone[i].dy
                love.graphics.rectangle("line", x - C1.x, TextZone[i].y - C1.y, TextZone[i].w, TextZone[i].h)
                x = TextZone[i].x + 5 - C1.x
                y = TextZone[i].y + (TextZone[i].h - font:getHeight(TextZone[i].t)) / 2 - C1.y
                love.graphics.print(Mol[TextZone[i].s2].brut, x, y)
            end
        end

    love.graphics.setCanvas()
end
function love.draw()
    love.graphics.setBackgroundColor(0.2, 0.3, 0.3)
    love.graphics.setFont(font)
    --TODO Draw TextZone 0
    love.graphics.rectangle("line", TextZone[0].x, TextZone[0].y, TextZone[0].w, TextZone[0].h)
    if TextZone[0].t ~= ''then
        --TODO Draw TextZone 0 Text
        love.graphics.print(TextZone[0].t, Scenter["1"].x, Scenter["1"].y)
    end

    love.graphics.rectangle("line", Buttons[1].x, Buttons[1].y, Buttons[1].w, Buttons[1].h)
    if Buttons[1].t ~= '' then
        --TODO Draw Buttons 1 Text
        local x, y
        x = Buttons[1].x + (Buttons[1].w - font:getWidth(Buttons[1].t)) / 2
        y = Buttons[1].y + (Buttons[1].h - font:getHeight(Buttons[1].t)) / 2
        love.graphics.print(Buttons[1].t, x, y)
    end

    love.graphics.rectangle("line", Buttons[6].x, Buttons[6].y, Buttons[6].w, Buttons[6].h)
    if Buttons[6].t ~= '' then
        --TODO Draw Buttons 1 Text
        local x, y
        x = Buttons[6].x + (Buttons[6].w - font:getWidth(Buttons[6].t)) / 2
        y = Buttons[6].y + (Buttons[6].h - font:getHeight(Buttons[6].t)) / 2
        love.graphics.print(Buttons[6].t, x, y)
    end
    --TODO Draw canvas Mol
    love.graphics.draw(ClistMol, C1.x, C1.y)
    if scene[1] == 'select' then
        --TODO Draw Canvas Donne
        love.graphics.draw(ClistDonne, C2.x, C2.y)
    end
    if scene[2] ~= nil and scene[3] == nil then
        --TODO Draw TextZone Text or Mol Text
        local t
        if TextZone[scene[2]].t ~= nil then
            t = TextZone[scene[2]].t
        else
            t = Mol[scene[2]].brut
        end
        --TODO add "|" after text to watch cursor
        love.graphics.print("|", TextZone[scene[2]].x + font:getWidth(t) + 5, TextZone[scene[2]].y + (TextZone[scene[2]].h - font:getHeight(t)) / 2)
    elseif scene[2] ~= nil and scene[3] ~= nil then
        local t = Donnes[scene[2]][scene[3]].t
        --TODO add "|" after text to watch cursor
        love.graphics.print("|", Donnes[scene[2]][scene[3]].x + font:getWidth(t) + 5, Donnes[scene[2]][scene[3]].y + (Donnes[scene[2]][scene[3]].h - font:getHeight(t)) / 2)
    end
end
function love.mousepressed()
    for i = 0, #TextZone do
        --TODO change textzone select "mol" ou "input mol"
        if mouse.x >= TextZone[i].x and mouse.x <= TextZone[i].x + TextZone[i].w and mouse.y >= TextZone[i].y and mouse.y <= TextZone[i].y + TextZone[i].h then
            scene[2] = i
            scene[3] = nil
            if i ~= 0 then
                scene[1] = 'select'
            else
                scene[1] = 'input'
            end
            break
        end
    end
    if mouse.x >= Buttons[6].x and mouse.x <= Buttons[6].x + Buttons[6].w and mouse.y >= Buttons[6].y and mouse.y <= Buttons[6].y + Buttons[6].h then
        --TODO calcul
    end
    if scene[1] == 'input' then
        --TODO create Mol with Brut
        if mouse.x >= Buttons[1].x and mouse.x <= Buttons[1].x + Buttons[1].w and mouse.y >= Buttons[1].y and mouse.y <= Buttons[1].y + Buttons[1].h then
            if TextZone[0].t ~= '' and scene[2] ~= nil then
                table.insert(Mol, {molecule:new()})
                Mol[#Mol].brut = TextZone[0].t
                Donnes[#Donnes+1] = {}
                --[[
                    * x = pos x textzone
                    * y = pos y textzone
                    * w = width textzone
                    * h = height textzone
                    * t = text / mol.brut pour les mol
                    * s1 = scene1 to click
                    * s2 = nombre de la textzone dnas la liste (pareil pour mol)
                    * dy = diff pos y avec wheel mouse
                ]]
                if #TextZone ~= 0 then
                    local dT = TextZone[#TextZone]
                    TextZone[#TextZone+1] = {x = dT.x, y = dT.y, w = dT.w, h = dT.h, t = nil, s1 = '', s2 = dT.s2 + 1, dy = dT.dy}
                else
                    TextZone[#TextZone+1] = {x = 10, y = 0, w = 150, h = 30, t = nil, s1 = '', s2 = 1, dy = 0}
                end
                --* reset scene and text
                TextZone[0].t = ''
                scene[2] = nil
            end
        end
    elseif scene[1] == 'select' and scene[2] ~= nil then
        --TODO click pour select une molecule dnas la liste
        for i = 1, #Donnes[scene[2]] do
            if mouse.x >= Donnes[scene[2]][i].x and mouse.x <=Donnes[scene[2]][i].x + Donnes[scene[2]][i].w and mouse.y >= Donnes[scene[2]][i].y and mouse.y <= Donnes[scene[2]][i].y + Donnes[scene[2]][i].h then
                scene[3] = i
                break
            end
        end
        if mouse.x >= Buttons[2].x and mouse.x <= Buttons[2].x + Buttons[2].w and mouse.y >= Buttons[2].y and mouse.y <= Buttons[2].y + Buttons[2].h then
            --TODO register donnes
            --enregistrer
            --* reset scene
            scene[3] = nil
            scene[2] = nil
            scene[1] = 'input'
        elseif mouse.x >= Buttons[3].x and mouse.x <= Buttons[3].x + Buttons[3].w and mouse.y >= Buttons[3].y and mouse.y <= Buttons[3].y + Buttons[3].h then
            --TODO supp Mol in list
            --* reiterer les s2 des textzones
            for i = scene[2], #TextZone do
                TextZone[i].s2 = TextZone[i].s2 -1
            end
            --* reiterer les s2 des donnes
            for i = scene[2], #Donnes[scene[2]] do
                Donnes[scene[2]][i].s2 = Donnes[scene[2]][i].s2 -1
            end
            --* remove table
            table.remove(TextZone, scene[2])
            table.remove(Mol, scene[2])
            table.remove(Donnes, scene[2])
            --* reset scene
            scene[1] = 'input'
            scene[2] = nil
            scene[3] = nil
        elseif mouse.x >= Buttons[4].x and mouse.x <= Buttons[4].x + Buttons[4].w and mouse.y >= Buttons[4].y and mouse.y <= Buttons[4].y + Buttons[4].h then
            --TODO add une Donne vide de la Mol
            if #Donnes[scene[2]] ~= 0 then
                --* take les refs du dernier
                local dT = Donnes[scene[2]][#Donnes[scene[2]]]
                Donnes[scene[2]][#Donnes[scene[2]] + 1] = {x = dT.x, y = dT.y, w = dT.w, h = dT.h, t = '', s1 = '', s2 = dT.s2, s3 = dT.s3, dy = dT.dy}
            else
                --* take create first ref
                Donnes[scene[2]][#Donnes[scene[2]] + 1] = {x = 180, y = 0, w = 150, h = 30, t = '', s1 = '', s2 = scene[2], s3 = 1, dy = 0}
            end
        elseif mouse.x >= Buttons[5].x and mouse.x <= Buttons[5].x + Buttons[5].w and mouse.y >= Buttons[5].y and mouse.y <= Buttons[5].y + Buttons[5].h then
            --TODO supp une Donne dnas la liste Donnes de Mol
            if scene[3] ~= nil then
                --* reiterer les s3 de Donnes
                for i = scene[3], #Donnes[scene[2]] do
                    Donnes[scene[2]][i].s3 = Donnes[scene[2]][i].s3 -1
                end
                --typedonne supp de la mol
                --* remove table
                table.remove(Donnes[scene[2]], scene[3])
                --* reset scene
                scene[3] = nil
            end
        end
    end
end
function love.wheelmoved(dx, dy)
    if mouse.x >= C1.x and mouse.x <= C1.x + ClistMol:getWidth() and mouse.y >= C1.y and mouse.y <= C1.y + ClistMol:getHeight() then
        --TODO change diff y de TextZones
        for i = 1, #TextZone do
            TextZone[i].dy = TextZone[i].dy - dy * 3
        end
    elseif mouse.x >= C2.x and mouse.x <= C2.x + ClistDonne:getWidth() and mouse.y >= C2.y and mouse.y <= C2.y + ClistDonne:getHeight() then
        --TODO change diff y de Donnes
        if scene[2] ~= nil then
            for i = 1, #Donnes[scene[2]] do
                Donnes[scene[2]][i].dy = Donnes[scene[2]][i].dy - dy * 3
            end
        end
    end
end
function love.textinput(text)
    if scene[2] ~= nil then
        --TODO add Text in TextZone
        if scene[3] == nil then
            --* if change t Textzone or brut Mol
            if TextZone[scene[2]].t ~= nil then
                TextZone[scene[2]].t = TextZone[scene[2]].t .. text
            else
                Mol[scene[2]].brut = Mol[scene[2]].brut .. text
            end
        else
            --TODO add Text in Donnes
            Donnes[scene[2]][scene[3]].t = Donnes[scene[2]][scene[3]].t .. text
        end
    end
end
function love.keypressed(key)
    if scene[1] == 'input'  and scene[2] ~= nil then
        --TODO supp last char TextZone
        if key == 'backspace' then
            TextZone[scene[2]].t = TextZone[scene[2]].t:sub(1, -2)
        end
    elseif scene[1] == 'select'  and scene[2] ~= nil then
        --TODO supp last char Mol
        if scene[3] == nil then
            if key == 'backspace' then
                Mol[scene[2]].brut = Mol[scene[2]].brut:sub(1, -2)
            end
        else
            --TODO supp last char Donnes
            if key == 'backspace' then
                Donnes[scene[2]][scene[3]].t = Donnes[scene[2]][scene[3]].t:sub(1, -2)
            end
        end
    end
end
