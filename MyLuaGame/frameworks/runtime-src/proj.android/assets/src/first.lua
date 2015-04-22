require "src/head"
require "src/mainsceen"
require "src/checkbox1"
function addscene(node, order)
    local scene = cc.Director:getInstance():getRunningScene()
    if scene then
        scene:addChild(node, order)
    end
end
function createmsghandleemptystruct(handlefun)
    local o = {}
    o.onNetEvent = handlefun
    return o
end

function tablecellpositioncreate(x, y, w, h)
    x = x or 0
    y = y or 0
    w = w or game_width
    h = h or game_height
    local tablecellposition = {}
    local getposition = function(x1, y1, w1, h1, anchorpoint)
        anchorpoint = anchorpoint or cc.p(0, 0.5)
        local a = x1 - x
        local b = h - (y1 - y) - h1
        a = a + anchorpoint.x * w1
        b = b + anchorpoint.y * h1
        return cc.p(a, b)
    end
    local setposition = function(node, x1, y1, w1, h1, anchorpoint)
        if node then
            if anchorpoint then
                node:setAnchorPoint(anchorpoint)
            end
            w1 = w1 or node:getContentSize().width
            h1 = h1 or node:getContentSize().height
            local pos = getposition(x1, y1, w1, h1, node:getAnchorPoint())
            node:setPosition(pos)
        end
        return node
    end
    tablecellposition.get = getposition
    tablecellposition.set = setposition
    return tablecellposition
end
fullscreenposition = tablecellpositioncreate()

local function createfirstlayer()
	local layer = cc.LayerColor:create(cc.c4b(255,0,0,255),game_width,game_height)
	layer:setAnchorPoint(cc.p(0, 0))
	layer:setPosition(cc.p(0, 0))
    local a = checkbox1:create(cc.Label:createWithTTF("migong", "res/fonts/Marker Felt.ttf", 30), cc.Label:createWithTTF("migong", "res/fonts/Marker Felt.ttf", 30), function()
		local sceneGame = mainsceen:create()
        if cc.Director:getInstance():getRunningScene() then
			cc.Director:getInstance():replaceScene(sceneGame)
		else
			cc.Director:getInstance():runWithScene(sceneGame)
		end
    end)
    a:setPosition(game_width / 2, 200)
    layer:addChild(a)
    local b = checkbox1:create(cc.Label:createWithTTF("eluosi", "res/fonts/Marker Felt.ttf", 30), cc.Label:createWithTTF("eluosi", "res/fonts/Marker Felt.ttf", 30), function()
		local sceneGame = mainsceen:eluosi()
        if cc.Director:getInstance():getRunningScene() then
			cc.Director:getInstance():replaceScene(sceneGame)
		else
			cc.Director:getInstance():runWithScene(sceneGame)
		end
    end)
    b:setPosition(game_width / 2, 200 + 50)
    layer:addChild(b)
    local c = checkbox1:create(cc.Label:createWithTTF("xiaoshuo", "res/fonts/Marker Felt.ttf", 30), cc.Label:createWithTTF("xiaoshuo", "res/fonts/Marker Felt.ttf", 30), function()
		local sceneGame = mainsceen:xiaoshuo()
        if cc.Director:getInstance():getRunningScene() then
			cc.Director:getInstance():replaceScene(sceneGame)
		else
			cc.Director:getInstance():runWithScene(sceneGame)
		end
    end)
    c:setPosition(game_width / 2, 200 + 100)
    layer:addChild(c)
--	layer:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function(node)
--		local sceneGame = mainsceen:create()
--    if cc.Director:getInstance():getRunningScene() then
--			cc.Director:getInstance():replaceScene(sceneGame)
--		else
--			cc.Director:getInstance():runWithScene(sceneGame)
--		end
--	end)))
    syn.create(function()
        for i = 0, 10, 1 do
            print("ssssssssssssss update", i)
        end
    end, function()
        print("thread end 1")
    end)
    syn.create(function()
        for i = 0, 10, 1 do
            print("fffffffffffff update", i)
        end
    end, function()
        print("thread end 2")
    end)
	return layer
end

return createfirstlayer