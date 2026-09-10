local CoreGui = game:GetService("CoreGui")

-- 1. Подключение библиотеки Panda Auth
local PUSL = loadstring(game:HttpGet("https://secure.pandauth.com/pv4/lib"))()
if not PUSL or type(PUSL.configure) ~= "function" then
    return warn("[Panda] Ошибка загрузки библиотеки Panda Auth.")
end

PUSL.configure({
    serviceId = "kneoscript",
})

local MAIN_SCRIPT_URL = "https://raw.githubusercontent.com/Kneo-World/1/refs/heads/main/Main.lua"
local SAVE_FILE = "KneoPandaKey.txt"

-- Автопроверка, если ключ уже сохранялся ранее
if isfile and readfile and isfile(SAVE_FILE) then
    local savedKey = readfile(SAVE_FILE)
    local result = PUSL.validate(savedKey)
    if result and result.success then
        print("[Kneo Script] Ключ авторизван! Запуск Main.lua...")
        loadstring(game:HttpGet(MAIN_SCRIPT_URL))()
        return
    end
end

-- 2. Интерфейс ввода ключа
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "KneoPandaKeySystem"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 340, 0, 190)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -95)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "🔑 Kneo Script - Key System (2 Hours)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold

local TextBox = Instance.new("TextBox", MainFrame)
TextBox.Size = UDim2.new(0.8, 0, 0, 35)
TextBox.Position = UDim2.new(0.1, 0, 0.3, 0)
TextBox.PlaceholderText = "Введи ключ сюда..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TextBox.TextSize = 14
TextBox.Font = Enum.Font.Gotham

local BoxCorner = Instance.new("UICorner", TextBox)
BoxCorner.CornerRadius = UDim.new(0, 6)

local CheckButton = Instance.new("TextButton", MainFrame)
CheckButton.Size = UDim2.new(0.38, 0, 0, 35)
CheckButton.Position = UDim2.new(0.1, 0, 0.65, 0)
CheckButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
CheckButton.Text = "Проверить"
CheckButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckButton.Font = Enum.Font.GothamBold
CheckButton.TextSize = 14

local CheckCorner = Instance.new("UICorner", CheckButton)
CheckCorner.CornerRadius = UDim.new(0, 6)

local GetKeyButton = Instance.new("TextButton", MainFrame)
GetKeyButton.Size = UDim2.new(0.38, 0, 0, 35)
GetKeyButton.Position = UDim2.new(0.52, 0, 0.65, 0)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
GetKeyButton.Text = "Получить ключ"
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.TextSize = 14

local GetKeyCorner = Instance.new("UICorner", GetKeyButton)
GetKeyCorner.CornerRadius = UDim.new(0, 6)

-- 3. Логика работы
GetKeyButton.MouseButton1Click:Connect(function()
    local keyUrl = PUSL.getKeyUrl()
    if setclipboard then
        setclipboard(keyUrl)
        GetKeyButton.Text = "Ссылка скопирована!"
        task.wait(2)
        GetKeyButton.Text = "Получить ключ"
    end
end)

CheckButton.MouseButton1Click:Connect(function()
    local userKey = TextBox.Text:gsub("^%s*(.-)%s*$", "%1")
    if userKey == "" then
        CheckButton.Text = "Введи ключ!"
        task.wait(1.5)
        CheckButton.Text = "Проверить"
        return
    end
    
    CheckButton.Text = "Проверка..."
    local result = PUSL.validate(userKey)
    
    if result and result.success then
        CheckButton.Text = "Успешно!"
        
        if writefile then
            pcall(function() writefile(SAVE_FILE, userKey) end)
        end
        
        task.wait(1)
        ScreenGui:Destroy()
        
        -- Запуск основного скрипта
        loadstring(game:HttpGet(MAIN_SCRIPT_URL))()
    else
        CheckButton.Text = "Неверный ключ!"
        task.wait(1.5)
        CheckButton.Text = "Проверить"
    end
end)
