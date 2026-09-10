-- Создание UI для ввода ключа
local CoreGui = gethui and gethui() or game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "KneoKeySystem"

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
TextBox.PlaceholderText = "Введи ключ..."
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

-- Логика кнопок
GetKeyBtn.MouseButton1Click:Connect(function()
    local link = copyLink()
    if setclipboard and link then
        setclipboard(link)
        GetKeyBtn.Text = "Ссылка скопирована!"
        task.wait(2)
        GetKeyBtn.Text = "Получить ключ"
    end
end)

CheckBtn.MouseButton1Click:Connect(function()
    local key = TextBox.Text
    local isValid = verifyKey(key)
    
    if isValid then
        CheckBtn.Text = "Успешно!"
        task.wait(1)
        ScreenGui:Destroy()
        -- Твой основной код скрипта после успешной проверки
        print("Ключ принят, скрипт запущен!")
    else
        CheckBtn.Text = "Неверный ключ!"
        task.wait(1.5)
        CheckBtn.Text = "Проверить"
    end
end)
