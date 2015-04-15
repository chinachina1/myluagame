require "src/tableviewctrl"
require "src/downmanger"
require "src/xiaoshuoparser"
local xiaoshuo = {}

function downurl(str, callfun)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", str)
    local function downok() 
        --print("down result:", xhr.succeed, xhr.response)
        --if xhr.succeed then
            local response = xhr.response
            callfun(response)
        --else
        --end
    end
    xhr:registerScriptHandler(downok)
    xhr:send()
end

local function createbooknamectrl(info, callfun)--info{name, folder, progress = {title, pro}}
    local w = 200
    local h = 80
    local color = cc.c4b(249, 30, 90, 255)
    if info.folder then
        color = cc.c4b(255, 128, 0, 255)
    end
    local a = cc.LayerColor:create(color, w, h)
    local b = cc.LayerColor:create(color, w, h)
    local str = info.name
    if not info.folder then
        str = str .. "\n" .. info.progress.title .. " " .. tostring(info.progress.pro)
    end
    local c = cc.Label:createWithTTF(str, "src/yu.ttf", 20, cc.size(w, 0))
    c:setAnchorPoint(cc.p(0.5, 0.5))
    c:setPosition(cc.p(w / 2, h / 2))
    local d = normalbtn:create(a, b, function()
        if callfun and callfun() then
        end
    end)
    d:addChild(c)
    return d
end

local function createlabelbtn(str, w, h, callfun)
    local lab = cc.Label:createWithTTF(str, "src/yu.ttf", 20)
    lab:setPosition(cc.p(w / 2, h / 2))
    local b = normalbtn:create(cc.LayerColor:create(cc.c4b(92, 244, 11, 255), w, h), cc.LayerColor:create(cc.c4b(65, 190, 78, 255), w, h), function()
        if (callfun and callfun()) then
        end
    end)
    b:addChild(lab)
    return b
end

local function inputurlpathdlg()
	local layer = cc.LayerColor:create(cc.c4b(62,71,193,255),game_width,game_height)
	layer:setAnchorPoint(cc.p(0, 0))
	layer:setPosition(cc.p(0, 0))
    
    local editboxusername = cc.EditBox:create(cc.size(372,30),cc.Scale9Sprite:create("src/empty.png"))
    editboxusername:setFontName(FONTLABEL)
    editboxusername:setFontSize(22)
    editboxusername:setMaxLength(96)
    editboxusername:setReturnType(cc.KEYBOARD_RETURNTYPE_GO)
    editboxusername:setText("http://www.biquge.la/book/14/")
    fullscreenposition.set(editboxusername, 50, 30)
    layer:addChild(editboxusername)

    local downokevent = ""
    local c = checkbox1:create(cc.Label:createWithTTF("loadurl", "res/fonts/Marker Felt.ttf", 30), cc.Label:createWithTTF("loadurl", "res/fonts/Marker Felt.ttf", 28), function()
        local str = editboxusername:getText()
        print("url:", str)
        downokevent = str .. tostring(os.time)
        downmgr.addexpresstask("xiaoshuomulu", str, function(xhr, title, downokevent)
            response = xhr.response
            local ff = my.FileUnit:create("wm.txt")
            ff:createdir("xiaoshuo")
            ff:opendir("xiaoshuo")
            ff:createdir("chengdong")
            ff:opendir("chengdong")
            local xiaoshuomingzi, xiaoshuozhangjie = xiaoshuoparser.parserxiaoshuo(str, response, true)
            ff:createdir(xiaoshuomingzi)
            ff:opendir(xiaoshuomingzi)
            ff:createfile("bin", str)
            for k,v in ipairs(xiaoshuozhangjie) do
                ff:createdir(v[1])
                ff:opendir(v[1])
                ff:createfile("bin", str .. v[2])
                ff:gotoupdir()
            end
            ff:release()
        end, downokevent)
    end)
    fullscreenposition.set(c, 100, 200)
    layer:addChild(c)
    
    local function closeevent(event)
        local eventdata = event._usedata
        if eventdata ~= downokevent then
            return
        end
        layer:removeFromParent()
    end
    g_eventDispatcher:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("httpdownevent",closeevent), layer)
    return layer
end
xiaoshuo.inputurlpathdlg = inputurlpathdlg


local function listlocalbook()
	local layerbase = cc.LayerColor:create(cc.c4b(62,71,193,255),game_width,game_height)
	layerbase:setAnchorPoint(cc.p(0, 0))
	layerbase:setPosition(cc.p(0, 0))

    local ff = my.FileUnit:create("wm.txt")
    local function createbooklistui()
        local layer = cc.LayerColor:create(cc.c4b(62,71,193,255),game_width,game_height)
        layer:setAnchorPoint(cc.p(0, 0))
        layer:setPosition(cc.p(0, 0))

        
        local tableview  = TableViewCtrl:create()
        tableview:setContentSize(cc.size(game_width, game_height))
        fullscreenposition.set(tableview, 50, 0)
        layer:addChild(tableview)
        local filelist = ff:getfilelist()
        for k,v in ipairs(filelist) do
            local t = v:gettitle()
            local c = v:getcontent()
            --print("oooooooooooooo", t, c)
            if true then--t ~= "bin" then
                local tt = {}
                tt.name = t
                tt.folder = (c == "folder")
                tt.progress = {title = "what", pro = 1}
                local hh = createbooknamectrl(tt, function()
                    if c == "folder" then
                        ff:opendir(t)
                        local nn = createbooklistui()
                        layerbase:addChild(nn, 1)
                        layer:removeFromParent()
                    else
                        if ff:openfile(t) then
                        end
                    end
                end)
                hh:setAnchorPoint(cc.p(0, 0))
                tableview:addCell(hh)
            end
        end
        tableview:reloadData()

        local function backfun()
            if ff:gotoupdir() then
                local nn = createbooklistui()
                layerbase:addChild(nn, 1)
                layer:removeFromParent()
            else
                ff:release()
                layerbase:removeFromParent();
            end
        end
        local backbtn = createlabelbtn("back", 50, 50, backfun)
        fullscreenposition.set(backbtn, game_width - 50, 0)
        layer:addChild(backbtn, 10)
        return layer
    end
    
    local nn = createbooklistui()
    layerbase:addChild(nn, 1)
    return layerbase
end
xiaoshuo.listlocalbook = listlocalbook






return xiaoshuo