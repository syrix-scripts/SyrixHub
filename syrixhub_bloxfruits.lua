local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "SyrixHub—Bloxfruits",
   LoadingTitle = "SyrixHub—Bloxfruits",
   LoadingSubtitle = "Made by @syrixscripts",
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
   KeySettings = {
      Title = "Key System",
      Subtitle = "Key System",
      Note = "No method to get the key is provided",
      FileName = "Key",
      SaveKey = true,
      GoogleAnalyticsFileName = "UserID"
   }
})

Window.ShowWindowButton = false

-- ==================== SOCIALS TAB ====================
local SocialsTab = Window:CreateTab("Socials", 4934561911)
local SocialsSection = SocialsTab:CreateSection("Socials")

-- Discord Server Button
local DiscordButton = SocialsTab:CreateButton({
   Name = "Discord Server",
   Callback = function()
      setclipboard("https://discord.gg/Tds6abWdK")
      Rayfield:Notify({
         Title = "Copied!",
         Content = "Discord server link copied to clipboard",
         Duration = 2.5,
         Image = 4483362458,
      })
   end,
})

-- Credits Section
local CreditsSection = SocialsTab:CreateSection("Credits")
local CopyButton = SocialsTab:CreateButton({
   Name = "Made by @syrixscripts",
   Callback = function()
      setclipboard("@syrixscripts")
      Rayfield:Notify({
         Title = "Copied!",
         Content = "@syrixscripts copied to clipboard",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

SocialsTab:CreateLabel("Made by @syrixscripts")

-- ==================== HOME TAB ====================
local HomeTab = Window:CreateTab("Home", 0)
local HomeSection = HomeTab:CreateSection("Welcome to SyrixHub—Bloxfruits")

HomeTab:CreateLabel("Made by @syrixscripts")
HomeTab:CreateDivider()
HomeTab:CreateLabel("Select a section from the tabs above to get started!")

-- ==================== MAIN FARM TAB ====================
local MainFarmTab = Window:CreateTab("Main Farm", 1)
local MainFarmSection = MainFarmTab:CreateSection("Main Farm Features")

-- Auto Farm Level Toggle
local AutoFarmLevel = MainFarmTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Flag = "AutoFarmLevel",
   Callback = function(Value)
      print("Auto Farm Level:", Value)
      if Value then
         Rayfield:Notify({
            Title = "Enabled",
            Content = "Auto Farm Level is now enabled",
            Duration = 2,
            Image = 4483362458,
         })
      end
   end,
})

-- Auto Take Quest Toggle
local AutoTakeQuest = MainFarmTab:CreateToggle({
   Name = "Auto Take Quest",
   CurrentValue = false,
   Flag = "AutoTakeQuest",
   Callback = function(Value)
      print("Auto Take Quest:", Value)
      if Value then
         Rayfield:Notify({
            Title = "Enabled",
            Content = "Auto Take Quest is now enabled",
            Duration = 2,
            Image = 4483362458,
         })
      end
   end,
})

-- Footer for Auto Take Quest
MainFarmTab:CreateLabel("Auto take quest b/w grind")

-- Auto Bones Toggle
local AutoBones = MainFarmTab:CreateToggle({
   Name = "Auto Bones",
   CurrentValue = false,
   Flag = "AutoBones",
   Callback = function(Value)
      print("Auto Bones:", Value)
      if Value then
         Rayfield:Notify({
            Title = "Enabled",
            Content = "Auto Bones is now enabled",
            Duration = 2,
            Image = 4483362458,
         })
      end
   end,
})

-- ==================== SUB FARM TAB ====================
local SubFarmTab = Window:CreateTab("Sub Farm", 2)
local SubFarmSection = SubFarmTab:CreateSection("Sub Farm Features")

SubFarmTab:CreateLabel("Sub Farm features coming soon!")

-- ==================== QUEST/ITEMS TAB ====================
local QuestItemsTab = Window:CreateTab("Quest/Items", 3)
local QuestItemsSection = QuestItemsTab:CreateSection("Quest & Items")

QuestItemsTab:CreateLabel("Quest and Items features coming soon!")

-- ==================== SETTINGS TAB ====================
local SettingsTab = Window:CreateTab("Settings", 5)
local SettingsSection = SettingsTab:CreateSection("Settings")

-- GUI Scale Slider (Fixed)
local UIScale = SettingsTab:CreateSlider({
   Name = "GUI Scale",
   Range = {0.5, 2},
   Increment = 0.1,
   Suffix = "x",
   CurrentValue = 1,
   Flag = "UIScale",
   Callback = function(Value)
      pcall(function()
         local userInputService = game:GetService("UserInputService")
         if Window.UserSize then
            Window.UserSize = UDim2.new(0, 560 * Value, 0, 600 * Value)
         end
      end)
      print("GUI Scale set to:", Value)
   end,
})

-- Auto V3 Toggle
local AutoV3 = SettingsTab:CreateToggle({
   Name = "Auto V3",
   CurrentValue = false,
   Flag = "AutoV3",
   Callback = function(Value)
      print("Auto V3:", Value)
      if Value then
         Rayfield:Notify({
            Title = "Enabled",
            Content = "Auto V3 is now enabled",
            Duration = 2,
            Image = 4483362458,
         })
      end
   end,
})

-- Auto V4 Toggle
local AutoV4 = SettingsTab:CreateToggle({
   Name = "Auto V4",
   CurrentValue = false,
   Flag = "AutoV4",
   Callback = function(Value)
      print("Auto V4:", Value)
      if Value then
         Rayfield:Notify({
            Title = "Enabled",
            Content = "Auto V4 is now enabled",
            Duration = 2,
            Image = 4483362458,
         })
      end
   end,
})

-- Auto Observation Toggle
local AutoObservation = SettingsTab:CreateToggle({
   Name = "Auto Observation",
   CurrentValue = false,
   Flag = "AutoObservation",
   Callback = function(Value)
      print("Auto Observation:", Value)
      if Value then
         Rayfield:Notify({
            Title = "Enabled",
            Content = "Auto Observation is now enabled",
            Duration = 2,
            Image = 4483362458,
         })
      end
   end,
})

-- Notification on load
Rayfield:Notify({
   Title = "Welcome!",
   Content = "Welcome to SyrixHub—Bloxfruits",
   Duration = 3,
   Image = 4483362458,
})

print("SyrixHub—Bloxfruits loaded successfully!")
