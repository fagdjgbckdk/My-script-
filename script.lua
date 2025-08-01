local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")
local jumpEnabled = false
local currentJumpPower = 50

local function updateJump()
    if jumpEnabled then
        humanoid.JumpPower = currentJumpPower
    else
        humanoid.JumpPower = 50
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(key, gpe)
    if gpe then return end
    if key.KeyCode == Enum.KeyCode.J then
        jumpEnabled = not jumpEnabled
        updateJump()
    elseif key.KeyCode == Enum.KeyCode.K then
        currentJumpPower = currentJumpPower + 10
        updateJump()
    elseif key.KeyCode == Enum.KeyCode.L then
        currentJumpPower = math.max(50, currentJumpPower - 10)
        updateJump()
    end
end)
