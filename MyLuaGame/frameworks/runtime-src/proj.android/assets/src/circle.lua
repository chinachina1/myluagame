--region circle.lua
--Author : 张文天
--Date   : 2014/6/19
--此文件由[BabeLua]插件自动生成
require "Cocos2d"
require "Cocos2dConstants"
require "src/common"

local delaytime = 10
local balldisappeartag = 19
local ball = cc.Sprite:create("res/ui/public/denglu_lianjie.png")
fullscreenposition.set(ball, 543.5, 323 - 30, 193, 68)
ball:retain()
--ball:setScale(0.1)
ball:setLocalZOrder(1000)
local ball1 = cc.Sprite:create("res/ui/public/load_flower.png")
tablecellpositioncreate(545, 323, 193, 68).set(ball1, 556, 329, 55,55)
ball:addChild(ball1)
local balltip = cc.LabelTTF:create("连接中...", FONTLABEL, 26)
tablecellpositioncreate(545, 323, 193, 68).set(balltip, 623, 345, 104, 26, cc.p(0, 0.5))
ball:addChild(balltip)

function getcircledelaytime()
    return delaytime
end

local function balltimeout(node)
    ball:removeFromParent()
end

local function tiptimeout(node)
    node:removeFromParent()
end

local function onBallTouchBegan(touch, event)
    print("ball begin")
    return true
end

local function onBallTouch(touch, event)
end


local function ballenterevent(time)
    if not time then
        time = 10
    end
    local ac1 = cc.RotateBy:create(1.5,360)
    local ac2 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(1.2/12), cc.CallFunc:create(function(node)ball1:setRotation(ball1:getRotation() + 360 / 12) end)))--cc.Repeat:create(ac1,10)
    local ac3 = cc.Sequence:create(cc.DelayTime:create(time), cc.CallFunc:create(function(node)balltimeout(node);showtip("超时");end))
    ac3:setTag(balldisappeartag)
    --ball:runAction(ac2)
    --ball:runAction(cc.Spawn:create(ac2,ac3))
    ball:runAction(ac2)
    ball:runAction(ac3)
    local eventDispatcher = ball:getEventDispatcher()
    --eventDispatcher:setEnabledTouch(false)
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(onBallTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onBallTouch,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onBallTouch,cc.Handler.EVENT_TOUCH_ENDED )
    eventDispatcher:addEventListenerWithFixedPriority(listener, -129)
    --eventDispatcher:addEventListenerWithSceneGraphPriority(listener, ball)
    ball.customslistener = listener
end

local function ballexitevent()
    local eventDispatcher = ball:getEventDispatcher()
    --eventDispatcher:setEnabledTouch(true)
    eventDispatcher:removeEventListener(ball.customslistener)
end

local function onNodeEvent(event)
    if "exit" == event then
         print("ball exit")
        ballexitevent()
    elseif "enter" == event then
        print("ball enter")
        ballenterevent(delaytime)
    end
end
ball:registerScriptHandler(onNodeEvent)

function showcircle(time)--10s
    local parent = ball:getParent()
    time = time or 10
    ball:setVisible(true)
    if not parent then
        --print("调用结构")
        --local level = 1
        --while true do
        --    local info = debug.getinfo(level,"Sl")
        --    if not info then break end
        --    print(string.format("[%s]:%d",info.short_src,info.currentline))
        --    level = level + 1
        --end
        --print("调用结构")
        delaytime = time
        addscene(ball)
    else
        ball:stopActionByTag(balldisappeartag)
        local ac3 = cc.Sequence:create(cc.DelayTime:create(time), cc.CallFunc:create(function(node)balltimeout(node);showtip("超时");end))
        ac3:setTag(balldisappeartag)
        ball:runAction(ac3)
    end
end

function hidecircle()
    local parent = ball:getParent()
    if parent then
        ball:stopActionByTag(balldisappeartag)
        local ac3 = cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function(node)balltimeout(node);end))
        --balltimeout(ball)
        ac3:setTag(balldisappeartag)
        ball:runAction(ac3)
    end
end

function createweaponupdatefailtip(tip)
    local layerbase = cc.Sprite:create("res/ui/public/gongyong_tishi.png")
    local ttfConfig = {}
    ttfConfig.fontFilePath = LABELFONT
    ttfConfig.fontSize = 36
    local lb = cc.Label:create(tip, LABELFONT, 26)
    lb:setColor(cc.c3b(255, 234, 0))
    lb:enableOutline(cc.c4b(180, 48, 0), 2)
    lb:setAnchorPoint(cc.p(0.5,0.5))
    lb:setPosition(cc.p(layerbase:getContentSize().width/2,layerbase:getContentSize().height/2 - 0))
    --print(lb:getContentSize().width,lb:getContentSize().height)
    layerbase:addChild(lb,2,2)
    layerbase:setLocalZOrder(100000)
    local ac1 = cc.FadeOut:create(0.5)--cc.MoveBy:create(1,cc.p(0,200))
    local ac2 = cc.DelayTime:create(1)
    local ac3 = cc.CallFunc:create(function(node) node:removeFromParent()end)
    local ac4 = cc.Sequence:create(ac2,ac1,ac3)
    layerbase:runAction(ac4)
    setnodepos(layerbase,414,267)
    addscene(layerbase)
    layerbase:setCascadeOpacityEnabled(true)
end

function showtip(tip)
    --local label = cc.Label:create(tip, BTNFONT, 40)
    --label:setAnchorPoint(cc.p(0.5,0.5))
    --label:setPosition(cc.p(GAME_WIDHT/2,GAME_HEIGHT/2))
    --label:setLocalZOrder(1100)
    --addscene(label)
    --local ac1 = cc.MoveBy:create(1,cc.p(0,200))
    --local ac2 = cc.DelayTime:create(0.5)
    --local ac3 = cc.CallFunc:create(tiptimeout)
    --local ac4 = cc.Sequence:create(ac1,ac2,ac3)
    --label:runAction(ac4)
    createweaponupdatefailtip(tip)
end

function buymoneydlg()
    local layerbase = cc.Layer:create()
    layerbase:setLocalZOrder(1000)
    setlayerswallowtouch(layerbase)
    layerbase:addChild(setnodepos(createtipbg(376, 260),460,211))
    local lab = cc.LabelTTF:create("银两不足是否使用摇钱树",FONTLABEL,24)
    lab:setColor(COLOR_COFFEE_DEEP)
    lab:setPosition(getscreenpos(528,287,244,46))
    layerbase:addChild(lab)
    local btn1 = newminbtn4("取消", function()
        layerbase:removeFromParent()
    end,-4)
    layerbase:addChild(setnodepos(btn1,669,370))
    local btn2 = newminbtn4("确认", function()
        layerbase:removeFromParent()
        --addscene(createlayermoneytree())
        cc.Director:getInstance():getRunningScene():addChild(createlayermoneytree(), 41)
    end,-4)
    layerbase:addChild(setnodepos(btn2,509,370))
    addscene(layerbase)
end

function buycoindlg()
    local layerbase = cc.Layer:create()
    layerbase:setLocalZOrder(1000)
    setlayerswallowtouch(layerbase)
    layerbase:addChild(setnodepos(createtipbg(376, 260),460,211))
    local lab = cc.LabelTTF:create("元宝不足是否充值",FONTLABEL,24)
    lab:setColor(COLOR_COFFEE_DEEP)
    lab:setPosition(getscreenpos(528,287,244,46))
    layerbase:addChild(lab)
    local btn1 = newminbtn4("取消", function()
        layerbase:removeFromParent()
    end,-4)
    layerbase:addChild(setnodepos(btn1,669,370))
    local btn2 = newminbtn4("确认", function()
        layerbase:removeFromParent()
        cc.Director:getInstance():getRunningScene():addChild(createlayervip(), 41)
    end,-4)
    layerbase:addChild(setnodepos(btn2,509,370))
    addscene(layerbase)
end

function buytilidlg()
    local layerbase = cc.Layer:create()
    layerbase:setLocalZOrder(1000)
    setlayerswallowtouch(layerbase)
    layerbase:addChild(setnodepos(createtipbg(376, 260),460,211))
    local lab = cc.LabelTTF:create("体力不足是否购买",LABELFONT,24)
    lab:setColor(COLOR_COFFEE_DEEP)
    lab:setPosition(getscreenpos(528,287,244,46))
    layerbase:addChild(lab)
    local btn1 = newminbtn4("取消", function()
        layerbase:removeFromParent()
    end,-4)
    layerbase:addChild(setnodepos(btn1,669,370))
    local btn2 = newminbtn4("确认", function()
        layerbase:removeFromParent()
        --addscene(createlayerbuypower())
        cc.Director:getInstance():getRunningScene():addChild(createlayerbuypower(), 140)
    end,-4)
    layerbase:addChild(setnodepos(btn2,509,370))
    addscene(layerbase)
end
--endregion
