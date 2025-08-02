local p = game.Players.LocalPlayer
local h = p.Character:WaitForChild("Humanoid")
local g = Instance.new("ScreenGui", game.CoreGui)
local f = Instance.new("Frame", g)
local t = Instance.new("TextButton", f)
local up = Instance.new("TextButton", f)
local down = Instance.new("TextButton", f)
local l = Instance.new("TextLabel", f)
f.Size = UDim2.new(0,220,0,150)
f.Position = UDim2.new(0,350,0,100)
f.BackgroundColor3 = Color3.fromRGB(30,30,30)
f.BorderSizePixel = 0
t.Size = UDim2.new(0,200,0,30)
t.Position = UDim2.new(0,10,0,10)
t.Text = "Climb: OFF"
t.BackgroundColor3 = Color3.fromRGB(100,0,0)
up.Size = UDim2.new(0,95,0,30)
up.Position = UDim2.new(0,10,0,50)
up.Text = "Climb +"
up.BackgroundColor3 = Color3.fromRGB(0,100,0)
down.Size = UDim2.new(0,95,0,30)
down.Position = UDim2.new(0,115,0,50)
down.Text = "Climb -"
down.BackgroundColor3 = Color3.fromRGB(0,0,100)
l.Size = UDim2.new(0,200,0,30)
l.Position = UDim2.new(0,10,0,90)
l.Text = "Climb: 10"
l.BackgroundColor3 = Color3.fromRGB(50,50,50)
local e = false
local c = 10
local function u()
    l.Text = "Climb: "..c
end
t.MouseButton1Click:Connect(function()
    e = not e
    t.Text = "Climb: "..(e and "ON" or "OFF")
    t.BackgroundColor3 = e and Color3.fromRGB(0,150,0) or Color3.fromRGB(100,0,0)
    u()
end)
up.MouseButton1Click:Connect(function()
    c = c + 10
    u()
end)
down.MouseButton1Click:Connect(function()
    c = math.max(10,c-10)
    u()
end)
u()
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    h = char:WaitForChild("Humanoid")
end)
while true do
    if e then
        pcall(function()
            h.ClimbSpeed = c
        end)
    end
    wait(0.1)
end
