xiaoshuoparser = {}

local function changetoutf8(content)
    local _, _, tt = string.find(content, "charset=([^\"]*)")
    print(tt)
    tt = tt or "gbk"
    if tt == "gbk" then
        content = GBKToUTF8(content)
    end
    return content
end

local function biquge(content, isdir)
    if isdir then
        content = changetoutf8(content)
        local xiaoshuotitle = ""
        local xiaoshuozhangjie = {}
        local _, _, tt = string.find(content, "<meta name=\"keywords\" content=\"([^<]*)\" />")
        tt = tt or ""
        --tt = GBKToUTF8(tt)
        --print(tt)
        xiaoshuotitle = tt
        for w in string.gmatch(content, "<dd>.-</dd>") do
            --print(w)
            local _, _, html, title = string.find(w, "<dd><a href=\"(.*)\">(.*)</a></dd>")
            if html and title then
                --title = GBKToUTF8(title)
                table.insert(xiaoshuozhangjie, {title, html})
            end
        end
        return xiaoshuotitle, xiaoshuozhangjie, true
    else
        content = changetoutf8(content)
        local biaoti = ""
        local neirong = ""
        print(content)
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
        local cs, n = string.gsub(cs, "\n+", function(s)
            return "\n"
        end)
        neirong = cs
        return biaoti, neirong, true
    end
end

local function wanmeixiaoshuo(content, isdir)
    if isdir then
        content = changetoutf8(content)
        local xiaoshuotitle = ""
        local xiaoshuozhangjie = {}
        local _, _, tt = string.find(content, "<meta name=\"keywords\" content=\"([^<]*)\" />")
        tt = tt or ""
        --tt = GBKToUTF8(tt)
        xiaoshuotitle = tt
        for w in string.gmatch(content, "href=\".-\" rel=\"bookmark\">.-</a>") do
            --print(w)
            local _, _, html, title = string.find(w, "href=\"(.-)\" rel=\"bookmark\">(.-)</a>")
            --print(html, title)
            if html and title then
                --title = GBKToUTF8(title)
                table.insert(xiaoshuozhangjie, {title, html})
            end
        end
        return xiaoshuotitle, xiaoshuozhangjie, false
    else
        content = changetoutf8(content)
        local biaoti = ""
        local neirong = ""
        local _, _, tt = string.find(content, "<meta name=\"keywords\" content=\"([^<]*)\" />")
        tt = tt or ""
        biaoti = tt
        local _, _, cs = string.find(content, "<div style=\"padding: 15px 0px 0px 0px; width: 336px; float: right;\">  </div>(.*)<div style=\"padding: 0px 0px 0px 10px; width: 336px; float: left;\">")
        cs = cs or ""
        local cs, n = string.gsub(cs, "<p.->", function(s)
            return ""
        end)
        local cs, n = string.gsub(cs, "</p>", function(s)
            return ""
        end)
        local cs, n = string.gsub(cs, "<!%-%-.-%-%->", function(s)
            return ""
        end)
        local cs, n = string.gsub(cs, "&nbsp;", function(s)
            return "\n"
        end)
        local cs, n = string.gsub(cs, "<br />", function(s)
            return " "
        end)
        local cs, n = string.gsub(cs, "\n+", function(s)
            return "\n"
        end)
        neirong = cs
        return biaoti, neirong, false
    end
end

local function deafultweb(content, isdir)
    return biquge(content, isdir)
end

local function parserxiaoshuo(url, content, isdir)
    print(url)
    if string.find(url, "www.biquge") then
        return biquge(content, isdir)
    elseif string.find(url, "wanmeishijiexiaoshuo.org") then
        return wanmeixiaoshuo(content, isdir)
    else
        return deafultweb(content, isdir)
    end
end
xiaoshuoparser.parserxiaoshuo = parserxiaoshuo
