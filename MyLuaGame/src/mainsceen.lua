require "src/mainlayer"
require "src/eluosi"
require "src/xiaoshuo"
mainsceen = {}
local create = function()
	local sceneGame = cc.Scene:create()
	sceneGame:addChild(mainlayer:create())
	return sceneGame
end

mainsceen.create = create
local eluosi = function()
    local sceneGame = cc.Scene:create()
    sceneGame:addChild(eluosi:create())
    return sceneGame
end
mainsceen.eluosi = eluosi
local xiaoshuo = function()
    local sceneGame = cc.Scene:create()
    sceneGame:addChild(xiaoshuo:create())
    return sceneGame
end
mainsceen.xiaoshuo = xiaoshuo