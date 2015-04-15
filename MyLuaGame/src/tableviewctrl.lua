--region tableviewctrl.lua
--Author : 张文天
--Date   : 2014/6/14
--此文件由[BabeLua]插件自动生成

--tableview

TableViewCtrl = class("TableViewCtrl")
TableViewCtrl.__index = TableViewCtrl

TableViewCtrl.nodelist = {}
local _oldsetControlSize = nil
TableViewCtrl.tableviewctrlptr = nil
TableViewCtrl.needreload = false
TableViewCtrl.clickcallback = nil
TableViewCtrl.multiclick = true

TableViewCtrl.dotouchevent = false

function TableViewCtrl.extend(target)
    _oldsetControlSize = target.setContentSize
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target,t)
    end
    setmetatable(t,TableViewCtrl)
    return target
end

function TableViewCtrl.scrollViewDidScroll(view)
end

function TableViewCtrl.scrollViewDidZoom(view)
end

function TableViewCtrl.tableCellTouched(table1,cell)
    local idx = cell:getIdx()
    local tableview = table1.ctrldata
    if not tableview.dotouchevent then
        tableview.dotouchevent = true
        local callfun = tableview.clickcallback
        if callfun then
            if tableview.multiclick then
                tableview.nodelist[idx + 1].click = not tableview.nodelist[idx + 1].click
                callfun(tableview.nodelist[idx + 1],tableview.nodelist[idx + 1].click,idx + 1)
            else
                for i,v in pairs(tableview.nodelist) do
                    if i == (idx + 1) then
                        --if not v.click then
                            --print("table:" .. tostring(i) .. "click")
                            v.click = true
                            callfun(v,true,i)      
                        --end              
                    else
                        if v.click then
                            --print("table:" .. tostring(i) .. "no click")
                            v.click = false
                            callfun(v,false,i)  
                        end
                    end
                end
            end
            --print("\n")
        end
    end
    tableview.dotouchevent = false
end

function TableViewCtrl.cellSizeForTable(table1,idx)
    local tb = table1.ctrldata.nodelist
    local node = tb[idx + 1]
    local size = cc.size(1,1)
    if node then
        size = node:getContentSize()
    end
    --print("width:" .. tostring(size.width) .. "height:" .. tostring(size.height))
    --print("table size",idx,size.height,size.width)
    return size.height,size.width
end

function TableViewCtrl.tableCellAtIndex(table1,idx)
    --cell = table1.ctrldata:getCell(idx)
    local node = table1.ctrldata:getNode(idx)
    local cell = table1:dequeueCell()
    if not cell then
        cell = cc.TableViewCell:new()
        if node then
            node:removeFromParent()
            cell:addChild(node)
        end
    else
        cell:removeAllChildren()
        if node then
            node:removeFromParent()
            cell:addChild(node)
        end
    end
    --print("table cell",cell,idx)
    return cell
end

function TableViewCtrl.numberOfCellsInTableView(table1)
    local tb = table1.ctrldata.nodelist
    local cnt = table.getn(tb)
    --print("table cnt",cnt)
    return cnt
end

function TableViewCtrl:init(flag)
    local tableView = cc.TableView:create(self:getContentSize())
    tableView.ctrldata = self
    self.tableviewctrlptr = tableView
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:setPosition(cc.p(0,0))
    tableView:setAnchorPoint(cc.p(0,0))
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self:addChild(tableView)
    tableView:registerScriptHandler(TableViewCtrl.scrollViewDidScroll,cc.SCROLLVIEW_SCRIPT_SCROLL)
    tableView:registerScriptHandler(TableViewCtrl.scrollViewDidZoom,cc.SCROLLVIEW_SCRIPT_ZOOM)
    tableView:registerScriptHandler(TableViewCtrl.tableCellTouched,cc.TABLECELL_TOUCHED)
    tableView:registerScriptHandler(TableViewCtrl.cellSizeForTable,cc.TABLECELL_SIZE_FOR_INDEX)
    tableView:registerScriptHandler(TableViewCtrl.tableCellAtIndex,cc.TABLECELL_SIZE_AT_INDEX)
    tableView:registerScriptHandler(TableViewCtrl.numberOfCellsInTableView,cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
    --if flag then
        tableView:reloadData()
    --end

    self:setProgress(0)
    --local ttfConfig = {}
    --ttfConfig.fontFilePath = "res/fonts/fzkt.ttf"
    --ttfConfig.fontSize = 30
    --local label1 = cc.Label:createWithTTF(ttfConfig,"123456")
    --self:addChild(label1)
    return true
end

function TableViewCtrl:create(nodelist)
    local layer = TableViewCtrl.extend(cc.Layer:create())
    if nil ~= layer then
        if nodelist then
            for i,v in pairs(nodelist) do
                v:retain()
                v:setAnchorPoint(cc.p(0,0))
                v:setPosition(cc.p(0,0))
                v.click = false
            end
            layer.nodelist = nodelist
        else
            layer.nodelist = {}
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
            for i,v in pairs(layer.nodelist) do
                v:release()
            end
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

function TableViewCtrl:getNode(idx)
    local tmp = self.nodelist[idx + 1]
    --print(type(tmp))
    return tmp
end

function TableViewCtrl:setContentSize(size)
    _oldsetControlSize(self,size)
    local tmpsize = self:getContentSize()
    local tmp = self.tableviewctrlptr
    tmp:setViewSize(size)
    tmp:reloadData()
    self:setScrollBgSize(self:getContentSize())
    self:setoneclipespritecoorder()
    self:settwoclipespritecoorder()
end

function TableViewCtrl:reloadData()
    local tmp = self.tableviewctrlptr
    tmp:reloadData()
end

function TableViewCtrl:setScroll(filename1,xoffset1,filename2,xoffset2)
end

function TableViewCtrl:addCell(node)
    if node then
        node:retain()
        node:setAnchorPoint(cc.p(0,0))
        node:setPosition(cc.p(0,0))
        node.click = false
        table.insert(self.nodelist,node)
    end
end

function TableViewCtrl:removeCell(idx)
    local node = table.remove(self.nodelist,idx)
    if node then
        node:release()
    end
end

function TableViewCtrl:removeallCell()
    while table.getn(self.nodelist) ~= 0 do
        local node = table.remove(self.nodelist)
        if node then
            node:release()
        end
    end
end

function TableViewCtrl:insertCell(node,idx)
    if node then
        node:retain()
        node:setAnchorPoint(cc.p(0,0))
        node:setPosition(cc.p(0,0))
        node.click = false
        table.insert(self.nodelist,idx,node)
    end
end

function TableViewCtrl:setScrollBgSize(size)
end

function TableViewCtrl:getProgress()
    local tmp = self.tableviewctrlptr
    local realsize = tmp:getContentSize()
    local viewsize = tmp:getViewSize()
    local offset = tmp:getContentOffset()
    --local range = offset.y / (viewsize.height - realsize.height)
    local range = viewsize.height - offset.y - realsize.height
    return range
end

function TableViewCtrl:setProgress(range)
    local tmp = self.tableviewctrlptr
    local realsize = tmp:getContentSize()
    local viewsize = tmp:getViewSize()
    --local y = viewsize.height - realsize.height
    --local offset = cc.p(0,y * range)
    local offset = cc.p(0,viewsize.height - realsize.height - range)
    tmp:setContentOffset(offset)
end

function TableViewCtrl:gotoProgress(range)--0 1.0
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

function TableViewCtrl:isTouchMoved()
    return self.tableviewctrlptr:isTouchMoved()
end

function TableViewCtrl:setoneclipespritecoorder()
end

function TableViewCtrl:settwoclipespritecoorder()
end

function TableViewCtrl:addoneclipesprite(filename, a, b)
end

function TableViewCtrl:addtwoclipesprite(filename, a, b)
end
--endregion
