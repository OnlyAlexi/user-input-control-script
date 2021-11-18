local Player = game:GetService("Players").LocalPlayer
local RStorage = game:GetService("ReplicatedStorage")
local ContextService = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Healing = false
local Camera = workspace.CurrentCamera
local SoundService = game:GetService("SoundService")

math.randomseed(tick())

local Crosshair = Player.PlayerGui.Menu.Crosshair 
local CrosshairTop = Crosshair.Top ; local OriginalPositionTop = UDim2.new(0.504,0,-0.004,0)
local CrosshairRight = Crosshair.Right ; local OriginalPositionRight = UDim2.new(0.66,0,0.485,0)
local CrosshairLeft = Crosshair.Left ; local OriginalPositionLeft = UDim2.new(-0.005,0,0.485,0)
local CrosshairBottom = Crosshair.Bottom ; local OriginalPositionBottom = UDim2.new(0.504,0,0.689,0)
local Mouse = Player:GetMouse()
local MouseEnabled = false
local PlayerInfo = Player.PlayerGui.Menu.PlayerInfo

function HealCD()
	local CD = 0
	Player.PlayerGui.Menu.PlayerUI.Counter.Text = "30"
	for i = 30,CD,-1 do
		Player.PlayerGui.Menu.PlayerUI.Counter.Text = tostring(i)
		wait(1)
	end
	Player.PlayerGui.Menu.PlayerUI.Counter.Text = "0"
end

local function handleKeys(action, input, object)
	if(action == "Heal" and Player.TeamColor == BrickColor.new("Bright green") and Player.PlayerGui.Menu.PlayerUI.Counter.Text == tostring(0) and Healing == false) then
		for i,v in pairs(game.Players:GetChildren()) do
			if(Player:DistanceFromCharacter(v.Character.UpperTorso.Position) < 10 and v.Name ~= Player.Name) then
				Healing = true
				RStorage.Remotes.HealPlayer:FireServer(v)
				Player.PlayerGui.Menu.HealingMessage.Visible = true
				Player.PlayerGui.Menu.HealingMessage.MainBar:TweenSize(UDim2.new(0,431,0,24), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 3)
				wait(3)
				Player.PlayerGui.Menu.HealingMessage.Visible = false
				Player.PlayerGui.Menu.HealingMessage.MainBar.Size = UDim2.new(0,8,0,24)
				spawn(HealCD)
				Healing = false
			end
		end
	end
end

ContextService:BindAction("Heal", handleKeys, false, Enum.KeyCode.E, Enum.KeyCode.ButtonX)
ContextService:BindAction("Sprint", handleKeys, false, Enum.KeyCode.LeftShift, Enum.KeyCode.ButtonL3)

UserInputService.InputBegan:Connect(function(inputs)
	if(UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)) then
		local FOVTween = TweenInfo.new(0.3)
		local TweenFOV = TweenService:Create(workspace.CurrentCamera, FOVTween, {FieldOfView=85})
		TweenFOV:Play()
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20		
		CrosshairTop:TweenPosition(OriginalPositionTop - UDim2.new(0,0,0.5,0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 1, true)
		CrosshairRight:TweenPosition(OriginalPositionRight + UDim2.new(0.5,0,0.0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 1, true)
		CrosshairBottom:TweenPosition(OriginalPositionBottom + UDim2.new(0,0,0.5,0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 1, true)
		CrosshairLeft:TweenPosition(OriginalPositionLeft - UDim2.new(0.5,0,0.0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 1, true)
	end
	
	if(inputs.UserInputType == Enum.UserInputType.Keyboard) then
		if(inputs.KeyCode == Enum.KeyCode.LeftControl) then
			if(MouseEnabled == false) then
				UserInputService.MouseIconEnabled = true
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
				MouseEnabled=true
			else if (MouseEnabled == true) then
					UserInputService.MouseIconEnabled = false
					UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
					MouseEnabled=false
				end
			end
		end
	else if(UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)) then
			local ZoomTween = TweenInfo.new(0.4)
			local ZoomTweenFOV = TweenService:Create(workspace.CurrentCamera, ZoomTween, {FieldOfView=52})
			ZoomTweenFOV:Play()
			
			CrosshairTop:TweenPosition(OriginalPositionTop + UDim2.new(0,0,0.18,0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 1, true)
			CrosshairRight:TweenPosition(OriginalPositionRight - UDim2.new(0.16,0,0.0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 1, true)
			CrosshairBottom:TweenPosition(OriginalPositionBottom - UDim2.new(0,0,0.18,0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 1, true)
			CrosshairLeft:TweenPosition(OriginalPositionLeft + UDim2.new(0.16,0,0.0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 1, true)
			
			end	
		end
end)

UserInputService.InputEnded:Connect(function(inputs)
	if not (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)) then
		if not (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)) then
	local FOVTween2 = TweenInfo.new(0.3)
	local TweenFOV2 = TweenService:Create(workspace.CurrentCamera, FOVTween2, {FieldOfView=70})
		TweenFOV2:Play()
		local UnZoomTween = TweenInfo.new(0.3)
		local UnZoomTweenFOV = TweenService:Create(workspace.CurrentCamera, UnZoomTween, {FieldOfView=70})
		UnZoomTweenFOV:Play()
		CrosshairTop:TweenPosition(OriginalPositionTop, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 1, true)
		CrosshairRight:TweenPosition(OriginalPositionRight, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 1, true)
		CrosshairBottom:TweenPosition(OriginalPositionBottom, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 1, true)
		CrosshairLeft:TweenPosition(OriginalPositionLeft, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 1, true)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 14
		end
	end
end)

local spd = 0.7
local max = 0.03
local inc = -0.004

function movePlant(plant)
	for i = 1,70,1 do
		spd = (spd+inc)
		spd = (spd < -max and -max or spd > max and max or spd)		-- tenery operations
		inc = ((spd == max and (inc*-1) or spd == -max and (inc*-1)) or inc)
		plant.CFrame = (plant.CFrame*CFrame.new(spd*0.4,spd,0))
		RunService.RenderStepped:Wait()
	end
end

Player.Character.Humanoid.Touched:Connect(function(t)
	if(string.match(t.Name, "Keypad")) then
		game:GetService("ReplicatedStorage").Remotes.ChangeDoor:FireServer(t.Door.Value, t)
	else if (t:FindFirstChild("Emit")) then
			t.Emit:Emit(2)
			if(not SoundService.Brush.IsPlaying) then
				SoundService.Brush.PlaybackSpeed = math.random(8,14)*.1
				SoundService.Brush:Play()
				coroutine.resume(coroutine.create(movePlant), t)
			end
		end
	end
end)

Player.Chatted:connect(function(m)
	print(m .. " CLIENT MESSAGE")
	RStorage.Remotes.VoiceChat:FireServer(m)
end)

Player.Character.Humanoid.Changed:Connect(function(d)
	if(Player.Character.Humanoid.Health <= 0) then
		print("0 HP")
		RStorage.Remotes.PlayerDied:FireServer()
	end
end)


