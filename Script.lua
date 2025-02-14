while true do
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart then
        local function simulateTouch(part)
            if part and part:IsA("BasePart") then
                firetouchinterest(humanoidRootPart, part, 0)
                task.wait(0.1)
                firetouchinterest(humanoidRootPart, part, 1)
            end
        end

        local function simulateClick(clickDetector)
            if clickDetector and clickDetector:IsA("ClickDetector") then
                clickDetector:FireServer()
            end
        end

        for _, instance in pairs(game:GetDescendants()) do
            if instance:IsA("BasePart") then
                if instance:FindFirstChildOfClass("TouchTransmitter") then
                    simulateTouch(instance)
                end
                local clickDetector = instance:FindFirstChildOfClass("ClickDetector")
                if clickDetector then
                    simulateClick(clickDetector)
                end
            end
        end
    end

    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Rebirth"):FireServer()
    task.wait(0.1)

    local args = {
        [1] = "2"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("GemUpgrade"):FireServer(unpack(args))

    task.wait(0.1) -- Adjust wait time to prevent excessive server requests
end
