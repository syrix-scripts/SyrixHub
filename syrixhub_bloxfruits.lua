-- SyrixHub UI Script
-- Created by @syrixscripts
-- Safe for testing in controlled environments

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SyrixHub"
screenGui.Parent = CoreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Prevent multiple instances
if CoreGui:FindFirstChild("SyrixHub") then
    CoreGui:FindFirstChild("SyrixHub"):Destroy()
end

-- Discord invite link
local DISCORD_INVITE = "https://discord.gg/9aGQqc45Ph"

-- ============================================
-- LOADING SCREEN (HoHo Hub style inspiration)
-- ============================================

local loadingFrame = Instance.new("Frame")
loadingFrame.Name = "LoadingScreen"
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
loadingFrame.BackgroundTransparency = 1
loadingFrame.Parent = screenGui

local loadingImage = Instance.new("ImageLabel")
loadingImage.Name = "LoadingImage"
loadingImage.Size = UDim2.new(0, 200, 0, 200)
loadingImage.Position = UDim2.new(0.5, -100, 0.5, -100)
loadingImage.BackgroundTransparency = 1
loadingImage.Image = "https://cdn.discordapp.com/attachments/1504163901405790334/1519984324479553557/file_0000000094287230b84f1debaaa5c579.png?ex=6a3f8b36&is=6a3e39b6&hm=688860a6df6dce262765da76e70cda8e154c3255318c2b99bd3dc96d8a7b27a2&"
loadingImage.ImageTransparency = 1
loadingImage.ScaleType = Enum.ScaleType.Fit
loadingImage.Parent = loadingFrame

-- Loading animation sequence
task.spawn(function()
    -- Fade in
    local fadeIn = TweenService:Create(loadingImage, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0})
    fadeIn:Play()
    fadeIn.Completed:Wait()
    
    -- Zoom and slide up
    local zoomIn = TweenService:Create(loadingImage, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 250, 0, 250), Position = UDim2.new(0.5, -125, 0.5, -125)})
    zoomIn:Play()
    zoomIn.Completed:Wait()
    
    wait(0.3)
    
    local slideUp = TweenService:Create(loadingImage, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, -125, -0.3, 0), ImageTransparency = 0.5})
    slideUp:Play()
    slideUp.Completed:Wait()
    
    -- Fade out loading screen
    local fadeOut = TweenService:Create(loadingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
    fadeOut:Play()
    fadeOut.Completed:Wait()
    
    loadingFrame:Destroy()
end)

-- Wait for loading to complete
wait(2.5)

-- ============================================
-- NOTIFICATION SYSTEM
-- ============================================

local notificationFrame = Instance.new("Frame")
notificationFrame.Name = "Notification"
notificationFrame.Size = UDim2.new(0, 300, 0, 60)
notificationFrame.Position = UDim2.new(1, -320, 0, 20)
notificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
notificationFrame.BackgroundTransparency = 1
notificationFrame.BorderSizePixel = 0
notificationFrame.ClipsDescendants = true
notificationFrame.Parent = screenGui

-- Rounded corners for notification
local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 12)
notifCorner.Parent = notificationFrame

local notifStroke = Instance.new("UIStroke")
notifStroke.Color = Color3.fromRGB(100, 100, 255)
notifStroke.Thickness = 1.5
notifStroke.Transparency = 0.5
notifStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
notifStroke.Parent = notificationFrame

local notifTitle = Instance.new("TextLabel")
notifTitle.Name = "Title"
notifTitle.Size = UDim2.new(1, -20, 0, 25)
notifTitle.Position = UDim2.new(0, 10, 0, 5)
notifTitle.BackgroundTransparency = 1
notifTitle.Text = "SyrixHub"
notifTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
notifTitle.TextSize = 16
notifTitle.Font = Enum.Font.GothamBold
notifTitle.TextXAlignment = Enum.TextXAlignment.Left
notifTitle.Parent = notificationFrame

local notifSubtitle = Instance.new("TextLabel")
notifSubtitle.Name = "Subtitle"
notifSubtitle.Size = UDim2.new(1, -20, 0, 20)
notifSubtitle.Position = UDim2.new(0, 10, 0, 30)
notifSubtitle.BackgroundTransparency = 1
notifSubtitle.Text = "SyrixHub loaded\nCredits: @syrixscripts"
notifSubtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
notifSubtitle.TextSize = 12
notifSubtitle.Font = Enum.Font.Gotham
notifSubtitle.TextXAlignment = Enum.TextXAlignment.Left
notifSubtitle.TextWrapped = true
notifSubtitle.Parent = notificationFrame

-- Show notification with smooth animation
task.spawn(function()
    wait(2.7) -- Wait for loading to finish
    
    -- Slide in from right
    local slideIn = TweenService:Create(notificationFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -320, 0, 20)})
    notificationFrame.BackgroundTransparency = 0
    slideIn:Play()
    slideIn.Completed:Wait()
    
    wait(2)
    
    -- Slide out
    local slideOut = TweenService:Create(notificationFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, 0, 20), BackgroundTransparency = 1})
    slideOut:Play()
    slideOut.Completed:Wait()
    
    notificationFrame:Destroy()
end)

-- ============================================
-- MAIN UI
-- ============================================

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 550, 0, 400)
mainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
mainFrame.BackgroundTransparency = 1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Main UI Corner
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

-- Main UI Stroke
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(80, 80, 120)
mainStroke.Thickness = 2
mainStroke.Transparency = 0.3
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.Parent = mainFrame

-- Drop shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.Position = UDim2.new(0, -20, 0, -20)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6015897843"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(49, 49, 450, 450)
shadow.Parent = mainFrame

-- Gradient background
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
})
gradient.Rotation = 45
gradient.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 16)
titleCorner.Parent = titleBar

-- Fix bottom corners
local titleBottomFix = Instance.new("Frame")
titleBottomFix.Size = UDim2.new(1, 0, 0.5, 0)
titleBottomFix.Position = UDim2.new(0, 0, 0.5, 0)
titleBottomFix.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
titleBottomFix.BorderSizePixel = 0
titleBottomFix.Parent = titleBar

-- Title Text
local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0.5, 0, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "SyrixHub"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 18
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Title gradient
local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 255))
})
titleGradient.Parent = titleText

-- Control buttons container
local controlsFrame = Instance.new("Frame")
controlsFrame.Size = UDim2.new(0, 100, 0, 30)
controlsFrame.Position = UDim2.new(1, -110, 0, 5)
controlsFrame.BackgroundTransparency = 1
controlsFrame.Parent = titleBar

-- Discord button
local discordButton = Instance.new("TextButton")
discordButton.Name = "Discord"
discordButton.Size = UDim2.new(0, 28, 0, 28)
discordButton.Position = UDim2.new(0, 0, 0, 0)
discordButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
discordButton.BackgroundTransparency = 0.3
discordButton.Text = "🌐"
discordButton.TextSize = 14
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordButton.BorderSizePixel = 0
discordButton.AutoButtonColor = false
discordButton.Parent = controlsFrame

local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0, 6)
discordCorner.Parent = discordButton

discordButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_INVITE)
    end
    -- Visual feedback
    local flash = TweenService:Create(discordButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0})
    flash:Play()
    flash.Completed:Wait()
    local unflash = TweenService:Create(discordButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.3})
    unflash:Play()
end)

-- Minimize button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "Minimize"
minimizeButton.Size = UDim2.new(0, 28, 0, 28)
minimizeButton.Position = UDim2.new(0, 32, 0, 0)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
minimizeButton.BackgroundTransparency = 0.3
minimizeButton.Text = "-"
minimizeButton.TextSize = 18
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.BorderSizePixel = 0
minimizeButton.AutoButtonColor = false
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = controlsFrame

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeButton

local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        -- Minimize animation
        local minimize = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 550, 0, 40)})
        minimize:Play()
    else
        -- Maximize animation
        local maximize = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 550, 0, 400)})
        maximize:Play()
    end
end)

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "Close"
closeButton.Size = UDim2.new(0, 28, 0, 28)
closeButton.Position = UDim2.new(0, 64, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeButton.BackgroundTransparency = 0.3
closeButton.Text = "X"
closeButton.TextSize = 14
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BorderSizePixel = 0
closeButton.AutoButtonColor = false
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = controlsFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    -- Close animation
    local shrink = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)})
    shrink:Play()
    shrink.Completed:Wait()
    screenGui:Destroy()
end)

-- Button hover effects
local function addHoverEffects(button, defaultTransparency)
    button.MouseEnter:Connect(function()
        local hover = TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = defaultTransparency - 0.2})
        hover:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local leave = TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = defaultTransparency})
        leave:Play()
    end)
end

addHoverEffects(discordButton, 0.3)
addHoverEffects(minimizeButton, 0.3)
addHoverEffects(closeButton, 0.3)

-- ============================================
-- SIDE NAVIGATION
-- ============================================

local sideNav = Instance.new("Frame")
sideNav.Name = "SideNav"
sideNav.Size = UDim2.new(0, 140, 1, -40)
sideNav.Position = UDim2.new(0, 0, 0, 40)
sideNav.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
sideNav.BorderSizePixel = 0
sideNav.Parent = mainFrame

local sideNavCorner = Instance.new("UICorner")
sideNavCorner.CornerRadius = UDim.new(0, 0)
sideNavCorner.Parent = sideNav

-- Navigation buttons
local navButtons = {}
local sections = {"Social", "Settings", "Main Farm"}
local currentSection = nil

local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -140, 1, -40)
contentFrame.Position = UDim2.new(0, 140, 0, 40)
contentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- Create section pages
local socialPage = Instance.new("ScrollingFrame")
socialPage.Size = UDim2.new(1, -20, 1, -20)
socialPage.Position = UDim2.new(0, 10, 0, 10)
socialPage.BackgroundTransparency = 1
socialPage.ScrollBarThickness = 4
socialPage.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 100)
socialPage.CanvasSize = UDim2.new(0, 0, 0, 200)
socialPage.Visible = false
socialPage.Parent = contentFrame

local settingsPage = Instance.new("ScrollingFrame")
settingsPage.Size = UDim2.new(1, -20, 1, -20)
settingsPage.Position = UDim2.new(0, 10, 0, 10)
settingsPage.BackgroundTransparency = 1
settingsPage.ScrollBarThickness = 4
settingsPage.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 100)
settingsPage.CanvasSize = UDim2.new(0, 0, 0, 350)
settingsPage.Visible = false
settingsPage.Parent = contentFrame

local mainFarmPage = Instance.new("ScrollingFrame")
mainFarmPage.Size = UDim2.new(1, -20, 1, -20)
mainFarmPage.Position = UDim2.new(0, 10, 0, 10)
mainFarmPage.BackgroundTransparency = 1
mainFarmPage.ScrollBarThickness = 4
mainFarmPage.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 100)
mainFarmPage.CanvasSize = UDim2.new(0, 0, 0, 500)
mainFarmPage.Visible = false
mainFarmPage.Parent = contentFrame

-- Create nav buttons with smooth animations
for i, sectionName in ipairs(sections) do
    local navButton = Instance.new("TextButton")
    navButton.Name = sectionName
    navButton.Size = UDim2.new(1, -20, 0, 35)
    navButton.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 45)
    navButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    navButton.BackgroundTransparency = 0.5
    navButton.Text = sectionName
    navButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    navButton.TextSize = 14
    navButton.Font = Enum.Font.GothamSemibold
    navButton.BorderSizePixel = 0
    navButton.AutoButtonColor = false
    navButton.Parent = sideNav
    
    local navCorner = Instance.new("UICorner")
    navCorner.CornerRadius = UDim.new(0, 8)
    navCorner.Parent = navButton
    
    local navGradient = Instance.new("UIGradient")
    navGradient.Parent = navButton
    
    -- Selection indicator
    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(0, 3, 0.6, 0)
    indicator.Position = UDim2.new(0, -10, 0.2, 0)
    indicator.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    indicator.BorderSizePixel = 0
    indicator.BackgroundTransparency = 1
    indicator.Parent = navButton
    
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, 2)
    indicatorCorner.Parent = indicator
    
    navButton.MouseButton1Click:Connect(function()
        if currentSection == sectionName then return end
        currentSection = sectionName
        
        -- Hide all pages with fade out
        for _, page in ipairs({socialPage, settingsPage, mainFarmPage}) do
            if page.Visible then
                local fadeOut = TweenService:Create(page, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Position = UDim2.new(0, 30, 0, 10)})
                fadeOut:Play()
                fadeOut.Completed:Wait()
                page.Visible = false
            end
        end
        
        -- Show selected page with fade in
        local selectedPage
        if sectionName == "Social" then
            selectedPage = socialPage
        elseif sectionName == "Settings" then
            selectedPage = settingsPage
        elseif sectionName == "Main Farm" then
            selectedPage = mainFarmPage
        end
        
        selectedPage.Position = UDim2.new(0, 30, 0, 10)
        selectedPage.Visible = true
        local fadeIn = TweenService:Create(selectedPage, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 10, 0, 10)})
        fadeIn:Play()
        
        -- Update button styles
        for _, btn in ipairs(navButtons) do
            local resetStyle = TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.5})
            resetStyle:Play()
            local resetIndicator = TweenService:Create(btn.Indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
            resetIndicator:Play()
        end
        
        local activeStyle = TweenService:Create(navButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2})
        activeStyle:Play()
        local showIndicator = TweenService:Create(indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0})
        showIndicator:Play()
    end)
    
    table.insert(navButtons, navButton)
end

-- ============================================
-- SOCIAL PAGE CONTENT
-- ============================================

local socialTitle = Instance.new("TextLabel")
socialTitle.Size = UDim2.new(1, 0, 0, 30)
socialTitle.Position = UDim2.new(0, 0, 0, 10)
socialTitle.BackgroundTransparency = 1
socialTitle.Text = "SyrixHub"
socialTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
socialTitle.TextSize = 24
socialTitle.Font = Enum.Font.GothamBold
socialTitle.TextXAlignment = Enum.TextXAlignment.Center
socialTitle.Parent = socialPage

local creatorLabel = Instance.new("TextLabel")
creatorLabel.Size = UDim2.new(1, 0, 0, 20)
creatorLabel.Position = UDim2.new(0, 0, 0, 45)
creatorLabel.BackgroundTransparency = 1
creatorLabel.Text = "Created By @syrixscripts"
creatorLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
creatorLabel.TextSize = 14
creatorLabel.Font = Enum.Font.Gotham
creatorLabel.TextXAlignment = Enum.TextXAlignment.Center
creatorLabel.Parent = socialPage

local discordSocialButton = Instance.new("TextButton")
discordSocialButton.Size = UDim2.new(0.7, 0, 0, 40)
discordSocialButton.Position = UDim2.new(0.15, 0, 0, 80)
discordSocialButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discordSocialButton.BackgroundTransparency = 0.2
discordSocialButton.Text = "Join Discord"
discordSocialButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordSocialButton.TextSize = 16
discordSocialButton.Font = Enum.Font.GothamBold
discordSocialButton.BorderSizePixel = 0
discordSocialB