
downmgr = {}
local function newdowninfocell()
    local o = {}
--    o.url
--    o.title
--    o.dataoperatefun
--    o.downeventname
    return o
end
local needdownqueue = {}
local curdowninfocell = nil

local function getfirstjob()
    local cur = needdownqueue[1]
    table.remove(needdownqueue, 1)
    return cur
end

local function senddownevent()
    local event = cc.EventCustom:new("httpdownevent")
    event._usedata = curdowninfocell.downeventname
    g_eventDispatcher:dispatchEvent(event)
end

local function dofirstwork()
    if curdowninfocell then
        return
    end
    local tmpjob = getfirstjob()
    if tmpjob == nil then
        return
    end
    curdowninfocell = tmpjob
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", curdowninfocell.url)
    local function downok() 
        local res = xhr.succeed
        if res == 1 then
            local response = xhr.response
            curdowninfocell.dataoperatefun(xhr, curdowninfocell.title, curdowninfocell.downeventname)
            senddownevent()
            curdowninfocell = nil
            dofirstwork()
        else
            local tttt = curdowninfocell
            curdowninfocell = nil
            table.insert(needdownqueue, tttt)
            print(tttt.url)
            dofirstwork()
        end
    end
    xhr:registerScriptHandler(downok)
    xhr:send()
end

local function istitlerepeat(title)
    if curdowninfocell and curdowninfocell.title == title then
        return true
    end
    for k,v in ipairs(needdownqueue) do
        if v.title == title then
            return true
        end
    end
    return false
end

local function addexpresstask(title, url, dataoperafun, downokevent)--title key
    if istitlerepeat(title) then
        return
    end
    local o = newdowninfocell()
    o.title = title
    o.url = url
    o.dataoperatefun = dataoperafun
    o.downeventname = downokevent
    table.insert(needdownqueue, 1, o)
    dofirstwork()
end

local function addnormaltask(title, url, dataoperafun, downokevent)--title key
    if istitlerepeat(title) then
        return
    end
    local o = newdowninfocell()
    o.title = title
    o.url = url
    o.dataoperatefun = dataoperafun
    o.downeventname = downokevent
    table.insert(needdownqueue, o)
    dofirstwork()
end

downmgr.addexpresstask = addexpresstask
downmgr.addnormaltask = addnormaltask