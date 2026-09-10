-- Настройки Platoboost
local SERVICE_ID = 31477
local API_KEY = "534d5db1-1fd4-4e5b-bd27-8b1fe2eea3c0"

-- Функция генерации ссылки через API Platoboost
local function getLink()
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    local url = "https://api.platoboost.com/public/start?serviceId=31477&identifier=" .. game:GetService("HttpService"):UrlEncode(hwid)
    
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success then
        local data = game:GetService("HttpService"):JSONDecode(response)
        -- Платобуст возвращает ссылку в поле data.url или data.link
        if data and (data.url or data.link) then
            return data.url or data.link
        end
    end
    
    -- Если API не ответило, возвращаем прямую ссылку на твой сервис в Platoboost
    return "https://platoboost.com/a/31477"
end

-- Функция проверки ключа через API Platoboost
local function verifyKey(key)
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    local url = "https://api.platoboost.com/public/check?serviceId=" .. SERVICE_ID .. "&key=" .. key .. "&identifier=" .. hwid
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if success then
        local data = game:GetService("HttpService"):JSONDecode(response)
        if data and data.success then
            return true
        end
    end
    return false
end

-- Создание UI
local CoreGui = gethui and gethui() or game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "PlatoboostKeySystem"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 320, 0, 180)
Frame.Position = UDim2.new(0.5, -160, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0

local Corner = Instance.new("UICorner", Frame)
Corner.CornerRadius = UDim.new(0, 8)

local TextBox = Instance.new("TextBox", Frame)
TextBox.Size = UDim2.new(0.8, 0, 0, 35)
TextBox.Position = UDim2.new(0.1, 0, 0.3, 0)
TextBox.PlaceholderText = "Введи ключ с LootLabs..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TextBox.TextSize = 14

local BoxCorner = Instance.new("UICorner", TextBox)
BoxCorner.CornerRadius = UDim.new(0, 6)

local CheckBtn = Instance.new("TextButton", Frame)
CheckBtn.Size = UDim2.new(0.38, 0, 0, 35)
CheckBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
CheckBtn.Text = "Проверить"
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.TextSize = 14

local CheckCorner = Instance.new("UICorner", CheckBtn)
CheckCorner.CornerRadius = UDim.new(0, 6)

local GetKeyBtn = Instance.new("TextButton", Frame)
GetKeyBtn.Size = UDim2.new(0.38, 0, 0, 35)
GetKeyBtn.Position = UDim2.new(0.52, 0, 0.65, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
GetKeyBtn.Text = "Получить ключ"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 14

local GetKeyCorner = Instance.new("UICorner", GetKeyBtn)
GetKeyCorner.CornerRadius = UDim.new(0, 6)

-- Обработка кнопок
GetKeyBtn.MouseButton1Click:Connect(function()
    local link = getLink()
    if setclipboard then
        setclipboard(link)
        GetKeyBtn.Text = "Ссылка скопирована!"
        task.wait(2)
        GetKeyBtn.Text = "Получить ключ"
    end
end)

CheckBtn.MouseButton1Click:Connect(function()
    local key = TextBox.Text
    if verifyKey(key) then
        CheckBtn.Text = "Успешно!"
        task.wait(1)
        ScreenGui:Destroy()
        -- Запуск твоего основного скрипта
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Kneo-World/1/refs/heads/main/Main.lua"))()
    else
        CheckBtn.Text = "Неверный ключ!"
        task.wait(1.5)
        CheckBtn.Text = "Проверить"
    end
end)
