
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
    needdownqueue[1] = nil
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
        local response = xhr.response
        curdowninfocell.dataoperatefun(xhr, curdowninfocell.title, curdowninfocell.downeventname)
        senddownevent()
        curdowninfocell = nil
        dofirstwork()
    end
    xhr:registerScriptHandler(downok)
    xhr:send()
end

local function addexpresstask(title, url, dataoperafun, downokevent)
    local o = newdowninfocell()
    o.title = title
    o.url = url
    o.dataoperatefun = dataoperafun
    o.downeventname = downokevent
    table.insert(needdownqueue, 1, o)
    dofirstwork()
end

local function addnormaltask(title, url, dataoperafun, downokevent)
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