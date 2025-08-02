local p = game.Players.LocalPlayer
local c = p.Character or p.CharacterAdded:Wait()
local hrp = c:WaitForChild("HumanoidRootPart")
local g = Instance.new("ScreenGui", game.CoreGui)
local f = Instance.new("Frame", g)
f.Size = UDim2.new(0, 220, 0, 150)
f.Position = UDim2.new(0, 350, 0, 100)
f.BackgroundColor3 = Color3.fromRGB(30,30,30)
f.BorderSizePixel = 0

local b1 = Instance.new("TextButton", f)
b1.Size = UDim2.new(0, 200, 0, 30)
b1.Position = UDim2.new(0, 10, 0, 10)
b1.Text = "Fly: OFF"
b1.BackgroundColor3 = Color3.fromRGB(100,0,0)

local b2 = Instance.new("TextButton", f)
b2.Size = UDim2.new(0, 200, 0, 30)
b2.Position = UDim2.new(0, 10, 0, 50)
b2.Text = "Invisible: OFF"
b2.BackgroundColor3 = Color3.fromRGB(100,0,0)

local b3 = Instance.new("TextButton", f)
b3.Size = UDim2.new(0, 200, 0, 30)
b3.Position = UDim2.new(0, 10, 0, 90)
b3.Text = "NoClip: OFF"
b3.BackgroundColor3 = Color3.fromRGB(100,0,0)

local fly, invis, noclip = false, false, false
local bv = Instance.new("BodyVelocity", hrp)
bv.MaxForce = Vector3.new(1,1,1)*math.huge
bv.P = 1250
bv.Velocity = Vector3.zero
bv.Enabled = false

b1.MouseButton1Click:Connect(function()
    fly = not fly
    b1.Text = "Fly: "..(fly and "ON" or "OFF")
    b1.BackgroundColor3 = fly and Color3.fromRGB(0,150,0) or Color3.fromRGB(100,0,0)
    bv.Enabled = fly
end)

b2.MouseButton1Click:Connect(function()
    invis = not invis
    b2.Text = "Invisible: "..(invis and "ON" or "OFF")
    b2.BackgroundColor3 = invis and Color3.fromRGB(0,150,0) or Color3.fromRGB(100,0,0)
    for _,v in pairs(c:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v.Transparency = invis and 1 or 0
        elseif v:IsA("Decal") then
            v.Transparency = invis and 1 or 0
        end
    end
end)

b3.MouseButton1Click:Connect(function()
    noclip = not noclip
    b3.Text = "NoClip: "..(noclip and "ON" or "OFF")
    b3.BackgroundColor3 = noclip and Color3.fromRGB(0,150,0) or Color3.fromRGB(100,0,0)
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if fly then
        local cf = workspace.CurrentCamera.CFrame
        local mv = Vector3.zero
        local uis = game:GetService("UserInputService")
        if uis:IsKeyDown(Enum.KeyCode.W) then mv = mv + cf.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.S) then mv = mv - cf.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.A) then mv = mv - cf.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.D) then mv = mv + cf.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.Space) then mv = mv + cf.UpVector end
        if uis:IsKeyDown(Enum.KeyCode.LeftControl) then mv = mv - cf.UpVector end
        bv.Velocity = mv.Magnitude > 0 and mv.Unit * 100 or Vector3.zero
    end
    if noclip then
        for _,v in pairs(c:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    else
        for _,v in pairs(c:GetDescendants()) do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                v.CanCollide = true
            end
        end
    end
end)

p.CharacterAdded:Connect(function(chr)
    c = chr
    hrp = c:WaitForChild("HumanoidRootPart")
    bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(1,1,1)*math.huge
    bv.P = 1250
    bv.Velocity = Vector3.zero
    bv.Enabled = fly
end)
