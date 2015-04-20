--region checkbox1.lua
--Date 2014/6/13
--此文件由[BabeLua]插件自动生成
--选中太,正常太 毁掉
local _nodecreatefun = nil
local _nodeinitfun = nil

checkbox1 = class("checkbox1",
    function()
        local layer = cc.Node:create()
        _nodeinitfun = cc.Node.init
        return layer
    end
    )
checkbox1.touchbeginpos = cc.p(0,0)
checkbox1.touchendpos = cc.p(0,0)
function checkbox1:init(node,node2)
    if _nodeinitfun ~= nil then 
        _nodeinitfun(self)
    end

    if node2 then
        self:addChild(node2)
        self.m_unchecksprite = node2
        self.m_unchecksprite:setPosition(cc.p(node2:getContentSize().width / 2,node2:getContentSize().height / 2))
        self.m_unchecksprite:setAnchorPoint(cc.p(0.5,0.5))
        self.m_unchecksprite:setVisible(not self.m_ischeck)
    end

    self:addChild(node)
    self.m_checksprite = node
    self.m_checksprite:setPosition(cc.p(node:getContentSize().width / 2,node:getContentSize().height / 2))
    self.m_checksprite:setAnchorPoint(cc.p(0.5,0.5))
    self.m_checksprite:setVisible(self.m_ischeck)
    self:setContentSize(self.m_checksprite:getContentSize())


    local function onTouchBegin(touch,event)
        self.m_clickbegin = false
        self.touchbeginpos = touch:getLocation()
        local pos = self:convertToNodeSpace(touch:getLocation())
        local pos1 = self:convertToNodeSpaceAR(touch:getLocation())
        local rect = cc.rect(0,0,self:getContentSize().width,self:getContentSize().height)
        if cc.rectContainsPoint(rect,pos) then
            self.m_clickbegin = true
        end
        if not self:isVisible() then
            self.m_clickbegin = false
        end
        if self.m_clickbegin then
            if self.m_unchecksprite then
                self.m_unchecksprite:setVisible(false)
            end
            self.m_checksprite:setVisible(true)
        end
        return self.m_clickbegin
    end
    local function onTouchMove(touch,event)
    end
    local function onTouchEnd(touch,event)
        self.touchendpos = touch:getLocation()
        if self.m_clickbegin then
            local pos = self:convertToNodeSpace(touch:getLocation())
            local rect = cc.rect(0,0,self:getContentSize().width,self:getContentSize().height)
            if cc.rectContainsPoint(rect,pos) then
                self.m_ischeck = not self.m_ischeck
                if self.m_unchecksprite then
                    self.m_unchecksprite:setVisible(self.m_ischeck==false)
                end
                self.m_checksprite:setVisible(self.m_ischeck)
                if self.m_clickCallfun then
                    self:m_clickCallfun(self.m_ischeck)
                end
            else
                if self.m_unchecksprite then
                    self.m_unchecksprite:setVisible(self.m_ischeck==false)
                end
                self.m_checksprite:setVisible(self.m_ischeck)
            end
        end
        self.m_clickbegin = false
    end
    local listener = cc.EventListenerTouchOneByOne:create()
    --self:setSwallowTouches(true)
    listener:registerScriptHandler(onTouchBegin,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMove,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnd,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end
checkbox1.m_ischeck = false
checkbox1.m_unchecksprite = nil
checkbox1.m_checksprite = nil
checkbox1.m_clickbegin = false
checkbox1.m_clickCallfun = nil
function checkbox1:IsCheck()
    return self.m_ischeck
end
function checkbox1:SetCheck(check)
    self.m_ischeck = check
    if self.m_unchecksprite then
        self.m_unchecksprite:setVisible(self.m_ischeck==false)
    end
    self.m_checksprite:setVisible(self.m_ischeck)
end
function checkbox1:setCallBack(fun)--function(checkbox,bool)
    self.m_clickCallfun = fun
end
function checkbox1:create(sprite,sprite2,callback)
    local node = checkbox1.new()
    --node:ignoreAnchorPointForPosition(false)
    node:init(sprite,sprite2)
    node.m_clickCallfun = callback
    node:setAnchorPoint(cc.p(0.5,0.5))
    return node
end
--endregion
