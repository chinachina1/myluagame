xiaoshuoparser = {}

local function biquge(content, isdir)
    if isdir then
        local xiaoshuotitle = ""
        local xiaoshuozhangjie = {}
        local _, _, tt = string.find(response, "<meta name=\"keywords\" content=\"([^<]*)\" />")
        tt = tt or ""
        tt = GBKToUTF8(tt)
        xiaoshuotitle = tt
        for w in string.gmatch(response, "<dd>.-</dd>") do
            local _, _, html, title = string.find(w, "<dd><a href=\"(.*)\">(.*)</a></dd>")
            if html and title then
                title = GBKToUTF8(title)
                table.insert(xiaoshuozhangjie, {title, html})
            end
        end
        return xiaoshuotitle, xiaoshuozhangjie
    else
    end
end

local function deafultweb(content, isdir)
    return biquge(content, isdir)
end

local function parserxiaoshuo(url, content, isdir)
    if string.find(url, "www.biquge") then
        return biquge(content, isdir)
    else
        return deafultweb(content, isdir)
    end
end
xiaoshuoparser.parserxiaoshuo = parserxiaoshuo
