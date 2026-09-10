-- Защита и подключение Platoboost (вставь свой код библиотеки выше или используй этот шаблон)
-- SERVICE ID и SECRET бери из своего личного кабинета Platoboost
local service = 31477
local secret = "534d5db1-1fd4-4e5b-bd27-8b1fe2eea3c0" 
local useNonce = true

-- Функция уведомлений для Delta
local function showNotify(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Key System",
        Text = text,
        Duration = 3
    })
end

-- Переопределяем callback для сообщений Platoboost
onMessage = function(message)
    showNotify(message)
end

-- Создание простого и красивого UI под Delta
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
ScreenGui.Name = "PlatoKeySystem"

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 210)

UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 10)

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Key System (Platoboost)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

KeyBox.Parent = MainFrame
KeyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
KeyBox.Position = UDim2.new(0.1, 0, 0, 50)
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Font = Enum.Font.Gotham
KeyBox.PlaceholderText = "Вставь ключ сюда..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14

BoxCorner.Parent = KeyBox
BoxCorner.CornerRadius = UDim.new(0, 6)

GetKeyBtn.Parent = MainFrame
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 216)
GetKeyBtn.Position = UDim2.new(0.1, 0, 0, 100)
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 35)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Text = "Получить ссылку (LootLabs)"
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

-- Логика кнопок
GetKeyBtn.MouseButton1Click:Connect(function()
    copyLink() -- Копирует ссылку на прохождение чекпоинта LootLabs в буфер обмена
    showNotify("Ссылка скопирована в буфер обмена!")
end)

VerifyBtn.MouseButton1Click:Connect(function()
    local userKey = KeyBox.Text
    if userKey == "" then
        showNotify("Введи ключ!")
        return
    end
    
    local isValid = verifyKey(userKey)
    if isValid then
        showNotify("Ключ верный! Запуск скрипта...")
        ScreenGui:Destroy() -- Закрываем окно ключа
        
        -- ТВОЙ ОСНОВНОЙ СКРИПТ ПИСАТЬ ЗДЕСЬ:
        print("Скрипт успешно разблокирован!")
        
    else
        showNotify("Неверный ключ или просрочен.")
    end
end)
