
local xiaoshuo = {}

function downurl(str, callfun)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", str)
    local function downok() 
        --print("down result:", xhr.succeed, xhr.response)
        --if xhr.succeed then
            local response = xhr.response
            callfun(response)
        --else
        --end
    end
    xhr:registerScriptHandler(downok)
    xhr:send()
end

local function inputurlpathdlg()
	local layer = cc.LayerColor:create(cc.c4b(62,71,193,255),game_width,game_height)
	layer:setAnchorPoint(cc.p(0, 0))
	layer:setPosition(cc.p(0, 0))
    
    local editboxusername = cc.EditBox:create(cc.size(372,30),cc.Scale9Sprite:create("src/empty.png"))
    editboxusername:setFontName(FONTLABEL)
    editboxusername:setFontSize(22)
    editboxusername:setMaxLength(96)
    editboxusername:setReturnType(cc.KEYBOARD_RETURNTYPE_GO)
    editboxusername:setText("http://www.biquge.la/book/14/")
    fullscreenposition.set(editboxusername, 50, 30)
    layer:addChild(editboxusername)

    
    local c = checkbox1:create(cc.Label:createWithTTF("loadurl", "res/fonts/Marker Felt.ttf", 30), cc.Label:createWithTTF("loadurl", "res/fonts/Marker Felt.ttf", 28), function()
        local str = editboxusername:getText()
        print("url:", str)
        downurl(str, function(response)
--            print("html content:", response)
--            local lab = cc.Label:create(response, "src/yu.ttf", 20, cc.size(game_width, 0))
--            fullscreenposition.set(lab, 0, 0)
--            layer:addChild(lab, 10)
            local ff = my.FileUnit:new("hh.txt")
            ff:clear()
            ff:setbaseurl(str)
            local _, _, tt = string.find(response, "<meta name=\"keywords\" content=\"([^<]*)\" />")
            tt = tt or ""
            print(tt)
            tt = GBKToUTF8(tt)
            print(tt)
            --tt = "123324"
            ff:settitle(tt)
            local lasttitle = nil
            --local f = assert(io.open("C:/111.txt", 'w'))
            for w in string.gmatch(response, "<dd>.-</dd>") do
                local _, _, html, title = string.find(w, "<dd><a href=\"(.*)\">(.*)</a></dd>")
                if html and title then
                    title = GBKToUTF8(title)
                    --print("partern:", w, html, title)
                    --f:write(html .. "  " .. title .. "\n")
                    lasttitle = title
                    ff:addrow(title, html, "")
                end
            end
            --f:close()
            local lab = cc.Label:createWithTTF(lasttitle, "src/yu.ttf", 20)
            fullscreenposition.set(lab, 100, 100)
            layer:addChild(lab, 10)
            ff:savedata()
            ff:destroy()
        end)
    end)
    fullscreenposition.set(c, 100, 200)
    layer:addChild(c)
    return layer
end
xiaoshuo.inputurlpathdlg = inputurlpathdlg








return xiaoshuo