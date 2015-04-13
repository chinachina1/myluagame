game_width = 480
game_height = 320

function changescene(node)
    local sceneGame = cc.Scene:create()
    if node then
        sceneGame:addChild(node)
    end
    if cc.Director:getInstance():getRunningScene() then
		cc.Director:getInstance():replaceScene(sceneGame)
	else
		cc.Director:getInstance():runWithScene(sceneGame)
	end
end

function addscene(node)
    local scene = cc.Director:getInstance():getRunningScene()
    if scene then
        scene:addChild(node)
    end
end