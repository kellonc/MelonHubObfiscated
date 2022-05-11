local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
  --VARIABLES
  local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
  local Window = Library.CreateLib("MelonHub | Strucid", "Sentinel")
  local Main = Window:NewTab("Main")
  local MainSection = Main:NewSection("Main")
  local Player = Window:NewTab("Player")
  local PlayerSection = Player:NewSection("Player")
  local Custom = Window:NewTab("Customize")
  local CustomSection = Custom:NewSection("UI Colors")
  local Aimbot = Window:NewTab("Aimbot")
  local AimSection = Aimbot:NewSection("Aimbot")
  local Esp = Window:NewTab("ESP")
  local EspSection = Esp:NewSection("ESP")
  local Holding = false
  --CUSTOMIZE UI
  local colors = {
      SchemeColor = Color3.fromRGB(0,255,255),
      Background = Color3.fromRGB(0, 0, 0),
      Header = Color3.fromRGB(0, 0, 0),
      TextColor = Color3.fromRGB(255,255,255),
      ElementColor = Color3.fromRGB(20, 20, 20)
  }
  for theme, color in pairs(colors) do
      CustomSection:NewColorPicker(theme, "Change your "..theme, color, function(color3)
          Library:ChangeColor(theme, color3)
      end)
  end
  
  --UI TOGGLE
  MainSection:NewKeybind("Toggle UI", "Shows/Hides the gui", Enum.KeyCode.RightControl, function()
      Library:ToggleUI()
  end)
  --AIMBOT
  _G.Aimbot = false
  _G.Silentaim = false
  _G.Teamcheck = false
  _G.Aimpart = "Head"
  _G.hitpart = "Head"
  _G.Sensitivity = 0
  _G.Distance = 500
  --ESP
  _G.esp = false
  _G.nametxt = false
  _G.tracers = false
  _G.boxcolor = Color3.fromRGB(207, 38, 103)

  _G.CircleSides = 64 -- How many sides the FOV circle would have.
  _G.CircleColor = Color3.fromRGB(235, 45, 92) -- (RGB) Color that the FOV circle would appear as.
  _G.CircleTransparency = 0.7 -- Transparency of the circle.
  _G.CircleRadius = 80 -- The radius of the circle / FOV.
  _G.CircleFilled = false -- Determines whether or not the circle is filled.
  _G.CircleVisible = true -- Determines whether or not the circle is visible.
  _G.CircleThickness = 0 -- The thickness of the circle.

  local FOVCircle = Drawing.new("Circle")
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Filled = _G.CircleFilled
    FOVCircle.Color = _G.CircleColor
    FOVCircle.Visible = _G.CircleVisible
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Transparency = _G.CircleTransparency
    FOVCircle.NumSides = _G.CircleSides
    FOVCircle.Thickness = _G.CircleThickness

    local function GetClosestPlayer()
        local MaximumDistance = _G.CircleRadius
        local Target = nil

        for _, v in next, Players:GetPlayers() do
            if v.Name ~= LocalPlayer.Name then
                if _G.Teamcheck == true then
                    if v.Team ~= LocalPlayer.Team then
                        if v.Character ~= nil then
                            if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                    local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                    local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude

                                    if VectorDistance < MaximumDistance then
                                        if _G.Distance > (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude then
                                        Target = v
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if v.Character ~= nil then
                        if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                            if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                
                                if VectorDistance < MaximumDistance then
                                    if _G.Distance > (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude then
                                    Target = v
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return Target
    end

    UserInputService.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton2 then
            Holding = true
        end
    end)

    UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton2 then
            Holding = false
        end
    end)

    RunService.RenderStepped:Connect(function()
        FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
        FOVCircle.Radius = _G.CircleRadius
        FOVCircle.Filled = _G.CircleFilled
        FOVCircle.Color = _G.CircleColor
        FOVCircle.Visible = _G.CircleVisible
        FOVCircle.Radius = _G.CircleRadius
        FOVCircle.Transparency = _G.CircleTransparency
        FOVCircle.NumSides = _G.CircleSides
        FOVCircle.Thickness = _G.CircleThickness

        if Holding == true and _G.Aimbot == true then
            TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.Aimpart].Position)}):Play()
        end
    end)

    --ESP
local Player = game:GetService("Players").LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = Player:GetMouse()

local function Dist(pointA, pointB) -- magnitude errors for some reason  : (
    return math.sqrt(math.pow(pointA.X - pointB.X, 2) + math.pow(pointA.Y - pointB.Y, 2))
end

local function GetClosest(points, dest)
    local min  = math.huge 
    local closest = nil
    for _,v in pairs(points) do
        local dist = Dist(v, dest)
        if dist < min then
            min = dist
            closest = v
        end
    end
    return closest
end

local function DrawESP(plr)
    local Box = Drawing.new("Quad")
    Box.Visible = false
    Box.PointA = Vector2.new(0, 0)
    Box.PointB = Vector2.new(0, 0)
    Box.PointC = Vector2.new(0, 0)
    Box.PointD = Vector2.new(0, 0)
    Box.Color = _G.boxcolor
    Box.Thickness = 2
    Box.Transparency = 1
    local NameTxt = Drawing.new("Text")
    NameTxt.Text = plr.Name
    NameTxt.Size = 20
    NameTxt.Center = true
    NameTxt.Visible = false
    NameTxt.Color = Color3.fromRGB(118, 42, 240)
    NameTxt.Position = Vector2.new(0, 0)
    local Line = Drawing.new("Line")
    Line.Visible = false
    Line.From = Vector2.new(0, 0)
    Line.To = Vector2.new(0, 0)
    Line.Color = Color3.fromRGB(207, 38, 103)
    Line.Thickness = 2
    Line.Transparency = 1
    Line.ZIndex = 1


    local function Update()
        local c
        c = game:GetService("RunService").RenderStepped:Connect(function()
            if plr.Character ~= nil and plr.Character:FindFirstChildOfClass("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
                if plr.Team == LocalPlayer.Team then
                    Box.Color = Color3.fromRGB(45, 55, 185)
                    Line.Color = Color3.fromRGB(45, 55, 185)
                    NameTxt.Color = Color3.fromRGB(45, 55, 185)
                else
                    Box.Color = Color3.fromRGB(207, 38, 103)
                    Line.Color = Color3.fromRGB(207, 38, 103)
                    NameTxt.Color = Color3.fromRGB(207, 38, 103)
                end
                local pos, vis = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                if vis then 
                    local points = {}
                    local c = 0
                    for _,v in pairs(plr.Character:GetChildren()) do
                        if v:IsA("BasePart") then
                            c = c + 1
                            local p = Camera:WorldToViewportPoint(v.Position)
                            if v.Name == "HumanoidRootPart" then
                                p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, 0, -v.Size.Z)).p)
                            elseif v.Name == "Head" then
                                p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, v.Size.Y/2, v.Size.Z/1.25)).p)
                            elseif string.match(v.Name, "Left") then
                                p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(-v.Size.X/2, 0, 0)).p)
                            elseif string.match(v.Name, "Right") then
                                p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(v.Size.X/2, 0, 0)).p)
                            end
                            points[c] = p
                        end
                    end
                    local Left = GetClosest(points, Vector2.new(0, pos.Y))
                    local Right = GetClosest(points, Vector2.new(Camera.ViewportSize.X, pos.Y))
                    local Top = GetClosest(points, Vector2.new(pos.X, 0))
                    local Bottom = GetClosest(points, Vector2.new(pos.X, Camera.ViewportSize.Y))

                    if Left ~= nil and Right ~= nil and Top ~= nil and Bottom ~= nil then
                        Box.PointA = Vector2.new(Right.X, Top.Y)
                        Box.PointB = Vector2.new(Left.X, Top.Y)
                        Box.PointC = Vector2.new(Left.X, Bottom.Y)
                        Box.PointD = Vector2.new(Right.X, Bottom.Y)
                        NameTxt.Position = Vector2.new(Right.X, Bottom.Y)
                        Line.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                        Line.To = Vector2.new(Right.X, Bottom.Y)
                        if _G.esp == true then
                        Box.Visible = true
                        if _G.nametxt == true then
                            NameTxt.Visible = true
                            if _G.tracers == true then
                                Line.Visible = true
                                end
                            end
                        end
                    else if _G.esp == false then
                        Box.Visible = false
                        NameTxt.Visible = false
                        Line.Visible = false
                    end
                    end
                else 
                    Box.Visible = false
                    NameTxt.Visible = false
                    Line.Visible = false
                end
            else
                Box.Visible = false
                NameTxt.Visible = false
                Line.Visible = false
                if game.Players:FindFirstChild(plr.Name) == nil then
                    c:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Update)()
end

for _,v in pairs(game:GetService("Players"):GetChildren()) do
    if v.Name ~= Player.Name then 
        DrawESP(v)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(v)
    DrawESP(v)
end)


 --AIMBOT GUI
 AimSection:NewToggle("Silent aim", "toggles silent aim...", function(state)
    _G.Silentaim = state
 end)
 AimSection:NewDropdown("Hit Part", "Select a hit part", {"Head", "Torso"}, function(option)
    _G.hitpart = option
end)
 AimSection:NewSlider("FOV Slider", "Adjust FOV", 250, 50, function(s) -- 500 (MaxValue) | 0 (MinValue)
    _G.CircleRadius = s
end)
AimSection:NewColorPicker("FOV Color", "Changes Circle Color", Color3.fromRGB(0,0,0), function(color)
    _G.CircleColor = color
end)

--ESP GUI
EspSection:NewToggle("ESP", "toggles esp...", function(state)
    _G.esp = state
 end)
 EspSection:NewToggle("Name ESP", "toggles name esp...", function(state)
    _G.nametxt = state
 end)
 EspSection:NewToggle("Tracers", "toggles line tracers...", function(state)
    _G.tracers = state
 end)


    --SILENT AIM SHIT
    --player func
    local function getClosestPlayer()
        local closestPlayer;
        local shortestDistance = _G.CircleRadius;

        for i, v in next, Players:GetPlayers() do
            if (v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and _G.Silentaim == true) then
                if _G.hitpart == "Head" then
                     pos = Camera:WorldToViewportPoint(v.Character.Head.Position);
                elseif _G.hitpart == "Torso" then 
                     pos = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position);
                end
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude;

                if (magnitude < shortestDistance) then
                    closestPlayer = v;
                    shortestDistance = magnitude;
                end
            end
        end
        return closestPlayer;
    end
    --main func
    local function run()
            task.wait();

        local gunModule = require(LocalPlayer.PlayerGui:WaitForChild("MainGui").NewLocal.Tools.Tool.Gun);
        local oldFunc = gunModule.ConeOfFire;

        gunModule.ConeOfFire = function(...)
            if (getfenv(2).script.Name == "Extra" and _G.Silentaim == true) then
                local closePlayer = getClosestPlayer();

                if (closePlayer and closePlayer.Character) then
                    if _G.hitpart == "Head" then
                    return closePlayer.Character.Head.CFrame * CFrame.new(math.random(0.1, 0.25), math.random(0.1, 0.25),
                math.random(0.1, 0.25)).p;
                    elseif _G.hitpart == "Torso" then
                        return closePlayer.Character.HumanoidRootPart.CFrame * CFrame.new(math.random(0.1, 0.25), math.random(0.1, 0.25),
                math.random(0.1, 0.25)).p;
                    end
                end
            end
            
            return oldFunc(...);
        end
    end
    --first run
    run();

    --epic char added
    LocalPlayer.CharacterAdded:Connect(run);