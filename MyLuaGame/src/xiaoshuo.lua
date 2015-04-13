require "src/normalbtn"

local xiaoshuolayer = require "src/xiaoshuolayer"

xiaoshuo = {}

local function loadlocaldata()
    local c = checkbox1:create(cc.Label:createWithTTF("localdata", "res/fonts/Marker Felt.ttf", 30), cc.Label:createWithTTF("localdata", "res/fonts/Marker Felt.ttf", 30), function()
    end)
    return c
end

local function loadurldata()
    local c = checkbox1:create(cc.Label:createWithTTF("loadurl", "res/fonts/Marker Felt.ttf", 30), cc.Label:createWithTTF("loadurl", "res/fonts/Marker Felt.ttf", 30), function()
        addscene(xiaoshuolayer.inputurlpathdlg(), 10)
    end)
    return c
end

local create = function()
	local layer = cc.LayerColor:create(cc.c4b(62,71,193,255),game_width,game_height)
	layer:setAnchorPoint(cc.p(0, 0))
	layer:setPosition(cc.p(0, 0))

    local localdata = loadlocaldata()
    local urldata = loadurldata()
    fullscreenposition.set(localdata, 100, 100)
    fullscreenposition.set(urldata, 100, 150)
    layer:addChild(localdata)
    layer:addChild(urldata)

    return layer
end
xiaoshuo.create = create