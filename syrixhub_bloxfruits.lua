local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

LocalPlayer.CharacterAdded:Connect(function(char)
   Character = char
   HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
   Humanoid = char:WaitForChild("Humanoid")
end)

local State = {
   AutoFarmLevel  = false,
   AutoTakeQuest  = false,
   AutoBones      = false,
   AutoV3         = false,
   AutoV4         = false,
   AutoObservation= false,
   AutoFarm       = false,
}

-- ==================== WINDOW ====================
local Window = Rayfield:CreateWindow({
   Name = "SyrixHub - Bloxfruits",
   LoadingTitle = "SyrixHub - Bloxfruits",