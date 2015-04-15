--region tableviewctrl1.lua
--Author : 张文天
--Date   : 2014/7/8
--此文件由[BabeLua]插件自动生成

--region tableviewctrl.lua
--Author : 张文天
--Date   : 2014/6/14
--此文件由[BabeLua]插件自动生成

--tableview

TableViewCtrl1 = class("TableViewCtrl1")
TableViewCtrl1.__index = TableViewCtrl1

TableViewCtrl1.cellnum = 0
TableViewCtrl1.updatecellfun = function (_,cell,idx) end
TableViewCtrl1.getcellsizefun = function(_,idx) return 1,1 end
local _oldsetControlSize = nil
TableViewCtrl1.tableviewctrlptr = nil
TableViewCtrl1.needreload = false
TableViewCtrl1.clickcallback = nil

TableViewCtrl1.scrollbg = nil
TableViewCtrl1.scroll = nil
TableViewCtrl1.scrollbgxoffset = 0
TableViewCtrl1.scrollxoffset = 0
TableViewCtrl1.clippingnode = nil

TableViewCtrl1.dotouchevent = false

TableViewCtrl1.oneclipesprite = nil
TableViewCtrl1.oneclipesize = {0, 1}
TableViewCtrl1.twoclipesprite = nil
TableViewCtrl1.twoclipesize = {0, 1}

TableViewCtrl1.upbarshowfunction = nil
TableViewCtrl1.downbarshowfunction = nil
TableViewCtrl1.leftbarshowfunction = nil
TableViewCtrl1.rightbarshowfunction = nil

function TableViewCtrl1.extend(target)
    _oldsetControlSize = target.setContentSize
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target,t)
    end
    setmetatable(t,TableViewCtrl1)
    return target
end

function TableViewCtrl1.scrollViewDidScroll(view)
    local tableview = view.ctrldata
    local realsize = view:getContentSize()
    local viewsize = view:getViewSize()
    if realsize.height <= viewsize.height then
        if tableview.clippingnode then
            tableview.clippingnode:setVisible(false)
        end
    else
        if tableview.clippingnode then
            tableview.clippingnode:setVisible(true)
            local offset = view:getContentOffset()
            local scrollyrange = tableview.scrollbg:getContentSize().height - tableview.scroll:getContentSize().height
            local range = offset.y / (viewsize.height - realsize.height)
            tableview.scroll:setPositionY(scrollyrange * range)
        end
    end
    if true then
        local offset = view:getContentOffset()
        local size = tableview:getContentSize()
        if view:getDirection() == cc.SCROLLVIEW_DIRECTION_VERTICAL then
            if offset.y + realsize.height > size.height then
                if tableview.oneclipesprite then tableview.oneclipesprite:setVisible(true) end
                if tableview.upbarshowfunction then tableview.upbarshowfunction(true) end
            else
                if tableview.oneclipesprite then tableview.oneclipesprite:setVisible(false) end
                if tableview.upbarshowfunction then tableview.upbarshowfunction(false) end
            end
            if offset.y < 0 then
                if tableview.twoclipesprite then tableview.twoclipesprite:setVisible(true) end
                if tableview.downbarshowfunction then tableview.downbarshowfunction(true) end
            else
                if tableview.twoclipesprite then tableview.twoclipesprite:setVisible(false) end
                if tableview.downbarshowfunction then tableview.downbarshowfunction(false) end
            end
        elseif view:getDirection() == cc.SCROLLVIEW_DIRECTION_HORIZONTAL then
            if offset.x + realsize.width > size.width then
                if tableview.twoclipesprite then tableview.twoclipesprite:setVisible(true) end
                if tableview.rightbarshowfunction then tableview.rightbarshowfunction(true) end
            else
                if tableview.twoclipesprite then tableview.twoclipesprite:setVisible(false) end
                if tableview.rightbarshowfunction then tableview.rightbarshowfunction(false) end
            end
            if offset.x < 0 then
                if tableview.oneclipesprite then tableview.oneclipesprite:setVisible(true) end
                if tableview.leftbarshowfunction then tableview.leftbarshowfunction(true) end
            else
                if tableview.oneclipesprite then tableview.oneclipesprite:setVisible(false) end
                if tableview.leftbarshowfunction then tableview.leftbarshowfunction(false) end
            end
        end
    end
end

function TableViewCtrl1.scrollViewDidZoom(view)
end

function TableViewCtrl1.tableCellTouched(table1,cell)
    local idx = cell:getIdx()
    local tableview = table1.ctrldata
    if not tableview.dotouchevent then
        tableview.dotouchevent = true
        local callfun = tableview.clickcallback
        if callfun then
            callfun(tableview,cell,idx)
        end
    end
    tableview.dotouchevent = false
end

function TableViewCtrl1.cellSizeForTable(table1,idx)
    return table1.ctrldata:getcellsizefun(idx)
end

function TableViewCtrl1.tableCellAtIndex(table1,idx)
    local cell = table1:dequeueCell()
    if not cell then
        cell = cc.TableViewCell:new()
    end
    table1.ctrldata:updatecellfun(cell,idx)
    return cell
end

function TableViewCtrl1.numberOfCellsInTableView(table1)
    return table1.ctrldata.cellnum
end

function TableViewCtrl1:init()
    local tableView = cc.TableView:create(self:getContentSize())
    tableView.ctrldata = self
    self.tableviewctrlptr = tableView
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:setPosition(cc.p(0,0))
    tableView:setAnchorPoint(cc.p(0,0))
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self:addChild(tableView)
    tableView:registerScriptHandler(TableViewCtrl1.scrollViewDidScroll,cc.SCROLLVIEW_SCRIPT_SCROLL)
    tableView:registerScriptHandler(TableViewCtrl1.scrollViewDidZoom,cc.SCROLLVIEW_SCRIPT_ZOOM)
    tableView:registerScriptHandler(TableViewCtrl1.tableCellTouched,cc.TABLECELL_TOUCHED)
    tableView:registerScriptHandler(TableViewCtrl1.cellSizeForTable,cc.TABLECELL_SIZE_FOR_INDEX)
    tableView:registerScriptHandler(TableViewCtrl1.tableCellAtIndex,cc.TABLECELL_SIZE_AT_INDEX)
    tableView:registerScriptHandler(TableViewCtrl1.numberOfCellsInTableView,cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
    tableView:reloadData()

    self:setProgress(0)
    --local ttfConfig = {}
    --ttfConfig.fontFilePath = "res/fonts/fzkt.ttf"
    --ttfConfig.fontSize = 30
    --local label1 = cc.Label:createWithTTF(ttfConfig,"123456")
    --self:addChild(label1)
    return true
end

function TableViewCtrl1:create(num)
    local layer = TableViewCtrl1.extend(cc.Layer:create())
    if nil ~= layer then
        if num then
            layer.cellnum = num
        end
        layer:ignoreAnchorPointForPosition(false)
        layer:init()

        local function enterevent()
             local function onTouchBegin(touch,event)
                local click = false
                local pos = layer:convertToNodeSpace(touch:getLocation())
                local rect = cc.rect(0,0,layer:getContentSize().width,layer:getContentSize().height)
                if cc.rectContainsPoint(rect,pos) then
                    click = true
                end
                return click
            end
            local function onTouchMove(touch,event)
            end
            local function onTouchEnd(touch,event)
            end
            local listener = cc.EventListenerTouchOneByOne:create()
            listener:setSwallowTouches(true)
            listener:registerScriptHandler(onTouchBegin,cc.Handler.EVENT_TOUCH_BEGAN )
            listener:registerScriptHandler(onTouchMove,cc.Handler.EVENT_TOUCH_MOVED )
            listener:registerScriptHandler(onTouchEnd,cc.Handler.EVENT_TOUCH_ENDED )
            local eventDispatcher = layer:getEventDispatcher()
            eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
        end

        local function exitevent()
        end
        local function onNodeEvent(event)
           if "enter" == event then
               enterevent()
           elseif "exit" == event then
                exitevent()
           end
        end
        layer:registerScriptHandler(onNodeEvent)
    end

    return layer
end

function TableViewCtrl1:setContentSize(size)
    _oldsetControlSize(self,size)
    local tmpsize = self:getContentSize()
    local tmp = self.tableviewctrlptr
    tmp:setViewSize(size)
    tmp:reloadData()
    self:setScrollBgSize(self:getContentSize())
    self:setoneclipespritecoorder()
    self:settwoclipespritecoorder()
end

function TableViewCtrl1:reloadData()
    local tmp = self.tableviewctrlptr
    tmp:reloadData()
end

function TableViewCtrl1:setScroll(filename1,xoffset1,filename2,xoffset2)
    self.scrollbgxoffset = xoffset1
    self.scrollxoffset = xoffset2
    local texture1 = cc.Director:getInstance():getTextureCache():addImage(filename1)
    local texture2 = cc.Director:getInstance():getTextureCache():addImage(filename2)
    if texture1 and texture2 then
        self.scrollbg = cc.Node:create()
        self.scrollbg:retain()
        self.scrollbg:setAnchorPoint(cc.p(0,0))
        self.scrollbg:setPosition(cc.p(0,0))
        local sp1 = cc.Sprite:create(filename1,cc.rect(0,0,texture1:getPixelsWide(),texture1:getPixelsHigh()/3))
        sp1:setAnchorPoint(cc.p(0,0))
        sp1:setPosition(cc.p(0,0))
        sp1:setTag(1)
        sp1:setFlippedY(true)
        self.scrollbg:addChild(sp1)
        local sp2 = cc.Sprite:create(filename1,cc.rect(0,texture1:getPixelsHigh()/3,texture1:getPixelsWide(),texture1:getPixelsHigh()/3))
        sp2:setAnchorPoint(cc.p(0,0))
        sp2:setPosition(cc.p(0,texture1:getPixelsHigh()/3))
        sp2:setTag(2)
        sp2:setFlippedY(true)
        self.scrollbg:addChild(sp2)
        local sp3 = cc.Sprite:create(filename1,cc.rect(0,texture1:getPixelsHigh() / 3 * 2,texture1:getPixelsWide(),texture1:getPixelsHigh()/3))
        sp3:setAnchorPoint(cc.p(0,0))
        sp3:setPosition(cc.p(0,texture1:getPixelsHigh()/3 * 2))
        sp3:setTag(3)
        sp3:setFlippedY(true)
        self.scrollbg:addChild(sp3)
        self.scrollbg:setContentSize(cc.size(texture1:getPixelsWide(),texture1:getPixelsHigh()))

        self.scroll = cc.Sprite:create(filename2)
        self.scroll:retain()
        self.scroll:setAnchorPoint(cc.p(0,0))
        self.scroll:setPosition(cc.p(0,0))

        --init
        if not self.scrollxoffset then
            self.scrollxoffset = (self.scrollbg:getContentSize().width - self.scroll:getContentSize().width)/2
            self:setPositionX(self.scrollxoffset)
        end
        self.clippingnode = cc.ClippingNode:create()
        self.clippingnode:setAnchorPoint(cc.p(0,0))
        self.clippingnode:setPosition(cc.p(self.scrollbgxoffset,0))
        self.clippingnode:setStencil(self.scrollbg)
        self.clippingnode:setAlphaThreshold(0.05)
        self.clippingnode:addChild(self.scrollbg)
        self.clippingnode:addChild(self.scroll)
        self:addChild(self.clippingnode)
        self:setScrollBgSize(self:getContentSize())
    end
end

function TableViewCtrl1:setScrollBgSize(size)
    if self.clippingnode then
        local sp1 = self.scrollbg:getChildByTag(1)
        local sp2 = self.scrollbg:getChildByTag(2)
        local sp3 = self.scrollbg:getChildByTag(3)
        local size1 = sp1:getContentSize()
        local size2 = sp2:getContentSize()
        local size3 = sp3:getContentSize()
        if size.height >= (size1.height + size3.height) then
            local needheight = size.height - size1.height - size3.height
            local scale = needheight / size2.height
            sp2:setScaleY(scale)
            sp3:setPosition(cc.p(0,size.height - size3.height))
            self.scrollbg:setContentSize(cc.size(size1.width,size.height))
        end
    end
end

function TableViewCtrl1:getProgress()
    local tmp = self.tableviewctrlptr
    local realsize = tmp:getContentSize()
    local viewsize = tmp:getViewSize()
    local offset = tmp:getContentOffset()
    --local range = offset.y / (viewsize.height - realsize.height)
    local range = viewsize.height - offset.y - realsize.height
    print("TableViewCtrl1:getProgress",range,viewsize.height,offset.y,realsize.height)
    return range
end

function TableViewCtrl1:setProgress(range)
    local tmp = self.tableviewctrlptr
    local realsize = tmp:getContentSize()
    local viewsize = tmp:getViewSize()
    --local y = viewsize.height - realsize.height
    --local offset = cc.p(0,y * range)
    local offset = cc.p(0,viewsize.height - realsize.height - range)
    print("TableViewCtrl1:setProgress",range,viewsize.height,offset.y,realsize.height)
    tmp:setContentOffset(offset,false)
end

function TableViewCtrl1:gotoProgress(range)--0 1.0
    local tmp = self.tableviewctrlptr
    local realsize = tmp:getContentSize()
    local viewsize = tmp:getViewSize()
    local offset = cc.p(0, viewsize.height / 2 - realsize.height * (1 - range))
    if offset.y < (viewsize.height - realsize.height) then
        offset.y = viewsize.height - realsize.height
    end
    if offset.y > 0 then
        offset.y = 0
    end
    tmp:setContentOffset(offset)
end

function TableViewCtrl1:isTouchMoved()
    return self.tableviewctrlptr:isTouchMoved()
end
function TableViewCtrl1:setoneclipespritecoorder()
    if self.oneclipesprite then
        if self.tableviewctrlptr:getDirection() == cc.SCROLLVIEW_DIRECTION_VERTICAL then
            local tmpa = self.oneclipesize[1] or 0
            local tmpb = self.oneclipesize[2] or self:getContentSize().width
            self.oneclipesprite:setAnchorPoint(cc.p(0, 1))
            self.oneclipesprite:setPosition(cc.p(tmpa, self:getContentSize().height))
            self.oneclipesprite:setScaleX(tmpb)
        elseif self.tableviewctrlptr:getDirection() == cc.SCROLLVIEW_DIRECTION_HORIZONTAL then
            local tmpa = self.oneclipesize[1] or 0
            local tmpb = self.oneclipesize[2] or self:getContentSize().height
            self.oneclipesprite:setAnchorPoint(cc.p(0, 0))
            self.oneclipesprite:setPosition(cc.p(0, tmpa))
            self.oneclipesprite:setScaleY(tmpb)
        end
    end
end

function TableViewCtrl1:settwoclipespritecoorder()
    if self.twoclipesprite then
        if self.tableviewctrlptr:getDirection() == cc.SCROLLVIEW_DIRECTION_VERTICAL then
            local tmpa = self.oneclipesize[1] or 0
            local tmpb = self.oneclipesize[2] or self:getContentSize().width
            self.twoclipesprite:setAnchorPoint(cc.p(0, 0))
            self.twoclipesprite:setPosition(cc.p(tmpa, 0))
            self.twoclipesprite:setScaleX(tmpb)
        elseif self.tableviewctrlptr:getDirection() == cc.SCROLLVIEW_DIRECTION_HORIZONTAL then
            local tmpa = self.oneclipesize[1] or 0
            local tmpb = self.oneclipesize[2] or self:getContentSize().height
            self.twoclipesprite:setAnchorPoint(cc.p(1, 0))
            self.twoclipesprite:setPosition(cc.p(self:getContentSize().width, tmpa))
            self.twoclipesprite:setScaleY(tmpb)
        end
    end
end

function TableViewCtrl1:addoneclipesprite(filename, a, b)
    if self.oneclipesprite then
        self.oneclipesprite:removeFromParent()
        self.oneclipesprite = nil
    end
    self.oneclipesprite = cc.Sprite:create(filename)
    self:addChild(self.oneclipesprite, 1)
    self.oneclipesprite:setVisible(false)
    self.oneclipesize = {a, b}
    self:setoneclipespritecoorder()
end

function TableViewCtrl1:addtwoclipesprite(filename, a, b)
    if self.twoclipesprite then
        self.twoclipesprite:removeFromParent()
        self.twoclipesprite = nil
    end
    self.twoclipesprite = cc.Sprite:create(filename)
    self:addChild(self.twoclipesprite, 1)
    self.twoclipesprite:setVisible(false)
    self.twoclipesize = {a, b}
    self:settwoclipespritecoorder()
end
--endregion


--endregion
