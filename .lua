local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

Notification:Notify(
    {Title = "Made by bleakangel", Description = "https://discord.gg/V2z6bhpvMU"},
    {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "option"},
    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84), Callback = function(State) 
        if State == "Checked" then
            setclipboard("https://discord.gg/dmBzVaRrD3")
        end
    end}
)

-- Wait for the notification to disappear or for 4.5 seconds
wait(4.5)

-- Copy the description to clipboard after 4.5 seconds
setclipboard("https://discord.gg/dmBzVaRrD3")

local player = game.Players.LocalPlayer
local folder = game.Workspace.Memes

if not folder then
    Notification:Notify(
        {Title = "Error", Description = " folder not found in Workspace!"},
        {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "default"}
    )
    return
end

local teleporting = false

local function getTeleportObjects()
    local objects = {}
    for _, object in pairs(folder:GetChildren()) do
        if object:IsA("BasePart") then
            table.insert(objects, object)
        elseif object:IsA("Model") and object.PrimaryPart then
            table.insert(objects, object.PrimaryPart)
        end
    end
    return objects
end

local function teleportToRandomObject()
    local objects = getTeleportObjects()
    local targetObject = objects[math.random(1, #objects)]
    if player.Character and player.Character.PrimaryPart then
        player.Character:SetPrimaryPartCFrame(targetObject.CFrame)
    end
end

local function createGUI()
    local oldGUI = game:GetService("CoreGui"):FindFirstChild("MadeByPolleser")
    if oldGUI then
        oldGUI:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MadeByPolleser"
    screenGui.Parent = game:GetService("CoreGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.3, 0, 0.15, 0)
    frame.Position = UDim2.new(0.35, 0, 0.4, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local UserInputService = game:GetService("UserInputService")
    
    local draggingFrame, dragStartFrame, startPosFrame

    local function onFrameDrag(input)
        if draggingFrame then
            local delta = input.Position - dragStartFrame
            frame.Position = UDim2.new(startPosFrame.X.Scale, startPosFrame.X.Offset + delta.X,
                                       startPosFrame.Y.Scale, startPosFrame.Y.Offset + delta.Y)
        end
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingFrame = true
            dragStartFrame = input.Position
            startPosFrame = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingFrame = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(onFrameDrag)

    local startButton = Instance.new("TextButton")
    startButton.Name = "StartButton"
    startButton.Text = "Start"
    startButton.Size = UDim2.new(0.4, 0, 0.4, 0)
    startButton.Position = UDim2.new(0.1, 0, 0.3, 0)
    startButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    startButton.TextScaled = true
    startButton.Parent = frame

    local stopButton = Instance.new("TextButton")
    stopButton.Name = "StopButton"
    stopButton.Text = "Stop"
    stopButton.Size = UDim2.new(0.4, 0, 0.4, 0)
    stopButton.Position = UDim2.new(0.55, 0, 0.3, 0)
    stopButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    stopButton.TextScaled = true
    stopButton.Parent = frame

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Text = "-"
    minimizeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
    minimizeButton.Position = UDim2.new(0.9, 0, 0.05, 0)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    minimizeButton.TextScaled = true
    minimizeButton.Parent = screenGui

    local isMinimized = false

    local draggingMinimize, dragStartMinimize, startPosMinimize

    local function onMinimizeButtonDrag(input)
        if draggingMinimize then
            local delta = input.Position - dragStartMinimize
            minimizeButton.Position = UDim2.new(startPosMinimize.X.Scale, startPosMinimize.X.Offset + delta.X,
                                                 startPosMinimize.Y.Scale, startPosMinimize.Y.Offset + delta.Y)
        end
    end

    minimizeButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMinimize = true
            dragStartMinimize = input.Position
            startPosMinimize = minimizeButton.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingMinimize = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(onMinimizeButtonDrag)

    minimizeButton.MouseButton1Click:Connect(function()
        if isMinimized then
            frame.Size = UDim2.new(0.3, 0, 0.15, 0)
            frame.BackgroundTransparency = 0
            startButton.Visible = true
            stopButton.Visible = true
            minimizeButton.Text = "-"
        else
            frame.Size = UDim2.new(0.3, 0, 0.05, 0)
            frame.BackgroundTransparency = 1
            startButton.Visible = false
            stopButton.Visible = false
            minimizeButton.Text = "+"
        end
        isMinimized = not isMinimized
    end)

    local rainbowTextLabel = Instance.new("TextLabel")
    rainbowTextLabel.Name = "RainbowTextLabel"
    rainbowTextLabel.Text = "Made by bleakangel"
    rainbowTextLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
    rainbowTextLabel.Position = UDim2.new(0.1, 0, 0.05, 0)
    rainbowTextLabel.BackgroundTransparency = 1
    rainbowTextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    rainbowTextLabel.TextScaled = true
    rainbowTextLabel.Parent = frame


    local function changeTextColor()
        while true do
            for i = 1, 6 do
                rainbowTextLabel.TextColor3 = Color3.fromHSV(i / 6, 1, 1)
                wait(0.1)
            end
        end
    end


    spawn(changeTextColor)


    startButton.MouseButton1Click:Connect(function()
        if not teleporting then
            teleporting = true
            while teleporting do
                teleportToRandomObject()
                wait(4.5)
            end
        end
    end)


    stopButton.MouseButton1Click:Connect(function()
        teleporting = false
    end)
end

createGUI()
