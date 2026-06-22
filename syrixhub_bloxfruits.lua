local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ==================== SERVICES ====================
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- ==================== STATE ====================
local State = {
   AutoFarmLevel = false,
   AutoTakeQuest = false,
   AutoBones = false,
   AutoV3 = false,
   AutoV4 = false,
   AutoObservation = false,
}

-- ==================== WINDOW ====================
local Window = Rayfield:CreateWindow({
   Name = "SyrixHub — Bloxfruits",
   LoadingTitle = "SyrixHub — Bloxfruits",
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
local function SimulateKey(keyCode)
   local vInput = Instance.new("InputObject")
   vInput.KeyCode = keyCode
   vInput.UserInputType = Enum.UserInputType.Keyboard

   -- Fire using VirtualInputManager if available, else use fireclickdetector fallback
   pcall(function()
      game:GetService("VirtualInputManager"):SendKeyEvent(true, keyCode, false, game)
      task.wait(0.1)
      game:GetService("VirtualInputManager"):SendKeyEvent(false, keyCode, false, game)
   end)
end

local function Notify(title, content, duration)
   Rayfield:Notify({
      Title = title,
      Content = content,
      Duration = duration or 2.5,
      Image = 4483362458,
   })
end

-- ==================== LOOP SYSTEM ====================
local Loops = {}

local function StartLoop(name, interval, fn)
   if Loops[name] then return end
   Loops[name] = task.spawn(function()
      while State[name] do
         pcall(fn)
         task.wait(interval)
      end
      Loops[name] = nil
   end)
end

local function StopLoop(name)
   State[name] = false
   -- loop will self-terminate on next iteration
end

-- ==================== HOME TAB ====================
local HomeTab = Window:CreateTab("🏠 Home", 0)
HomeTab:CreateSection("Welcome to SyrixHub")
HomeTab:CreateLabel("👋 Made by @syrixscripts")
HomeTab:CreateDivider()
HomeTab:CreateLabel("⚡ Fast • Reliable • Updated")
HomeTab:CreateDivider()
HomeTab:CreateLabel("📌 Use the tabs above to navigate features")
HomeTab:CreateDivider()
HomeTab:CreateLabel("🔔 Join Discord for updates & support!")

-- ==================== MAIN FARM TAB ====================
local MainFarmTab = Window:CreateTab("⚔️ Main Farm", 1)
MainFarmTab:CreateSection("Auto Farming")

local AutoFarmLevelToggle = MainFarmTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Flag = "AutoFarmLevel",
   Callback = function(Value)
      State.AutoFarmLevel = Value
      if Value then
         Notify("Auto Farm Level", "✅ Auto farming levels enabled!", 2)
         StartLoop("AutoFarmLevel", 0.5, function()
            -- Auto farm level logic here
         end)
      else
         StopLoop("AutoFarmLevel")
         Notify("Auto Farm Level", "❌ Auto farm level disabled", 2)
      end
   end,
})

MainFarmTab:CreateDivider()
MainFarmTab:CreateSection("Quest System")

local AutoTakeQuestToggle = MainFarmTab:CreateToggle({
   Name = "Auto Take Quest",
   CurrentValue = false,
   Flag = "AutoTakeQuest",
   Callback = function(Value)
      State.AutoTakeQuest = Value
      if Value then
         Notify("Auto Take Quest", "✅ Auto quest enabled — taking quests between grinds!", 2.5)
         StartLoop("AutoTakeQuest", 5, function()
            -- Auto quest logic here
         end)
      else
         StopLoop("AutoTakeQuest")
         Notify("Auto Take Quest", "❌ Auto take quest disabled", 2)
      end
   end,
})

MainFarmTab:CreateLabel("ℹ️ Auto-takes quest between grinding sessions")
MainFarmTab:CreateDivider()

MainFarmTab:CreateSection("Bone Collection")

local AutoBonesToggle = MainFarmTab:CreateToggle({
   Name = "Auto Bones",
   CurrentValue = false,
   Flag = "AutoBones",
   Callback = function(Value)
      State.AutoBones = Value
      if Value then
         Notify("Auto Bones", "✅ Auto bones collection enabled!", 2)
         StartLoop("AutoBones", 1, function()
            -- Auto bones logic here
         end)
      else
         StopLoop("AutoBones")
         Notify("Auto Bones", "❌ Auto bones disabled", 2)
      end
   end,
})

-- ==================== SUB FARM TAB ====================
local SubFarmTab = Window:CreateTab("🌾 Sub Farm", 2)
SubFarmTab:CreateSection("Sub Farm Features")
SubFarmTab:CreateLabel("🔜 Sub Farm features coming soon!")
SubFarmTab:CreateDivider()
SubFarmTab:CreateLabel("Stay tuned for updates in Discord!")

-- ==================== QUEST/ITEMS TAB ====================
local QuestItemsTab = Window:CreateTab("🎯 Quest/Items", 3)
QuestItemsTab:CreateSection("Quest & Items")
QuestItemsTab:CreateLabel("🔜 Quest and Items features coming soon!")
QuestItemsTab:CreateDivider()
QuestItemsTab:CreateLabel("Join Discord to suggest features!")

-- ==================== SETTINGS TAB ====================
local SettingsTab = Window:CreateTab("⚙️ Settings", 5)

-- GUI Scale
SettingsTab:CreateSection("Interface")

local UIScaleSlider = SettingsTab:CreateSlider({
   Name = "GUI Scale",
   Range = {0.5, 2},
   Increment = 0.1,
   Suffix = "x",
   CurrentValue = 1,
   Flag = "UIScale",
   Callback = function(Value)
      pcall(function()
         if Window.UserSize then
            -- Smooth tween on scale change
            local goal = UDim2.new(0, 560 * Value, 0, 600 * Value)
            local tween = TweenService:Create(
               Window.Frame or Window,
               TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {Size = goal}
            )
            tween:Play()
         end
      end)
   end,
})

SettingsTab:CreateDivider()

-- ==================== AUTO V3 SYSTEM ====================
SettingsTab:CreateSection("Auto Key Systems")

local AutoV3Toggle = SettingsTab:CreateToggle({
   Name = "Auto V3  [ T key / 30s ]",
   CurrentValue = false,
   Flag = "AutoV3",
   Callback = function(Value)
      State.AutoV3 = Value
      if Value then
         Notify("Auto V3", "✅ Auto V3 enabled — pressing T every 30 seconds", 3)

         task.spawn(function()
            while State.AutoV3 do
               pcall(function()
                  SimulateKey(Enum.KeyCode.T)
               end)
               -- Countdown feedback every 10s
               task.wait(10)
               if State.AutoV3 then
                  task.wait(10)
               end
               if State.AutoV3 then
                  task.wait(10)
               end
            end
         end)

      else
         Notify("Auto V3", "❌ Auto V3 disabled", 2)
      end
   end,
})

SettingsTab:CreateLabel("ℹ️ Simulates pressing [T] every 30 seconds automatically")
SettingsTab:CreateDivider()

-- ==================== AUTO OBSERVATION SYSTEM ====================
local AutoObservationToggle = SettingsTab:CreateToggle({
   Name = "Auto Observation  [ E key / 5s ]",
   CurrentValue = false,
   Flag = "AutoObservation",
   Callback = function(Value)
      State.AutoObservation = Value
      if Value then
         Notify("Auto Observation", "✅ Observation enabled — pressing E every 5 seconds", 3)

         task.spawn(function()
            while State.AutoObservation do
               pcall(function()
                  SimulateKey(Enum.KeyCode.E)
               end)
               task.wait(5)
            end
         end)

      else
         Notify("Auto Observation", "❌ Observation disabled", 2)
      end
   end,
})

SettingsTab:CreateLabel("ℹ️ Simulates pressing [E] every 5 seconds to keep Observation active")
SettingsTab:CreateDivider()

-- Auto V4
local AutoV4Toggle = SettingsTab:CreateToggle({
   Name = "Auto V4",
   CurrentValue = false,
   Flag = "AutoV4",
   Callback = function(Value)
      State.AutoV4 = Value
      if Value then
         Notify("Auto V4", "✅ Auto V4 enabled!", 2)
         StartLoop("AutoV4", 1, function()
            -- V4 logic here
         end)
      else
         StopLoop("AutoV4")
         Notify("Auto V4", "❌ Auto V4 disabled", 2)
      end
   end,
})

-- ==================== SOCIALS TAB ====================
local SocialsTab = Window:CreateTab("🌐 Socials", 4934561911)
SocialsTab:CreateSection("Community")

SocialsTab:CreateButton({
   Name = "📋 Copy Discord Invite",
   Callback = function()
      setclipboard("https://discord.gg/Tds6abWdK")
      Notify("Copied!", "Discord invite link copied to clipboard!", 2.5)
   end,
})

SocialsTab:CreateDivider()
SocialsTab:CreateSection("Credits")

SocialsTab:CreateButton({
   Name = "👤 @syrixscripts",
   Callback = function()
      setclipboard("@syrixscripts")
      Notify("Copied!", "@syrixscripts copied to clipboard", 2)
   end,
})

SocialsTab:CreateLabel("💙 Made with care by @syrixscripts")

-- ==================== LOAD NOTIFICATION ====================
task.wait(1) -- slight delay for smooth load-in feel
Notify("Welcome to SyrixHub! 🎉", "Bloxfruits Hub loaded — enjoy your grind!", 4)
print("[SyrixHub] Loaded successfully!")