-- ========================================================================
-- ENGINE V3: DYNAMIC SLOTS SYSTEM WITH SLIDERS & DROPDOWNS (MOBILE)
-- ========================================================================

if game.CoreGui:FindFirstChild("HvH_Private_Menu") then
    game.CoreGui["HvH_Private_Menu"]:Destroy()
end

getgenv().Config = {}
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HvH_Private_Menu"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderColor3 = Color3.fromRGB(150, 0, 0) -- ТЁМНО-КРАСНАЯ ОБВОДКА МЕНЮ
MainFrame.Position = UDim2.new(0.15, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 600, 0, 380)
MainFrame.Active = true
MainFrame.Draggable = true

local LeftPanel = Instance.new("Frame")
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
LeftPanel.Size = UDim2.new(0, 140, 1, 0)
LeftPanel.BorderSizePixel = 0

local TabContainer = Instance.new("Frame")
TabContainer.Parent = LeftPanel
TabContainer.Size = UDim2.new(1, 0, 1, 0)
TabContainer.BackgroundTransparency = 1

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabContainer
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 4)

local ScrollContent = Instance.new("ScrollingFrame")
ScrollContent.Parent = MainFrame
ScrollContent.Position = UDim2.new(0, 150, 0, 10)
ScrollContent.Size = UDim2.new(0, 440, 0, 360)
ScrollContent.BackgroundTransparency = 1
ScrollContent.BorderSizePixel = 0
ScrollContent.CanvasSize = UDim2.new(0, 0, 0, 950)

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Parent = ScrollContent
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 8)

-- Кнопка Скрыть/Показать
local ToggleMenuBtn = Instance.new("TextButton")
ToggleMenuBtn.Parent = ScreenGui
ToggleMenuBtn.Position = UDim2.new(0.02, 0, 0.05, 0)
ToggleMenuBtn.Size = UDim2.new(0, 80, 0, 35)
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ToggleMenuBtn.BorderColor3 = Color3.fromRGB(150, 0, 0) -- ТЁМНО-КРАСНАЯ ОБВОДКА КНОПКИ
ToggleMenuBtn.Text = "HvH Menu"
ToggleMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleMenuBtn.Font = Enum.Font.SourceSansBold
ToggleMenuBtn.TextSize = 14
local BtnCorner = Instance.new("UICorner", ToggleMenuBtn)
BtnCorner.CornerRadius = UDim.new(0, 6)

ToggleMenuBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local RegisteredElements = {}
local CreatedTabs = {}

local function BuildCheckbox(tabName, funcName)
    getgenv().Config[funcName] = false
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -15, 0, 45)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
    Frame.BorderSizePixel = 0
    Frame.Visible = false
    local FrameCorner = Instance.new("UICorner", Frame)
    FrameCorner.CornerRadius = UDim.new(0, 6)
    
    local Box = Instance.new("TextButton")
    Box.Size = UDim2.new(0, 26, 0, 26)
    Box.Position = UDim2.new(0, 12, 0, 9)
    Box.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Box.BorderSizePixel = 0
    Box.Text = ""
    Box.Parent = Frame
    local BoxCorner = Instance.new("UICorner", Box)
    BoxCorner.CornerRadius = UDim.new(0, 4)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 50, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = funcName
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 18
    Label.Parent = Frame
    
    if tabName == "AA" then
        local TagLabel = Instance.new("TextLabel")
        TagLabel.Size = UDim2.new(0.3, 0, 1, 0)
        TagLabel.Position = UDim2.new(0.65, 0, 0, 0)
        TagLabel.BackgroundTransparency = 1
        TagLabel.Font = Enum.Font.SourceSansBold
        TagLabel.TextSize = 14
        TagLabel.TextXAlignment = Enum.TextXAlignment.Right
        TagLabel.Parent = Frame
        
        if string.find(funcName, "Visual") then
            TagLabel.Text = "[визуал]"
            TagLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
        else
            TagLabel.Text = "[не визуал]"
            TagLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        end
    end
    
    Box.MouseButton1Click:Connect(function()
        getgenv().Config[funcName] = not getgenv().Config[funcName]
        if getgenv().Config[funcName] then
            Box.BackgroundColor3 = Color3.fromRGB(255, 30, 30) -- ЯРКО-КРАСНЫЙ ЧЕКБОКС
            local Mark = Instance.new("Frame")
            Mark.Name = "Mark"
            Mark.Size = UDim2.new(0, 12, 0, 12)
            Mark.Position = UDim2.new(0, 7, 0, 7)
            Mark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Mark.Parent = Box
            local MarkCorner = Instance.new("UICorner", Mark)
            MarkCorner.CornerRadius = UDim.new(0, 3)
        else
            Box.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            if Box:FindFirstChild("Mark") then Box.Mark:Destroy() end
        end
    end)
    
    if not RegisteredElements[tabName] then RegisteredElements[tabName] = {} end
    table.insert(RegisteredElements[tabName], Frame)
end

local function BuildSlider(tabName, funcName, min, max, default)
    getgenv().Config[funcName] = default
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -15, 0, 50)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
    Frame.BorderSizePixel = 0
    Frame.Visible = false
    local FrameCorner = Instance.new("UICorner", Frame)
    FrameCorner.CornerRadius = UDim.new(0, 6)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 0, 25)
    Label.Position = UDim2.new(0, 12, 0, 2)
    Label.BackgroundTransparency = 1
    Label.Text = funcName
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 16
    Label.Parent = Frame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.2, 0, 0, 25)
    ValueLabel.Position = UDim2.new(0.5, 0, 0, 2)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(255, 30, 30) -- ЦВЕТ ЦИФР ПОЛЗУНКА
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Left
    ValueLabel.Font = Enum.Font.SourceSansBold
    ValueLabel.TextSize = 16
    ValueLabel.Parent = Frame

    if tabName == "AA" then
        local TagLabel = Instance.new("TextLabel")
        TagLabel.Size = UDim2.new(0.3, 0, 0, 25)
        TagLabel.Position = UDim2.new(0.65, 0, 0, 2)
        TagLabel.BackgroundTransparency = 1
        TagLabel.Font = Enum.Font.SourceSansBold
        TagLabel.TextSize = 14
        TagLabel.TextXAlignment = Enum.TextXAlignment.Right
        TagLabel.Parent = Frame
        
        if string.find(funcName, "Visual") then
            TagLabel.Text = "[визуал]"
            TagLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
        else
            TagLabel.Text = "[не визуал]"
            TagLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        end
    end

    local SliderTrack = Instance.new("TextButton")
    SliderTrack.Size = UDim2.new(1, -24, 0, 6)
    SliderTrack.Position = UDim2.new(0, 12, 0, 32)
    SliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    SliderTrack.Text = ""
    SliderTrack.BorderSizePixel = 0
    SliderTrack.Parent = Frame
    local TrackCorner = Instance.new("UICorner", SliderTrack)
    TrackCorner.CornerRadius = UDim.new(0, 3)
    
    local SliderFill = Instance.new("Frame")
    local percent = (default - min) / (max - min)
    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(255, 30, 30) -- КРАСНАЯ ЗАЛИВКА ПОЛЗУНКА
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderTrack
    local FillCorner = Instance.new("UICorner", SliderFill)
    FillCorner.CornerRadius = UDim.new(0, 3)
    
    local function UpdateSlider(input)
        local x = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * x)
        SliderFill.Size = UDim2.new(x, 0, 1, 0)
        ValueLabel.Text = tostring(value)
        getgenv().Config[funcName] = value
    end
    
    local dragging = false
    SliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            UpdateSlider(input)
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input)
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    if not RegisteredElements[tabName] then RegisteredElements[tabName] = {} end
    table.insert(RegisteredElements[tabName], Frame)
end

local function BuildDropdown(tabName, funcName, listOptions)
    getgenv().Config[funcName] = listOptions[1]
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -15, 0, 45)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
    Frame.BorderSizePixel = 0
    Frame.Visible = false
    local FrameCorner = Instance.new("UICorner", Frame)
    FrameCorner.CornerRadius = UDim.new(0, 6)
    Frame.ClipsDescendants = false
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = funcName
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 18
    Label.Parent = Frame
    
    local TriggerBtn = Instance.new("TextButton")
    TriggerBtn.Size = UDim2.new(0.4, 0, 0, 30)
    TriggerBtn.Position = UDim2.new(0.55, 0, 0, 7)
    TriggerBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    TriggerBtn.Text = listOptions[1]
    TriggerBtn.TextColor3 = Color3.fromRGB(255, 30, 30) -- ЦВЕТ ТЕКСТА В ДРОПДАУНЕ
    TriggerBtn.Font = Enum.Font.SourceSansBold
    TriggerBtn.TextSize = 14
    TriggerBtn.Parent = Frame
    local TriggerCorner = Instance.new("UICorner", TriggerBtn)
    TriggerCorner.CornerRadius = UDim.new(0, 4)
    
    local ListContainer = Instance.new("Frame")
    ListContainer.Size = UDim2.new(1, 0, 0, #listOptions * 32)
    ListContainer.Position = UDim2.new(0, 0, 1, 4)
    ListContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
    ListContainer.BorderSizePixel = 1
    ListContainer.BorderColor3 = Color3.fromRGB(150, 0, 0) -- ТЁМНО-КРАСНАЯ ОБВОДКА СПИСКА
    ListContainer.Visible = false
    ListContainer.ZIndex = 5
    ListContainer.Parent = TriggerBtn
    local ListCorner = Instance.new("UICorner", ListContainer)
    ListCorner.CornerRadius = UDim.new(0, 4)
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = ListContainer
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    for i, option in ipairs(listOptions) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.Size = UDim2.new(1, 0, 0, 32)
        OptBtn.BackgroundTransparency = 1
        OptBtn.Text = option
        OptBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        OptBtn.Font = Enum.Font.SourceSans
        OptBtn.TextSize = 16
        OptBtn.ZIndex = 6
        OptBtn.Parent = ListContainer
        
        OptBtn.MouseButton1Click:Connect(function()
            getgenv().Config[funcName] = option
            TriggerBtn.Text = option
            ListContainer.Visible = false
        end)
    end
    
    TriggerBtn.MouseButton1Click:Connect(function()
        ListContainer.Visible = not ListContainer.Visible
    end)
    
    if not RegisteredElements[tabName] then RegisteredElements[tabName] = {} end
    table.insert(RegisteredElements[tabName], Frame)
end

local function CreateTabButton(tabName)
    if CreatedTabs[tabName] then return end
    CreatedTabs[tabName] = true
    
    local TabButton = Instance.new("TextButton")
    TabButton.Name = "Tab_" .. tabName
    TabButton.Size = UDim2.new(1, 0, 0, 45)
    TabButton.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    TabButton.BorderSizePixel = 0
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextSize = 18
    TabButton.Parent = TabContainer
    
    TabButton.MouseButton1Click:Connect(function()
        for _, btn in ipairs(TabContainer:GetChildren()) do
            if btn:IsA("TextButton") then btn.TextColor3 = Color3.fromRGB(150, 150, 150) end
        end
        TabButton.TextColor3 = Color3.fromRGB(255, 30, 30) -- ЦВЕТ АКТИВНОЙ ВКЛАДКИ
        
        for _, obj in ipairs(ScrollContent:GetChildren()) do
            if obj:IsA("Frame") then obj.Parent = nil end
        end
        
        if RegisteredElements[tabName] then
            for _, frame in ipairs(RegisteredElements[tabName]) do
                frame.Parent = ScrollContent
                frame.Visible = true
            end
        end
    end)
end

local Slots = {
    ["ESP_Box"] = function()
        local function CreateBox(player)
            if player == game.Players.LocalPlayer then return end
            local Box = Drawing.new("Square")
            Box.Color = Color3.fromRGB(255, 30, 30) -- Ярко-красный контур
            Box.Thickness = 2
            Box.Filled = false
            Box.Visible = false

            local connection
            connection = game:GetService("RunService").RenderStepped:Connect(function()
                if not getgenv().Config["Box"] then Box.Visible = false return end
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local rhrp = player.Character.HumanoidRootPart
                    local vector, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(rhrp.Position)
                    if onScreen then
                        local sizeX = 1600 / vector.Z
                        local sizeY = 2400 / vector.Z
                        Box.Size = Vector2.new(sizeX, sizeY)
                        Box.Position = Vector2.new(vector.X - sizeX / 2, vector.Y - sizeY / 2)
                        Box.Visible = true
                    else Box.Visible = false end
                else
                    Box.Visible = false
                    if not game.Players:FindFirstChild(player.Name) then Box:Remove() connection:Disconnect() end
                end
            end)
        end
        for _, p in ipairs(game.Players:GetPlayers()) do CreateBox(p) end
        game.Players.PlayerAdded:Connect(CreateBox)
    end, 
    
    ["ESP_FillBox"] = function()
        local function CreateFill(player)
            if player == game.Players.LocalPlayer then return end
            local Fill = Drawing.new("Square")
            Fill.Color = Color3.fromRGB(120, 0, 0) -- Тёмно-красный / Бордовый для заливки
            Fill.Thickness = 0
            Fill.Filled = true
            Fill.Transparency = 0.35 -- Легкая прозрачность, чтобы не перекрывать модельку
            Fill.Visible = false

            local connection
            connection = game:GetService("RunService").RenderStepped:Connect(function()
                if not getgenv().Config["FillBox"] then Fill.Visible = false return end
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local rhrp = player.Character.HumanoidRootPart
                    local vector, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(rhrp.Position)
                    if onScreen then
                        local sizeX = 1600 / vector.Z
                        local sizeY = 2400 / vector.Z
                        Fill.Size = Vector2.new(sizeX, sizeY)
                        Fill.Position = Vector2.new(vector.X - sizeX / 2, vector.Y - sizeY / 2)
                        Fill.Visible = true
                    else Fill.Visible = false end
                else
                    Fill.Visible = false
                    if not game.Players:FindFirstChild(player.Name) then Fill:Remove() connection:Disconnect() end
                end
            end)
        end
        for _, p in ipairs(game.Players:GetPlayers()) do CreateFill(p) end
        game.Players.PlayerAdded:Connect(CreateFill)
    end,
    
    ["ESP_HealthBar"] = function()
        local function CreateHealthBar(player)
            if player == game.Players.LocalPlayer then return end
            local RedBar = Drawing.new("Line")
            RedBar.Thickness = 2
            RedBar.Visible = false

            local connection
            connection = game:GetService("RunService").RenderStepped:Connect(function()
                if not getgenv().Config["HealthBar"] then RedBar.Visible = false return end
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
                    local rhrp = player.Character.HumanoidRootPart
                    local hum = player.Character.Humanoid
                    local vector, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(rhrp.Position)
                    if onScreen and hum.Health > 0 then
                        local sizeY = 2400 / vector.Z
                        local sizeX = 1600 / vector.Z
                        local healthPercent = hum.Health / hum.MaxHealth
                        local barHeight = sizeY * healthPercent
                        local boxLeftX = vector.X - sizeX / 2
                        local boxBottomY = vector.Y + sizeY / 2
                        
                        if getgenv().Config["GradientHP"] then
                            RedBar.Color = Color3.fromHSV(healthPercent * 0.33, 1, 1) -- Стандартный градиент (красно-желто-зеленый)
                        else
                            RedBar.Color = Color3.fromRGB(200, 0, 20) -- Глубокий красный цвет вместо стандартного зелёного
                        end
                        
                        RedBar.From = Vector2.new(boxLeftX - 5, boxBottomY)
                        RedBar.To = Vector2.new(boxLeftX - 5, boxBottomY - barHeight)
                        RedBar.Visible = true
                    else RedBar.Visible = false end
                else
                    RedBar.Visible = false
                    if not game.Players:FindFirstChild(player.Name) then RedBar:Remove() connection:Disconnect() end
                end
            end)
        end
        for _, p in ipairs(game.Players:GetPlayers()) do CreateHealthBar(p) end
        game.Players.PlayerAdded:Connect(CreateHealthBar)
    end,
    
    ["ESP_GradientHP"] = function() end,
    
    ["ESP_Name"] = function()
        local function CreateNameESP(player)
            if player == game.Players.LocalPlayer then return end
            local Text = Drawing.new("Text")
            Text.Color = Color3.fromRGB(255, 120, 120) -- Светло-красный текст для идеальной читаемости
            Text.Size = 16
            Text.Center = true
            Text.Outline = true
            Text.OutlineColor = Color3.fromRGB(30, 0, 0) -- Очень тёмная красная обводка (почти черная)
            Text.Visible = false

            local connection
            connection = game:GetService("RunService").RenderStepped:Connect(function()
                if not getgenv().Config["Name"] then Text.Visible = false return end
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local rhrp = player.Character.HumanoidRootPart
                    local vector, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(rhrp.Position)
                    if onScreen then
                        local sizeY = 3000 / vector.Z
                        Text.Position = Vector2.new(vector.X, (vector.Y - sizeY / 2) - 20)
                        Text.Text = player.Name
                        Text.Visible = true
                    else Text.Visible = false end
                else
                    Text.Visible = false
                    if not game.Players:FindFirstChild(player.Name) then Text:Remove() connection:Disconnect() end
                end
            end)
        end
        for _, p in ipairs(game.Players:GetPlayers()) do CreateNameESP(p) end
        game.Players.PlayerAdded:Connect(CreateNameESP)
    end,
    
    ["ESP_Tracers"] = function()
        local function CreateTracer(player)
            if player == game.Players.LocalPlayer then return end
            local Line = Drawing.new("Line")
            Line.Color = Color3.fromRGB(150, 0, 0) -- Тёмно-красные линии (не режут глаза)
            Line.Thickness = 1.5
            Line.Visible = false

            local connection
            connection = game:GetService("RunService").RenderStepped:Connect(function()
                if not getgenv().Config["Tracers"] then Line.Visible = false return end
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local rhrp = player.Character.HumanoidRootPart
                    local vector, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(rhrp.Position)
                    if onScreen then
                        local cam = game.Workspace.CurrentCamera
                        Line.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                        Line.To = Vector2.new(vector.X, vector.Y)
                        Line.Visible = true
                    else Line.Visible = false end
                else
                    Line.Visible = false
                    if not game.Players:FindFirstChild(player.Name) then Line:Remove() connection:Disconnect() end
                end
            end)
        end
        for _, p in ipairs(game.Players:GetPlayers()) do CreateTracer(p) end
        game.Players.PlayerAdded:Connect(CreateTracer)
    end,

    ["ESP_Skeleton"] = function()
        local Players = game:GetService("Players")
        local Camera = workspace.CurrentCamera
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer

        local BonePairs = {
            {"Head", "UpperTorso"},
            {"UpperTorso", "LowerTorso"},
            {"UpperTorso", "LeftUpperArm"},
            {"LeftUpperArm", "LeftLowerArm"},
            {"LeftLowerArm", "LeftHand"},
            {"UpperTorso", "RightUpperArm"},
            {"RightUpperArm", "RightLowerArm"},
            {"RightLowerArm", "RightHand"},
            {"LowerTorso", "LeftUpperLeg"},
            {"LeftUpperLeg", "LeftLowerLeg"},
            {"LeftLowerLeg", "LeftFoot"},
            {"LowerTorso", "RightUpperLeg"},
            {"RightUpperLeg", "RightLowerLeg"},
            {"RightLowerLeg", "RightFoot"}
        }

        local function CreateSkeleton(player)
            if player == LocalPlayer then return end
            
            local Lines = {}
            for i = 1, #BonePairs do
                local line = Drawing.new("Line")
                line.Color = Color3.fromRGB(255, 255, 255) -- Специально оставлен Белым
                line.Thickness = 1.5
                line.Transparency = 1
                line.Visible = false
                table.insert(Lines, line)
            end

            local connection
            connection = RunService.RenderStepped:Connect(function()
                if not getgenv().Config["Skeleton"] then
                    for _, line in ipairs(Lines) do line.Visible = false end
                    return
                end

                local char = player.Character
                if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                    for id, pair in ipairs(BonePairs) do
                        local partA = char:FindFirstChild(pair[1])
                        local partB = char:FindFirstChild(pair[2])
                        local line = Lines[id]

                        if partA and partB then
                            local posA, onScreenA = Camera:WorldToViewportPoint(partA.Position)
                            local posB, onScreenB = Camera:WorldToViewportPoint(partB.Position)

                            if onScreenA and onScreenB then
                                line.From = Vector2.new(posA.X, posA.Y)
                                line.To = Vector2.new(posB.X, posB.Y)
                                line.Visible = true
                            else
                                line.Visible = false
                            end
                        else
                            line.Visible = false
                        end
                    end
                else
                    for _, line in ipairs(Lines) do line.Visible = false end
                    if not Players:FindFirstChild(player.Name) then
                        for _, line in ipairs(Lines) do line:Remove() end
                        connection:Disconnect()
                    end
                end
            end)
        end

        for _, p in ipairs(Players:GetPlayers()) do CreateSkeleton(p) end
        Players.PlayerAdded:Connect(CreateSkeleton)
    end,

    ["AIM_Aimbot"] = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        local RunService = game:GetService("RunService")
        
        local FOVCircle = Drawing.new("Circle")
        FOVCircle.Color = Color3.fromRGB(0, 180, 255)
        FOVCircle.Thickness = 1.5
        FOVCircle.Filled = false
        FOVCircle.Transparency = 0.7
        FOVCircle.Visible = false

        local function IsVisible(character, targetPart)
            if not getgenv().Config["Visible"] then return true end 
            local parts = Camera:GetPartsObscuringTarget({targetPart.Position}, {LocalPlayer.Character, character})
            return #parts == 0
        end

        local function GetClosestTarget()
            local closestTarget = nil
            local maxDistance = getgenv().Config["AimRadius"] or 100
            local selectedOption = getgenv().Config["Hitbox"] or "Head"

            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local targetPart = player.Character:FindFirstChild(selectedOption) or player.Character:FindFirstChild("HumanoidRootPart")
                    
                    if targetPart then
                        local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                        if onScreen then
                            local mousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                            local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                            
                            if distance < maxDistance and IsVisible(player.Character, targetPart) then
                                maxDistance = distance
                                closestTarget = targetPart
                            end
                        end
                    end
                end
            end
            return closestTarget
        end

        RunService.RenderStepped:Connect(function()
            if getgenv().Config["ShowFOV"] and getgenv().Config["AimRadius"] then
                FOVCircle.Radius = getgenv().Config["AimRadius"]
                FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                FOVCircle.Visible = true
            else
                FOVCircle.Visible = false 
            end

            if not getgenv().Config["Aimbot"] then return end

            local targetPart = GetClosestTarget()
            if targetPart then
                local smoothness = (getgenv().Config["Smoothness"] or 5) / 10
                local targetCFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
                Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, smoothness)
            end
        end)
    end,

    ["AIM_Hitbox"]     = function() end,
    ["AIM_AimRadius"]        = function() end,
    ["AIM_Visible"]    = function() end,
    ["AIM_Smoothness"] = function() end,
    ["MOVEMENT_BunnyHop"] = function()
        local RunService = game:GetService("RunService")
        local LocalPlayer = game.Players.LocalPlayer
        
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if not getgenv().Config["BunnyHop"] then return end
            
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                local hum = char.Humanoid
                local hrp = char.HumanoidRootPart
                
                if hum:GetState() == Enum.HumanoidStateType.Freefall then
                    local maxLimit = getgenv().Config["BhopMax"] or 100
                    local moveDir = hum.MoveDirection
                    
                    if moveDir.Magnitude > 0 then
                        local currentVel = hrp.Velocity
                        hrp.Velocity = Vector3.new(
                            moveDir.X * maxLimit * 0.5, 
                            currentVel.Y, 
                            moveDir.Z * maxLimit * 0.5
                        )
                    end
                end
            end
        end)
    end,

    ["MOVEMENT_MoonJump"] = function()
        local RunService = game:GetService("RunService")
        local LocalPlayer = game.Players.LocalPlayer
        local Workspace = game:GetService("Workspace")
        local normalGravity = 196.2
        local moonGravity = 80 

        RunService.RenderStepped:Connect(function()
            if not getgenv().Config["MoonJump"] then 
                if Workspace.Gravity ~= normalGravity then Workspace.Gravity = normalGravity end
                return 
            end
            
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                local hum = char.Humanoid
                if hum.FloorMaterial == Enum.Material.Air then
                    Workspace.Gravity = moonGravity
                else
                    Workspace.Gravity = normalGravity
                end
            end
        end)
        LocalPlayer.CharacterRemoving:Connect(function() Workspace.Gravity = normalGravity end)
    end,

    ["VISUALS_SelfChams"] = function()
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local lp = Players.LocalPlayer

        -- Кэш для сохранения оригинального вида персонажа
        local originalMaterials = {}
        local originalColors = {}
        local originalTextures = {}

        local ForceFieldColor = Color3.fromRGB(255, 255, 255) -- Белый акцент

        -- Функция для сохранения оригинального состояния деталей
        local function backupPart(part)
            if not originalMaterials[part] then
                originalMaterials[part] = part.Material
                originalColors[part] = part.Color
                
                local mesh = part:FindFirstChildOfClass("SpecialMesh")
                if mesh then
                    originalTextures[part] = mesh.TextureId
                end
            end
        end

        RunService.RenderStepped:Connect(function()
            local char = lp.Character
            if not char then return end

            -- ЕСЛИ ЧИТ ВКЛЮЧЕН В МЕНЮ
            if getgenv().Config["SelfChams"] then
                
                -- Функция применения ForceField
                local function applyFF(part)
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        backupPart(part) -- Сохраняем оригинал перед изменением
                        
                        part.Material = Enum.Material.ForceField
                        part.Color = ForceFieldColor
                        
                        local mesh = part:FindFirstChildOfClass("SpecialMesh")
                        if mesh then
                            mesh.TextureId = "" -- Очищаем текстуру одежды/волос
                        end
                    end
                end

                -- Обрабатываем тело и аксессуары
                for _, child in ipairs(char:GetChildren()) do
                    applyFF(child)
                    if child:IsA("Accessory") then
                        local handle = child:FindFirstChild("Handle")
                        if handle then applyFF(handle) end
                    end
                end

                -- Скрываем 2D декали (лицо, принты на футболках), чтобы не баговали
                for _, decal in ipairs(char:GetDescendants()) do
                    if decal:IsA("Decal") or decal:IsA("Texture") then
                        decal.Transparency = 1
                    end
                end

                -- Создаем сквозной рентген-эффект (Highlight)
                if not char:FindFirstChild("My_FF_XRay") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "My_FF_XRay"
                    hl.FillColor = ForceFieldColor
                    hl.FillTransparency = 0.99
                    hl.OutlineTransparency = 1
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Adornee = char
                    hl.Parent = char
                end

            -- ЕСЛИ ЧИТ ВЫКЛЮЧЕН В МЕНЮ (Возвращаем все как было)
            else
                if char:FindFirstChild("My_FF_XRay") then 
                    char.My_FF_XRay:Destroy() 
                end

                for part, mat in pairs(originalMaterials) do
                    if part and part.Parent then
                        part.Material = mat
                        part.Color = originalColors[part]
                        
                        local mesh = part:FindFirstChildOfClass("SpecialMesh")
                        if mesh and originalTextures[part] then
                            mesh.TextureId = originalTextures[part] -- Возвращаем волосы/одежду
                        end
                    end
                end
                
                -- Возвращаем видимость лицу и деталям
                for _, decal in ipairs(char:GetDescendants()) do
                    if (decal:IsA("Decal") or decal:IsA("Texture")) and decal.Name ~= "HumanoidRootPart" then
                        decal.Transparency = 0
                    end
                end
                
                -- Очищаем таблицы кэша, если выключили функцию
                table.clear(originalMaterials)
                table.clear(originalColors)
                table.clear(originalTextures)
            end
        end)

        -- Сброс кэша при респавне, чтобы не было багов с новыми шмотками
        lp.CharacterAdded:Connect(function()
            table.clear(originalMaterials)
            table.clear(originalColors)
            table.clear(originalTextures)
        end)
    end,

    ["VISUALS_ThirdPerson"] = function()
        local RunService = game:GetService("RunService")
        local LocalPlayer = game.Players.LocalPlayer
        
        RunService.RenderStepped:Connect(function()
            if getgenv().Config["ThirdPerson"] then
                local distance = getgenv().Config["Distance"] or 25
                LocalPlayer.CameraMode = Enum.CameraMode.Classic
                LocalPlayer.CameraMaxZoomDistance = distance
                LocalPlayer.CameraMinZoomDistance = distance
            else
                if LocalPlayer.CameraMaxZoomDistance == (getgenv().Config["Distance"] or 25) then
                    LocalPlayer.CameraMaxZoomDistance = 128
                    LocalPlayer.CameraMinZoomDistance = 0.5
                end
            end
        end)
    end,

    ["VISUALS_Distance"] = function() end,
    ["VISUALS_KillStreak"] = function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local TweenService = game:GetService("TweenService")
        local lp = Players.LocalPlayer

        -- Переменные логики киллстрика
        local currentStreak = 0
        local lastKillTime = 0
        local comboDuration = 3 -- Время комбо (3 секунды)
        
        -- Таблица для хранения истории прицеливания (буфер на 0.4 секунды)
        local aimHistory = {}
        local historyWindow = 0.4 -- Окно задержки из-за интернета

        -- Создаем графический интерфейс для счетчика (Локально)
        local StreakGui = Instance.new("ScreenGui")
        StreakGui.Name = "KillStreak_Display"
        StreakGui.Parent = game.CoreGui
        StreakGui.ResetOnSpawn = false

        -- Главный контейнер (СМЕЩЕН В САМЫЙ НИЗ ЭКРАНА - 85% высоты)
        local MainBox = Instance.new("Frame")
        MainBox.Size = UDim2.new(0, 200, 0, 26)
        MainBox.Position = UDim2.new(0.5, -100, 0, workspace.CurrentCamera.ViewportSize.Y * 0.67)
        MainBox.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
        MainBox.BackgroundTransparency = 1 -- По умолчанию скрыто
        MainBox.BorderSizePixel = 0
        MainBox.Parent = StreakGui
        local BoxCorner = Instance.new("UICorner", MainBox)
        BoxCorner.CornerRadius = UDim.new(0, 4)

        -- Фон полоски времени
        local BarBackground = Instance.new("Frame")
        BarBackground.Size = UDim2.new(0, 140, 0, 3) -- СДЕЛАНА ПОТОНЬШЕ (3 пикселя)
        BarBackground.Position = UDim2.new(0, 10, 0, 18)
        BarBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        BarBackground.BackgroundTransparency = 1
        BarBackground.BorderSizePixel = 0
        BarBackground.Parent = MainBox
        local BarBgCorner = Instance.new("UICorner", BarBackground)
        BarBgCorner.CornerRadius = UDim.new(0, 2)

        -- Сама тающая линия
        local ProgressBar = Instance.new("Frame")
        ProgressBar.Size = UDim2.new(1, 0, 1, 0)
        ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255) 
        ProgressBar.BackgroundTransparency = 1
        ProgressBar.BorderSizePixel = 0
        ProgressBar.Parent = BarBackground
        local BarCorner = Instance.new("UICorner", ProgressBar)
        BarCorner.CornerRadius = UDim.new(0, 2)

        -- Текст названия "STREAK"
        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Size = UDim2.new(0, 140, 0, 16)
        TitleLabel.Position = UDim2.new(0, 10, 0, 1)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = "COMBО STREAK"
        TitleLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
        TitleLabel.TextTransparency = 1
        TitleLabel.Font = Enum.Font.SourceSansBold
        TitleLabel.TextSize = 11
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.Parent = MainBox

        -- Цифра счётчика убийств (справа)
        local CountLabel = Instance.new("TextLabel")
        CountLabel.Size = UDim2.new(0, 40, 0, 26)
        CountLabel.Position = UDim2.new(0, 155, 0, 0)
        CountLabel.BackgroundTransparency = 1
        CountLabel.Text = "0"
        CountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        CountLabel.TextTransparency = 1
        CountLabel.Font = Enum.Font.SourceSansBold
        CountLabel.TextSize = 22
        CountLabel.TextXAlignment = Enum.TextXAlignment.Center
        CountLabel.Parent = MainBox

        -- Анимация появления и таяния линии
        local activeTween = nil
        local function triggerKillVisuals()
            MainBox.BackgroundTransparency = 0.25
            BarBackground.BackgroundTransparency = 0
            ProgressBar.BackgroundTransparency = 0
            TitleLabel.TextTransparency = 0
            CountLabel.TextTransparency = 0
            
            CountLabel.Text = tostring(currentStreak)
            ProgressBar.Size = UDim2.new(1, 0, 1, 0)

            if activeTween then activeTween:Cancel() end

            local tweenInfo = TweenInfo.new(comboDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            activeTween = TweenService:Create(ProgressBar, tweenInfo, {Size = UDim2.new(0, 0, 1, 0)})
            activeTween:Play()
        end

        -- Плавное растворение счетчика
        local function fadeOutVisuals()
            currentStreak = 0
            local fadeInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            
            TweenService:Create(MainBox, fadeInfo, {BackgroundTransparency = 1}):Play()
            TweenService:Create(BarBackground, fadeInfo, {BackgroundTransparency = 1}):Play()
            TweenService:Create(ProgressBar, fadeInfo, {BackgroundTransparency = 1}):Play()
            TweenService:Create(TitleLabel, fadeInfo, {TextTransparency = 1}):Play()
            TweenService:Create(CountLabel, fadeInfo, {TextTransparency = 1}):Play()
        end

        -- Постоянно записываем историю того, куда мы смотрели
        RunService.RenderStepped:Connect(function()
            if not getgenv().Config["KillStreak"] then return end
            
            local camera = workspace.CurrentCamera
            local currentTime = tick()
            local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
            
            -- Проверяем всех игроков и сохраняем их экранные позиции в историю
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= lp and player.Character and player.Character:FindFirstChild("Head") then
                    local head = player.Character.Head
                    local vector, onScreen = camera:WorldToViewportPoint(head.Position)
                    
                    if onScreen then
                        local dist = (Vector2.new(vector.X, vector.Y) - screenCenter).Magnitude
                        
                        -- Если навелись на голову (в пределах 160 пикселей) — записываем это событие
                        if dist <= 160 then
                            if not aimHistory[player.Name] then aimHistory[player.Name] = {} end
                            table.insert(aimHistory[player.Name], currentTime)
                        end
                    end
                end
            end
            
            -- Чистим старые записи истории, которые вышли за рамки 0.4 секунд
            for pName, timestamps in pairs(aimHistory) do
                for i = #timestamps, 1, -1 do
                    if currentTime - timestamps[i] > historyWindow then
                        table.remove(timestamps, i)
                    end
                end
                if #timestamps == 0 then aimHistory[pName] = nil end
            end
        end)

        -- Логика отслеживания смертей врагов
        local function monitorPlayer(player)
            if player == lp then return end
            
            player.CharacterAdded:Connect(function(char)
                local humanoid = char:WaitForChild("Humanoid", 5)
                if humanoid then
                    humanoid.Died:Connect(function()
                        if not getgenv().Config["KillStreak"] then return end
                        
                        local currentTime = tick()
                        local wasTargetedRecently = false
                        
                        -- Проверяем буфер: был ли этот игрок в нашем прицеле за последние 0.4 сек
                        if aimHistory[player.Name] and #aimHistory[player.Name] > 0 then
                            for _, timestamp in ipairs(aimHistory[player.Name]) do
                                if currentTime - timestamp <= historyWindow then
                                    wasTargetedRecently = true
                                    break
                                end
                            end
                        end
                        
                        -- Если ты целился в него в пределах 0.4 сек до его смерти — засчитываем твой килл!
                        if wasTargetedRecently then
                            lastKillTime = currentTime
                            currentStreak = currentStreak + 1
                            triggerKillVisuals()
                            -- Очищаем буфер для этого челика, чтобы не сработало дважды
                            aimHistory[player.Name] = nil
                        end
                    end)
                end
            end)
        end

        for _, p in ipairs(Players:GetPlayers()) do monitorPlayer(p) end
        Players.PlayerAdded:Connect(monitorPlayer)

        -- Постоянный чек таймера серии в фоне
        RunService.Heartbeat:Connect(function()
            if currentStreak > 0 and (tick() - lastKillTime) >= comboDuration then
                fadeOutVisuals()
            end
        end)
    end,

    ["AA_VisualJitterBack"] = function()
        local RunService = game:GetService("RunService")
        local LocalPlayer = game.Players.LocalPlayer
        local lastToggle = 0
        local state = false

        RunService.RenderStepped:Connect(function()
            if not getgenv().Config["VisualJitterBack"] then return end
            
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local cam = workspace.CurrentCamera.CFrame.LookVector
                
                local speed = getgenv().Config["VisualJitterSpeed"] or 2
                local interval = 1 / math.max(speed, 0.1)
                
                if tick() - lastToggle >= interval then
                    state = not state
                    lastToggle = tick()
                end
                
                local range = math.rad(getgenv().Config["VisualJitterRange"] or 15)
                local currentSway = state and range or -range
                
                hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(cam.X, 0, cam.Z)) 
                             * CFrame.Angles(0, math.rad(180) + currentSway, 0)
            end
        end)
    end,
    ["AA_VisualJitterSpeed"] = function() end,
    ["AA_VisualJitterSpin"] = function()
        local RunService = game:GetService("RunService")
        local LocalPlayer = game.Players.LocalPlayer
        local lastTransform = 0
        local currentAngle = 0

        RunService.RenderStepped:Connect(function()
            if not getgenv().Config["VisualJitterSpin"] then return end
            
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local cam = workspace.CurrentCamera.CFrame.LookVector
                
                -- Получаем настройки из слайдеров (если их нет, ставим стандартные)
                local delayTime = (getgenv().Config["JitterSpinDelay"] or 50) / 100 -- из ползунка (например, 50 = 0.5 сек)
                local angleStep = getgenv().Config["JitterSpinStep"] or 90 -- шаг поворота в градусах
                
                -- Проверяем, прошло ли нужное время (например, 0.5 секунд) для прыжка направления
                if tick() - lastTransform >= delayTime then
                    currentAngle = (currentAngle + angleStep) % 360
                    lastTransform = tick()
                end
                
                -- Оставляем позицию игрока, но разворачиваем его CFrame относительно камеры на текущий угол
                hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(cam.X, 0, cam.Z)) 
                             * CFrame.Angles(0, math.rad(currentAngle), 0)
            end
        end)
    end,
    ["AA_JitterSpinDelay"] = function() end,
    ["AA_JitterSpinStep"] = function() end,
    ["WORLD_TextureQuality"] = function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Texture") or obj:IsA("Decal") then
                obj.Enabled = false 
            elseif obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
            end
        end
        workspace.DescendantAdded:Connect(function(obj)
            if getgenv().Config["TextureQuality"] then
                if obj:IsA("Texture") or obj:IsA("Decal") then
                    obj.Enabled = false
                elseif obj:IsA("BasePart") then
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.Reflectance = 0
                end
            end
        end)
    end,
    ["WORLD_SkyColor"] = function()
        local Lighting = game:GetService("Lighting")
        game:GetService("RunService").RenderStepped:Connect(function()
            if getgenv().Config["SkyColor"] then
                Lighting.Ambient = Color3.fromRGB(0, 180, 255)
                Lighting.OutdoorAmbient = Color3.fromRGB(0, 180, 255)
                for _, obj in pairs(Lighting:GetChildren()) do
                    if obj:IsA("Sky") then
                        obj.SkyboxBk = ""
                        obj.SkyboxDn = ""
                        obj.SkyboxFt = ""
                        obj.SkyboxLf = ""
                        obj.SkyboxRt = ""
                        obj.SkyboxUp = ""
                    end
                end
            end
        end)
    end,
    ["WORLD_NoFog"] = function()
        local Lighting = game:GetService("Lighting")
        game:GetService("RunService").RenderStepped:Connect(function()
            if getgenv().Config["NoFog"] then
                Lighting.FogEnd = 999999
                Lighting.FogStart = 999999
            end
        end)
    end,
    ["WORLD_DeathParticles"] = function()
        local Players = game:GetService("Players")
        local function CreateTextEffect(char)
            if not getgenv().Config["DeathParticles"] then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local pos = hrp.Position
            local part = Instance.new("Part")
            part.Size = Vector3.new(1, 1, 1)
            part.Transparency = 1
            part.Anchored = true
            part.CanCollide = false
            part.Position = pos + Vector3.new(0, 3, 0)
            part.Parent = workspace
            local billboard = Instance.new("BillboardGui")
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.Adornee = part
            billboard.Parent = part
            local label = Instance.new("TextLabel")
            label.Text = "💀 💀 💀"
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.TextScaled = true
            label.Font = Enum.Font.Code
            label.Parent = billboard
            task.spawn(function()
                for i = 1, 50 do
                    part.Position = part.Position + Vector3.new(0, 0.05, 0)
                    label.TextTransparency = i / 50
                    task.wait(0.08)
                end
                part:Destroy()
            end)
        end
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(char)
                char:WaitForChild("Humanoid").Died:Connect(function()
                    CreateTextEffect(char)
                end)
            end)
        end)
    end,
     ["VISUALS_CameraFOV"] = function()
        local RunService = game:GetService("RunService")
        local Camera = game:GetService("Workspace").CurrentCamera
        RunService.RenderStepped:Connect(function()
            if getgenv().Config["CameraFOV"] then
                Camera.FieldOfView = getgenv().Config["CameraFOV"]
            else
                Camera.FieldOfView = 70
            end
        end)
    end,
    ["AIM_HitboxExpander"] = function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if not getgenv().Config["HitboxExpander"] then return end
        
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                -- Увеличиваем, если включено
                player.Character.Head.Size = Vector3.new(30, 30, 30)
                player.Character.Head.Transparency = 0.7
                player.Character.Head.CanCollide = false
            end
        end
    end)
end,
    ["MOVEMENT_NoclipFly"] = function()
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local lp = Players.LocalPlayer
        
        local bv = nil -- Физический вектор скорости

        RunService.RenderStepped:Connect(function()
            -- Если чит выключен в меню
            if not getgenv().Config["NoclipFly"] then 
                if bv then 
                    bv:Destroy() 
                    bv = nil 
                end
                return 
            end
            
            local char = lp.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
            
            local hrp = char.HumanoidRootPart
            local hum = char.Humanoid
            local camera = workspace.CurrentCamera
            local speed = getgenv().Config["NoclipFlySpeed"] or 50

            -- 1. ВКЛЮЧАЕМ НОУКЛИП (пролёт сквозь стены)
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end

            -- 2. СОЗДАЕМ ВЕКТОР СКОРОСТИ
            if not bv or bv.Parent ~= hrp then
                if bv then bv:Destroy() end
                bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge) -- Даем бесконечную силу, чтобы лететь сквозь всё
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.Parent = hrp
            end

            -- 3. СЧИТЫВАЕМ ДЖОЙСТИК И НАПРАВЛЕНИЕ КАМЕРЫ
            local moveDir = hum.MoveDirection -- Идеально для мобильного джойстика и WASD

            if moveDir.Magnitude > 0 then
                -- Вектор взгляда камеры (куда наведён прицел/экран)
                local camLook = camera.CFrame.LookVector
                
                -- Базовое направление движения берем от джойстика
                local finalVelocity = moveDir
                
                -- Считаем, насколько джойстик нажат "вперед" относительно взгляда камеры
                local forwardDot = moveDir:Dot(Vector3.new(camLook.X, 0, camLook.Z).Unit)
                
                if forwardDot > 0.5 then
                    -- Если джойстик тянут вперед, плавно добавляем наклон камеры (Y)
                    -- Смотришь вверх — летишь вверх, смотришь вниз — летишь под землю
                    finalVelocity = Vector3.new(moveDir.X, camLook.Y * forwardDot, moveDir.Z)
                elseif forwardDot < -0.5 then
                    -- Если джойстик тянут назад, инвертируем высоту камеры
                    finalVelocity = Vector3.new(moveDir.X, -camLook.Y * math.abs(forwardDot), moveDir.Z)
                end
                
                -- Задаем скорость нашему физическому телу
                bv.Velocity = finalVelocity.Unit * speed
            else
                -- Если джойстик отпущен — персонаж мертво зависает в воздухе и не падает
                bv.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    end,
    ["MOVEMENT_NoclipFlySpeed"] = function() end,
    ["AIM_MassKill"] = function()
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local lp = Players.LocalPlayer

        RunService.RenderStepped:Connect(function()
            -- Если функция выключена в меню — возвращаем всех на место
            if not getgenv().Config["MassKill"] then 
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.Anchored = false
                    end
                end
                return 
            end
            
            local myChar = lp.Character
            if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
            
            local camCFrame = workspace.CurrentCamera.CFrame

            -- Каждую миллисекунду стягиваем врагов
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
                    local targetHrp = player.Character.HumanoidRootPart
                    local targetHum = player.Character.Humanoid
                    
                    -- Стягиваем только живых
                    if targetHum.Health > 0 then
                        -- Ставим игроков кучкой в 4 блоках перед камерой, чуть правее и ниже
                        local targetPosition = camCFrame * CFrame.new(2, -1.2, -4)
                        
                        -- ОТКЛЮЧАЕМ КОЛЛИЗИИ ПРАВИЛЬНО (исправлено)
                        for _, part in pairs(player.Character:GetDescendants()) do
                            if part:IsA("BasePart") then 
                                part.CanCollide = false 
                            end
                        end
                        
                        -- Отключаем встроенную физику Humanoid локально, чтобы модельку не штормило
                        targetHum:ChangeState(Enum.HumanoidStateType.Physics)
                        
                        -- Насильно переписываем их позицию на твоем экране
                        targetHrp.CFrame = targetPosition
                        targetHrp.Anchored = true 
                    else
                        -- Если умер — отпускаем труп
                        targetHrp.Anchored = false
                    end
                end
            end
        end)
    end,
        ["AIM_Silent360"] = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        local RunService = game:GetService("RunService")

        -- Функция проверки видимости (сквозь стены)
        local function IsVisible(character, targetPart)
            if not getgenv().Config["CheckWall"] then return true end -- Если проверка стен выключена — лупим сквозь них
            local parts = Camera:GetPartsObscuringTarget({targetPart.Position}, {LocalPlayer.Character, character})
            return #parts == 0
        end

        -- Поиск самой близкой жертвы в радиусе 360 градусов
        local function GetClosestPlayer360()
            local closestTarget = nil
            local shortestDistance = math.huge -- Ищем по минимальной дистанции в 3D пространстве

            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    -- Наводимся строго в голову, как ты просил
                    local head = player.Character:FindFirstChild("Head")
                    
                    if head then
                        -- Считаем чистое расстояние между тобой и врагом в мире
                        local distance = (LocalPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude
                        
                        if distance < shortestDistance and IsVisible(player.Character, head) then
                            shortestDistance = distance
                            closestTarget = head
                        end
                    end
                end
            end
            return closestTarget
        end

        RunService.RenderStepped:Connect(function()
            if not getgenv().Config["Silent360"] then return end
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end

            local targetHead = GetClosestPlayer360()
            if targetHead then
                -- Полный игнор плавности (Smoothness). Наводка происходит за 1 кадр (мгновенный флик)
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetHead.Position)
            end
        end)
    end,
    ["AIM_CheckWall"] = function() end,
    
        ["ESP_Skeleton"] = function()
        local Players = game:GetService("Players")
        local Camera = workspace.CurrentCamera
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer

        -- Список пар костей, которые нужно соединить линиями
        local BonePairs = {
            -- Позвоночник / Голова
            {"Head", "UpperTorso"},
            {"UpperTorso", "LowerTorso"},
            
            -- Левая рука
            {"UpperTorso", "LeftUpperArm"},
            {"LeftUpperArm", "LeftLowerArm"},
            {"LeftLowerArm", "LeftHand"},
            
            -- Правая рука
            {"UpperTorso", "RightUpperArm"},
            {"RightUpperArm", "RightLowerArm"},
            {"RightLowerArm", "RightHand"},
            
            -- Левая нога
            {"LowerTorso", "LeftUpperLeg"},
            {"LeftUpperLeg", "LeftLowerLeg"},
            {"LeftLowerLeg", "LeftFoot"},
            
            -- Правая нога
            {"LowerTorso", "RightUpperLeg"},
            {"RightUpperLeg", "RightLowerLeg"},
            {"RightLowerLeg", "RightFoot"}
        }

        local function CreateSkeleton(player)
            if player == LocalPlayer then return end
            
            -- Массив для хранения графических линий этого игрока
            local Lines = {}
            for i = 1, #BonePairs do
                local line = Drawing.new("Line")
                -- СРАЗУ ДЕЛАЕМ БЕЛЫМ (потом поменяем на фиолетовый)
                line.Color = Color3.fromRGB(255, 255, 255) 
                line.Thickness = 1.5
                line.Transparency = 1
                line.Visible = false
                table.insert(Lines, line)
            end

            local connection
            connection = RunService.RenderStepped:Connect(function()
                -- Проверка чекбокса в меню
                if not getgenv().Config["Skeleton"] then
                    for _, line in ipairs(Lines) do line.Visible = false end
                    return
                end

                local char = player.Character
                if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                    for id, pair in ipairs(BonePairs) do
                        local partA = char:FindFirstChild(pair[1])
                        local partB = char:FindFirstChild(pair[2])
                        local line = Lines[id]

                        if partA and partB then
                            -- Переводим 3D координаты суставов в 2D экранные координаты
                            local posA, onScreenA = Camera:WorldToViewportPoint(partA.Position)
                            local posB, onScreenB = Camera:WorldToViewportPoint(partB.Position)

                            -- Если обе части тела видны на экране — рисуем кость
                            if onScreenA and onScreenB then
                                line.From = Vector2.new(posA.X, posA.Y)
                                line.To = Vector2.new(posB.X, posB.Y)
                                line.Visible = true
                            else
                                line.Visible = false
                            end
                        else
                            line.Visible = false
                        end
                    end
                else
                    -- Если игрок умер или вышел
                    for _, line in ipairs(Lines) do line.Visible = false end
                    if not Players:FindFirstChild(player.Name) then
                        for _, line in ipairs(Lines) do line:Remove() end
                        connection:Disconnect()
                    end
                end
            end)
        end

        -- Запускаем для всех текущих и будущих игроков
        for _, p in ipairs(Players:GetPlayers()) do CreateSkeleton(p) end
        Players.PlayerAdded:Connect(CreateSkeleton)
    end,
    ["VISUALS_RSC"] = function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local TextChatService = game:GetService("TextChatService")
        local lp = Players.LocalPlayer

        getgenv().RSC_Users = {} -- Глобальный список софтеров

        -- Функция отправки скрытого пинга в сеть сервера
        local function sendPing()
            if not getgenv().Config["RSC"] then return end
            -- Отправляем в локальный текстовый поток скрытый маркер нашего софта
            pcall(function()
                if TextChatService and TextChatService:FindFirstChild("TextChannels") and TextChatService.TextChannels:FindFirstChild("RBXGeneral") then
                    -- Отправляем системный пакет, который обычные люди в чате не видят (так как он пустой или зашифрован)
                    -- Но наш скрипт его поймает
                    TextChatService.TextChannels.RBXGeneral:SendAsync("	[RSC_PING_NEVERLOSE]	")
                end
            end)
        end

        -- Каждые 5 секунд кричим в скрытый канал, что мы на сервере
        task.spawn(function()
            while task.wait(5) do
                if getgenv().Config["RSC"] then
                    sendPing()
                else
                    table.clear(getgenv().RSC_Users)
                end
            end
        end)

        -- Ловим чужие пинги софтеров на этом сервере
        if TextChatService and TextChatService:FindFirstChild("TextChannels") and TextChatService.TextChannels:FindFirstChild("RBXGeneral") then
            TextChatService.TextChannels.RBXGeneral.MessageReceived:Connect(function(message)
                if not getgenv().Config["RSC"] then return end
                
                -- Если сообщение содержит наш секретный маркер и это не мы сами
                if message.Text == "	[RSC_PING_NEVERLOSE]	" and message.TextSource then
                    local sender = Players:GetPlayerByUserId(message.TextSource.UserId)
                    if sender and sender ~= lp then
                        -- Добавляем софтера в вайтлист, если его там еще нет
                        if not table.find(getgenv().RSC_Users, sender.Name) then
                            table.insert(getgenv().RSC_Users, sender.Name)
                            
                            -- Визуальный эффект: красим его чамс в фиолетовый, показывая что он "наш"
                            if sender.Character and sender.Character:FindFirstChild("My_FF_XRay") then
                                sender.Character.My_FF_XRay.FillColor = Color3.fromRGB(180, 0, 255)
                            end
                        end
                    end
                end
            end)
        end

        -- Очистка списка, если игрок вышел с сервера
        Players.PlayerRemoving:Connect(function(player)
            local index = table.find(getgenv().RSC_Users, player.Name)
            if index then
                table.remove(getgenv().RSC_Users, index)
            end
        end)
    end,

    ["MENU_ThemeSelect"] = function() 
        -- Просто заглушка для конфига дропдауна
    end,

    ["MENU_LoadTheme"] = function()
        local RunService = game:GetService("RunService")
        
        -- Сюда мы закладываем код каждого софта прямо в RAW формате (внутри огромных строк)
        local RawScripts = {
            ["Фиолетовая"] = [[
loadstring(game:HttpGet("https://raw.githubusercontent.com/dllebo/Violet.lua/refs/heads/main/violete.lua"))()
                print("Загружена Фиолетовая тема!")
                -- Пример: loadstring(game:HttpGet("ссылка"))() если всё же захочешь отсюда вызвать гитхаб,
                -- но лучше вставить сюда весь код целиком от первой до последней строчки.
            ]],
            
            ["Красная"] = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/dllebo/Violet.lua/refs/heads/main/red.lua"))()
                print("Загружена Красная тема!")
            ]],
            
            ["Синяя"] = [[
                -- СЮДА ВСТАВЛЯЕШЬ ПОЛНУЮ КОПИЮ СВОЕГО СКРИПТА, НО С СИНИМИ ЦВЕТАМИ
                print("Загружена Синяя тема!")
            ]],
            
            ["Зелёная"] = [[
                -- КОД ЗЕЛЁНОГО СОФТА
                print("Загружена Зелёная тема!")
            ]],
            
            ["Жёлтая"] = [[
                -- КОД ЖЁЛТОГО СОФТА
                print("Загружена Жёлтая тема!")
            ]],
            
            ["Черная"] = [[
                -- КОД ЧЁРНОГО СОФТА
                print("Загружена Чёрная тема!")
            ]]
        }

        -- Следим за нажатием чекбокса Load
        task.spawn(function()
            while task.wait(0.3) do
                if getgenv().Config["LoadTheme"] then
                    -- Мгновенно отжимаем чекбокс назад
                    getgenv().Config["LoadTheme"] = false
                    
                    -- Получаем выбранный цвет
                    local selectedColor = getgenv().Config["ThemeSelect"] or "Фиолетовая"
                    local rawCode = RawScripts[selectedColor]

                    if rawCode and rawCode ~= "" then
                        -- 1. ЖЕСТКАЯ ОЧИСТКА: Удаляем старое меню
                        if game.CoreGui:FindFirstChild("HvH_Private_Menu") then
                            game.CoreGui["HvH_Private_Menu"]:Destroy()
                        end
                        
                        -- 2. Сносим все Drawing-линии старого ESP, чтобы они не оставались на экране
                        -- (Если твои ESP-функции используют Drawing, этот вызов очистит их из памяти)
                        if clear and typeof(clear) == "function" then
                            pcall(clear)
                        end

                        -- 3. ЗАГРУЗКА ИЗ ПАМЯТИ: Выполняем заложенный RAW код
                        local success, err = pcall(function()
                            local compiled = loadstring(rawCode)
                            if compiled then
                                compiled()
                            else
                                warn("Ошибка компиляции RAW кода для темы: " .. selectedColor)
                            end
                        end)
                        
                        if not success then
                            warn("Ошибка выполнения темы: ", err)
                        end
                        
                        break -- Выходим из цикла, так как новый софт успешно переинициализировался
                    end
                end
            end
        end)
    end,

}

for slotName, slotCode in pairs(Slots) do
    if slotCode ~= nil then
        local parsed = string.split(slotName, "_")
        local tab = parsed[1]
        local func = parsed[2]
        
        CreateTabButton(tab)
        
        if func == "AimRadius" then
            BuildSlider(tab, func, 10, 600, 100)
        elseif func == "Smoothness" then
            BuildSlider(tab, func, 1, 30, 5)
        elseif func == "Distance" then
            BuildSlider(tab, func, 5, 100, 25)
        elseif func == "ThemeSelect" then
            BuildDropdown(tab, func, {"Фиолетовая", "Красная", "Синяя", "Зелёная", "Жёлтая", "Черная"})
        elseif func == "VisualJitterSpin" then
            BuildCheckbox(tab, func)
        elseif func == "NoclipFly" then
            BuildCheckbox(tab, func)
        elseif func == "NoclipFlySpeed" then
            BuildSlider(tab, func, 10, 300, 60)
        elseif func == "JitterSpinDelay" then
            BuildSlider(tab, func, 5, 200, 50)
        elseif func == "JitterSpinStep" then
            BuildSlider(tab, func, 15, 180, 90)
        elseif func == "VisualJitterRange" then
            BuildSlider(tab, func, 5, 45, 15)
        elseif func == "VisualJitterSpeed" then
            BuildSlider(tab, func, 1, 20, 2)
        elseif func == "CameraFOV" then
            BuildSlider(tab, func, 50, 400, 70)
        elseif func == "Hitbox" then
            BuildDropdown(tab, func, {"Head", "HumanoidRootPart", "LowerTorso"})
        else
            BuildCheckbox(tab, func)
        end
        
        task.spawn(slotCode)
    end
end

for tabName, _ in pairs(CreatedTabs) do
    local btn = TabContainer:FindFirstChild("Tab_" .. tabName)
    if btn then
        btn.TextColor3 = Color3.fromRGB(0, 180, 255)
        if RegisteredElements[tabName] then
            for _, frame in ipairs(RegisteredElements[tabName]) do
                frame.Parent = ScrollContent
                frame.Visible = true
            end
        end
        break
    end
end
