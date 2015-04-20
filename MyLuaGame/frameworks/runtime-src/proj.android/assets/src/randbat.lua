
math.randomseed(os.time())
local w = 0
local h = 0
local list = {}
local getindex = function(x, y)
	return x + (y - 1) * h
end
local getarroundpos = function(pos)
	local temp = {}
	if pos.x + 1 <= w then
		table.insert(temp, list[getindex(pos.x + 1, pos.y)])
	end
	if pos.x - 1 >= 1 then
		table.insert(temp, list[getindex(pos.x - 1, pos.y)])
	end
	if pos.y + 1 <= h then
		table.insert(temp, list[getindex(pos.x, pos.y + 1)])
	end
	if pos.y - 1 >= 1 then
		table.insert(temp, list[getindex(pos.x, pos.y - 1)])
	end
	return temp
end
local getrand = function(max)
    local r = math.random(1, max)
	return r
end
local adddegree = function(b, e, list)
    b.wall = 0
    e.wall = 0
    local function dowork(pos)
        pos.wall = 2
        local bb = pos
        local flag = true
        while flag do
            local child = getarroundpos(bb)
            for i = table.getn(child), 1, -1 do
                local v = child[i]
                if v.wall == 0 or v.wall == 2 then
                    table.remove(child, i)
                else
                    local temp = getarroundpos(v)
                    local num = 0
                    for m, n in ipairs(temp) do
                        if n.wall == 0 or n.wall == 2 then
                            num = num + 1
                        end
                    end
                    if num > 1 then
                        table.remove(child, i)
                    end
                end
            end
            if table.getn(child) > 0 then
                bb = child[getrand(table.getn(child))]
                bb.wall = 2
            else
                flag = false
                break
            end
        end
    end
    for k,v in ipairs(list) do
        local child = getarroundpos(v)
        local num = 0
        for m,n in pairs(child) do
            if n.wall == 0 or n.wall == 2 then
                num = num + 1
            end
        end
        if num == 2 then
            for m,n in pairs(child) do
                if n.wall ~= 0 and n.wall ~= 2 then
                    local temp = getarroundpos(n)
                    local num = 0
                    for p, q in ipairs(temp) do
                        if q.wall == 0 or q.wall == 2 then
                            num = num + 1
                        end
                    end
                    if num == 1 then
                        dowork(n)
                    end
                end
            end
        end
    end
    for k,v in ipairs(list) do
        if v.wall == 2 then
            v.wall = 0
        end
    end
end
newbat = function(w1, h1)
    w = w1
    h = h1
	local begin = cc.p(1, 1)
	local beginend = cc.p(w, h)
	list = {}
	for i = 1, h, 1 do
		for j = 1, w, 1 do
			local temp = 0
			if i == 1 or i == h then
				temp = temp + 1
			end
			if j == 1 or j == w then
				temp = temp + 1
			end
			table.insert(list, {x = j, y = i, wall = 1, visit = temp})
		end
	end
	local bb = list[getindex(begin.x, begin.y)]
	bb.wall = 0
	bb.visit = bb.visit + 1
    local flag = true
	while flag do
		if bb.x == beginend.x and bb.y == beginend.y then
            flag = false
			break
		end
		--print("parent--",bb.x, "---", bb.y)
		local temp = getarroundpos(bb)
		for i = table.getn(temp), 1 , -1 do
			local v = temp[i]
			--print("arround---", v.x, "----", v.y)
			if v.wall == 0 or v.visit == 5 then
				table.remove(temp, i)
            else
			    local arr = getarroundpos(v)
			    local num = 0
			    for m,n in pairs(arr) do
                    --print("arround arround---", n.x, "----", n.y, "---------", n.wall)
				    if n.wall == 0 then
					    num = num + 1
				    end
			    end
			    if num > 1 then
				    table.remove(temp, i)
			    end
			end
		end
        --print("parent count--",table.getn(temp))
		if table.getn(temp) > 0 then
			local pre = bb
			bb = temp[getrand(table.getn(temp))]
			bb.wall = 0
			bb.visit = bb.visit + 1
			bb.pre = pre
		else
			if bb.pre then
				bb.wall = 1
				bb.visit = 5
				bb = bb.pre
				bb.visit = bb.visit + 1
			else
                flag = false
				break
			end
		end
	end
    adddegree(begin, beginend, list)
	local res = {}
	for k,v in pairs(list) do
		if v.wall == 0 then
			table.insert(res, cc.p(v.x, v.y))
		end
	end
--	local pp = bb
--	while pp do
--		table.insert(res, cc.p(pp.x, pp.y))
--        print("res pos-", pp.x, "----", pp.y)
--		pp = pp.pre
--	end

	return begin, beginend, res
end