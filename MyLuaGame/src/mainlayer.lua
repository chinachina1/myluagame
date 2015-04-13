require "src/aplus"
require "src/randbat"

mainlayer = {}

local drawpoly = function(beginpoint, width, num)
	local action = 0
	local node = cc.Node:create()
	node:setContentSize(cc.size(width * num, width *num))
	local celllist = {}
	local draw = cc.DrawNode:create()
	for i = 0, num - 1, 1 do
		for j = 0, num - 1, 1 do
			local o = {}
			o.x = i * width
			o.y = j * width
			o.w = width
			o.h = width
			o.xslot = i
			o.yslot = j
			o.slot = o.xslot * num + o.yslot
			o.type = 0--0普通 1绿色
			o.points = {cc.p(o.x + 1, o.y + 1), cc.p(o.x + o.w - 2, o.y + 1), cc.p(o.x + o.w - 2, o.y + o.h - 2), cc.p(o.x + 1, o.y + o.h - 2)}
			o.rect = cc.rect(o.x, o.y, o.w, o.h)
			table.insert(celllist, o)
		end
	end
	
	node:addChild(draw)
	local function resetpoly()
		draw:clear()
		for i = 0, num, 1 do
			draw:drawSegment(cc.p(0, i * width), cc.p(width * num, i * width), 1, cc.c4f(35,97,63,1)) 
			draw:drawSegment(cc.p(i * width, 0), cc.p(i * width, width * num), 1, cc.c4f(35,97,63, 1))
		end
		for k,v in ipairs(celllist) do
			if k ~= -1 then
				if v.type == 0 then
					--print("slot .................",v.points[1].x, v.points[2].x)
					draw:drawPolygon(v.points, table.getn(v.points), cc.c4f(0.5,0.5,0.5,1), 1, cc.c4f(0.5,0.5,0.5,1))
				elseif v.type == 1 then
					draw:drawPolygon(v.points, table.getn(v.points), cc.c4f(1,0,0,1), 1, cc.c4f(1,0,0,1))
				elseif v.type == 2 then
					draw:drawPolygon(v.points, table.getn(v.points), cc.c4f(117,61,45,1), 1, cc.c4f(117,61,45,1))
				elseif v.type == 3 then
					draw:drawPolygon(v.points, table.getn(v.points), cc.c4f(86, 250, 119,1), 1, cc.c4f(86, 250, 119,1))
				elseif v.type == 10 then
					draw:drawPolygon(v.points, table.getn(v.points), cc.c4f(209, 84, 41,1), 1, cc.c4f(209, 84, 41,1))
				else
				
				end
			else
			end
			
		end
	end
	resetpoly()
	local rand = function()
		for m,n in ipairs(celllist) do
				n.type = 2
		end
		local b, e, list = newbat(num, num)
		for k,v in ipairs(list) do
			for m,n in ipairs(celllist) do
				if n.xslot + 1 == v.x and n.yslot + 1 == v.y then
					n.type = 0
				end
			end
		end
		for k,v in ipairs(celllist) do
			if v.xslot + 1 == b.x and v.yslot + 1 == b.y then
				v.type = 1
			end
			if v.xslot + 1 == e.x and v.yslot + 1 == e.y then
				v.type = 3
			end
		end
		resetpoly()
	end
	node.rand = rand
	local reset = function()
		for k,v in ipairs(celllist) do
			v.type = 0
		end
		resetpoly()
		action = 0
	end
	node.reset = reset
	local qiang = function()
		action = 2
	end
	node.qiang = qiang
	local start = function()
		action = 1
	end
	node.start = start
	local target = function()
		action = 3
	end
	node.target = target
	local go = function()
		local w = num
		local h = num
		local b = nil
		local e = nil
		local list = {}
		for k,v in ipairs(celllist) do
			if v.type == 1 then
				local o = {}
				o.x = v.xslot + 1
				o.y = v.yslot + 1
				b = o
			elseif v.type == 3 then
				local o = {}
				o.x = v.xslot + 1
				o.y = v.yslot + 1
				e = o
			elseif v.type == 2 then
				local o = {}
				o.x = v.xslot + 1
				o.y = v.yslot + 1
				table.insert(list, o)
			else
			end
		end
		local res, relist = calcapluspath(w, h, b, e, list)
		print("go res", res)
		for k,v in ipairs(relist) do
			print("res, pos ", v.x, v.y)
		end
		if res then
			--[[local ac = {}
			local delay = cc.DelayTime:create(0.3)
			for k,v in ipairs(relist) do
				table.insert(ac, delay:clone())
				local fun = cc.CallFunc:create(function()
					for m,n in ipairs(celllist) do
						if n.xslot == v.x and n.yslot == v.y then
							n.type = 1
						end
					end
					resetpoly()
				end)
				table.insert(ac, fun)
			end
			node:runAction(cc.Sequence:create(unpack(ac)))--]]
			for k,v in ipairs(relist) do
				--celllist[(v.x - 1) * num + (v.y - 1) + 1].type = 1
				for m,n in ipairs(celllist) do
						if n.xslot == v.x - 1 and n.yslot == v.y - 1 then
							n.type = 10
						end
					end
			end
			resetpoly()
		end
	end
	node.go = go
    local step = function(x, y)
        local xslot = x
        local yslot = y
        local b = nil
        for k,v in ipairs(celllist) do
            if v.type == 1 then
                xslot = v.xslot + xslot
                yslot = v.yslot + yslot
                b = v
                break
            end
        end
        if b == nil then
            return
        end
        for k,v in ipairs(celllist) do
            if v.xslot == xslot and v.yslot == yslot then
                if v.type == 0 then
                    v.type = 1
                    b.type = 0
                    resetpoly()
                end
                break
            end
        end
    end
    local left = function()
        step(-1, 0)
    end
    node.left = left
    local right = function()
        step(1, 0)
    end
    node.right = right
    local up = function()
        step(0, 1)
    end
    node.up = up
    local down = function()
        step(0, -1)
    end
    node.down = down
  local function onTouchBegin(touch,event)
  		local pos = node:convertToNodeSpace(touch:getLocation())
  		local rect = cc.rect(0, 0, node:getContentSize().width, node:getContentSize().height)
  		if cc.rectContainsPoint(rect, pos) then
  				for k,v in ipairs(celllist) do
  					if cc.rectContainsPoint(v.rect, pos) then
  						if v.type == action then
  							v.type = 0
  						else
  							v.type = action
  						end
  					end
  				end
  				resetpoly()
  				return true
  		end
  		
      return false
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
  local eventDispatcher = node:getEventDispatcher()
  eventDispatcher:addEventListenerWithSceneGraphPriority(listener, node)
	return node
end


local create = function()
	local layer = cc.LayerColor:create(cc.c4b(62,71,193,255),game_width,game_height)
	layer:setAnchorPoint(cc.p(0, 0))
	layer:setPosition(cc.p(0, 0))
	
	local num = 20
	local bgnode = drawpoly(cc.p(10, 10), 300 / num, num)
	bgnode:setAnchorPoint(cc.p(0, 0))
	bgnode:setPosition(cc.p(10, 10))
	layer:addChild(bgnode)
	
	local mainmenu = cc.Menu:create()
	local lab = cc.Label:createWithTTF("rand", "res/fonts/Marker Felt.ttf", 20)
	local btn = cc.MenuItemLabel:create(lab)
	btn:setPosition(cc.p(350, 310))
	btn:registerScriptTapHandler(function()
		bgnode.rand()
	end)
	mainmenu:addChild(btn)
	local lab = cc.Label:createWithTTF("reset", "res/fonts/Marker Felt.ttf", 20)
	local btn = cc.MenuItemLabel:create(lab)
	btn:setPosition(cc.p(400, 310))
	btn:registerScriptTapHandler(function()
		bgnode.reset()
	end)
	mainmenu:addChild(btn)
	local lab = cc.Label:createWithTTF("qiang", "res/fonts/Marker Felt.ttf", 20)
	local btn = cc.MenuItemLabel:create(lab)
	btn:setPosition(cc.p(400, 280))
	btn:registerScriptTapHandler(function()
		bgnode.qiang()
	end)
	mainmenu:addChild(btn)
	local lab = cc.Label:createWithTTF("start", "res/fonts/Marker Felt.ttf", 20)
	local btn = cc.MenuItemLabel:create(lab)
	btn:setPosition(cc.p(400, 250))
	btn:registerScriptTapHandler(function()
		bgnode.start()
	end)
	mainmenu:addChild(btn)
	local lab = cc.Label:createWithTTF("target", "res/fonts/Marker Felt.ttf", 20)
	local btn = cc.MenuItemLabel:create(lab)
	btn:setPosition(cc.p(400, 220))
	btn:registerScriptTapHandler(function()
		bgnode.target()
	end)
	mainmenu:addChild(btn)
	local lab = cc.Label:createWithTTF("go", "res/fonts/Marker Felt.ttf", 20)
	local btn = cc.MenuItemLabel:create(lab)
	btn:setPosition(cc.p(400, 190))
	btn:registerScriptTapHandler(function()
		bgnode.go()
	end)
	mainmenu:addChild(btn)
	local lab = cc.Label:createWithTTF("left", "res/fonts/Marker Felt.ttf", 20)
	local btn = cc.MenuItemLabel:create(lab)
	btn:setPosition(cc.p(350, 80))
	btn:registerScriptTapHandler(function()
		bgnode.left()
	end)
	mainmenu:addChild(btn)
	local lab = cc.Label:createWithTTF("right", "res/fonts/Marker Felt.ttf", 20)
	local btn = cc.MenuItemLabel:create(lab)
	btn:setPosition(cc.p(450, 80))
	btn:registerScriptTapHandler(function()
		bgnode.right()
	end)
	mainmenu:addChild(btn)
	local lab = cc.Label:createWithTTF("up", "res/fonts/Marker Felt.ttf", 20)
	local btn = cc.MenuItemLabel:create(lab)
	btn:setPosition(cc.p(400, 130))
	btn:registerScriptTapHandler(function()
		bgnode.up()
	end)
	mainmenu:addChild(btn)
	local lab = cc.Label:createWithTTF("down", "res/fonts/Marker Felt.ttf", 20)
	local btn = cc.MenuItemLabel:create(lab)
	btn:setPosition(cc.p(400, 30))
	btn:registerScriptTapHandler(function()
		bgnode.down()
	end)
	mainmenu:addChild(btn)
	mainmenu:setAnchorPoint(cc.p(0, 0))
	mainmenu:setPosition(cc.p(0, 0))
	layer:addChild(mainmenu)
	return layer
end

mainlayer.create = create