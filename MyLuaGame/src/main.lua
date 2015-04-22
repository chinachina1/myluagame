require "Cocos2d"
require "Cocos2dConstants"

-- cclog
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    -- initialize director
    local director = cc.Director:getInstance()
    local glview = director:getOpenGLView()
    if nil == glview then
        glview = cc.GLView:createWithRect("HelloLua", cc.rect(0,0,900,640))
        director:setOpenGLView(glview)
    end

    glview:setDesignResolutionSize(480, 320, cc.ResolutionPolicy.SHOW_ALL)

    --turn on display FPS
    director:setDisplayStats(true)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(1.0 / 60)

	cc.FileUtils:getInstance():addSearchResolutionsOrder("src");
	cc.FileUtils:getInstance():addSearchResolutionsOrder("res");
	local schedulerID = 0
    --support debug
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) or 
       (cc.PLATFORM_OS_ANDROID == targetPlatform) or (cc.PLATFORM_OS_WINDOWS == targetPlatform) or
       (cc.PLATFORM_OS_MAC == targetPlatform) then
        cclog("result is ")
		--require('debugger')()
        
    end
    require "hello2"
    cclog("result is " .. myadd(1, 1))

    ---------------

    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()


    -- play background music, preload effect

    -- uncomment below for the BlackBerry version
--    local bgMusicPath = nil 
--    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
--        bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("res/background.caf")
--    else
--        bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("res/background.mp3")
--    end
--    cc.SimpleAudioEngine:getInstance():playMusic(bgMusicPath, true)
--    local effectPath = cc.FileUtils:getInstance():fullPathForFilename("effect1.wav")
--    cc.SimpleAudioEngine:getInstance():preloadEffect(effectPath)
		cc.FileUtils:getInstance():addSearchPath("/mnt/sdcard/a123", true)
		print("set path ok")
		local first = require "src/first"
    -- run
    require "src/syn"
    local function update(dt)
        syn.tick(dt)
    end
    local sceneGame = cc.Scene:create()
    sceneGame:scheduleUpdateWithPriorityLua(update,0)
    g_eventDispatcher = sceneGame:getEventDispatcher()
    sceneGame:addChild(first())
		print("print first path", cc.FileUtils:getInstance():fullPathForFilename("src/first.lua"), first, first())
    --sceneGame:addChild(createLayerFarm())
    --sceneGame:addChild(createLayerMenu())
    print("pppppppppppppp", my, my.FileUnit, my.FileUnit.new)
    do
	local ff = my.FileUnit:create("wm.db")
--    ff:createdir("put")
--    ff:createdir("in")
--    ff:createdir("out")
--    ff:createdir("poll")
--    ff:opendir("in")
--    ff:createfile("123.txt", "1234567890")
--    ff:opendir("in")
--    ff:openfile("123.txt")
--    print("kkkk", ff:getcurfile())
--    local ll = ff:getfilelist()
--    for k,v in pairs(ll) do
--        print(v:gettitle())
--    end
--    ff:opendir("xiaoshuo")
--    ff:opendir("chengdong")
--    local tti
--    local ll = ff:getfilelist()
--    for k,v in pairs(ll) do
--        print(v:gettitle())
--        tti = v:gettitle()
--    end
--    ff:opendir(tti)
--    ff:openfile("bin")
--    print(ff:getcurfile())
--    ff:gotoupdir()
--    local ll = ff:getfilelist()
--    local i = 0
--    for k,v in pairs(ll) do
--        print(v:gettitle())
--        i = i + 1
--        if i > 10 then
--            break
--        end
--    end
    ff:release()
    end
--    do
--    local ff = my.pingpong:new()
--    ff:destroy()
--    end
	if cc.Director:getInstance():getRunningScene() then
		cc.Director:getInstance():replaceScene(sceneGame)
	else
		cc.Director:getInstance():runWithScene(sceneGame)
	end

end


xpcall(main, __G__TRACKBACK__)
