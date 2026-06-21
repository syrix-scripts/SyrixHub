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
      Enabled = false,
      Invite = "noinvitelink",
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

-- Create main tab with title and subtitle
local MainTab = Window:CreateTab("Home", 0)
local MainSection = MainTab:CreateSection("SyrixHub—Bloxfruits")

-- Add subtitle
MainTab:CreateLabel("Made by @syrixscripts")

-- Create Credits section
local CreditsSection = MainTab:CreateSection("Credits")

-- Copy username button
local CopyButton = MainTab:CreateButton({
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

-- Divider
MainTab:CreateDivider()

-- Create Features tab
local FeaturesTab = Window:CreateTab("Features", 1)
local FeaturesSection = FeaturesTab:CreateSection("Coming Soon")

FeaturesTab:CreateLabel("Features will be added soon!")

-- Create Settings tab
local SettingsTab = Window:CreateTab("Settings", 2)
local SettingsSection = SettingsTab:CreateSection("UI Settings")

-- UI Scale slider
local UIScale = SettingsTab:CreateSlider({
   Name = "UI Scale",
   Range = {0.5, 2},
   Increment = 0.1,
   Suffix = "x",
   CurrentValue = 1,
   Flag = "UIScale",
   Callback = function(Value)
      print("UI Scale set to:", Value)
   end,
})

-- Toggle notifications
local NotificationsToggle = SettingsTab:CreateToggle({
   Name = "Enable Notifications",
   CurrentValue = true,
   Flag = "NotificationsToggle",
   Callback = function(Value)
      print("Notifications:", Value)
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
