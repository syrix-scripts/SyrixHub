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
   LoadingSubtitle = "by @syrixscripts",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SyrixHub",
      FileName = "BloxfruitsConfig"
   },
   Discord = {
      Enabled = true,
      Invite = "Tds6abWdK",
      RememberJoins = true
   },
   KeySystem = false,
})

Window.ShowWindowButton = false

-- ==================== UTILITY ====================
local function Notify(title, content, duration)
   Rayfield:Notify({
      Title = title,
      Content = content,
      Duration = duration or 2.5,
      Image = 4483362458,
   })
end

local function PressKey(keyCode)
   pcall(function()
      VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
      task.wait(0.05)
      VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
   end)
end

-- Tween character to a position
local function TweenTo(targetPos, duration)
   duration = duration or 1.5
   local goal = {CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))}
   local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
   local tween = TweenService:Create(HumanoidRootPart, tweenInfo, goal)
   tween:Play()
   tween.Completed:Wait()
end

-- Get closest NPC matching a name keyword
local function FindNPC(keyword)
   local workspace = game:GetService("Workspace")
   local closest = nil
   local closestDist = math.huge

   -- Bloxfruits NPCs live inside Workspace.Map or Workspace directly
   local searchFolders = {workspace}
   pcall(function()
      if workspace:FindFirstChild("Map") then
         table.insert(searchFolders, workspace.Map)
      end
   end)

   for _, folder in ipairs(searchFolders) do
      for _, obj in ipairs(folder:GetDescendants()) do
         if obj:IsA("Model") and obj.Name:lower():find(keyword:lower()) then
            local root = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Torso")
            local hum  = obj:FindFirstChildOfClass("Humanoid")
            if root and hum and hum.Health > 0 then
               local dist = (HumanoidRootPart.Position - root.Position).Magnitude
               if dist < closestDist then
                  closestDist = dist
                  closest = obj
               end
            end
         end
      end
   end
   return closest
end

-- Parse quest target NPC name from the quest board/active quest
local function GetActiveQuestTarget()
   local target = nil
   pcall(function()
      -- Bloxfruits stores active quest info in PlayerGui or ReplicatedStorage
      local questGui = LocalPlayer.PlayerGui:FindFirstChild("Main")
         or LocalPlayer.PlayerGui:FindFirstChild("Quest")
      if questGui then
         for _, label in ipairs(questGui:GetDescendants()) do
            if label:IsA("TextLabel") and label.Text:lower():find("kill") then
               -- extract NPC name from "Kill X <NpcName>" pattern
               local name = label.Text:match("[Kk]ill%s+%d+%s+(.+)")
               if name then
                  target = name:gsub("%s+$", "")
               end
            end
         end
      end
   end)
   return target
end

-- Take quest from nearest quest giver NPC
local function TakeNearestQuest()
   pcall(function()
      local workspace = game:GetService("Workspace")
      local questNPCs = {"Quest", "Fist", "Sword", "Pirate", "Marine"}

      for _, keyword in ipairs(questNPCs) do
         local npc = FindNPC(keyword)
         if npc then
            local root = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Torso")
            if root then
               TweenTo(root.Position, 1)
               task.wait(0.5)
               -- Interact with quest NPC via click detector or remote
               local clickDetector = npc:FindFirstChildOfClass("ClickDetector")
                  or npc:FindFirstChild("Head") and npc.Head:FindFirstChildOfClass("ClickDetector")
               if clickDetector then
                  fireClickDetector(clickDetector)
                  task.wait(0.3)
               end
               -- Fire the quest accept remote
               local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
               if remotes then
                  local questRemote = remotes:FindFirstChild("CommF_")
                     or remotes:FindFirstChild("QuestRemote")
                  if questRemote then
                     pcall(function() questRemote:InvokeServer("StartQuest", npc) end)
                     pcall(function() questRemote:FireServer("StartQuest", npc) end)
                  end
               end
               break
            end
         end
      end
   end)
end

-- Melee attack loop against target NPC
local function MeleeAttack(targetModel)
   if not targetModel then return end
   local root = targetModel:FindFirstChild("HumanoidRootPart") or targetModel:FindFirstChild("Torso")
   local hum  = targetModel:FindFirstChildOfClass("Humanoid")
   if not root or not hum or hum.Health <= 0 then return end

   -- Walk/tween close
   local dist = (HumanoidRootPart.Position - root.Position).Magnitude
   if dist > 6 then
      TweenTo(root.Position, math.clamp(dist / 20, 0.3, 1.2))
   end

   -- Face target
   HumanoidRootPart.CFrame = CFrame.lookAt(HumanoidRootPart.Position, root.Position)

   -- Swing melee (Z is default melee in Bloxfruits)
   PressKey(Enum.KeyCode.Z)
   task.wait(0.1)

   -- Also try clicking (default attack)
   pcall(function()
      VirtualInputManager:SendMouseButtonEvent(
         Mouse.X, Mouse.Y, 0, true, game, 1
      )
      task.wait(0.05)
      VirtualInputManager:SendMouseButtonEvent(
         Mouse.X, Mouse.Y, 0, false, game, 1
      )
   end)
end

-- ==================== MAIN AUTO FARM LOOP ====================
local function AutoFarmLoop()
   while State.AutoFarm do
      pcall(function()
         -- 1. Get current quest target name
         local questTarget = GetActiveQuestTarget()

         -- 2. If no active quest, try to take one
         if not questTarget then
            TakeNearestQuest()
            task.wait(2)
            questTarget = GetActiveQuestTarget()
         end

         -- 3. Find and kill target NPC
         if questTarget then
            local npc = FindNPC(questTarget)
            if npc then
               local hum = npc:FindFirstChildOfClass("Humanoid")
               -- Attack until dead
               while npc and hum and hum.Health > 0 and State.AutoFarm do
                  MeleeAttack(npc)
                  task.wait(0.3 / 1.3) -- 1.3x attack speed
               end
            else
               task.wait(1)
            end
         else
            task.wait(2)
         end
      end)

      task.wait(0.1)
   end
end

-- ==================== HOME TAB ====================
local HomeTab = Window:CreateTab("Home", 0)
HomeTab:CreateSection("Welcome to SyrixHub")
HomeTab:CreateLabel("Made by @syrixscripts")
HomeTab:CreateDivider()
HomeTab:CreateLabel("Select a tab above to get started")

-- ==================== MAIN FARM TAB ====================
local MainFarmTab = Window:CreateTab("Main Farm", 1)
MainFarmTab:CreateSection("Auto Farm")

MainFarmTab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value)
      State.AutoFarm = Value
      if Value then
         Notify("Auto Farm", "Enabled - detecting quest and farming", 2.5)
         task.spawn(AutoFarmLoop)
      else
         Notify("Auto Farm", "Disabled", 2)
      end
   end,
})

MainFarmTab:CreateDivider()
MainFarmTab:CreateSection("Farming")

MainFarmTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Flag = "AutoFarmLevel",
   Callback = function(Value)
      State.AutoFarmLevel = Value
      if Value then
         Notify("Auto Farm Level", "Enabled", 2)
         task.spawn(function()
            while State.AutoFarmLevel do
               task.wait(0.1)
            end
         end)
      else
         Notify("Auto Farm Level", "Disabled", 2)
      end
   end,
})

MainFarmTab:CreateSection("Quest")

MainFarmTab:CreateToggle({
   Name = "Auto Take Quest",
   CurrentValue = false,
   Flag = "AutoTakeQuest",
   Callback = function(Value)
      State.AutoTakeQuest = Value
      if Value then
         Notify("Auto Take Quest", "Enabled", 2)
         task.spawn(function()
            while State.AutoTakeQuest do
               TakeNearestQuest()
               task.wait(5)
            end
         end)
      else
         Notify("Auto Take Quest", "Disabled", 2)
      end
   end,
})

MainFarmTab:CreateLabel("Auto takes quest between grinding")
MainFarmTab:CreateDivider()
MainFarmTab:CreateSection("Bones")

MainFarmTab:CreateToggle({
   Name = "Auto Bones",
   CurrentValue = false,
   Flag = "AutoBones",
   Callback = function(Value)
      State.AutoBones = Value
      if Value then
         Notify("Auto Bones", "Enabled", 2)
         task.spawn(function()
            while State.AutoBones do
               task.wait(0.1)
            end
         end)
      else
         Notify("Auto Bones", "Disabled", 2)
      end
   end,
})

-- ==================== SUB FARM TAB ====================
local SubFarmTab = Window:CreateTab("Sub Farm", 2)
SubFarmTab:CreateSection("Sub Farm")
SubFarmTab:CreateLabel("Sub Farm features coming soon")

-- ==================== QUEST/ITEMS TAB ====================
local QuestItemsTab = Window:CreateTab("Quest/Items", 3)
QuestItemsTab:CreateSection("Quest and Items")
QuestItemsTab:CreateLabel("Quest and Items features coming soon")

-- ==================== SETTINGS TAB ====================
local SettingsTab = Window:CreateTab("Settings", 5)
SettingsTab:CreateSection("Interface")

-- GUI Scale — adjusts Rayfield's actual ScreenGui scale
SettingsTab:CreateSlider({
   Name = "GUI Scale",
   Range = {50, 150},
   Increment = 5,
   Suffix = "%",
   CurrentValue = 100,
   Flag = "UIScale",
   Callback = function(Value)
      pcall(function()
         local scale = Value / 100
         -- Find Rayfield ScreenGui and apply UIScale
         for _, gui in ipairs(LocalPlayer.PlayerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and (gui.Name:find("Rayfield") or gui.Name:find("SyrixHub")) then
               local uiScale = gui:FindFirstChildOfClass("UIScale")
               if not uiScale then
                  uiScale = Instance.new("UIScale", gui)
               end
               -- Smooth tween the scale
               TweenService:Create(
                  uiScale,
                  TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                  {Scale = scale}
               ):Play()
            end
         end
      end)
   end,
})

SettingsTab:CreateDivider()
SettingsTab:CreateSection("Key Systems")

SettingsTab:CreateToggle({
   Name = "Auto V3",
   CurrentValue = false,
   Flag = "AutoV3",
   Callback = function(Value)
      State.AutoV3 = Value
      if Value then
         Notify("Auto V3", "Enabled", 2)
         task.spawn(function()
            while State.AutoV3 do
               PressKey(Enum.KeyCode.T)
               local elapsed = 0
               while elapsed < 30 and State.AutoV3 do
                  task.wait(0.5)
                  elapsed = elapsed + 0.5
               end
            end
         end)
      else
         Notify("Auto V3", "Disabled", 2)
      end
   end,
})

SettingsTab:CreateToggle({
   Name = "Auto Observation",
   CurrentValue = false,
   Flag = "AutoObservation",
   Callback = function(Value)
      State.AutoObservation = Value
      if Value then
         Notify("Auto Observation", "Enabled", 2)
         task.spawn(function()
            while State.AutoObservation do
               PressKey(Enum.KeyCode.E)
               local elapsed = 0
               while elapsed < 5 and State.AutoObservation do
                  task.wait(0.1)
                  elapsed = elapsed + 0.1
               end
            end
         end)
      else
         Notify("Auto Observation", "Disabled", 2)
      end
   end,
})

SettingsTab:CreateToggle({
   Name = "Auto V4",
   CurrentValue = false,
   Flag = "AutoV4",
   Callback = function(Value)
      State.AutoV4 = Value
      if Value then
         Notify("Auto V4", "Enabled", 2)
         task.spawn(function()
            while State.AutoV4 do
               task.wait(0.1)
            end
         end)
      else
         Notify("Auto V4", "Disabled", 2)
      end
   end,
})

-- ==================== SOCIALS TAB ====================
local SocialsTab = Window:CreateTab("Socials", 4934561911)
SocialsTab:CreateSection("Socials")

SocialsTab:CreateButton({
   Name = "Discord Server",
   Callback = function()
      setclipboard("https://discord.gg/Tds6abWdK")
      Notify("Copied", "Discord link copied to clipboard", 2.5)
   end,
})

SocialsTab:CreateDivider()
SocialsTab:CreateSection("Credits")

SocialsTab:CreateButton({
   Name = "Made by @syrixscripts",
   Callback = function()
      setclipboard("@syrixscripts")
      Notify("Copied", "@syrixscripts copied to clipboard", 2)
   end,
})

SocialsTab:CreateLabel("Made by @syrixscripts")

-- ==================== LOAD ====================
task.wait(0.5)
Notify("SyrixHub", "Welcome to SyrixHub - Bloxfruits", 3)
print("[SyrixHub] Loaded")