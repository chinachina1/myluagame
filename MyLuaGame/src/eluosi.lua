require "src/normalbtn"
eluosi = {}
local gezi = 10
local downspeed = 0.3
local predelay = downspeed
local dotbox = {
0, 0, 0,
0, 1, 0,
0, 0, 0,
}
local curbox = {
0, 0, 0,
0, 1, 1,
0, 1, 1,
}
local curcolor = cc.c3b(255, 0, 0)
local nextbox = {
0, 0, 0,
0, 1, 1,
0, 1, 1,
}
local nextcolor = cc.c3b(255, 0, 0)
local allboxlist = {
{
0, 0, 0,
0, 1, 1,
0, 1, 1,
color = cc.c3b(255, 0, 0),
},
{
0, 0, 1,
0, 0, 1,
0, 0, 1,
color = cc.c3b(255, 255, 0),
},
{
0, 1, 1,
0, 0, 1,
0, 0, 1,
color = cc.c3b(0, 255, 0),
},
{
0, 0, 0,
0, 1, 0,
1, 1, 1,
color = cc.c3b(0, 255, 255),
},
{
0, 0, 0,
1, 1, 1,
1, 0, 1,
color = cc.c3b(0, 0, 255),
},
}
local coordercharge = {
[1 + (-1) * 3] = 1,
[0 + (-1) * 3] = 2,
[-1 + (-1) * 3] = 3,
[1 + (0) * 3] = 4,
[0 + (0) * 3] = 5,
[-1 + (0) * 3] = 6,
[1 + (1) * 3] = 7,
[0 + (1) * 3] = 8,
[-1 + (1) * 3] = 9,
}
local cfgw
local cfgh
local cfg
local celllist
local function rotation(box)
    local q = box[1]
    local p = box[2]
    box[1] = box[3]
    box[2] = box[6]
    box[3] = box[9]
    box[6] = box[8]
    box[9] = box[7]
    box[8] = box[4]
    box[7] = q
    box[4] = p
end
local function minicell(color)
    color = color or cc.c4b(curcolor.r, curcolor.g, curcolor.b, 255)
    local a = cc.LayerColor:create(color, gezi - 1, gezi - 1)
    local b = cc.Layer:create()
    b:setContentSize(cc.size(gezi, gezi))
    a:setAnchorPoint(cc.p(0, 0))
    a:setPosition(cc.p(0, 0))
    b:addChild(a)
    return b
end
local function minicell1(x, y)
    local a = x
    local b = y
    local cell = minicell()
    cell.getxy = function()
        return a, b
    end
    cell.setxy = function(m, n)
        a = m
        b = n
        cell:setAnchorPoint(cc.p(0, 0))
        cell:setPosition(cc.p((m - 1) * gezi, (n - 1) * gezi))
        --cell:setPosition(cc.p(100, 100))
    end
    cell.setxyslow = function(m, n)
        cell:runAction(cc.MoveBy:create(predelay, cc.p((m - a) * gezi, (n - b) * gezi)))
        a = m
        b = n
    end
    cell.disappear = function(h)
        --print("ppppppppppppppppppppppppppppp", h)
        if b == h then
            cell:removeFromParent()
            return true
        end
        if b > h then
            cell.setxyslow(a, b - 1)
        end
        return false
    end
    cell.setxy(a, b)
    return cell
end
local function check(box, x, y)
    local cfg1 = cfg
    local w = cfgw
    local h = cfgh
    local function getva(b, a)
        if a < 1 then 
            return 1
        end
        if a > w then
            return 1
        end
        if b < 1 then
            return 1
        end
        if b > h then
            return 1
        end
        for k,v in pairs(celllist) do
            local x, y = v.getxy()
            if x == a and y == b then
                return 1
            end
--            if a <= x + 1 and a >= x - 1 then
--                if b <= y + 1 and b >= y - 1 then
--                    local c = v.cfg[coordercharge[x - a + (y - b) * 3]]
--                    if c == 1 then
--                        return 1
--                    end
--                end
--            end
        end
        return cfg1[(b - 1) * w + a]
    end
    local bound = {
    getva(y + 1, x - 1), getva(y + 1, x), getva(y + 1, x + 1),
    getva(y - 0, x - 1), getva(y - 0, x), getva(y - 0, x + 1),
    getva(y - 1, x - 1), getva(y - 1, x), getva(y - 1, x + 1),
    }
--    if y < 2 then
--        return false
--    end
    for k,v in ipairs(bound) do
        if bound[k] + box[k] >= 2 then
            return false
        end
    end
    return true
end
local function checkdisappear()
    local res = {}
    for i = 1, cfgh, 1 do
        local flag = false
        for j = 1, cfgw, 1 do
            if check(dotbox, j, i) then
                flag = true
                break
            end
        end
        if not flag then
            table.insert(res, i)
        end
    end
    return res
end
local function newcellbycurbox(game)
    local function getparam(pa)
        local a = math.floor((pa - 1) / 3)
        local b = pa - a * 3
        return a, b
    end
    local node = cc.Layer:create()
    node:setContentSize(cc.size(gezi * 3, gezi * 3))
    --local node = cc.LayerColor:create(cc.c4b(128,128,193,128),gezi * 3,gezi * 3)
    local a = {}
    for k,v in ipairs(curbox) do
        if v == 1 then
            tt = minicell()
            a[k] = tt
            local pa1, pa2 = getparam(k)
            tt:setAnchorPoint(cc.p(0, 0))
            tt:setPosition(cc.p((pa2 - 1) * gezi, (2 - pa1) * gezi))
            --print("zuobiao:",(pa2 - 1) * gezi, "--",(2 - pa1) * gezi)
            node:addChild(tt)
        end
    end
    --node:setAnchorPoint(cc.p(2 / 3, 2 / 3))
    node:setAnchorPoint(cc.p(0, 0))
    node.cfg = {unpack(curbox)}
    node.getxy = function()
        local posx, posy = node:getPosition()
        local x1 = math.floor(posx / gezi)
        local y1 = math.floor(posy / gezi)
        x1 = x1 + 2
        y1 = y1 + 2
        return x1, y1
    end
    node.setxy = function(x, y)
        x = x - 2
        y = y - 2
        node:setPosition(cc.p(x * gezi, y * gezi))
    end
    node.bian = function()
        local tmp = a
        local function findcell()
            for k,v in pairs(tmp) do
                tmp[k] = nil
                return v
            end
            return nil
        end
        local tmpcfg = {unpack(node.cfg)}
        rotation(node.cfg)
        if not check(node.cfg, node.getxy()) then
            node.cfg = tmpcfg
            return
        end
        a = {}
        for k,v in ipairs(node.cfg) do
            if v == 1 then
                tt = findcell()
                a[k] = tt
                local pa1, pa2 = getparam(k)
                tt:setPosition(cc.p((pa2 - 1) * gezi, (2 - pa1) * gezi))
            end
        end
    end
    node.down = function(flag)
        local x1, y1 = node.getxy()
        if check(node.cfg, x1, y1 - 1) then
            if flag then
                downspeed = 0.05
            end
            node.setxy(x1, y1 - 1)
        else
            downspeed = predelay
            game.newcell()
        end
    end
    node.zuo = function()
        local x1, y1 = node.getxy()
        if check(node.cfg, x1 - 1, y1) then
            node.setxy(x1 - 1, y1)
        end
    end
    node.you = function()
        local x1, y1 = node.getxy()
        if check(node.cfg, x1 + 1, y1) then
            node.setxy(x1 + 1, y1)
        end
    end
    return node
end
local function newcellbynextbox()
    local function getparam(pa)
        local a = math.floor((pa - 1) / 3)
        local b = pa - a * 3
        return a, b
    end
    local node = cc.Layer:create()
    node:setContentSize(cc.size(gezi * 3, gezi * 3))
    --local node = cc.LayerColor:create(cc.c4b(128,128,193,128),gezi * 3,gezi * 3)
    local a = {}
    for k,v in ipairs(nextbox) do
        if v == 1 then
            tt = minicell(cc.c4b(nextcolor.r, nextcolor.g, nextcolor.b, 255))
            a[k] = tt
            local pa1, pa2 = getparam(k)
            tt:setAnchorPoint(cc.p(0, 0))
            tt:setPosition(cc.p((pa2 - 1) * gezi, (2 - pa1) * gezi))
            --print("zuobiao:",(pa2 - 1) * gezi, "--",(2 - pa1) * gezi)
            node:addChild(tt)
        end
    end
    return node
end
local function game()
    local scroe = 0
	local layer = cc.LayerColor:create(cc.c4b(128,71,193,255),200,300)
	layer:setAnchorPoint(cc.p(0.5, 0.5))
	layer:setPosition(cc.p(25 + 10 + 30, -15 - 30))
    layer:setRotation(270)
    local poly = cc.DrawNode:create()
    poly:setAnchorPoint(cc.p(0, 0))
    poly:setPosition(cc.p(0, 0))
    layer:addChild(poly)
    for i = 0, layer:getContentSize().width, gezi do
        poly:drawSegment(cc.p(i,0), cc.p(i,layer:getContentSize().height), 1, cc.c4f(0.5, 0.5, 0.5, 1))
    end
--	layer:setAnchorPoint(cc.p(0, 0))
--	layer:setPosition(cc.p(10, 1))
    cfgw = math.floor(layer:getContentSize().width / gezi)
    cfgh = math.floor(layer:getContentSize().height / gezi)
    cfg = {}
    celllist = {}
    for i = 1, cfgw * cfgh, 1 do
        cfg[i] = 0
    end

    local tt
    local nextcell
    local sclab = cc.Label:createWithTTF("0", "res/fonts/Marker Felt.ttf", 24)
	sclab:setAnchorPoint(cc.p(0.5, 0.5))
	sclab:setPosition(cc.p(25 + 10 + 30 + 200, -15 + 230 + 50))
    layer:addChild(sclab)
    local premovetime = 0
    local totaltime = 0
    local function update(dt)
        totaltime = totaltime + dt
        if totaltime - premovetime >= downspeed and tt then
            tt.down()
            premovetime = totaltime
        end
    end
    layer:scheduleUpdateWithPriorityLua(update,0)

    layer.bian = function()
        tt.bian()
    end
    layer.down = function()
        tt.down(true)
    end
    layer.zuo = function()
        tt.zuo()
    end
    layer.you = function()
        tt.you()
    end
    layer.newcell = function()
        if tt then
            local tta, ttb = tt.getxy()
            local a = {
            {tta - 1, ttb + 1, tt.cfg[1]},
            {tta - 0, ttb + 1, tt.cfg[2]},
            {tta + 1, ttb + 1, tt.cfg[3]},
            {tta - 1, ttb + 0, tt.cfg[4]},
            {tta - 0, ttb + 0, tt.cfg[5]},
            {tta + 1, ttb + 0, tt.cfg[6]},
            {tta - 1, ttb - 1, tt.cfg[7]},
            {tta - 0, ttb - 1, tt.cfg[8]},
            {tta + 1, ttb - 1, tt.cfg[9]},
            }
            for k,v in ipairs(a) do
                if v[3] == 1 then
                    local cell = minicell1(v[1], v[2])
                    layer:addChild(cell, 10)
                    table.insert(celllist, cell)
                end
            end
            --table.insert(celllist, tt)
            tt:removeFromParent()
        end
        curbox = {unpack(nextbox)}
        curcolor = nextcolor
        local tmp = allboxlist[math.random(1, table.getn(allboxlist))]
        nextbox = {unpack(tmp)}
        for i = 1, math.random(0, 3), 1 do
            rotation(nextbox)
        end
        nextcolor = tmp.color
        tt = newcellbycurbox(layer)
        tt:setPosition(cc.p(math.floor(layer:getContentSize().width / 2), layer:getContentSize().height - 30))
        layer:addChild(tt)
        if not check(tt.cfg, tt.getxy()) then
            local first = require "src/first"
            local sceneGame = cc.Scene:create()
            sceneGame:addChild(first())
	        if cc.Director:getInstance():getRunningScene() then
		        cc.Director:getInstance():replaceScene(sceneGame)
	        else
		        cc.Director:getInstance():runWithScene(sceneGame)
	        end
        end
        if nextcell then
            nextcell:removeFromParent()
        end
        nextcell = newcellbynextbox()
	    nextcell:setAnchorPoint(cc.p(0.5, 0.5))
	    nextcell:setPosition(cc.p(25 + 10 + 30 + 200, -15 + 230))
        --nextcell:setRotation(270)
        layer:addChild(nextcell)
        local res = checkdisappear()
        if table.getn(res) > 0 then
            scroe = scroe + table.getn(res) * 100
            if table.getn(res) >= 3 then
                scroe = scroe + 1 * 100
            end
            sclab:setString(tostring(scroe))
            for k = table.getn(res), 1, -1 do
                v = res[k]
                for m, n in pairs(celllist) do
                    if n.disappear(v) then
                        celllist[m] = nil
                    end
                end
            end
        end
    end
    layer.newcell()
    return layer
end

local function create()
    math.randomseed(os.time())
	local layer = cc.LayerColor:create(cc.c4b(62,71,193,255),game_width,game_height)
	layer:setAnchorPoint(cc.p(0, 0))
	layer:setPosition(cc.p(0, 0))

    local gamehandle = game()
    layer:addChild(gamehandle)

--    local tt = cc.Label:createWithTTF("O", "res/fonts/Marker Felt.ttf", 30)
--    tt:setPosition(cc.p(100, 200))
--    layer:addChild(tt, 2)
    local a = cc.Sprite:create("src/gongyong_zuojiantou.png")
    local b = cc.Sprite:create("src/gongyong_zuojiantou.png")
    local shang = checkbox1:create(a, b, function()
        gamehandle.bian()
    end)
    shang:setPosition(cc.p(300 + 40, 150))
    layer:addChild(shang)
    local a = cc.Sprite:create("src/gongyong_zuojiantou.png")
    a:setAnchorPoint(cc.p(0.5, 0.5))
    a:setRotation(180)
    local b = cc.Sprite:create("src/gongyong_zuojiantou.png")
    b:setAnchorPoint(cc.p(0.5, 0.5))
    b:setRotation(180)
    local xia = checkbox1:create(a, b, function()
        gamehandle.down()
    end)
    xia:setPosition(cc.p(400 + 40, 150))
    layer:addChild(xia)
    local a = cc.Sprite:create("src/gongyong_zuojiantou.png")
    a:setAnchorPoint(cc.p(0.5, 0.5))
    a:setRotation(90)
    local b = cc.Sprite:create("src/gongyong_zuojiantou.png")
    b:setAnchorPoint(cc.p(0.5, 0.5))
    b:setRotation(90)
    local you = checkbox1:create(a, b, function()
        gamehandle.you()
    end)
    you:setPosition(cc.p(350 + 40, 220))
    layer:addChild(you)
    local a = cc.Sprite:create("src/gongyong_zuojiantou.png")
    a:setAnchorPoint(cc.p(0.5, 0.5))
    a:setRotation(270)
    local b = cc.Sprite:create("src/gongyong_zuojiantou.png")
    b:setAnchorPoint(cc.p(0.5, 0.5))
    b:setRotation(270)
    local zuo = checkbox1:create(a, b, function()
        gamehandle.zuo()
    end)
    zuo:setPosition(cc.p(350 + 40, 80))
    layer:addChild(zuo)
    return layer
end

eluosi.create = create