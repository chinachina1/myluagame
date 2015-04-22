syn = {}
syn.worklist = {}
local function createsynwork(inputfun, callbackfun)
    local o = {}
    local task = coroutine.create(function()
        local args = {}
        --xpcall(function()
        local res = {inputfun()}
        args = res
        o.param = args
        o.finish = true
        --end, __G__TRACKBACK__)
    end)
    o.handle = task
    o.backfun = callbackfun
    coroutine.resume(task)
    table.insert(syn.worklist, o)
end

local function tick(dt)
    for k,v in ipairs(syn.worklist) do
        if v.finish then
            local fun = v.backfun
            fun(unpack(v.param or {}))
            table.remove(syn.worklist, k)
            break
        end
    end
end

syn.tick = tick
syn.create = createsynwork