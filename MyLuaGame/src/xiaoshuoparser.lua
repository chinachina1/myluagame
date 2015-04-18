xiaoshuoparser = {}

local function biquge(content, isdir)
    if isdir then
        content = GBKToUTF8(content)
        local xiaoshuotitle = ""
        local xiaoshuozhangjie = {}
        local _, _, tt = string.find(content, "<meta name=\"keywords\" content=\"([^<]*)\" />")
        tt = tt or ""
        --tt = GBKToUTF8(tt)
        xiaoshuotitle = tt
        for w in string.gmatch(content, "<dd>.-</dd>") do
            local _, _, html, title = string.find(w, "<dd><a href=\"(.*)\">(.*)</a></dd>")
            if html and title then
                --title = GBKToUTF8(title)
                table.insert(xiaoshuozhangjie, {title, html})
            end
        end
        return xiaoshuotitle, xiaoshuozhangjie
    else
        content = GBKToUTF8(content)
        local biaoti = ""
        local neirong = ""
        local _, _, tt = string.find(content, "<meta name=\"keywords\" content=\"([^<]*)\" />")
        tt = tt or ""
        biaoti = tt
        local _, _, cs = string.find(content, "<div id=\"content\">(.-)</div>")
        cs = cs or ""
        local cs, n = string.gsub(cs, "&nbsp;", function(s)
            return "\n"
        end)
        local cs, n = string.gsub(cs, "<br />", function(s)
            return " "
        end)
        neirong = cs
        return biaoti, neirong
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
