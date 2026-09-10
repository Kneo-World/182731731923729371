-- 1. Сюда вставляется вся библиотека Platoboost (которую ты скидывал первым сообщением)
-- ... (весь код шифрования, функции copyLink, verifyKey и т.д.) ...

-- Укажи свои данные из панели Platoboost:
service = 31477
secret = "534d5db1-1fd4-4e5b-bd27-8b1fe2eea3c0" 
useNonce = true

-- 2. Функция уведомлений (под Delta / Synapse / другие эмуляторы)
local function showNotify(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Kneo World | Key System",
        Text = text,
        Duration = 3
    })
end

onMessage = function(message)
    showNotify(message)
end

-- 3. Создание графического интерфейса (UI)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local KeyBox = Instance.new("TextBox")
local BoxCorner = Instance.new("UICorner")
local GetKeyBtn = Instance.new("TextButton")
local GetCorner = Instance.new("UICorner")
local VerifyBtn = Instance.new("TextButton")
local VerifyCorner = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "KneoKeySystem"

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 210)

UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 10)

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Kneo World - Key System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

KeyBox.Parent = MainFrame
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
KeyBox.Position = UDim2.new(0.1, 0, 0, 50)
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Font = Enum.Font.Gotham
KeyBox.PlaceholderText = "Вставь ключ от LootLabs..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14

BoxCorner.Parent = KeyBox
BoxCorner.CornerRadius = UDim.new(0, 6)

GetKeyBtn.Parent = MainFrame
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
GetKeyBtn.Position = UDim2.new(0.1, 0, 0, 100)
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 35)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Text = "Получить ключ"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 13

GetCorner.Parent = GetKeyBtn
GetCorner.CornerRadius = UDim.new(0, 6)

VerifyBtn.Parent = MainFrame
VerifyBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
VerifyBtn.Position = UDim2.new(0.1, 0, 0, 145)
VerifyBtn.Size = UDim2.new(0.8, 0, 0, 35)
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Text = "Проверить ключ"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.TextSize = 13

VerifyCorner.Parent = VerifyBtn
VerifyCorner.CornerRadius = UDim.new(0, 6)

-- 4. Обработка нажатий
GetKeyBtn.MouseButton1Click:Connect(function()
    copyLink() -- Platoboost сам создаст ссылку через LootLabs и кинет её в буфер обмена игрока
    showNotify("Ссылка на LootLabs скопирована в буфер обмена!")
end)

VerifyBtn.MouseButton1Click:Connect(function()
    local userKey = KeyBox.Text
    if userKey == "" then
        showNotify("Поле ввода пустое!")
        return
    end
    
    local isValid = verifyKey(userKey) -- Проверяем ключ через API Platoboost
    
    if isValid then
        showNotify("Ключ подтвержден! Загружаю скрипт...")
        ScreenGui:Destroy() -- Убираем окно с ключом
        
        -- ЗАГРУЖАЕМ ТВОЙ ОСНОВНОЙ СКРИПТ С GITHUB ПОСЛЕ УСПЕШНОЙ ПРОВЕРКИ:
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Kneo-World/1/refs/heads/main/Main.lua"))()
        end)
        
        if not success then
            showNotify("Ошибка запуска Main.lua: " .. tostring(err))
            warn(err)
        end
    else
        showNotify("Неверный ключ или срок его действия истек.")
    end
end)
