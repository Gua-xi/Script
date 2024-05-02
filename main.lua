local function createESP(player)
    local esp = Instance.new("Part")
    esp.Shape = Enum.PartType.Ball
    esp.Size = Vector3.new(4, 0.2, 4)
    esp.Transparency = 0.5
    esp.Anchored = true
    esp.CanCollide = false
    esp.Name = player.Name .. "_ESP"
    esp.Parent = game.Workspace

    
    local playerColor = Color3.fromHSV(math.random(), 1, 1)
    esp.Color = playerColor

    local isDifferentTeam = false
    if player.Team ~= game.Players.LocalPlayer.Team then
        isDifferentTeam = true
    end
	
    local label = Instance.new("BillboardGui")
    label.Size = UDim2.new(0, 300, 0, 100)
    label.StudsOffset = Vector3.new(0, 3, 0)
    label.Name = "PlayerLabel"
    label.AlwaysOnTop = true
    label.Parent = esp

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = isDifferentTeam and Color3.new(1, 0, 0) or Color3.new(1, 1, 1)  -- Cor vermelha se estiver em time diferente
    textLabel.TextStrokeTransparency = 0.5
    textLabel.TextScaled = true
    textLabel.Text = player.Name .. " - " .. math.floor((player.Character.HumanoidRootPart.Position - game.Workspace.CurrentCamera.CFrame.p).magnitude) .. "m"
    textLabel.Parent = label

    local function updateESP()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            esp.Position = player.Character.HumanoidRootPart.Position
            textLabel.Text = player.Name .. " - " .. math.floor((player.Character.HumanoidRootPart.Position - game.Workspace.CurrentCamera.CFrame.p).magnitude) .. "m"
        end
    end

    game:GetService("RunService").Heartbeat:Connect(updateESP)
end

local function createAllESPs()
    for _, player in ipairs(game.Players:GetPlayers()) do
        createESP(player)
    end
end

game.Players.PlayerAdded:Connect(function(player)
    createESP(player)
end)

createAllESPs()
