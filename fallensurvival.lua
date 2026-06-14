--if _G.FallenLoaded then
--	return
--end
--_G.FallenLoaded = true

-- 6/11/2026
local Cache = {}
Cache.RunService = game:GetService("RunService")
Cache.Workspace = game:GetService("Workspace")
Cache.Players = game:GetService("Players")
Cache.ReplicatedStorage = game:GetService("ReplicatedStorage")
Cache.UserInputService = game:GetService("UserInputService")
Cache.PhysicsService = game:GetService("PhysicsService")
Cache.SoundService = game:GetService("SoundService")
Cache.Client = Cache.Players.LocalPlayer
Cache.Camera = Cache.Workspace.CurrentCamera
Cache.Character = Cache.Client.Character or Cache.Client.CharacterAdded:Wait()

Cache.Client.CharacterAdded:Connect(function(newCharacter)
	Cache.Character = newCharacter
end)

local Flags = {}
Flags.KeyBinds = {}
Flags.KeyStates = {}

local Cheat = {}
Cheat.BulletInfo = {
	["Pumpkin Launcher"] = { Speed = 80, Gravity = 0.16 },
	["Military M4A1"] = { Speed = 2100, Gravity = 0.55 },
	["Salvaged AK74u"] = { Speed = 1800, Gravity = 0.6 },
	["Nail Gun"] = { Speed = 165, Gravity = 0.25 },
	["Salvaged RPG"] = { Speed = 100, Gravity = 0.12 },
	["Salvaged Python"] = { Speed = 1800, Gravity = 0.6 },
	["Salvaged M14"] = { Speed = 2100, Gravity = 0.55 },
	["Salvaged SMG"] = { Speed = 1800, Gravity = 0.6 },
	["Salvaged P250"] = { Speed = 1400, Gravity = 0.6 },
	["Salvaged Sniper"] = { Speed = 2400, Gravity = 0.55 },
	["Wooden Bow"] = { Speed = 320, Gravity = 0.2 },
	["Salvaged Pipe Rifle"] = { Speed = 1700, Gravity = 0.6 },
	["Salvaged AK47"] = { Speed = 2100, Gravity = 0.55 },
	["Crossbow"] = { Speed = 420, Gravity = 0.2 },
	["Salvaged Pump Action"] = { Speed = 650, Gravity = 0.6 },
	["Military AA12"] = { Speed = 600, Gravity = 0.6 },
	["Salvaged Skorpion"] = { Speed = 1600, Gravity = 0.6 },
	["Military Barrett"] = { Speed = 2500, Gravity = 0.55 },
	["Military PKM"] = { Speed = 2400, Gravity = 0.55 },
	["Bruno's M4A1"] = { Speed = 2100, Gravity = 0.55 },
	["Military MP7"] = { Speed = 1900, Gravity = 0.6 },
	["Military USP"] = { Speed = 1500, Gravity = 0.6 },
	["Salvaged Shotgun"] = { Speed = 400, Gravity = 0.6 },
	["Salvaged Break Action"] = { Speed = 550, Gravity = 0.6 },
	["Military Grenade Launcher"] = { Speed = 85, Gravity = 0.15 },
	["Salvaged Grenade Launcher"] = { Speed = 85, Gravity = 0.15 },
	["Salvaged Double Barrel"] = { Speed = 550, Gravity = 0.6 },
	["Military M39"] = { Speed = 2400, Gravity = 0.52 },
}
Cheat.ModeratorIDs = {
	[51281722] = "Game Moderator",
	[7178750309] = "Game Moderator",
	[113179883] = "Game Moderator",
	[3122439095] = "Game Moderator",
	[991290934] = "Game Moderator",
	[3968854760] = "Game Moderator",
	[114812725] = "Game Moderator",
	[81993536] = "Game Moderator",
	[1004214871] = "Game Moderator",
	[914847610] = "Game Moderator",
	[3034930770] = "Game Moderator",
	[1622256215] = "Game Moderator",
	[1116486172] = "Game Moderator",
	[4252853044] = "Game Moderator",
	[2364950171] = "Game Moderator",
	[1528346843] = "Game Moderator",
	[165053216] = "Game Moderator",
	[9024231578] = "Game Moderator",
	[1127954045] = "Game Moderator",
	[3640120679] = "Game Moderator",
	[602009251] = "Game Moderator",
	[372791101] = "Game Moderator",
	[1378169111] = "Game Moderator",
	[3020799797] = "Game Moderator",
	[372528624] = "Game Moderator",
	[2567998467] = "Game Moderator",
	[4243907215] = "Game Moderator",
	[813030262] = "Game Moderator",
	[353983652] = "Game Moderator",
	[1406181681] = "Game Moderator",
	[2229169589] = "Game Moderator",
	[30934698] = "Game Moderator",
	[3004094651] = "Game Moderator",
	[839333692] = "Game Moderator",
	[979624578] = "Game Moderator",
	[1478885961] = "Game Moderator",
	[399754916] = "Game Moderator",
	[1193091081] = "Game Moderator",
	[4553863490] = "Game Moderator",
	[4225513035] = "Game Moderator",
	[41482597] = "Game Moderator",
	[2924549627] = "Game Moderator",
	[2732967856] = "Game Moderator",
	[1937516999] = "Game Moderator",
	[1374319325] = "Game Moderator",
	[1058831985] = "Game Moderator",
	[9621064456] = "Game Moderator",
	[584370127] = "Game Moderator",
	[174212818] = "Contribution",
	[25548179] = "Lead Developer",
	[363101315] = "Lead Developer",
	[47983795] = "Co-Founder",
	[16681869] = "Founder",
}
Cheat.Offsets = {
	["Base"] = memory.get_base_address(),
	["DataSenderRate"] = memory.get_base_address() + 0x760a654,
	["PhysicsSenderMaxBandwidthBps"] = memory.get_base_address() + 0x760a634,
}
Cheat.ArmorImages = {
	["Armor_153"] = "rbxassetid://14654795058",
	["Armor_115"] = "rbxassetid://14654794835",
	["Armor_116"] = "rbxassetid://14654794952",
	["Armor_156"] = "rbxassetid://14654831164",
	["Armor_117"] = "rbxassetid://14654794730",
	["Armor_124"] = "rbxassetid://14776135830",
	["Armor_125"] = "rbxassetid://14776135514",
	["Armor_123"] = "rbxassetid://14776135648",
	["Armor_145"] = "rbxassetid://14654792150",
	["Armor_146"] = "rbxassetid://14654792418",
	["Armor_147"] = "rbxassetid://14654792046",
	["Armor_155"] = "rbxassetid://14654792260",
	["Armor_148"] = "rbxassetid://14654793165",
	["Armor_149"] = "rbxassetid://14654793303",
	["Armor_150"] = "rbxassetid://14654792938",
	["Armor_157"] = "rbxassetid://14654794652",
	["Armor_271"] = "rbxassetid://18312187080",
	["Armor_272"] = "rbxassetid://18354053691",
	["Armor_141"] = "rbxassetid://14654791532",
	["Armor_142"] = "rbxassetid://14654791689",
	["Armor_143"] = "rbxassetid://14654791387",
	["Armor_158"] = "rbxassetid://14654794097",
	["Armor_113"] = "rbxassetid://14654791921",
	["Armor_59"] = "rbxassetid://14654794392",
	["Armor_63"] = "rbxassetid://14654792590",
	["Armor_60"] = "rbxassetid://15046441717",
	["Armor_111"] = "rbxassetid://14654794176",
	["Armor_121"] = "rbxassetid://14654795457",
	["Armor_112"] = "rbxassetid://14654793432",
	["Armor_122"] = "rbxassetid://14654794281",
	["Armor_114"] = "rbxassetid://14654791246",
	["Armor_159"] = "rbxassetid://15304093679",
	["Armor_154"] = "rbxassetid://14654795325",
	["Armor_152"] = "rbxassetid://14654791788",
	["Armor_223"] = "rbxassetid://16652579167",
	["Armor_222"] = "rbxassetid://16652581317",
	["Armor_298"] = "rbxassetid://119847143620647",
	["Armor_308"] = "rbxassetid://117242081838466",
	["Armor_309"] = "rbxassetid://80978101846806",
}
Cheat.RaycastDistance = 1000
Cheat.RaycastFilterList = { Cache.Character:FindFirstChild("HumanoidRootPart") }

-- gun mods
local function ApplyNoRecoil()
	for _, tbl in gc.getgc("table") do
		pcall(function()
			if tbl.Value and tbl.Value:ContainsKey("RecoilMult") then
				tbl.Value.RecoilMult = -1
			end
		end)
	end
end

local function DisableNoRecoil()
	for _, tbl in gc.getgc("table") do
		pcall(function()
			if tbl.Value and tbl.Value:ContainsKey("RecoilMult") then
				tbl.Value.RecoilMult = 1
			end
		end)
	end
end

local function ApplyNoSpread()
	for _, tbl in gc.getgc("table") do
		pcall(function()
			if tbl.Value then
				if tbl.Value:ContainsKey("AimSpreadMult") then tbl.Value.AimSpreadMult = -1 end
				if tbl.Value:ContainsKey("HipSpreadMult") then tbl.Value.HipSpreadMult = -1 end
			end
		end)
	end
end

local function DisableNoSpread()
	for _, tbl in gc.getgc("table") do
		pcall(function()
			if tbl.Value then
				if tbl.Value:ContainsKey("AimSpreadMult") then tbl.Value.AimSpreadMult = 1 end
				if tbl.Value:ContainsKey("HipSpreadMult") then tbl.Value.HipSpreadMult = 1 end
			end
		end)
	end
end


local function CalculateDrop(BulletSpeed, BulletGravity, Position, Origin)
	local Distance = (Origin - Position).Magnitude
	local TimeToHit = Distance / BulletSpeed
	local G = BulletGravity * -195
	local Drop = -0.5 * G * TimeToHit * TimeToHit
	if tostring(Drop):find("nan") then
		Drop = 0
	end
	return Drop
end

local function CalculateTargetPosition(BulletSpeed, BulletGravity, Velocity, Position, Origin)
	local MovePred = Velocity * ((Origin - Position).Magnitude / BulletSpeed)
	local Drop = CalculateDrop(BulletSpeed, BulletGravity, Position, Origin)
	return Position + Vector3.new(MovePred.X, 0, MovePred.Z) + Vector3.new(0, Drop, 0)
end

local function Vector2Distance(a, b)
	local dx = a.X - b.X
	local dy = a.Y - b.Y
	return math.sqrt(dx * dx + dy * dy)
end

local function FindClosestViableTarget()
	local ClosestTarget
	local ClosestDistance = math.huge
	local MousePos = Cache.UserInputService:GetMouseLocation()
	local LocalRoot = Cache.Character and Cache.Character:FindFirstChild("HumanoidRootPart")

	for _, Player in pairs(Cache.Players:GetPlayers()) do
		if Player == Cache.Client then
			continue
		end
		local Character = Player.Character
		if not Character then
			continue
		end
		local Head = Character:FindFirstChild("Head")
		if not Head then
			continue
		end
		local Humanoid = Character:FindFirstChild("Humanoid")
		if not Humanoid or Humanoid.Health <= 0 then
			continue
		end

		if Flags.SafezoneCheck then
			local Success, Value = pcall(function()
				return Player:GetAttribute("SafeZone")
			end)
			if not Success then
				continue
			end
			if Value then
				continue
			end
		end

		if LocalRoot and (LocalRoot.Position - Head.Position).Magnitude > (Flags.AimbotMaxDistance or 1000) then
			continue
		end

		local ScreenPos, OnScreen = rendering.world_to_screen(Head.Position)
		if not OnScreen then
			continue
		end

		local Distance = Vector2Distance(ScreenPos, MousePos)
		if Flags.AimbotFovCheck and Distance > (Flags.AimbotFov or 50) then
			continue
		end

		if Distance < ClosestDistance then
			ClosestDistance = Distance
			ClosestTarget = {
				Player = Player,
				Character = Character,
				Head = Head,
				Humanoid = Humanoid,
				ScreenDistance = Distance,
				ScreenPos = Vector2.new(ScreenPos.X, ScreenPos.Y),
			}
		end
	end

	return ClosestTarget
end

local function GetHeldWeapon(character)
	if not character then
		return "None"
	end
	for _, model in character:GetChildren() do
		if not model:IsA("Model") then
			continue
		end
		if model.Name == "Hair" or model.Name == "HolsterModel" then
			continue
		end
		if not model.PrimaryPart then
			continue
		end
		if
			model:FindFirstChild("Detail")
			or model:FindFirstChild("Main")
			or model:FindFirstChild("Handle")
			or model:FindFirstChild("Attachments")
			or model:FindFirstChild("ArrowAttach")
			or model:FindFirstChild("Attach")
		then
			return model.Name
		end
	end
	return "None"
end

local function GetBulletInfo(WeaponName)
	if not WeaponName then
		return nil
	end
	return Cheat.BulletInfo[WeaponName]
end
-- end of helper functions

-- helper functions for ui callbacks
local font20 = font.get_font_descriptor("Arial", 20)

-- plant cache
local PlantCache = {}
local plantConfig = {
	["Wool Plant"] = { flag = "WoolPlantESP", col = Color4.new(1, 1, 1, 1) },
	["Tomato Plant"] = { flag = "TomatoPlantESP", col = Color4.new(1, 0.2, 0.2, 1) },
	["Raspberry Plant"] = { flag = "RaspberryPlantESP", col = Color4.new(0.9, 0.1, 0.4, 1) },
	["Blueberry Plant"] = { flag = "BlueberryPlantESP", col = Color4.new(0.2, 0.4, 1, 1) },
	["Lemon Plant"] = { flag = "LemonPlantESP", col = Color4.new(1, 1, 0.2, 1) },
	["Corn Plant"] = { flag = "CornPlantESP", col = Color4.new(1, 0.85, 0.1, 1) },
	["Pumpkin Plant"] = { flag = "PumpkinPlantESP", col = Color4.new(1, 0.5, 0.1, 1) },
}

local function GetPart(plant)
	if plant:IsA("BasePart") then
		return plant
	end
	if plant:IsA("Model") then
		return plant.PrimaryPart or plant:FindFirstChildWhichIsA("BasePart")
	end
	return nil
end

local function RegisterPlant(plant)
	local cfg = plantConfig[plant.Name]
	if not cfg then
		return
	end
	local part = GetPart(plant)
	if not part or part:IsInvalidInstance() then
		return
	end
	-- pre-build label so we never concat static parts in the render loop
	PlantCache[plant] = { part = part, flag = cfg.flag, col = cfg.col, label = plant.Name }
end

local function UnregisterPlant(plant)
	PlantCache[plant] = nil
end

do
	local workspace = game:GetService("Workspace")
	local plants = workspace:FindFirstChild("Plants")
	if plants and not plants:IsInvalidInstance() then
		for _, plant in pairs(plants:GetChildren()) do
			RegisterPlant(plant)
		end
		pcall(function()
			plants.ChildAdded:Connect(RegisterPlant)
			plants.ChildRemoved:Connect(UnregisterPlant)
		end)
	else
		pcall(function()
			workspace.ChildAdded:Connect(function(child)
				if child.Name ~= "Plants" or child:IsInvalidInstance() then
					return
				end
				for _, plant in pairs(child:GetChildren()) do
					RegisterPlant(plant)
				end
				pcall(function()
					child.ChildAdded:Connect(RegisterPlant)
					child.ChildRemoved:Connect(UnregisterPlant)
				end)
			end)
		end)
	end
end

local function OnModCheckerToggle(bool, ModCheckerDropdown)
	Flags.ModChecker = bool
	ModCheckerDropdown:set_visible(bool)
	if bool then
		local foundMod = false
		for _, Player in Cache.Players:GetPlayers() do
			if Player ~= Cache.Client and Cheat.ModeratorIDs[Player.UserId] then
				foundMod = true
				if Flags.ModCheck == "Notify" then
					rbxcli.display_notification(
						Cheat.ModeratorIDs[Player.UserId] .. " (" .. Player.Name .. ") is in your game!",
						7
					)
				elseif Flags.ModCheck == "Kick" then
					print("in work")
				end
			end
		end
		if not foundMod and (Flags.ModCheck == "Notify" or not Flags.ModCheck) then
			rbxcli.display_notification("No moderators found in server", 5)
		end
	end
end

-- ui
local gui = rbxcli_gui
local AimbotTab = gui.add_tab("Combat", { icon = Enum.TabIcon.Crosshair, after = "after" })

-- keybind controls, declared here so the main loops below can reference them
local AimbotKeybind
local DesyncKeybind

do
	local AimbotCategory = AimbotTab:add_category("Aimbot")
	AimbotCategory:add_toggle("Aimbot", false, function(bool)
		Flags.Aimbot = bool
	end)
	AimbotKeybind = AimbotCategory:add_keybind(
		"Keybind",
		Enum.KeyCode.RightButton,
		Enum.KeybindMode.PressAndHold,
		function(k) end
	)
	AimbotKeybind:on_activated(function(active)
		if active then
			Flags.AimbotActive = true
			Flags.LockedTarget = nil
		else
			Flags.AimbotActive = false
			Flags.LockedTarget = nil
		end
	end)
	AimbotCategory:add_slider("Max Distance", 50, 1500, 1000, Enum.SliderValueType.Int, function(v)
		Flags.AimbotMaxDistance = v
	end)
	AimbotCategory:add_toggle("Safezone Check", false, function(bool)
		Flags.SafezoneCheck = bool
	end)
end

do
	local AimbotVisualsCategory = AimbotTab:add_category("Visuals")
	local FovSlider
	AimbotVisualsCategory:add_toggle("FOV Circle", false, function(bool)
		Flags.AimbotFovCheck = bool
		FovSlider:set_visible(bool)
	end)
	FovSlider = AimbotVisualsCategory:add_slider("FOV", 5, 500, 50, Enum.SliderValueType.Int, function(v)
		Flags.AimbotFov = v
	end)
	FovSlider:set_visible(false)
	AimbotVisualsCategory:add_toggle("Snapline", false, function(bool)
		Flags.Snapline = bool
	end)
end

do
	local GunModsCategory = AimbotTab:add_category("Gun Mods")
	GunModsCategory:add_toggle("No Recoil", false, function(bool)
		Flags.NoRecoil = bool
		if bool then
			ApplyNoRecoil()
		else
			DisableNoRecoil()
		end
	end)
	GunModsCategory:add_toggle("No Spread", false, function(bool)
		Flags.NoSpreadEnabled = bool
		if bool then
			ApplyNoSpread()
		else
			DisableNoSpread()
		end
	end)
end

local MovementTab = gui.add_tab("Movement", { icon = Enum.TabIcon.Human, after = "after" })

do
	local MovementCategory = MovementTab:add_category("Movement")
	local FlySpeedSlider
	local InfiniteFlyToggle
	MovementCategory:add_toggle("Fly", false, function(bool)
		Flags.Fly = bool
		FlySpeedSlider:set_visible(bool)
		InfiniteFlyToggle:set_visible(bool)

		if bool == false then
			Cache.Character:FindFirstChild("Humanoid").PlatformStand = false
		end
	end)
	FlySpeedSlider = MovementCategory:add_slider("Fly Speed", 1, 7, 5, Enum.SliderValueType.Int, function(v)
		Flags.FlySpeed = v
	end)
	FlySpeedSlider:set_visible(false)
	InfiniteFlyToggle = MovementCategory:add_toggle("Infinite Fly", false, function(bool)
		Flags.InfiniteFly = bool
	end)
	InfiniteFlyToggle:set_visible(false)
end

do
	local DesyncCategory = MovementTab:add_category("Desync")
	Flags.DesyncType = "Movement"
	local DesyncKeyBind
	DesyncCategory:add_toggle("Desync", false, function(bool)
		Flags.Desync = bool
		DesyncKeyBind:set_visible(bool)
	end)
	DesyncKeyBind = DesyncCategory:add_keybind("Keybind", Enum.KeyCode.T, Enum.KeybindMode.Toggle, function(k) end)
	DesyncKeyBind:on_activated(function(active)
		if active then
			Flags.DesyncActive = true
			if memory.is_enabled() then
				memory.writei32(Cheat.Offsets["PhysicsSenderMaxBandwidthBps"], -9999)
				memory.writei32(Cheat.Offsets["DataSenderRate"], 60)
				Flags.DesyncPosition = Cache.Camera.CFrame.Position
				Flags.DesyncEnabled = true
			end
		else
			Flags.DesyncActive = false
			if memory.is_enabled() then
				memory.writei32(Cheat.Offsets["PhysicsSenderMaxBandwidthBps"], 38760)
				Flags.DesyncPosition = nil
				Flags.DesyncEnabled = false
			end
		end
	end)
	DesyncKeyBind:set_visible(false)
	-- store so we can call is_active later
	DesyncKeybind = DesyncKeyBind
end

local VisualsTab = gui.add_tab("ESP", { icon = Enum.TabIcon.Eye, after = "after" })

-- loot esp
do
	local LootCategory = VisualsTab:add_category("Loot")
	LootCategory:add_toggle("Dropped Items ESP", false, function(bool)
		Flags.ItemESP = bool
	end)
	LootCategory:add_slider("Distance", 50, 1000, 500, Enum.SliderValueType.Int, function(v)
		Flags.ItemESPDistance = v
	end)
end

-- node esp
do
	local NodeCategory = VisualsTab:add_category("Nodes")
	NodeCategory:add_toggle("Stone ESP", false, function(bool)
		Flags.StoneESP = bool
	end)
	NodeCategory:add_toggle("Phosphate ESP", false, function(bool)
		Flags.PhosphateESP = bool
	end)
	NodeCategory:add_toggle("Metal ESP", false, function(bool)
		Flags.MetalESP = bool
	end)
	NodeCategory:add_slider("Node Distance", 50, 1000, 500, Enum.SliderValueType.Int, function(v)
		Flags.NodeESPDistance = v
	end)
end

-- plant esp
do
	local PlantCategory = VisualsTab:add_category("Plants")
	PlantCategory:add_toggle("Wool Plant ESP", false, function(bool)
		Flags.WoolPlantESP = bool
	end)
	PlantCategory:add_toggle("Tomato Plant ESP", false, function(bool)
		Flags.TomatoPlantESP = bool
	end)
	PlantCategory:add_toggle("Raspberry Plant ESP", false, function(bool)
		Flags.RaspberryPlantESP = bool
	end)
	PlantCategory:add_toggle("Blueberry Plant ESP", false, function(bool)
		Flags.BlueberryPlantESP = bool
	end)
	PlantCategory:add_toggle("Lemon Plant ESP", false, function(bool)
		Flags.LemonPlantESP = bool
	end)
	PlantCategory:add_toggle("Corn Plant ESP", false, function(bool)
		Flags.CornPlantESP = bool
	end)
	PlantCategory:add_toggle("Pumpkin Plant ESP", false, function(bool)
		Flags.PumpkinPlantESP = bool
	end)
	PlantCategory:add_slider("Plant Distance", 50, 1000, 500, Enum.SliderValueType.Int, function(v)
		Flags.PlantESPDistance = v
	end)
end

-- player esp
do
	local LimitDistance

	local PlayerEspCategory = VisualsTab:add_category("Player")
	PlayerEspCategory:add_toggle("Armor Viewer", false, function(bool)
		Flags.ArmorViewer = bool
	end)
	PlayerEspCategory:add_toggle("Held Item", false, function(bool)
		Flags.HeldItemEsp = bool
	end)
	PlayerEspCategory:add_slider("Limit Distance", 50, 1000, 500, Enum.SliderValueType.Int, function(v)
		Flags.PlayerLimitDistance = v
	end)
end

-- misc tab
local MiscTab = gui.add_tab("Misc", { icon = Enum.TabIcon.Code, after = "after" })

do
	local ModCheckerCategory = MiscTab:add_category("Mod Checker")
	Flags.ModCheck = "Notify"
	local ModCheckerDropdown
	ModCheckerCategory:add_toggle("Mod Checker", false, function(bool)
		OnModCheckerToggle(bool, ModCheckerDropdown)
	end)
	ModCheckerDropdown = ModCheckerCategory:add_dropdown("Behavior", { "Notify", "Kick" }, 0, function(v)
		if v == 0 then
			Flags.ModCheck = "Notify"
		elseif v == 1 then
			Flags.ModCheck = "Kick"
		end
	end)
	ModCheckerDropdown:set_visible(false)
end
-- end of ui

-- main loops
do
	do -- targeting loop
		Cache.RunService.Heartbeat:Connect(function(dt)
			if Flags.Aimbot and AimbotKeybind:is_active() then
				if
					not Flags.LockedTarget
					or not Flags.LockedTarget.Character.Parent
					or not Flags.LockedTarget.Humanoid
					or Flags.LockedTarget.Humanoid.Health <= 0
				then
					Flags.LockedTarget = FindClosestViableTarget()
				end

				-- guard clause for if no target is found
				if not Flags.LockedTarget or not Flags.LockedTarget.Head then
					return
				end

				local TargetPos = Flags.LockedTarget.Head.Position
				local Info = GetBulletInfo(GetHeldWeapon(Cache.Character))
				if not Info then
					return
				end

				if Flags.InstantBullet then
					local Drop = CalculateDrop(
						Info.Speed,
						Info.Gravity,
						Flags.LockedTarget.Head.Position,
						Cache.Camera.CFrame.Position
					)
					TargetPos = Flags.LockedTarget.Head.Position + Vector3.new(0, Drop, 0)
				else
					TargetPos = CalculateTargetPosition(
						Info.Speed,
						Info.Gravity,
						Flags.LockedTarget.Head.Velocity,
						Flags.LockedTarget.Head.Position,
						Cache.Camera.CFrame.Position
					)
				end
				Cache.Camera.CFrame = CFrame.lookAt(Cache.Camera.CFrame.Position, TargetPos)
			end
		end)

		do -- aimbot visuals
			Cache.RunService.PreRender:Connect(function()
				if Flags.Aimbot and Flags.AimbotFovCheck then
					local MousePos = Cache.UserInputService:GetMouseLocation()
					immediate.circle(
						Vector2.new(MousePos.X, MousePos.Y),
						Flags.AimbotFov or 50,
						false,
						true,
						Color4.new(1, 1, 1, 1)
					)
				end
				if Flags.Snapline and Flags.Aimbot and AimbotKeybind:is_active() and Flags.LockedTarget then
					local MousePos = Cache.UserInputService:GetMouseLocation()
					immediate.line(
						Vector2.new(MousePos.X, MousePos.Y),
						Flags.LockedTarget.Head.Position,
						1,
						true,
						Color4.new(1, 1, 1, 1)
					)
				end
			end)
		end
	end -- end of targetting loop

	-- esp rendering
	do
		local Viewport = Cache.Camera.ViewportSize

		local BoxCount = 7
		local BoxSize = 64 -- width and height of each box
		local BoxSpacing = 5 -- gap between boxes
		local TopMargin = 30 -- distance from top of screen
		local BoxRounding = 10

		-- background, border, text colors
		local BgColor = Color4.new(0.28, 0.28, 0.28, 0.45)

		-- image cache
		local ImageCache = {}
		local function GetImage(AssetId)
			if not AssetId then
				return nil
			end

			local Cached = ImageCache[AssetId]
			if Cached == nil then
				local Ok, Handle = pcall(function()
					return image.load_from_asset_id(AssetId)
				end)
				if Ok and Handle then
					ImageCache[AssetId] = Handle
					return Handle
				else
					ImageCache[AssetId] = false
					return nil
				end
			end
			return Cached or nil
		end

		-- each slot: { Icon = Image? } or nil for empty
		local function GetSlots()
			local Slots = {}
			local Char = Flags.LockedTarget.Character
			if not Char then
				return Slots
			end

			local Seen = {}
			local Idx = 1

			for _, Child in Char:GetChildren() do
				if Idx > BoxCount then
					break
				end
				local Name = Child.Name
				if Name:Find("Armor") then
					local ArmorId = Name:Match("^(.-)/") or Name
					ArmorId = ArmorId:gsub(" ", "_")

					local AssetId = Cheat.ArmorImages[ArmorId]
					if AssetId and not Seen[ArmorId] then
						Seen[ArmorId] = true
						Slots[Idx] = {
							Icon = GetImage(AssetId),
						}
						Idx += 1
					end
				end
			end

			return Slots
		end

		Cache.RunService.PreRender:Connect(function()
			-- held item
			if Flags.HeldItemEsp then
				local camPos = Cache.Camera.CFrame.Position
				local maxDist = Flags.PlayerLimitDistance or 500

				for _, Player in Cache.Players:GetPlayers() do
					if Player == Cache.Client then
						continue
					end

					local Char = Player.Character
					if not Char or Char:IsInvalidInstance() then
						continue
					end

					local Humanoid = Char:FindFirstChild("Humanoid")
					if not Humanoid or Humanoid.Health <= 0 then
						continue
					end

					local Head = Char:FindFirstChild("Head")
					if not Head or Head:IsInvalidInstance() then
						continue
					end

					local Text = GetHeldWeapon(Char)

					local worldPos = Head.Position + Vector3.new(0, -5, 0)
					local dist = (camPos - worldPos).Magnitude
					if dist > maxDist then
						continue
					end

					local screenPos, onScreen = rendering.world_to_screen(worldPos)
					if not onScreen then
						continue
					end

					local size = immediate.calculate_text_size(Text, font20)
					immediate.text(
						Vector2.new(screenPos.X - size.X / 2, screenPos.Y),
						Text,
						font20,
						true,
						Color4.new(1, 1, 1, 1)
					)
				end
			end

			-- armor viewer
			if Flags.ArmorViewer and Flags.LockedTarget then
				local TotalWidth = BoxCount * BoxSize + (BoxCount - 1) * BoxSpacing
				local StartX = (Viewport.X - TotalWidth) / 2
				local Y = TopMargin

				--local Slots = GetSlots()

				for i = 1, BoxCount do
					local X = StartX + (i - 1) * (BoxSize + BoxSpacing)
					local TopLeft = Vector2.new(X, Y)
					local BottomRight = Vector2.new(X + BoxSize, Y + BoxSize)

					-- filled background
					immediate.rectangle(TopLeft, BottomRight, BoxRounding, true, false, BgColor)

					-- images
					local Slot = Slots[i]
					if Slot then
						if Slot.Icon then
							immediate.image(
								Slot.Icon,
								Vector2.new(X + 2, Y + 2),
								Vector2.new(X + BoxSize - 2, Y + BoxSize - 2),
								Color4.new(1, 1, 1, 1),
								BoxRounding
							)
						end
					end
				end
			end

			-- items
			if Flags.ItemESP then
				local drops = Cache.Workspace:FindFirstChild("Drops")
				if drops then
					for _, item in pairs(drops:GetChildren()) do
						if not item:IsInvalidInstance() then
							local basePart = item:IsA("Model")
									and (item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart"))
								or (item:IsA("BasePart") and item or nil)
							local pos = basePart and not basePart:IsInvalidInstance() and basePart.Position
							if pos then
								local dist = (Cache.Camera.CFrame.Position - pos).Magnitude
								if dist <= (Flags.ItemESPDistance or 500) then
									local sp, vis = rendering.world_to_screen(pos)
									if vis then
										immediate.text(
											Vector2.new(sp.X, sp.Y),
											item.Name .. " [" .. math.floor(dist) .. "m]",
											font20,
											true,
											Color4.new(1, 1, 1, 1)
										)
									end
								end
							end
						end
					end
				end
			end

			-- nodes
			if Flags.StoneESP or Flags.PhosphateESP or Flags.MetalESP then
				local nodes = Cache.Workspace:FindFirstChild("Nodes")
				if nodes then
					for _, node in pairs(nodes:GetChildren()) do
						if not node:IsInvalidInstance() then
							local col
							if Flags.StoneESP and node.Name:find("Stone") then
								col = Color4.new(0.5, 0.5, 0.5, 1)
							elseif Flags.PhosphateESP and node.Name:find("Phosphate") then
								col = Color4.new(1, 1, 0, 1)
							elseif Flags.MetalESP and node.Name:find("Metal") then
								col = Color4.new(0.7, 0.7, 0.7, 1)
							end
							if col then
								local basePart = node:IsA("Model")
										and (node.PrimaryPart or node:FindFirstChildWhichIsA("BasePart"))
									or (node:IsA("BasePart") and node or nil)
								local pos = basePart and not basePart:IsInvalidInstance() and basePart.Position
								if pos then
									local dist = (Cache.Camera.CFrame.Position - pos).Magnitude
									if dist <= (Flags.NodeESPDistance or 500) then
										local sp, vis = rendering.world_to_screen(pos)
										if vis then
											immediate.text(
												Vector2.new(sp.X, sp.Y),
												node.Name:gsub("_Node", "") .. " [" .. math.floor(dist) .. "m]",
												font20,
												true,
												col
											)
										end
									end
								end
							end
						end
					end
				end
			end

			-- plants
			local camPos = Cache.Camera.CFrame.Position
			local maxDist = Flags.PlantESPDistance or 500
			for _, entry in pairs(PlantCache) do
				if not Flags[entry.flag] then
					continue
				end
				local part = entry.part
				if part:IsInvalidInstance() then
					continue
				end
				local dist = (camPos - part.Position).Magnitude
				if dist > maxDist then
					continue
				end
				local sp, vis = rendering.world_to_screen(part)
				if not vis then
					continue
				end
				immediate.text(
					Vector2.new(sp.X, sp.Y),
					entry.label .. " [" .. math.floor(dist) .. "m]",
					font20,
					true,
					entry.col
				)
			end
		end)
	end -- end of esp loop

	do -- movement
		Cache.RunService.Heartbeat:Connect(function(dt)
			local char = Cache.Character
			if not char or not char.Parent then
				return
			end
			local Root = char:FindFirstChild("HumanoidRootPart")
			local Humanoid = char:FindFirstChild("Humanoid")
			local IsFlying = false

			if Flags.Fly then
				task.spawn(function()
					IsFlying = true
					if Root and Humanoid and Humanoid.Health > 0 then
						local Delta = dt * (Flags.FlySpeed or 5) * 3
						local MoveVector = Vector3.new(0, 0, 0)
						local Look = Cache.Camera.CFrame.LookVector
						local Right = Cache.Camera.CFrame.RightVector
						if Cache.UserInputService:IsKeyDown(Enum.KeyCode.W) then
							MoveVector += Vector3.new(Look.X, 0, Look.Z)
						end
						if Cache.UserInputService:IsKeyDown(Enum.KeyCode.S) then
							MoveVector -= Vector3.new(Look.X, 0, Look.Z)
						end
						if Cache.UserInputService:IsKeyDown(Enum.KeyCode.A) then
							MoveVector -= Vector3.new(Right.X, 0, Right.Z)
						end
						if Cache.UserInputService:IsKeyDown(Enum.KeyCode.D) then
							MoveVector += Vector3.new(Right.X, 0, Right.Z)
						end
						if Cache.UserInputService:IsKeyDown(Enum.KeyCode.Space) then
							MoveVector += Vector3.new(0, 1, 0)
						end
						if Cache.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
							MoveVector += Vector3.new(0, -1, 0)
						end
						if MoveVector.Magnitude > 0 then
							MoveVector = MoveVector.Unit
						end
						local Position = Root.CFrame.Position + MoveVector * Delta
						Humanoid.PlatformStand = true
						Root.Velocity = Vector3.new(0, 0, 0)
						Root.CFrame = CFrame.new(Position, Position + Vector3.new(Look.X, 0, Look.Z))
					end
				end)
			end

			if Flags.InfiniteFly and IsFlying and Root and char and char.Parent then
				local Result = physics.raycast(
					Root.Position,
					Vector3.new(0, -1000, 0),
					Cheat.RaycastDistance,
					Cheat.RaycastFilterList
				)
				if Result and Result.distance > 4 then
					task.spawn(function()
						if not Root or not Root.Parent or not char or not char.Parent then
							return
						end
						local OldVel = Root.AssemblyLinearVelocity
						for _, Part in char:GetChildren() do
							if Part:IsA("BasePart") then
								Part.Velocity = Vector3.new(0, -1000, 0)
							end
						end
						Cache.RunService.PreRender:Wait()
						for _, Part in char:GetChildren() do
							if Part:IsA("BasePart") then
								Part.Velocity = OldVel
							end
						end
					end)
				end
			end
		end)
	end -- end of movement loop

	do -- misc loop
		local function CheckForModerators(joinedPlayer)
			if not Flags.ModChecker then
				return
			end
			if joinedPlayer and Cheat.ModeratorIDs[joinedPlayer.UserId] then
				if Flags.ModCheck == "Notify" then
					rbxcli.display_notification(
						Cheat.ModeratorIDs[joinedPlayer.UserId] .. " (" .. joinedPlayer.Name .. ") joined your game!",
						7
					)
				elseif Flags.ModCheck == "Kick" then
					rbxcli.panic()
				end
			end
		end

		Cache.Players.PlayerAdded:Connect(function(player)
			CheckForModerators(player)
		end)

		do -- misc visuals
			Cache.RunService.PreRender:Connect(function()
				local ViewportSize = Cache.Camera.ViewportSize
				if Flags.DesyncEnabled then
					local Distance = (Cache.Camera.CFrame.Position - Flags.DesyncPosition).Magnitude
					local Color = Color4.new(1, 1, 1, 1)
					local Text = "Desynced " .. tostring(math.floor(Distance)) .. " Studs"
					local Width = #Text * 10
					local CenterX = (ViewportSize.X / 2) - (Width / 2)
					if Distance >= 8 then
						Color = Color4.new(1, 0, 0, 1)
					end
					immediate.text(Vector2.new(CenterX, ViewportSize.Y - 250), Text, font20, true, Color)
				end
			end)
		end
	end -- end of misc loop
end -- end of main loops
