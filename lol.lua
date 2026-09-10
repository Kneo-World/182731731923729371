-------------------------------------------------------------------------------
--! json library6767
--! cryptography library
local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;
local lEncode, lDecode, lDigest = a3, aw, Z;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--! platoboost / platorelay / lootlabs library
-------------------------------------------------------------------------------

--! configuration
local service = 31477;
local secret  = "534d5db1-1fd4-4e5b-bd27-8b1fe2eea3c0";
local useNonce = true;

--! LootLabs
local LOOTLABS_API_KEY = "4ec5ac1242349b71b7f7b623f464a1b4604d4e2c5bb1e474bc12956ee6bd12da";
local LOOTLABS_ENDPOINT = "https://creators.lootlabs.gg/api/public/content_locker";

--! callbacks
local onMessage = function(message)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Kneo Keysystem",
            Text  = tostring(message),
            Duration = 5,
        })
    end)
    print("[Kneo] " .. tostring(message))
end

--! wait for game
repeat task.wait(0.2) until game:IsLoaded();

--! executor funcs
local fSetClipboard = setclipboard or toclipboard or (syn and syn.setclipboard)
local fRequest      = request or http_request or (syn and syn.request) or (http and http.request)
local fStringChar   = string.char
local fToString     = tostring
local fOsTime       = os.time
local fMathRandom   = math.random
local fMathFloor    = math.floor
local fGetHwid      = gethwid or function()
    return game:GetService("Players").LocalPlayer.UserId
end

if not fRequest then
    onMessage("Нет HTTP. Обнови Delta.")
    error("no HTTP")
end

local requestSending = false;

local function safeRequest(opts)
    local ok, res = pcall(fRequest, opts)
    if not ok then return nil, tostring(res) end
    if type(res) ~= "table" then return nil, "empty response" end
    return res, nil
end

--! host
local host = "https://api.platorelay.com"

--! кэш
local cachedLink, cachedTime = "", 0;

function cacheLink()
    if cachedTime + (10 * 60) > fOsTime() and cachedLink ~= "" then
        return true, cachedLink;
    end

    -- ========== ШАГ 1: получить ссылку Platorelay ==========
    local response, err = safeRequest({
        Url = host .. "/public/start",
        Method = "POST",
        Body = lEncode({
            service = service,
            identifier = lDigest(fGetHwid())
        }),
        Headers = { ["Content-Type"] = "application/json" }
    });

    if not response then
        local msg = "Нет связи с Platorelay: " .. tostring(err);
        onMessage(msg);
        return false, msg;
    end

    if response.StatusCode ~= 200 then
        local msg = "Ошибка Platorelay: " .. tostring(response.StatusCode);
        onMessage(msg);
        return false, msg;
    end

    local okDecode, decoded = pcall(lDecode, response.Body);
    if not okDecode or type(decoded) ~= "table" or not decoded.success then
        onMessage("Platorelay вернул не JSON или ошибку.");
        return false, "decode error";
    end

    local platorelayUrl = decoded.data.url;

       -- ========== ШАГ 2: создать LootLabs лочкер ==========
    -- Документация: POST с Authorization: Bearer TOKEN
    -- Response: {"type":"created","message":[{"short":"...","loot_url":"..."}]}
    local lootResponse, lootErr = safeRequest({
        Url = LOOTLABS_ENDPOINT,
        Method = "POST",
        Body = lEncode({
            title = "Kneo Keysystem",       -- max 30 символов
            url = platorelayUrl,             -- куда редиректить
            tier_id = 1,                     -- 1 = Trending & Recommended (1-4)
            number_of_tasks = 3,             -- 1-5, сколько реклам
            theme = 1                        -- 1 = Classic (1-5)
        }),
        Headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer " .. LOOTLABS_API_KEY
        }
    });

    if not lootResponse then
        local msg = "LootLabs недоступен: " .. tostring(lootErr);
        onMessage(msg);
        return false, msg;
    end

    -- отладка: показываем полный ответ LootLabs
    onMessage("LootLabs (" .. tostring(lootResponse.StatusCode) .. "): " .. tostring(lootResponse.Body));

    local okLoot, lootDecoded = pcall(lDecode, lootResponse.Body);
    if not okLoot or type(lootDecoded) ~= "table" then
        onMessage("LootLabs вернул не JSON.");
        return false, "lootlabs decode error";
    end

    -- message — это МАССИВ, берём первый элемент [1]
    if lootDecoded.type ~= "created"
        or type(lootDecoded.message) ~= "table"
        or not lootDecoded.message[1]
        or not lootDecoded.message[1].loot_url then

        local errMsg = "unknown"
        if type(lootDecoded.message) == "string" then
            errMsg = lootDecoded.message
        elseif type(lootDecoded.message) == "table" then
            errMsg = lEncode(lootDecoded.message)
        end

        onMessage("LootLabs ошибка: " .. tostring(errMsg));
        return false, "lootlabs error";
    end

    cachedLink = lootDecoded.message[1].loot_url;   -- берём loot_url из первого элемента массива
    cachedTime = fOsTime();

    return true, cachedLink;
end

--! nonce
local generateNonce = function()
    local str = ""
    for _ = 1, 16 do
        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97)
    end
    return str
end

local copyLink = function()
    local success, link = cacheLink();
    if success then
        if fSetClipboard then
            pcall(fSetClipboard, link);
            onMessage("Ссылка скопирована! Открой её в браузере.");
        else
            onMessage("Ссылка: " .. tostring(link));
        end
    end
    return success, link;
end

--! проверка ключа
local verifyKey = function(key)
    if requestSending == true then
        onMessage("Подожди, запрос уже идёт.");
        return false;
    end
    requestSending = true;

    local nonce = generateNonce();
    local endpoint = host .. "/public/whitelist/" .. fToString(service)
        .. "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key;
    if useNonce then endpoint = endpoint .. "&nonce=" .. nonce end

    local response, err = safeRequest({ Url = endpoint, Method = "GET" });
    requestSending = false;

    if not response then
        onMessage("Сеть: " .. tostring(err));
        return false;
    end

    if response.StatusCode == 200 then
        local okDecode, decoded = pcall(lDecode, response.Body);
        if not okDecode then
            onMessage("Не JSON от сервера (код 200)");
            return false;
        end

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true;
                    else
                        onMessage("integrity check failed.");
                        return false;
                    end
                else
                    return true;
                end
            else
                onMessage("Ключ недействителен.");
                return false;
            end
        else
            onMessage(decoded.message or "unknown");
            return false;
        end
    elseif response.StatusCode == 429 then
        onMessage("rate limit.");
        return false;
    else
        onMessage("Статус: " .. tostring(response.StatusCode));
        return false;
    end
end

-------------------------------------------------------------------------------
--! UI
-------------------------------------------------------------------------------

if _G.__PB_UI_OPEN then return end
_G.__PB_UI_OPEN = true

local Players     = game:GetService("Players")
local CoreGui     = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local MAIN_SCRIPT_URL = "https://raw.githubusercontent.com/Kneo-World/1/refs/heads/main/Main.lua"

pcall(function()
    local old = CoreGui:FindFirstChild("PB_KeyUI")
    if old then old:Destroy() end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "PB_KeyUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() gui.Parent = CoreGui end)
if not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 420, 0, 260)
main.Position = UDim2.new(0.5, -210, 0.5, -130)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(80, 80, 120)
stroke.Thickness = 1.5
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🔑  Kneo Keysystem"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = main

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 22)
status.Position = UDim2.new(0, 15, 0, 42)
status.BackgroundTransparency = 1
status.Text = "Введи ключ или получи новый"
status.TextColor3 = Color3.fromRGB(160, 160, 180)
status.Font = Enum.Font.Gotham
status.TextSize = 13
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main

local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -30, 0, 40)
box.Position = UDim2.new(0, 15, 0, 75)
box.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
box.BorderSizePixel = 0
box.Text = ""
box.PlaceholderText = "Вставь свой ключ сюда..."
box.TextColor3 = Color3.fromRGB(240, 240, 240)
box.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
box.Font = Enum.Font.Gotham
box.TextSize = 14
box.ClearTextOnFocus = false
box.Parent = main

Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

local getBtn = Instance.new("TextButton")
getBtn.Size = UDim2.new(1, -30, 0, 38)
getBtn.Position = UDim2.new(0, 15, 0, 125)
getBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 200)
getBtn.BorderSizePixel = 0
getBtn.Text = "📋  Получить ключ (ссылка в буфер)"
getBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getBtn.Font = Enum.Font.GothamSemibold
getBtn.TextSize = 14
getBtn.Parent = main

Instance.new("UICorner", getBtn).CornerRadius = UDim.new(0, 8)

local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(1, -30, 0, 45)
verifyBtn.Position = UDim2.new(0, 15, 0, 175)
verifyBtn.BackgroundColor3 = Color3.fromRGB(40, 170, 90)
verifyBtn.BorderSizePixel = 0
verifyBtn.Text = "✅  Проверить ключ и запустить"
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 15
verifyBtn.Parent = main

Instance.new("UICorner", verifyBtn).CornerRadius = UDim.new(0, 8)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = main

Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    _G.__PB_UI_OPEN = false
end)

local hint = Instance.new("TextLabel")
hint.Size = UDim2.new(1, -30, 0, 18)
hint.Position = UDim2.new(0, 15, 1, -22)
hint.BackgroundTransparency = 1
hint.Text = "Ключ действует 1 час · одноразовый"
hint.TextColor3 = Color3.fromRGB(120, 120, 140)
hint.Font = Enum.Font.Gotham
hint.TextSize = 11
hint.TextXAlignment = Enum.TextXAlignment.Right
hint.Parent = main

local function setStatus(text, color)
    status.Text = tostring(text)
    status.TextColor3 = color or Color3.fromRGB(160, 160, 180)
end

getBtn.MouseButton1Click:Connect(function()
    setStatus("Получаю ссылку...", Color3.fromRGB(200, 200, 100))
    local ok, linkOrErr = copyLink()
    if ok then
        setStatus("Ссылка в буфере! Открой её в браузере.", Color3.fromRGB(100, 220, 130))
    else
        setStatus("Ошибка: " .. tostring(linkOrErr), Color3.fromRGB(230, 100, 100))
    end
end)

local loading = false

verifyBtn.MouseButton1Click:Connect(function()
    if loading then return end
    local key = box.Text
    if key == nil or key == "" then
        setStatus("Введи ключ!", Color3.fromRGB(230, 100, 100))
        return
    end

    loading = true
    verifyBtn.Text = "⏳  Проверяю..."
    verifyBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 40)
    setStatus("Проверяю ключ...", Color3.fromRGB(200, 200, 100))

    task.spawn(function()
        local ok, result = pcall(function() return verifyKey(key) end)

        if ok and result == true then
            setStatus("✅ Ключ валиден! Запускаю...", Color3.fromRGB(100, 220, 130))
            verifyBtn.Text = "✅  Загружаю скрипт..."
            verifyBtn.BackgroundColor3 = Color3.fromRGB(40, 170, 90)

            task.wait(0.6)
            gui:Destroy()
            _G.__PB_UI_OPEN = false

            local okLoad, loadErr = pcall(function()
                loadstring(game:HttpGet(MAIN_SCRIPT_URL))()
            end)

            if not okLoad then
                warn("[Kneo] Ошибка загрузки main: " .. tostring(loadErr))
            end
        else
            loading = false
            verifyBtn.Text = "✅  Проверить ключ и запустить"
            verifyBtn.BackgroundColor3 = Color3.fromRGB(40, 170, 90)
            setStatus("❌ Ключ неверный или истёк", Color3.fromRGB(230, 100, 100))
        end
    end)
end)
