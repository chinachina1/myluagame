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


TableViewCtrl1.dotouchevent = false


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
end

function TableViewCtrl1:setScrollBgSize(size)
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
end

function TableViewCtrl1:settwoclipespritecoorder()
end

function TableViewCtrl1:addoneclipesprite(filename, a, b)
end

function TableViewCtrl1:addtwoclipesprite(filename, a, b)
end
--endregion


--endregion
