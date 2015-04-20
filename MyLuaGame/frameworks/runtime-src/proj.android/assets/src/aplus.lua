
NORMAL = 0
BEGIN = 1
END = 2
WALL = 3
local width = 0
local height = 0
local begin = nil
local endta = nil
local walllist = nil
local jugewalk = function(pos)
	if pos == nil then
		return false
	end
	--print("walk pos  ", pos.x, "----", pos.y)
	--print("jugewalk ", pos.x * width + pos.y, "---", walllist[pos.x * width + pos.y])
	return walllist[pos.x * width + pos.y] ==nil
end
local getarroundpath = function(pos, lias)	
	local pos1
	local pos2
	local pos3
	local pos4
	local pos5
	local pos6
	local pos7
	local pos8
	lias = not not lias
	if pos.x + 1 <= width then
		pos1 = cc.p(pos.x + 1, pos.y)
		pos1.g = pos.g + 10
		pos1.h = math.abs(pos1.x - pos.x) * 10 + math.abs(pos1.y - pos.y) * 10
		pos1.f = pos1.g + pos1.h
		pos1.pre = pos
		--print("find....", pos1.x, pos1.y)
	end
	if pos.y - 1 >= 1 then
		pos2 = cc.p(pos.x, pos.y - 1)
		pos2.g = pos.g + 10
		pos2.h = math.abs(pos2.x - pos.x) * 10 + math.abs(pos2.y - pos.y) * 10
		pos2.f = pos2.g + pos2.h
		pos2.pre = pos
		--print("find....", pos2.x, pos2.y)
	end
	if pos.x - 1 >= 1 then
		pos3 = cc.p(pos.x - 1, pos.y)
		pos3.g = pos.g + 10
		pos3.h = math.abs(pos3.x - pos.x) * 10 + math.abs(pos3.y - pos.y) * 10
		pos3.f = pos3.g + pos3.h
		pos3.pre = pos
		--print("find....", pos3.x, pos3.y)
	end
	if pos.y + 1 <= height then
		pos4 = cc.p(pos.x, pos.y + 1)
		pos4.g = pos.g + 10
		pos4.h = math.abs(pos4.x - pos.x) * 10 + math.abs(pos4.y - pos.y) * 10
		pos4.f = pos4.g + pos4.h
		pos4.pre = pos
		--print("find....", pos4.x, pos4.y)
	end
	if not lias then
		--print("find....", pos1, pos2, pos3, pos4)
		return pos1, pos2, pos3, pos4
	end
	if pos.y + 1 <= height and pos.x + 1 <= width then
		pos5 = cc.p(pos.x + 1, pos.y + 1)
		pos5.g = pos.g + 14
		pos5.h = math.abs(pos5.x - pos.x) * 10 + math.abs(pos5.y - pos.y) * 10
		pos5.f = pos5.g + pos5.h
		pos5.pre = pos
	end
	if pos.y + 1 <= height and pos.x - 1 >= 1 then
		pos6 = cc.p(pos.x - 1, pos.y + 1)
		pos6.g = pos.g + 14
		pos6.h = math.abs(pos6.x - pos.x) * 10 + math.abs(pos6.y - pos.y) * 10
		pos6.f = pos6.g + pos6.h
		pos6.pre = pos
	end
	if pos.y - 1 >= 1 and pos.x + 1 <= width then
		pos7 = cc.p(pos.x + 1, pos.y - 1)
		pos7.g = pos.g + 14
		pos7.h = math.abs(pos7.x - pos.x) * 10 + math.abs(pos7.y - pos.y) * 10
		pos7.f = pos7.g + pos7.h
		pos7.pre = pos
	end
	if pos.y - 1 >= 1 and pos.x - 1 >= 1 then
		pos8 = cc.p(pos.x - 1, pos.y - 1)
		pos8.g = pos.g + 14
		pos8.h = math.abs(pos8.x - pos.x) * 10 + math.abs(pos8.y - pos.y) * 10
		pos8.f = pos8.g + pos8.h
		pos8.pre = pos
	end
	return pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8
end
local function findgoodpath(open)
	local now = open[1]
	local slot = 1
	for k, v in pairs(open) do
		if now.f > v.f then
			now = v
			slot = k
		end
	end
	table.remove(open, slot)
	return now
end
local function jugeinclude(close, pos)
	for k,v in ipairs(close) do
		if v.x == pos.x and v.y == pos.y then
			--if v.f > pos.f then
			--	close[k] = pos
			--end
			return false
		end
	end
	return true
end

calcapluspath = function(w, h, b, e, list)
	width = w
	height = h
	begin = b
	endta = e
	walllist = {}
	for k,v in ipairs(list) do
		walllist[v.x * width + v.y] = 1
	end
	----------------------------------------------
	local open = {}
	local close = {}
	local curpos = cc.p(begin.x, begin.y)
	curpos.g = 0
	curpos.h = 1
	curpos.f = 1
	local res
	table.insert(open, curpos)
	while table.getn(open) > 0 do
		local pos = findgoodpath(open)
		table.insert(close, pos)
		--print("find step ", pos.x, " ", pos.y)
		--local pos1, pos2, pos3, pos4 = getarroundpath(pos)
		local poslist = {getarroundpath(pos, false)}
		for k,v in pairs(poslist) do
			--print("arround pos   ", v.x, "----", v.y)
			if v.x == endta.x and v.y == endta.y then
				res = v
				break
			end
			if jugewalk(v) and jugeinclude(close, v) then
				if jugeinclude(open, v) then
					table.insert(open, v)
				end
			end
		end
	end
	
	local pathlist = {}
	if res ~= nil then
		while res.pre ~= nil do
			table.insert(pathlist, 1, res.pre)
			res = res.pre
		end
	end
	
	return res ~= nil, pathlist
end