require "src/tableviewctrl"
require "src/tableviewctrl1"
require "src/downmanger"
require "src/xiaoshuoparser"
local xiaoshuo = {}

local normalfontsize = 20
xpcall(function()
local glview = cc.Director:getInstance():getOpenGLView()
local factor = ( glview:getScaleX() + glview:getScaleY() ) / 2
local MOVE_INCH = 49/160
local realsize = glview:getVisibleSize()
--normalfontsize = getdevicedpi() * MOVE_INCH / factor
local ff = math.min(realsize.width / game_width, realsize.height / game_height)
normalfontsize = 20 * ff
normalfontsize = math.floor(normalfontsize)
end, __G__TRACKBACK__)

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
    editboxusername:setText("http://wanmeishijiexiaoshuo.org/")
    fullscreenposition.set(editboxusername, 50, 30)
    layer:addChild(editboxusername)

    local downokevent = ""
    local c = checkbox1:create(cc.Label:createWithTTF("loadurl", "res/fonts/Marker Felt.ttf", 30), cc.Label:createWithTTF("loadurl", "res/fonts/Marker Felt.ttf", 28), function()
        local str = editboxusername:getText()
        print("url:", str)
        downokevent = str .. tostring(os.time)
        downmgr.addexpresstask(str, str, function(xhr, title, downokevent)
            response = xhr.response
            local ff = my.FileUnit:create("wm.txt")
            local xiaoshuomingzi, xiaoshuozhangjie, needbase = xiaoshuoparser.parserxiaoshuo(str, response, true)
            ff:createnewbook(xiaoshuomingzi, str)
            ff:openbook(xiaoshuomingzi, str)
            for k,v in ipairs(xiaoshuozhangjie) do
                if needbase then
                    ff:addbooktitle(v[1], str .. v[2])
                else
                    ff:addbooktitle(v[1], v[2])
                end
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
    local createbooklistui
    local createbooktitlelistui
    local createtxtread
    local ff = my.FileUnit:create("wm.txt")
    createtxtread = function ()
        local layer = cc.LayerColor:create(cc.c4b(255,255,255,255),game_width,game_height)
        layer:setAnchorPoint(cc.p(0, 0))
        layer:setPosition(cc.p(0, 0))
        
        local str = ff:getbooktitlecontent()
        local lab = cc.Label:createWithTTF(str, "src/hui.ttf", normalfontsize, cc.size(game_width, 0))
        lab:setColor(cc.c3b(0, 0, 0))
        lab:setAnchorPoint(cc.p(0, 0))
        lab:setPosition(cc.p(0, game_height - lab:getContentSize().height))
        layer:addChild(lab)

        local function backfun()
            local bookname = ff:getmybookname()
            ff:openbook(bookname, bookname)
            local nn = createbooktitlelistui()
            layerbase:addChild(nn, 1)
            layer:removeFromParent()
        end

        local touchremeber = {}
        if lab:getContentSize().height > game_height then
            local touchbeginpos = cc.p(0, 0)
            local function onTouchBegin(touch,event)
                touchbeginpos = touch:getLocation()
                touchremeber = {}
                return true
            end
            local function onTouchMove(touch,event)
                local pos = touch:getLocation()
                local dif = pos.y - touchbeginpos.y
                dif = lab:getPositionY() + dif
                dif = math.min(0, dif)
                dif = math.max(game_height - lab:getContentSize().height, dif)
                lab:setPositionY(dif)
                touchbeginpos = pos
                table.insert(touchremeber, pos)
            end
            local function onTouchEnd(touch,event)
                if table.getn(touchremeber) == 0 then
                    local dif = lab:getPositionY() + game_height - 20
                    dif = math.min(0, dif)
                    dif = math.max(game_height - lab:getContentSize().height, dif)
                    lab:setPositionY(dif)
                end
            end
            local listener = cc.EventListenerTouchOneByOne:create()
            listener:setSwallowTouches(true)
            listener:registerScriptHandler(onTouchBegin,cc.Handler.EVENT_TOUCH_BEGAN )
            listener:registerScriptHandler(onTouchMove,cc.Handler.EVENT_TOUCH_MOVED )
            listener:registerScriptHandler(onTouchEnd,cc.Handler.EVENT_TOUCH_ENDED )
            local eventDispatcher = layer:getEventDispatcher()
            eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
        end
--        local backbtn = createlabelbtn("back", 50, 50, backfun)
--        fullscreenposition.set(backbtn, game_width - 50, 0)
--        layer:addChild(backbtn, 10)

        local function keyclick(keycode)
            print(keycode)
            if keycode == "menuClicked" then
                --backfun()
            else
                backfun()
            end
        end
        layer:registerScriptKeypadHandler(keyclick)
        layer:setKeyboardEnabled(true)
--        local listener = cc.EventListenerKeyboard:create()
--        listener:registerScriptHandler(keyclick,cc.Handler.EVENT_KEYBOARD_PRESSED )
--        local eventDispatcher = layer:getEventDispatcher()
--        eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
        return layer
    end
    
    createbooktitlelistui = function ()
        local layer = cc.LayerColor:create(cc.c4b(62,71,193,255),game_width,game_height)
        layer:setAnchorPoint(cc.p(0, 0))
        layer:setPosition(cc.p(0, 0))

        local downokevent = ""
        local filelist = {}
        for k,v in ipairs(ff:getbooktitlelist()) do
            local o = {}
            o.title = v:gettitle()
            o.gettitle = function()
                return o.title
            end
            o.content = v:getcontent()
            o.getcontent = function()
                return o.content
            end
            o.path = v:getpath()
            o.getpath = function()
                return o.path
            end
            table.insert(filelist, o)
        end
        --local filelist = ff:getbooktitlelist()
        local cnt = table.getn(filelist)
        if cnt > 0 then
            cnt = cnt - 0
        end
        local tableview  = TableViewCtrl1:create(cnt)
        tableview:setContentSize(cc.size(game_width, game_height))
        fullscreenposition.set(tableview, 50, 0)
        layer:addChild(tableview)
        tableview.getcellsizefun = function(_, idx)
            return 80, 200
        end
        tableview.updatecellfun = function(_, cell, idx)
            cell:removeAllChildren()
            local v = filelist[idx + 1]
            local t = v:gettitle()
            local c = v:getcontent()
            local p = v:getpath()
            --print("oooooooooooooo", t, c)
            if true then--t ~= "bin" then
                local tt = {}
                tt.name = t
                tt.folder = false
                tt.progress = {title = "what", pro = 1}
                local hh = createbooknamectrl(tt, function()
                    if ff:openbooktitlecontent(t, p) then
                        local nn = createtxtread()
                        layerbase:addChild(nn, 2)
                        layer:removeFromParent()
                    else
                        downokevent = p .. tostring(os.time)
                        local fullpath = ff:getmybookname()
                        downmgr.addexpresstask(p, p, function(xhr, title, downokevent)
                            response = xhr.response
                            local ff = my.FileUnit:create("wm.txt")
                            ff:openbook(fullpath, fullpath)
                            local biaoti, neirong = xiaoshuoparser.parserxiaoshuo(p, response, false)
                            ff:addbooktitlecontent(biaoti, neirong, p)
                            ff:release()
                        end, downokevent)
                    end
                end)
                hh:setAnchorPoint(cc.p(0, 0))
                cell:addChild(hh)
            end
        end
        tableview:reloadData()

        local function backfun()
            if ff:onpageback() then
                local nn = createbooklistui()
                layerbase:addChild(nn, 1)
                layer:removeFromParent()
            end
        end
        local backbtn = createlabelbtn("back", 50, 50, backfun)
        fullscreenposition.set(backbtn, game_width - 50, 0)
        layer:addChild(backbtn, 10)

        local function downall()
            local ii = 1
            for k,v in ipairs(filelist) do
                local t = v:gettitle()
                local p = v:getpath()
                if not ff:openbooktitlecontent(t, p) then
                    if ii > 1 then
                        break
                    end
                    print(t, p)
                    downokevent = "lianxude"
                    local fullpath = ff:getmybookname()
                    downmgr.addexpresstask(p, p, function(xhr, title, downokevent)
                        response = xhr.response
                        local ff = my.FileUnit:create("wm.txt")
                        ff:openbook(fullpath, fullpath)
                        local biaoti, neirong = xiaoshuoparser.parserxiaoshuo(p, response, false)
                        ff:addbooktitlecontent(biaoti, neirong, p)
                        print(biaoti)
                        ff:release()
                    end, downokevent)
                    ii = ii + 1
                end
            end
        end
        local backbtn = createlabelbtn("downall", 50, 50, downall)
        fullscreenposition.set(backbtn, game_width - 100, 0)
        layer:addChild(backbtn, 10)

            
        local function closeevent(event)
            local eventdata = event._usedata
            if eventdata == "lianxude" then
                downall()
                return
            end
        end
        g_eventDispatcher:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("httpdownevent",closeevent), layer)
        return layer
    end
    createbooklistui = function ()
        local layer = cc.LayerColor:create(cc.c4b(62,71,193,255),game_width,game_height)
        layer:setAnchorPoint(cc.p(0, 0))
        layer:setPosition(cc.p(0, 0))

        
        local filelist = {}
        for k,v in ipairs(ff:getbooklist()) do
            local o = {}
            o.title = v:gettitle()
            o.gettitle = function()
                return o.title
            end
            o.content = v:getcontent()
            o.getcontent = function()
                return o.content
            end
            o.path = v:getpath()
            o.getpath = function()
                return o.path
            end
            table.insert(filelist, o)
        end
        --local filelist = ff:getbooklist()
        local cnt = table.getn(filelist)
        if cnt > 0 then
            cnt = cnt - 0
        end
        local tableview  = TableViewCtrl1:create(cnt)
        tableview:setContentSize(cc.size(game_width, game_height))
        fullscreenposition.set(tableview, 50, 0)
        layer:addChild(tableview)
        tableview.getcellsizefun = function(_, idx)
            return 80, 200
        end
        tableview.updatecellfun = function(_, cell, idx)
            cell:removeAllChildren()
            local v = filelist[idx + 1]
            local t = v:gettitle()
            local c = v:getcontent()
            local p = v:getpath()
            --print("oooooooooooooo", t, c)
            if true then--t ~= "bin" then
                local tt = {}
                tt.name = t
                tt.folder = true
                tt.progress = {title = "what", pro = 1}
                local hh = createbooknamectrl(tt, function()
                    ff:openbook(t, p)
                    local nn = createbooktitlelistui()
                    layerbase:addChild(nn, 1)
                    layer:removeFromParent()
                end)
                hh:setAnchorPoint(cc.p(0, 0))
                cell:addChild(hh)
            end
        end
        tableview:reloadData()

        local function backfun()
            ff:release()
            layerbase:removeFromParent();
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