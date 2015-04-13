--region normalbtn.lua
--Author : 张文天
--Date   : 2014/8/9
--此文件由[BabeLua]插件自动生成


normalbtn = class("normalbtn",
    function()
        local layer = cc.Node:create()
        return layer
    end
    )
normalbtn.m_unclicksprite = nil
normalbtn.m_clicksprite = nil
normalbtn.m_dissprite = nil
normalbtn.m_clickCallfun = nil
normalbtn.m_beginClickCallfun = nil
normalbtn.m_endClickCallfun = nil
normalbtn.touchbeginpos = cc.p(0,0)
normalbtn.touchmovepos = cc.p(0, 0)
normalbtn.touchendpos = cc.p(0,0)
normalbtn.isenable = true
normalbtn.m_sacle = nil

function normalbtn:startclick()
    self.m_unclicksprite:setVisible(false)
    self.m_clicksprite:setVisible(true)
    if self.m_sacle and self.m_clickCallfun then
        self:setScale(0.97)
    end
    if self.m_beginClickCallfun then
        self:m_beginClickCallfun()
    end
end

function normalbtn:stopclick()
    self.m_unclicksprite:setVisible(true)
    self.m_clicksprite:setVisible(false)
    if self.m_sacle and self.m_clickCallfun then
        self:setScale(1)
    end
    if self.m_endClickCallfun then
        self:m_endClickCallfun()
    end
end

function normalbtn:ctrinit(sp,sp2,sp3,sacle)
    self:addChild(sp)
    self.m_clicksprite = sp
    self.m_clicksprite:setPosition(cc.p(0,0))
    self.m_clicksprite:setAnchorPoint(cc.p(0,0))
    self.m_clicksprite:setVisible(false)
    self:setContentSize(self.m_clicksprite:getContentSize())

    self:addChild(sp2)
    self.m_unclicksprite = sp2
    self.m_unclicksprite:setPosition(cc.p(0,0))
    self.m_unclicksprite:setAnchorPoint(cc.p(0,0))
    self.m_unclicksprite:setVisible(true)

    if sp3 then
        self:addChild(sp3)
        self.m_dissprite = sp3
        self.m_dissprite:setPosition(cc.p(0,0))
        self.m_dissprite:setAnchorPoint(cc.p(0,0))
        self.m_dissprite:setVisible(false)
    end

    self.m_sacle = sacle

    local function onTouchBegin(touch,event)
        if not self.isenable then
            return false
        end
        local m_clickbegin = false
        self.touchbeginpos = touch:getLocation()
        self.touchmovepos = self.touchbeginpos
        self.touchendpos = self.touchbeginpos
        self.begintime = g_dofortime.gettime()
        --self.clicksceenpos = g_sceentouchendpos
        --print("ggggggggggggggggggggggggggggggg", self.clicksceenpos.y - self.touchbeginpos.y)
        local pos = self:convertToNodeSpace(touch:getLocation())
        self.tmptouchbegin = pos
        local pos1 = self:convertToNodeSpaceAR(touch:getLocation())
        local rect = cc.rect(0,0,self:getContentSize().width,self:getContentSize().height)
        if cc.rectContainsPoint(rect,pos) then
            m_clickbegin = true
        end
        if not self:isVisible() then
            m_clickbegin = false
        end
        if m_clickbegin then
            self:startclick()
        end
        return m_clickbegin
    end
    local function onTouchMove(touch,event)
        if not self.isenable then
            return
        end        
        self.touchmovepos = touch:getLocation()
        local pos = self:convertToNodeSpace(touch:getLocation())
        local rect = cc.rect(0,0,self:getContentSize().width,self:getContentSize().height)
        if cc.rectContainsPoint(rect,pos) then
            self.touchendpos = self.touchmovepos
        else
            self:stopclick()
        end
    end
    local function onTouchEnd(touch,event)
        if not self.isenable then
            return
        end     
        self:stopclick()
        self.touchendpos = touch:getLocation()
        self.touchmovepos = self.touchendpos
        self.endtime = g_dofortime.gettime()
        local pos = self:convertToNodeSpace(touch:getLocation())
        local pos1 = self:convertToNodeSpaceAR(touch:getLocation())
        local rect = cc.rect(0,0,self:getContentSize().width,self:getContentSize().height)
        if cc.rectContainsPoint(rect,pos) then
            if self.m_clickCallfun then
                self:m_clickCallfun()
            end
        end   
    end
    local function onTouchCancelled(touch,event)
        self:stopclick()
        self.touchendpos = self.touchbeginpos
    end
    local listener = cc.EventListenerTouchOneByOne:create()
    --self:setSwallowTouches(true)
    listener:registerScriptHandler(onTouchBegin,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMove,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnd,cc.Handler.EVENT_TOUCH_ENDED )
    listener:registerScriptHandler(onTouchCancelled,cc.Handler.EVENT_TOUCH_CANCELLED )
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

function normalbtn:setCallBack(fun)--function(self,step)
    self.m_clickCallfun = fun
end

function normalbtn:enable(flag)
    if self.isenable ~= flag then
        self.isenable = flag
        self.m_clicksprite:setVisible(false)
        self.m_unclicksprite:setVisible(false)
        if self.m_dissprite then
            self.m_dissprite:setVisible(not self.isenable)
            self.m_unclicksprite:setVisible(self.isenable)
        else
            self.m_unclicksprite:setVisible(not self.isenable)
        end
    end
end

function normalbtn:create(sprite,sprite2,callback,sprite3,sacle)--select,normal,callback,disable
    local node = normalbtn.new()
    node:ignoreAnchorPointForPosition(false)
    node:ctrinit(sprite,sprite2,sprite3,sacle)
    node.m_clickCallfun = callback
    node:setAnchorPoint(cc.p(0.5,0.5))
    return node
end

--endregion
