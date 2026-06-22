--[[
    4skin   - main codebase + the idea to make this
    axinlol - some dogshit misc esp made with ai
    oxyhax  - manip and visuals rewrite

]]

if _G.FallenLoaded then
	return
end
_G.FallenLoaded = true

-- 6/18/2026
local Cache = {}
Cache.RunService = game:GetService("RunService")
Cache.Workspace = game:GetService("Workspace")
Cache.Players = game:GetService("Players")
Cache.UserInputService = game:GetService("UserInputService")
Cache.HttpService = game:GetService("HttpService")
Cache.Client = Cache.Players.LocalPlayer
Cache.Camera = Cache.Workspace.CurrentCamera
Cache.Character = Cache.Client.Character or Cache.Client.CharacterAdded:Wait()
Cache.RakPeerId = Cache.Character.HumanoidRootPart.NetworkOwnerV3

Cache.Client.CharacterAdded:Connect(function(newCharacter)
	Cache.Character = newCharacter
end)

local Flags = {}

-- default settings
Flags.AimbotTargetPart = "Head"
Flags.AimbotMaxDistance = 1000
Flags.AimbotFov = 50
Flags.AimbotVisCheck = false
Flags.AimbotManipulation = false
Flags.FlySpeed = 5
Flags.AimbotFovCheck = false
Flags.SafezoneCheck = false
Flags.Aimbot = false
Flags.Snapline = false
Flags.InstantBullet = false
Flags.Desync = false
Flags.Fly = false
Flags.InfiniteFly = false
Flags.WhiteListedPlayers = {}
Flags.Freecam = false
Flags.FreecamActive = false
Flags.FreecamSpeed = 5
Flags.CardNoClip = false
Flags.FreecamBtrTeleport = false
Flags.FakeLag = false
Flags.FakeLagInterval = 0.35
Flags.FakeLagActive = false
Flags.YawEnabled = false
Flags.YawSpeed = 50
Flags.YawType = "Jitter"
Flags.YawMin = 0
Flags.YawMax = 0
Flags.TargetNpcs = false
Flags.AimbotManipulationActive = false
Flags.BodybagESP = false
Flags.BodybagESPDistance = 500

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
	[51281722] = "Game Moderator", -- KittenBagelz
	[7178750309] = "Game Moderator", -- Rikumah
	[113179883] = "Game Moderator", -- DopeIlI
	[3122439095] = "Game Moderator", -- chancerocke
	[991290934] = "Game Moderator", -- Lexi34567812
	[3968854760] = "Game Moderator", -- puferyba
	[81993536] = "Game Moderator", -- aidenas2011
	[1004214871] = "Game Moderator", -- owner12310
	[3034930770] = "Game Moderator", -- Fan_hellrider
	[2364950171] = "Game Moderator", -- ilovetowerbattle_9
	[1528346843] = "Game Moderator", -- Hsixienn
	[165053216] = "Game Moderator", -- coolboyofawsome4
	[1127954045] = "Game Moderator", -- Kitty_1624
	[3640120679] = "Game Moderator", -- GamerMauriiYT
	[602009251] = "Game Moderator", -- Bajoogies_XD
	[372791101] = "Game Moderator", -- Xion_Light
	[1378169111] = "Game Moderator", -- Kaz_Elite
	[3020799797] = "Game Moderator", -- hello_myfriends45
	[2567998467] = "Game Moderator", -- joax009617
	[4243907215] = "Game Moderator", -- AaronElagant
	[353983652] = "Game Moderator", -- Puhgee
	[1406181681] = "Game Moderator", -- roblox_23193
	[2229169589] = "Game Moderator", -- fearedbyvamp
	[3004094651] = "Game Moderator", -- harrib_allsack54321
	[839333692] = "Game Moderator", -- Matheus06532
	[979624578] = "Game Moderator", -- B_BEAMO
	[1478885961] = "Game Moderator", -- fordjdj12
	[399754916] = "Game Moderator", -- sirfluf
	[1193091081] = "Game Moderator", -- Weerdeeg
	[4553863490] = "Game Moderator", -- giovannirv2
	[4225513035] = "Game Moderator", -- Waitwhatb40
	[41482597] = "Game Moderator", -- kerub131
	[2924549627] = "Game Moderator", -- rashhhh2
	[2732967856] = "Game Moderator", -- DontTouchZGrass
	[1937516999] = "Game Moderator", -- matheu09173
	[1374319325] = "Game Moderator", -- jostjohnyca
	[1058831985] = "Game Moderator", -- krisidisi23
	[9621064456] = "Game Moderator", -- MetaSile
	[584370127] = "Game Moderator", -- 1Newy1
	[813030262] = "Game Moderator", -- Prye4
	[3470393585] = "Game Moderator", -- k6ppo
	[122915793] = "Game Moderator", -- LionTooth99999
	[1534692727] = "Game Moderator", -- LUKASAJs
	[7278178099] = "Game Moderator", -- thecarrotman513
	[8593140875] = "Game Moderator", -- HurbertTheP3r73rt
	[2525997354] = "Game Moderator", -- BlackWhiteYT11
	[3126891654] = "Game Moderator", -- v6xzt
	[1190967808] = "Game Moderator", -- djvdhshscshs
	[833946684] = "Game Moderator", -- GamerGubbi
	[202751467] = "Game Moderator", -- lumbers2
	[510349404] = "Game Moderator", -- Kristian4209
	[174212818] = "Contribution", -- YTGonzo
	[25548179] = "Lead Developer", -- AsianAbrex
	[363101315] = "Lead Developer", -- Warm_Vibes
	[47983795] = "Co-Founder", -- ChickenBagelz
	[16681869] = "Founder", -- neddleduck
}

-- offsets
local Success, Response = pcall(function()
	return Cache.HttpService:RequestAsync({
		Method = "GET",
		Url = "https://raw.githubusercontent.com/sigma4skin/rbxcli-offsets/refs/heads/main/Offsets.lua",
	})
end)

if not Success or not Response or Response.StatusCode ~= 200 then
	warn("Failed to grab offset loader")
	return
end

Cheat.Offsets = rbxcli.loadstring(Response.Body)()
Cheat.Offsets.Base = memory.get_base_address()

Cheat.RaycastDistance = 1000
Cheat.Directory = "SigmaFallenScript"

Cheat.Fonts = {}
Cheat.Fonts.Font20 = font.get_font_descriptor("Arial", 20)
Cheat.Fonts.Font14 = font.get_font_descriptor("Arial", 14)

Cheat.SoldierNames = {
	Soldier = true,
	Brutus = true,
	Bruno = true,
	Boris = true,
	BTR = true,
}
Cheat.SoldierListCache = {}
Cheat.SoldierCacheLastUpdate = 0
Cheat.SOLDIER_CACHE_INTERVAL = 1

-- create directory
pcall(function()
	if not fs.is_directory(Cheat.Directory) then
		pcall(fs.create_directory(Cheat.Directory))
	end
end)

-- whitelist system
local WhiteListFilePath = Cheat.Directory .. "/whitelist.json"

local function SaveWhiteList()
	local Names = {}
	for NameLower, OriginalName in pairs(Flags.WhiteListedPlayers) do
		table.insert(Names, OriginalName)
	end
	local Json = Cache.HttpService:JSONEncode(Names)
	pcall(function()
		if not fs.is_file(WhiteListFilePath) then
			fs.create_file(WhiteListFilePath)
		end
		fs.write_async(WhiteListFilePath, buffer.fromstring(Json))
	end)
end

local function LoadWhiteList()
	Flags.WhiteListedPlayers = {}
	pcall(function()
		if fs.is_file(WhiteListFilePath) then
			local Data = fs.read_async(WhiteListFilePath)
			if not Data then
				return
			end

			local Str = buffer.tostring(Data)
			local Names = Cache.HttpService:JSONDecode(Str)
			if typeof(Names) == "table" then
				for _, Name in ipairs(Names) do
					if typeof(Name) == "string" and Name ~= "" then
						Flags.WhiteListedPlayers[Name:lower()] = Name
					end
				end
			end
		end
	end)
end

local function AddToWhiteList(PlayerName)
	if not PlayerName or PlayerName == "" then
		return false
	end
	local Key = PlayerName:lower()
	if Flags.WhiteListedPlayers[Key] then
		return false -- already whitelisted
	end

	-- try to resolve to an actual player in the server for exact name
	local ResolvedName = PlayerName
	for _, P in Cache.Players:GetPlayers() do
		if P.Name:lower() == Key or P.DisplayName:lower() == Key then
			ResolvedName = P.Name
			break
		end
	end

	Flags.WhiteListedPlayers[Key] = ResolvedName
	SaveWhiteList()

	return true
end

local function RemoveFromWhiteList(PlayerName)
	if not PlayerName or PlayerName == "" then
		return false
	end
	local Key = PlayerName:lower()
	if not Flags.WhiteListedPlayers[Key] then
		return false
	end
	Flags.WhiteListedPlayers[Key] = nil
	SaveWhiteList()
	return true
end

local function IsWhiteListed(Player)
	if not Player then
		return false
	end
	local NameLower = Player.Name:lower()
	local DisplayLower = Player.DisplayName:lower()
	return Flags.WhiteListedPlayers[NameLower] ~= nil or Flags.WhiteListedPlayers[DisplayLower] ~= nil
end

local function GetWhiteListString()
	local Names = {}
	for _, OriginalName in pairs(Flags.WhiteListedPlayers) do
		table.insert(Names, OriginalName)
	end
	table.sort(Names, function(a, b)
		return a:lower() < b:lower()
	end)
	if #Names == 0 then
		return "None"
	end
	return table.concat(Names, ", ")
end

-- load saved whitelist on startup
LoadWhiteList()
-- end of whitelist shit

-- gun mods
local function RefreshGunMods()
	if not (Flags.NoRecoil or Flags.NoSpreadEnabled) then
		return
	end
	for _, tbl in gc.getgc("table") do
		pcall(function()
			local Value = tbl.Value
			if not Value then
				return
			end
			if Flags.NoRecoil and Value:ContainsKey("RecoilMult") then
				Value.RecoilMult = -1
			end
			if Flags.NoSpreadEnabled then
				if Value:ContainsKey("AimSpreadMult") then
					Value.AimSpreadMult = -1
				end
				if Value:ContainsKey("HipSpreadMult") then
					Value.HipSpreadMult = -1
				end
			end
		end)
	end
end

local function RestoreGunMods(RestoreRecoil, RestoreSpread)
	for _, tbl in gc.getgc("table") do
		pcall(function()
			local Value = tbl.Value
			if not Value then
				return
			end
			if RestoreRecoil and Value:ContainsKey("RecoilMult") then
				Value.RecoilMult = 0
			end
			if RestoreSpread then
				if Value:ContainsKey("AimSpreadMult") then
					Value.AimSpreadMult = 0
				end
				if Value:ContainsKey("HipSpreadMult") then
					Value.HipSpreadMult = 0
				end
			end
		end)
	end
end
-- end of gun mods

-- helper functions
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
	return Position + Vector3.new(MovePred.X, MovePred.Y, MovePred.Z) + Vector3.new(0, Drop, 0)
end

local function CalculateTargetPositionNoYPred(BulletSpeed, BulletGravity, Velocity, Position, Origin)
	local MovePred = Velocity * ((Origin - Position).Magnitude / BulletSpeed)
	local Drop = CalculateDrop(BulletSpeed, BulletGravity, Position, Origin)
	return Position + Vector3.new(MovePred.X, 0, MovePred.Z) + Vector3.new(0, Drop, 0)
end

local function GetCharacterParts(character)
	local parts = {}
	if not character or character:IsInvalidInstance() then
		return parts
	end
	for _, child in character:GetChildren() do
		if child:IsA("BasePart") then
			table.insert(parts, child)
		end
	end
	return parts
end

local function BuildSelfFilter()
	return GetCharacterParts(Cache.Character)
end

local function BuildVisFilter(targetCharacter)
	local list = GetCharacterParts(Cache.Character)
	for _, part in GetCharacterParts(targetCharacter) do
		table.insert(list, part)
	end
	return list
end

local function IsTargetVisible(Character, TargetPart)
	if not Character or not TargetPart then
		return false
	end

	local Origin = Cache.Camera.CFrame.Position
	local Direction = (TargetPart.Position - Origin)

	-- filter own character and the target character so the raycast passes through them and only hits geometry
	local Filter = BuildVisFilter(Character)

	local Result = physics.raycast(Origin, Direction.Unit, Direction.Magnitude, Filter)

	-- if nothing was hit
	if not Result or not Result.hit_successful then
		return true
	end

	local HitInstance = Result.Instance
	if HitInstance then
		local HitModel = HitInstance
		while HitModel and not HitModel:IsA("Model") do
			HitModel = HitModel.Parent
		end
		return HitModel == Character
	end

	return false
end

local function IsVisibleFrom(Origin, TargetPart, TargetCharacter)
	if not TargetPart or TargetPart:IsInvalidInstance() then
		return false
	end

	local Direction = TargetPart.Position - Origin
	local Filter = BuildVisFilter(TargetCharacter)
	local Result = physics.raycast(Origin, Direction.Unit, Direction.Magnitude, Filter)

	if not Result or not Result.hit_successful then
		return true
	end

	local HitInstance = Result.Instance
	if HitInstance then
		local HitModel = HitInstance
		while HitModel and not HitModel:IsA("Model") do
			HitModel = HitModel.Parent
		end
		return HitModel == TargetCharacter
	end

	return false
end

-- only way i could think of doing manip externally without a debug lib
local function FindManipulationPosition(Origin, TargetPart, TargetCharacter)
	local EyeOffset = Vector3.new(0, 2.5, 0)

	if IsVisibleFrom(Origin + EyeOffset, TargetPart, TargetCharacter) then
		return Origin
	end

	for _, Radius in { 4, 8 } do
		for I = 0, 7 do
			local Angle = (I / 8) * math.pi * 2
			local Candidate = Origin + Vector3.new(math.cos(Angle) * Radius, 0, math.sin(Angle) * Radius)
			if IsVisibleFrom(Candidate + EyeOffset, TargetPart, TargetCharacter) then
				return Candidate
			end
		end
	end

	return nil
end

local function DisableManip()
	if not Flags.IsManipping then
		return
	end
	Flags.IsManipping = false
	Flags.ManipulationPosition = nil
	if memory.is_enabled() then
		memory.writei32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.PhysicsSenderMaxBandwidthBps, 38760)
		memory.writei32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.DataSenderRate, 60)
	end
end

local function ResolveTargetPart(Character, Head, HumanoidRootPart)
	local MousePos = Cache.UserInputService:GetMouseLocation()
	local TargetPartName = Flags.AimbotTargetPart

	if TargetPartName == "HumanoidRootPart" then
		return HumanoidRootPart or Head
	elseif TargetPartName == "Closest" then
		local ClosestPartDist = math.huge
		local ClosestPart = Head
		for _, Part in Character:GetChildren() do
			if not Part:IsA("BasePart") then
				continue
			end
			local PartScreen, PartOnScreen = rendering.world_to_screen(Part.Position)
			if not PartOnScreen then
				continue
			end
			local PartDist = (PartScreen - MousePos).Magnitude
			if PartDist < ClosestPartDist then
				ClosestPartDist = PartDist
				ClosestPart = Part
			end
		end
		return ClosestPart
	else
		return Head
	end
end

local function AiList()
	Cheat.SoldierListCache = {}
	local Military = Cache.Workspace:FindFirstChild("Military")
	if Military then
		for _, Folder in Military:GetChildren() do
			for _, Soldier in Folder:GetChildren() do
				if Soldier:IsA("Model") and Cheat.SoldierNames[Soldier.Name] then
					table.insert(Cheat.SoldierListCache, Soldier)
				end
			end
		end
	end
	local Events = Cache.Workspace:FindFirstChild("Events")
	if Events then
		for _, Obj in Events:GetChildren() do
			if Obj:IsA("Model") and Cheat.SoldierNames[Obj.Name] then
				table.insert(Cheat.SoldierListCache, Obj)
			end
		end
	end
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

		if IsWhiteListed(Player) then
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

		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
		if not HumanoidRootPart then
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

		if LocalRoot and (LocalRoot.Position - Head.Position).Magnitude > Flags.AimbotMaxDistance then
			continue
		end

		local ScreenPos, OnScreen = rendering.world_to_screen(Head.Position)
		if not OnScreen then
			continue
		end

		local Distance = (ScreenPos - MousePos).Magnitude
		if Flags.AimbotFovCheck and Distance > Flags.AimbotFov then
			continue
		end

		if Distance < ClosestDistance then
			local TargetPart = ResolveTargetPart(Character, Head, HumanoidRootPart)

			if Flags.AimbotVisCheck and not IsTargetVisible(Character, TargetPart) then
				continue
			end

			ClosestDistance = Distance
			ClosestTarget = {
				Player = Player,
				Character = Character,
				Head = Head,
				HumanoidRootPart = HumanoidRootPart,
				Humanoid = Humanoid,
				TargetPart = TargetPart,
				ScreenDistance = Distance,
				ScreenPos = Vector2.new(ScreenPos.X, ScreenPos.Y),
			}
		end
	end

	if Flags.TargetNpcs then
		local Now = os.clock()
		if Now - Cheat.SoldierCacheLastUpdate >= Cheat.SOLDIER_CACHE_INTERVAL then
			Cheat.SoldierCacheLastUpdate = Now
			AiList()
		end

		for _, Soldier in Cheat.SoldierListCache do
			if not Soldier or not Soldier.Parent then
				continue
			end

			local Head = Soldier:FindFirstChild("Head")
			if not Head then
				continue
			end

			local Humanoid = Soldier:FindFirstChild("Humanoid")
			if not Humanoid or Humanoid.Health <= 0 then
				continue
			end

			local HumanoidRootPart = Soldier:FindFirstChild("HumanoidRootPart")
			if not HumanoidRootPart then
				continue
			end

			if LocalRoot and (LocalRoot.Position - Head.Position).Magnitude > Flags.AimbotMaxDistance then
				continue
			end

			local ScreenPos, OnScreen = rendering.world_to_screen(Head.Position)
			if not OnScreen then
				continue
			end

			local Distance = (ScreenPos - MousePos).Magnitude
			if Flags.AimbotFovCheck and Distance > Flags.AimbotFov then
				continue
			end

			if Distance < ClosestDistance then
				local TargetPart = ResolveTargetPart(Soldier, Head, HumanoidRootPart)

				if Flags.AimbotVisCheck and not IsTargetVisible(Soldier, TargetPart) then
					continue
				end

				ClosestDistance = Distance
				ClosestTarget = {
					Player = nil,
					Character = Soldier,
					Head = Head,
					HumanoidRootPart = HumanoidRootPart,
					Humanoid = Humanoid,
					TargetPart = TargetPart,
					ScreenDistance = Distance,
					ScreenPos = Vector2.new(ScreenPos.X, ScreenPos.Y),
					IsNpc = true,
				}
			end
		end
	end

	return ClosestTarget
end

local function GetHeldWeapon(character)
	if not character then
		return "None"
	end
	if character:IsInvalidInstance() then
		return "None"
	end

	for _, model in character:GetChildren() do
		if model:IsInvalidInstance() or not model:IsA("Model") then
			continue
		end
		if model.Name == "Hair" or model.Name == "HolsterModel" then
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

local function OnModCheckerToggle(bool, ModCheckerDropdown)
	Flags.ModChecker = bool
	ModCheckerDropdown:set_visible(bool)
	if not bool then
		return
	end

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
-- end of ui helper functions

-- ui
local gui = rbxcli_gui
local AimbotTab = gui.add_tab("Combat", { icon = Enum.TabIcon.Crosshair, after = "after" })

-- keybind controls, declared here so the main loops below can reference them
local AimbotKeybind
local DesyncKeybind
local FreecamKeybind
local FakeLagKeybind

do
	local AimbotCategory = AimbotTab:add_category("Aimbot")

	local MaxDistanceSlider
	local SafezoneToggle
	local TargetPartDropdown
	local VisCheckToggle
	local TargetNpcsToggle

	AimbotCategory:add_toggle("Aimbot", false, function(bool)
		Flags.Aimbot = bool

		MaxDistanceSlider:set_visible(bool)
		SafezoneToggle:set_visible(bool)
		TargetPartDropdown:set_visible(bool)
		AimbotKeybind:set_visible(bool)
		VisCheckToggle:set_visible(bool)
		TargetNpcsToggle:set_visible(bool)
	end)
	AimbotKeybind = AimbotCategory:add_keybind(
		"Keybind",
		Enum.KeyCode.RightButton,
		Enum.KeybindMode.PressAndHold,
		function(k) end
	)
	AimbotKeybind:set_visible(false)

	local ManipulationKeybind
	AimbotCategory:add_toggle("Manipulation", false, function(bool)
		Flags.AimbotManipulation = bool
		ManipulationKeybind:set_visible(bool)
	end)
	ManipulationKeybind = AimbotCategory:add_keybind(
		"Keybind",
		Enum.KeyCode.C,
		Enum.KeybindMode.PressAndHold,
		function(k) end
	)
	ManipulationKeybind:on_activated(function(active)
		Flags.AimbotManipulationActive = active
	end)
	ManipulationKeybind:set_visible(false)

	-- on activated behvaior
	AimbotKeybind:on_activated(function(active)
		if active then
			Flags.AimbotActive = true
			Flags.LockedTarget = nil
		else
			Flags.AimbotActive = false
			Flags.LockedTarget = nil
		end
	end)
	TargetPartDropdown = AimbotCategory:add_dropdown(
		"Target Part",
		{ "Head", "Humanoid Root Part", "Closest" },
		0,
		function(v)
			local Parts = { "Head", "HumanoidRootPart", "Closest" }
			Flags.AimbotTargetPart = Parts[v + 1]
			Flags.LockedTarget = nil
		end
	)
	TargetPartDropdown:set_visible(false)
	MaxDistanceSlider = AimbotCategory:add_slider("Max Distance", 50, 1500, 1000, Enum.SliderValueType.Int, function(v)
		Flags.AimbotMaxDistance = v
		Flags.LockedTarget = nil
	end)
	TargetNpcsToggle = AimbotCategory:add_toggle("Target NPCS", false, function(Bool)
		Flags.TargetNpcs = Bool
	end)
	TargetNpcsToggle:set_visible(false)
	MaxDistanceSlider:set_visible(false)
	VisCheckToggle = AimbotCategory:add_toggle("Visible Check", false, function(bool)
		Flags.AimbotVisCheck = bool
		Flags.LockedTarget = nil
	end)
	VisCheckToggle:set_visible(false)
	SafezoneToggle = AimbotCategory:add_toggle("Safezone Check", false, function(bool)
		Flags.SafezoneCheck = bool
		Flags.LockedTarget = nil
	end)
	SafezoneToggle:set_visible(false)
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
			RefreshGunMods()
		else
			RestoreGunMods(true, false)
		end
	end)
	GunModsCategory:add_toggle("No Spread", false, function(bool)
		Flags.NoSpreadEnabled = bool
		if bool then
			RefreshGunMods()
		else
			RestoreGunMods(false, true)
		end
	end)
end

do
	local LastGunModWeapon = nil
	local LastGunModRefresh = 0
	-- Cache.RunService.Heartbeat:Connect(function() -- forgot this caused big fps whoops
	-- 	if not (Flags.NoRecoil or Flags.NoSpreadEnabled) then
	-- 		LastGunModWeapon = nil
	-- 		return
	-- 	end
	-- 	local Now = os.clock()
	-- 	local Weapon = GetHeldWeapon(Cache.Character)
	-- 	if Weapon ~= LastGunModWeapon or Now - LastGunModRefresh > 0.25 then
	-- 		LastGunModWeapon = Weapon
	-- 		LastGunModRefresh = Now
	-- 		RefreshGunMods()
	-- 	end
	-- end)
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
	end)
	FlySpeedSlider = MovementCategory:add_slider("Fly Speed", 1, 7, 5, Enum.SliderValueType.Int, function(v)
		Flags.FlySpeed = v
	end)
	FlySpeedSlider:set_visible(false)

	--[[
	InfiniteFlyToggle = MovementCategory:add_toggle("Infinite Fly", false, function(bool)
		Flags.InfiniteFly = bool
	end)

	InfiniteFlyToggle:set_visible(false)
	--]]
end

do
	local DesyncCategory = MovementTab:add_category("Desync")
	local FakeLagIntervalSlider

	DesyncCategory:add_toggle("Desync", false, function(bool)
		Flags.Desync = bool
		DesyncKeybind:set_visible(bool)
	end)
	DesyncKeybind = DesyncCategory:add_keybind("Keybind", Enum.KeyCode.T, Enum.KeybindMode.Toggle, function(k) end)
	DesyncKeybind:on_activated(function(active)
		if active and Flags.Desync then
			Flags.DesyncActive = true
			if memory.is_enabled() then
				memory.writei32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.PhysicsSenderMaxBandwidthBps, -9999)
				memory.writei32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.DataSenderRate, 60)
				Flags.DesyncPosition = Cache.Character:FindFirstChild("HumanoidRootPart").Position
				Flags.DesyncEnabled = true
			end
		else
			Flags.DesyncActive = false
			if memory.is_enabled() then
				memory.writei32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.PhysicsSenderMaxBandwidthBps, 38760)
				Flags.DesyncPosition = nil
				Flags.DesyncEnabled = false
			end
		end
	end)
	DesyncKeybind:set_visible(false)

	DesyncCategory:add_separator()

	DesyncCategory:add_toggle("Fake Lag", false, function(Bool)
		Flags.FakeLag = Bool
		FakeLagKeybind:set_visible(Bool)
		FakeLagIntervalSlider:set_visible(Bool)
	end)

	FakeLagKeybind = DesyncCategory:add_keybind("Keybind", Enum.KeyCode.Y, Enum.KeybindMode.Toggle, function(K) end)
	FakeLagKeybind:set_visible(false)

	FakeLagKeybind:on_activated(function(Active)
		Flags.FakeLagActive = Active

		if not Active then
			Cheat.FakeLagLastToggle = nil
			Cheat.FakeLagState = nil
			if memory.is_enabled() then
				memory.writei32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.PhysicsSenderMaxBandwidthBps, 38760)
				memory.writei32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.DataSenderRate, 60)
			end
		end
	end)

	FakeLagIntervalSlider = DesyncCategory:add_slider(
		"Interval",
		0.1,
		0.75,
		0.35,
		Enum.SliderValueType.Float,
		function(V)
			Flags.FakeLagInterval = V
		end
	)
	FakeLagIntervalSlider:set_visible(false)
end

do
	--[[
	local FreecamCategory = MovementTab:add_category("Freecam")
	local FreecamSpeedSlider
	local FreecamBtrTeleportToggle

	FreecamCategory:add_toggle("Freecam", false, function(Bool)
		Flags.Freecam = Bool
		FreecamKeybind:set_visible(Bool)
		FreecamSpeedSlider:set_visible(Bool)
		FreecamBtrTeleportToggle:set_visible(Bool)
	end)

	FreecamSpeedSlider = FreecamCategory:add_slider("Speed", 1, 20, 5, Enum.SliderValueType.Int, function(V)
		Flags.FreecamSpeed = V
	end)
	FreecamSpeedSlider:set_visible(false)

	FreecamKeybind = FreecamCategory:add_keybind(
		"Keybind",
		Enum.KeyCode.L,
		Enum.KeybindMode.Toggle,
		function(KeyCode) end
	)
	FreecamKeybind:set_visible(false)
	FreecamKeybind:on_activated(function(Active)
		Flags.FreecamActive = Active
	end)

	FreecamBtrTeleportToggle = FreecamCategory:add_toggle("BTR Teleport", false, function(Bool)
		Flags.FreecamBtrTeleport = Bool
	end)
	FreecamBtrTeleportToggle:set_visible(false)
	--]]
end

do
	local NoClipCategory = MovementTab:add_category("No Clip")

	NoClipCategory:add_toggle("Card No Clip", false, function(Bool)
		Flags.CardNoClip = Bool

		for _, Part in Cache.Workspace.RocketFactoryPinkCardInvisWalls:GetChildren() do
			if Part:IsA("MeshPart") then
				Part.CanCollide = not Bool
			end
		end

		for _, Part in Cache.Workspace.Monuments:GetDescendants() do
			if Part:IsA("MeshPart") and Part.Name:find("FallenShippingContainer") then
				Part.CanCollide = not Bool
			end
		end
	end)
	--[[
	Cache.Workspace.RocketFactoryPinkCardInvisWalls.ChildAdded:Connect(function(Part)
		Part.CanCollide = not Flags.CardNoClip
	end)

	Cache.Workspace.Monuments.DescendantAdded:Connect(function(Part)
		if Part:IsA("MeshPart") and Part.Name:find("FallenShippingContainer") then
			Part.CanCollide = not Flags.CardNoClip
		end
	end)
	--]]
end

do
	--[[
	local AntiAimCategory = MovementTab:add_category("Anti Aim")

	local AntiAimYawSpeedSlider
	local AntiAimYawDropdown
	local AntiAimYawMinSlider
	local AntiAimYawMaxSlider

	AntiAimCategory:add_toggle("Yaw", false, function(Bool)
		Flags.YawEnabled = Bool
		AntiAimYawSpeedSlider:set_visible(Bool)
		AntiAimYawDropdown:set_visible(Bool)
		AntiAimYawMinSlider:set_visible(Bool)
		AntiAimYawMaxSlider:set_visible(Bool)
	end)

	AntiAimYawSpeedSlider = AntiAimCategory:add_slider("Speed", 1, 100, 50, Enum.SliderValueType.Int, function(V)
		Flags.YawSpeed = V
	end)
	AntiAimYawSpeedSlider:set_visible(false)

	AntiAimYawDropdown = AntiAimCategory:add_dropdown("Type", { "Jitter", "Spin" }, 0, function(V)
		if V == 0 then
			Flags.YawType = "Jitter"
		elseif V == 1 then
			Flags.YawType = "Spin"
		end
	end)
	AntiAimYawDropdown:set_visible(false)

	AntiAimYawMinSlider = AntiAimCategory:add_slider("Min", -180, 180, 0, Enum.SliderValueType.Int, function(V)
		Flags.YawMin = V
	end)
	AntiAimYawMinSlider:set_visible(false)

	AntiAimYawMaxSlider = AntiAimCategory:add_slider("Max", -180, 180, 0, Enum.SliderValueType.Int, function(V)
		Flags.YawMax = V
	end)
	AntiAimYawMaxSlider:set_visible(false)
	--]]
end

local VisualsTab = gui.add_tab("ESP", { icon = Enum.TabIcon.Eye, after = "after" })

-- loot esp
do
	local LootCategory = VisualsTab:add_category("Loot")

	local DroppedItemsSlider
	local BodybagSlider

	LootCategory:add_toggle("Dropped Items", false, function(bool)
		Flags.ItemESP = bool
		DroppedItemsSlider:set_visible(bool)
	end)
	DroppedItemsSlider = LootCategory:add_slider("Distance", 50, 1000, 500, Enum.SliderValueType.Int, function(v)
		Flags.ItemESPDistance = v
	end)
	DroppedItemsSlider:set_visible(false)

	LootCategory:add_separator()

	LootCategory:add_toggle("Bodybags", false, function(Bool)
		Flags.BodybagESP = Bool
		BodybagSlider:set_visible(Bool)
	end)
	BodybagSlider = LootCategory:add_slider("Distance", 50, 1000, 500, Enum.SliderValueType.Int, function(V)
		Flags.BodybagESPDistance = V
	end)
	BodybagSlider:set_visible(false)
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

-- player esp
do
	local LimitDistance

	local PlayerEspCategory = VisualsTab:add_category("Player")
	PlayerEspCategory:add_toggle("Armor Viewer", false, function(bool)
		Flags.ArmorViewer = bool
	end)
	-- PlayerEspCategory:add_toggle("Held Item", false, function(bool)
	-- 	Flags.HeldItemEsp = bool
	-- end)
	PlayerEspCategory:add_toggle("Box", false, function(bool)
		Flags.BoxEsp = bool
	end)
	PlayerEspCategory:add_toggle("Name", false, function(bool)
		Flags.NameEsp = bool
	end)
	local HealthBarSideDropdown
	PlayerEspCategory:add_toggle("Health Bar", false, function(bool)
		Flags.HealthBarEsp = bool
		HealthBarSideDropdown:set_visible(bool)
	end)
	HealthBarSideDropdown = PlayerEspCategory:add_dropdown(
		"Health Bar Side",
		{ "Left", "Right", "Top", "Bottom" },
		0,
		function(v)
			Flags.HealthBarSide = ({ "Left", "Right", "Top", "Bottom" })[v + 1]
		end
	)
	HealthBarSideDropdown:set_visible(false)
	PlayerEspCategory:add_toggle("Distance", false, function(bool)
		Flags.DistanceEsp = bool
	end)
	PlayerEspCategory:add_toggle("Weapon", false, function(bool)
		Flags.WeaponEsp = bool
	end)
	PlayerEspCategory:add_toggle("Team Check", false, function(bool)
		Flags.TeamCheck = bool
	end)
	PlayerEspCategory:add_toggle("NPC", false, function(bool)
		Flags.AiEsp = bool
	end)
	PlayerEspCategory:add_slider("Limit Distance", 50, 1500, 500, Enum.SliderValueType.Int, function(v)
		Flags.PlayerLimitDistance = v
	end)
end

do
	local MiscCategory = MovementTab:add_category("Misc")
	Flags.ModCheck = "Notify"
	local ModCheckerDropdown
	MiscCategory:add_toggle("Mod Checker", false, function(bool)
		OnModCheckerToggle(bool, ModCheckerDropdown)
	end)
	ModCheckerDropdown = MiscCategory:add_dropdown("Behavior", { "Notify", "Kick" }, 0, function(v)
		if v == 0 then
			Flags.ModCheck = "Notify"
		elseif v == 1 then
			Flags.ModCheck = "Kick"
		end
	end)
	ModCheckerDropdown:set_visible(false)

	MiscCategory:add_separator()

	-- text input to add player
	local NameInput = MiscCategory:add_input("Name", "", 256, function() end)

	-- button to add player
	MiscCategory:add_button("Add Player", function()
		local Text = NameInput:get_text()
		if Text and Text ~= "" then
			local Success = AddToWhiteList(Text)
			if Success then
				rbxcli.display_notification("Removed '" .. Text .. "' from whitelist", 3)
			else
				rbxcli.display_notification("'" .. Text .. "' is not in whitelist", 3)
			end
		end
	end)

	-- button to remove player
	MiscCategory:add_button("Remove Player", function()
		local Text = NameInput:get_text()
		if Text and Text ~= "" then
			local Success = RemoveFromWhiteList(Text)
			if Success then
				rbxcli.display_notification("Added '" .. Text .. "' to whitelist", 3)
			else
				rbxcli.display_notification("'" .. Text .. "' is already whitelisted", 3)
			end
		end
	end)

	-- button to clear entire whitelist
	MiscCategory:add_button("Clear WhiteList", function()
		Flags.WhiteListedPlayers = {}
		SaveWhiteList()
		Flags.LockedTarget = nil
		rbxcli.display_notification("Whitelist cleared", 3)
	end)

	-- list current whitelisted
	MiscCategory:add_button("Show Whitelist", function()
		local list = GetWhiteListString()
		rbxcli.display_notification("Whitelisted: " .. list, 7)
	end)
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
					or (
						Flags.AimbotVisCheck
						and not IsTargetVisible(Flags.LockedTarget.Character, Flags.LockedTarget.TargetPart)
					)
				then
					Flags.LockedTarget = FindClosestViableTarget()
				end

				-- guard clause for if no target is found
				if not Flags.LockedTarget or not Flags.LockedTarget.Head then
					return
				end

				local ResolvedPart
				local TargetPartName = Flags.AimbotTargetPart or "Head"
				local Char = Flags.LockedTarget.Character

				if TargetPartName == "Closest" then
					local MousePos = Cache.UserInputService:GetMouseLocation()
					local ClosestPartDist = math.huge
					for _, Part in Char:GetChildren() do
						if not Part:IsA("BasePart") then
							continue
						end
						local PartScreen, PartOnScreen = rendering.world_to_screen(Part.Position)
						if not PartOnScreen then
							continue
						end
						local PartDist = (PartScreen - MousePos).Magnitude
						if PartDist < ClosestPartDist then
							ClosestPartDist = PartDist
							ResolvedPart = Part
						end
					end
					ResolvedPart = ResolvedPart or Flags.LockedTarget.Head
				elseif TargetPartName == "HumanoidRootPart" then
					ResolvedPart = Char:FindFirstChild("HumanoidRootPart") or Flags.LockedTarget.Head
				else
					ResolvedPart = Char:FindFirstChild("Head") or Flags.LockedTarget.TargetPart
				end

				if not ResolvedPart then
					return
				end
				local TargetPos = ResolvedPart.Position
				local HeldWeapon = GetHeldWeapon(Cache.Character)
				local Info = GetBulletInfo(HeldWeapon)
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
					TargetPos = ResolvedPart.Position + Vector3.new(0, Drop, 0)
				else
					if HeldWeapon == "Bow" or HeldWeapon == "Crossbow" then
						TargetPos = CalculateTargetPositionNoYPred(
							Info.Speed,
							Info.Gravity,
							ResolvedPart.Velocity,
							ResolvedPart.Position,
							Cache.Camera.CFrame.Position
						)
					else
						TargetPos = CalculateTargetPosition(
							Info.Speed,
							Info.Gravity,
							ResolvedPart.Velocity,
							ResolvedPart.Position,
							Cache.Camera.CFrame.Position
						)
					end
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
						Flags.LockedTarget.TargetPart.Position,
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
		-- armor viewer vars
		local BoxCount = 8
		local BoxSize = 64 -- width and height of each box
		local BoxSpacing = 5 -- gap between boxes
		local TopMargin = 55 -- distance from top of screen
		local BoxRounding = 10

		-- background, border, text colors
		local BgColor = Color4.new(0.28, 0.28, 0.28, 0.45)

		-- image cache
		local ImageCache = {}
		local Image_Base_Url = "https://raw.githubusercontent.com/sigma4skin/rbxcli-fallen/main/armor_images/"
		local ArmorImageDir = Cheat.Directory .. "/armor_images/"

		-- ensure dirs exist
		pcall(function()
			if not fs.is_directory(ArmorImageDir) then
				pcall(function()
					fs.create_directory(ArmorImageDir)
				end)
			end
		end)

		local function GetImage(ArmorId)
			if not ArmorId then
				return nil
			end

			local Cached = ImageCache[ArmorId]
			if Cached ~= nil then
				return Cached or nil
			end

			local Existing = image.get(ArmorId)
			if Existing and Existing.IsValid then
				ImageCache[ArmorId] = Existing
				return Existing
			end

			-- fetch from github
			local Url = Image_Base_Url .. ArmorId .. ".png"
			task.spawn(function()
				local FilePath = ArmorImageDir .. ArmorId .. ".png"

				-- try loading from disk first
				if fs.is_file(FilePath) then
					local Ok, Data = pcall(fs.read_async, FilePath)
					if Ok and Data then
						local Img = image.load(ArmorId, Data)
						ImageCache[ArmorId] = Img and Img.IsValid and Img or false
						return
					end
				end

				-- not on disk load from github
				local Ok, Response = pcall(Cache.HttpService.RequestAsync, Cache.HttpService, {
					Url = Url,
					Method = "GET",
					Headers = { ["User-Agent"] = "rbxcli-script" },
				})

				if not Ok or not Response.Success then
					ImageCache[ArmorId] = false
					return
				end

				local RawData = buffer.fromstring(Response.Body)

				-- save to disk for next time
				pcall(function()
					if not fs.is_file(FilePath) then
						fs.create_file(FilePath)
						fs.write_async(FilePath, RawData)
					end
				end)

				local Img = image.load(ArmorId, buffer.fromstring(Response.Body))
				ImageCache[ArmorId] = Img and Img.IsValid and Img or false
			end)

			return nil
		end

		-- caching shit
		local SlotCache = {}
		local SlotCacheTarget = nil

		local function RebuildSlotCache()
			SlotCache = {}
			if not Flags.LockedTarget then
				return
			end

			local Char = Flags.LockedTarget.Character
			if not Char then
				return
			end

			local Seen = {}
			local Idx = 1

			for _, Child in Char:GetChildren() do
				if Idx > BoxCount then
					break
				end

				local ArmorId = Child.Name:match("^Armor_%d+")
				if ArmorId and not Seen[ArmorId] then
					Seen[ArmorId] = true
					SlotCache[Idx] = { ArmorId = ArmorId, Icon = GetImage(ArmorId) }
					Idx += 1
				end
			end
		end

		local function UpdateSlotCacheImages()
			for I, Slot in SlotCache do
				if Slot and not Slot.Icon then
					local Img = ImageCache[Slot.ArmorId]
					if Img then
						Slot.Icon = Img
					end
				end
			end
		end

		local WeaponCache = {} -- [Player] = { Weapon = string, Connection = EventConnection }
		local HealthAnim = {}
		local LastEspClock = 0

		-- player list cache (refreshed on player added/removed)
		local PlayerListCache = {}

		local function RebuildPlayerListCache()
			PlayerListCache = {}
			for _, Player in Cache.Players:GetPlayers() do
				if Player ~= Cache.Client then
					table.insert(PlayerListCache, Player)
				end
			end
		end

		-- build initial caches
		RebuildPlayerListCache()

		-- keep player list updated via events
		Cache.Players.PlayerAdded:Connect(function(Player)
			if Player ~= Cache.Client then
				table.insert(PlayerListCache, Player)
			end
		end)

		Cache.Players.PlayerRemoving:Connect(function(Player)
			WeaponCache[Player] = nil
			for I, P in PlayerListCache do
				if P == Player then
					table.remove(PlayerListCache, I)
					break
				end
			end
		end)
		-- end of caching shit

		-- throttled cache refresh timer
		local WeaponCacheLastUpdate = 0
		local SlotCacheLastUpdate = 0
		local WEAPON_CACHE_INTERVAL = 1 -- refresh weapon cache every second (if your looking at these and your fps is shit change these)
		local SLOT_CACHE_INTERVAL = 1 -- refresh slot cache every second

		local function Espify(Char, DisplayName, Key, CamPos, MaxDist, EspDelta, White)
			if not Char or Char:IsInvalidInstance() then
				return
			end

			local Humanoid = Char:FindFirstChild("Humanoid")
			if not Humanoid or Humanoid.Health <= 0 then
				return
			end

			local Head = Char:FindFirstChild("Head")
			local Root = Char:FindFirstChild("HumanoidRootPart")
			if not Head or not Root or Head:IsInvalidInstance() or Root:IsInvalidInstance() then
				return
			end

			if (CamPos - Root.Position).Magnitude > MaxDist then
				return
			end

			local Up = Root.CFrame.UpVector
			local TopPos, TopVis = rendering.world_to_screen(Head.Position + Up * 1.2)
			local BottomPos, BottomVis = rendering.world_to_screen(Root.Position - Up * 2.5)
			if not (TopVis or BottomVis) then
				return
			end

			local Height = math.abs(BottomPos.Y - TopPos.Y)
			local Width = math.max(Height / 1.5, 6)
			local BoxX = math.floor(TopPos.X - Width / 2)
			local BoxY = math.floor(TopPos.Y)
			local BoxW = math.ceil(Width)
			local BoxH = math.ceil(Height)
			local BoxRight = BoxX + BoxW
			local BoxBottom = BoxY + BoxH
			local CenterX = BoxX + BoxW / 2

			local HealthPerc = math.clamp(Humanoid.Health / Humanoid.MaxHealth, 0, 1)
			local PrevPerc = HealthAnim[Key] or HealthPerc
			local AnimPerc = PrevPerc + (HealthPerc - PrevPerc) * (1 - math.exp(-EspDelta * 12))
			HealthAnim[Key] = AnimPerc

			local TopOff, BotOff = 0, 0

			if Flags.HealthBarEsp then
				local HealthColor = Color4.new(1 - AnimPerc, AnimPerc, 0, 1)
				local Side = Flags.HealthBarSide or "Left"
				if Side == "Top" then
					TopOff = 12
					local BarY = BoxY - 5
					immediate.rectangle(
						Vector2.new(BoxX, BarY),
						Vector2.new(BoxX + AnimPerc * BoxW, BarY + 1),
						0,
						true,
						true,
						HealthColor
					)
				elseif Side == "Bottom" then
					BotOff = 12
					local BarY = BoxBottom + 5
					immediate.rectangle(
						Vector2.new(BoxX, BarY),
						Vector2.new(BoxX + AnimPerc * BoxW, BarY + 1),
						0,
						true,
						true,
						HealthColor
					)
				elseif Side == "Right" then
					local BarX = BoxRight + 5
					immediate.rectangle(
						Vector2.new(BarX, BoxBottom - AnimPerc * BoxH),
						Vector2.new(BarX + 1, BoxBottom),
						0,
						true,
						true,
						HealthColor
					)
				else
					local BarX = BoxX - 5
					immediate.rectangle(
						Vector2.new(BarX, BoxBottom - AnimPerc * BoxH),
						Vector2.new(BarX + 1, BoxBottom),
						0,
						true,
						true,
						HealthColor
					)
				end
			end

			if Flags.BoxEsp then
				immediate.rectangle(Vector2.new(BoxX, BoxY), Vector2.new(BoxRight, BoxBottom), 0, false, true, White)
			end

			if Flags.NameEsp then
				local NameSize = immediate.calculate_text_size(DisplayName, Cheat.Fonts.Font14)
				immediate.text(
					Vector2.new(CenterX - NameSize.X / 2, BoxY - 16 - TopOff),
					DisplayName,
					Cheat.Fonts.Font14,
					true,
					White
				)
			end

			if Flags.DistanceEsp then
				local DistText = math.floor((CamPos - Root.Position).Magnitude) .. "s"
				local DistSize = immediate.calculate_text_size(DistText, Cheat.Fonts.Font14)
				immediate.text(
					Vector2.new(CenterX - DistSize.X / 2, BoxBottom + 2 + BotOff),
					DistText,
					Cheat.Fonts.Font14,
					true,
					White
				)
				BotOff = BotOff + 14
			end

			if Flags.WeaponEsp then
				local Entry = WeaponCache[Key]
				local WeaponText = (Entry and Entry.weapon) or GetHeldWeapon(Char)
				local WeaponSize = immediate.calculate_text_size(WeaponText, Cheat.Fonts.Font14)
				immediate.text(
					Vector2.new(CenterX - WeaponSize.X / 2, BoxBottom + 2 + BotOff),
					WeaponText,
					Cheat.Fonts.Font14,
					true,
					White
				)
			end
		end

		Cache.RunService.PreRender:Connect(function()
			local Viewport = Cache.Camera.ViewportSize
			local Now = os.clock()

			-- refresh weapon cache on interval
			if Now - WeaponCacheLastUpdate >= WEAPON_CACHE_INTERVAL then
				WeaponCacheLastUpdate = Now
				for _, Player in PlayerListCache do
					local Char = Player.Character
					if Char and not Char:IsInvalidInstance() then
						local Entry = WeaponCache[Player]
						if not Entry then
							WeaponCache[Player] = {}
							Entry = WeaponCache[Player]
						end
						Entry.weapon = GetHeldWeapon(Char)
					else
						WeaponCache[Player] = nil
					end
				end
			end

			-- refresh slot cache on interval too
			-- also handles locked target changing
			if SlotCacheTarget ~= Flags.LockedTarget or Now - SlotCacheLastUpdate >= SLOT_CACHE_INTERVAL then
				SlotCacheLastUpdate = Now
				SlotCacheTarget = Flags.LockedTarget
				RebuildSlotCache()
			end

			-- held item
			if Flags.HeldItemEsp then
				local CamPos = Cache.Camera.CFrame.Position
				local MaxDist = Flags.PlayerLimitDistance or 500

				for _, Player in PlayerListCache do
					local Entry = WeaponCache[Player]
					if not Entry then
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

					local WorldPos = Head.Position + Vector3.new(0, -5, 0)
					local Dist = (CamPos - WorldPos).Magnitude
					if Dist > MaxDist then
						continue
					end

					local ScreenPos, OnScreen = rendering.world_to_screen(WorldPos)
					if not OnScreen then
						continue
					end

					local Text = Entry.weapon or "None"
					local Size = immediate.calculate_text_size(Text, Cheat.Fonts.Font20)
					immediate.text(
						Vector2.new(ScreenPos.X - Size.X / 2, ScreenPos.Y),
						Text,
						Cheat.Fonts.Font20,
						true,
						Color4.new(1, 1, 1, 1)
					)
				end
			end

			if Flags.BoxEsp or Flags.NameEsp or Flags.HealthBarEsp or Flags.DistanceEsp or Flags.WeaponEsp then
				local CamPos = Cache.Camera.CFrame.Position
				local MaxDist = Flags.PlayerLimitDistance or 500
				local LocalTeam = Cache.Client.Team
				local EspDelta = Now - LastEspClock
				LastEspClock = Now
				local White = Color4.new(1, 1, 1, 1)

				for _, Player in PlayerListCache do
					if Flags.TeamCheck and LocalTeam and Player.Team == LocalTeam then
						continue
					end
					Espify(Player.Character, Player.Name, Player, CamPos, MaxDist, EspDelta, White)
				end

				if Flags.AiEsp then
					if Now - Cheat.SoldierCacheLastUpdate >= Cheat.SOLDIER_CACHE_INTERVAL then
						Cheat.SoldierCacheLastUpdate = Now
						AiList()
					end
					for _, Soldier in Cheat.SoldierListCache do
						if Soldier and Soldier.Parent then
							Espify(Soldier, Soldier.Name, Soldier, CamPos, MaxDist, EspDelta, White)
						end
					end
				end
			end

			-- armor viewer
			if Flags.ArmorViewer and Flags.LockedTarget then
				-- refresh any icons that finished loading async this frame
				UpdateSlotCacheImages()

				local TotalWidth = BoxCount * BoxSize + (BoxCount - 1) * BoxSpacing
				local StartX = (Viewport.X - TotalWidth) / 2
				local Y = TopMargin

				for I = 1, BoxCount do
					local X = StartX + (I - 1) * (BoxSize + BoxSpacing)
					local TopLeft = Vector2.new(X, Y)
					local BottomRight = Vector2.new(X + BoxSize, Y + BoxSize)

					-- filled background
					immediate.rectangle(TopLeft, BottomRight, BoxRounding, true, false, BgColor)

					-- image
					local Slot = SlotCache[I]
					if Slot and Slot.Icon then
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
											item.Name .. " [" .. math.floor(dist) .. "s]",
											Cheat.Fonts.Font20,
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

			-- body bags
			if Flags.BodybagESP then
				local Bodybags = Cache.Workspace.Bases.Loners:FindFirstChild("Body Bag")
				if not Bodybags then
					return
				end

				for _, Bodybag in Bodybags:GetChildren() do
					if Bodybag:IsInvalidInstance() then
						return
					end

					local Main = Bodybag:FindFirstChild("Main")
					if not Main then
						return
					end

					local Pos = Main.CFrame.Position
					local Dist = (Cache.Camera.CFrame.Position - Pos).Magnitude
					if Dist > Flags.BodybagESPDistance then
						return
					end

					local ScreenPos, Vis = rendering.world_to_screen(Pos)

					if Vis then
						immediate.text(
							Vector2.new(ScreenPos.X, ScreenPos.Y),
							Bodybag.Name .. " [" .. math.floor(Dist) .. "s]",
							Cheat.Fonts.Font20,
							true,
							Color4.new(1, 1, 1, 1)
						)
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
												node.Name:gsub("_Node", "") .. " [" .. math.floor(dist) .. "s]",
												Cheat.Fonts.Font20,
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
		end)
	end -- end of esp loop

	do -- manipulation
		local OgPos = nil

		Cache.RunService.Heartbeat:Connect(function()
			local Char = Cache.Character
			local Root = Char and Char:FindFirstChild("HumanoidRootPart")

			if not Root then
				DisableManip()
				OgPos = nil
				return
			end

			local ShouldManip = Flags.AimbotManipulation == true
				and Flags.AimbotManipulationActive == true
				and Flags.Aimbot == true
				and AimbotKeybind:is_active()
				and Flags.LockedTarget ~= nil
				and not (Flags.Desync and Flags.DesyncActive)

			if not ShouldManip then
				if Flags.IsManipping then
					if OgPos then
						Root.CFrame = (Root.CFrame - Root.CFrame.Position) + OgPos
						Root.Velocity = Vector3.zero
					end
					DisableManip()
				else
					return
				end
				OgPos = nil
				return
			end

			local Target = Flags.LockedTarget
			local TargetPart = Target and (Target.TargetPart or Target.Head)

			if not Target or not TargetPart or TargetPart:IsInvalidInstance() then
				if Flags.IsManipping then
					if OgPos then
						Root.CFrame = (Root.CFrame - Root.CFrame.Position) + OgPos
						Root.Velocity = Vector3.zero
					end
					DisableManip()
					OgPos = nil
				end
				return
			end

			if Flags.IsManipping then
				if OgPos then
					local PeekPos = FindManipulationPosition(OgPos, TargetPart, Target.Character)
					if PeekPos then
						Root.CFrame = (Root.CFrame - Root.CFrame.Position) + PeekPos
						Root.Velocity = Vector3.zero
					end
				end
				return
			end

			local PeekPos = FindManipulationPosition(Root.Position, TargetPart, Target.Character)
			if not PeekPos then
				return
			end

			if memory.is_enabled() then
				memory.writei32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.PhysicsSenderMaxBandwidthBps, -9999)
				memory.writei32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.DataSenderRate, 60)
				OgPos = Root.Position
				Flags.IsManipping = true
				Flags.ManipulationPosition = OgPos
				Root.CFrame = (Root.CFrame - Root.CFrame.Position) + PeekPos
				Root.Velocity = Vector3.zero
			end

			if
				not IsManipping
				and memory.readi32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.PhysicsSenderMaxBandwidthBps) == -9999
			then
				DisableManip()
			end
		end)
	end

	do -- movement
		local LastYawMove = os.clock()
		local TickCount = 0

		Cache.RunService.Heartbeat:Connect(function(dt)
			local Char = Cache.Character
			if not Char or not Char.Parent then
				return
			end
			local Root = Char:FindFirstChild("HumanoidRootPart")
			local Humanoid = Char:FindFirstChild("Humanoid")
			if not Root or not Humanoid then
				return
			end
			local IsFlying = false

			if Flags.Fly then
				IsFlying = true
				task.spawn(function()
					if Root and Humanoid and Humanoid.Health > 0 then
						local Delta = dt * Flags.FlySpeed * 3
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

						Humanoid.PlatformStand = false
						Root.Velocity = Vector3.zero
						Root.CFrame = CFrame.new(Position, Position + Vector3.new(Look.X, 0, Look.Z))
					end
				end)
			end

			if Flags.InfiniteFly and IsFlying and Root and Char and Char.Parent then
				local Result =
					physics.raycast(Root.Position, Vector3.new(0, -1000, 0), Cheat.RaycastDistance, BuildSelfFilter())

				local DistanceFromGround = Result and Result.hit_successful and Result.distance or math.huge
				if DistanceFromGround > 4 then
					task.spawn(function()
						local OldVel = Root.Velocity
						for _, Part in Char:GetChildren() do
							if Part:IsA("BasePart") then
								Part.Velocity = Vector3.new(0, -9999, 0)
							end
						end
						Cache.RunService.PreRender:Wait()
						for _, Part in Char:GetChildren() do
							if Part:IsA("BasePart") then
								Part.Velocity = OldVel
							end
						end
					end)
				end
			end

			if Flags.Freecam and Flags.FreecamActive and not IsFlying then
				if not Root then
					return
				end

				if not Cheat.NeedToReturn then
					Cheat.NeedToReturn = true
					Cheat.FreecamSavedPosition = Root.CFrame

					-- anchor root
					Root.NetworkOwnerV3 = 2
					Root.NetworkIsSleeping = true

					memory.writebool(Humanoid.Address + Cheat.Offsets.Humanoid.AutoRotate, false)
				end

				local CameraCF = Cache.Camera.CFrame
				local Look = CameraCF.LookVector
				local Right = CameraCF.RightVector
				local Up = Vector3.new(0, 1, 0)

				local MoveLookDir, MoveRightDir, MoveUpDir =
					(Cache.UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0) + (Cache.UserInputService:IsKeyDown(
						Enum.KeyCode.S
					) and -1 or 0),
					(Cache.UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0) + (Cache.UserInputService:IsKeyDown(
						Enum.KeyCode.A
					) and -1 or 0),
					(Cache.UserInputService:IsKeyDown(Enum.KeyCode.E) and 1 or 0) + (Cache.UserInputService:IsKeyDown(
						Enum.KeyCode.Control
					) and -1 or 0)

				local MoveDir = (Look * MoveLookDir) + (Right * MoveRightDir) + (Up * MoveUpDir)

				Root.Velocity = Vector3.zero
				local Delta = dt * Flags.FreecamSpeed * 50

				if MoveDir.Magnitude > 0 then
					Root.CFrame = Root.CFrame + (MoveDir.Unit * Delta)
				end

				local Pos = Root.Position
				Root.CFrame = CFrame.new(Pos, Pos + Vector3.new(Look.X, 0, Look.Z))

				if Flags.FreecamBtrTeleport then
					local BTR = Cache.Workspace:FindFirstChild("Events")
						and Cache.Workspace.Events:FindFirstChild("BTR")
					local BTRRoot = BTR and BTR:FindFirstChild("HumanoidRootPart")

					if BTRRoot and BTRRoot.IsNetworkOwner then
						BTRRoot.CFrame = Root.CFrame
					end
				end
			elseif Cheat.NeedToReturn then
				Cheat.NeedToReturn = false
				if not Root then
					return
				end

				memory.writebool(Humanoid.Address + Cheat.Offsets.Humanoid.AutoRotate, true)
				Root.NetworkIsSleeping = false

				if Char then
					for _, Part in Char:GetChildren() do
						if Part:IsA("BasePart") then
							Part.NetworkIsSleeping = false
						end
					end
				end

				if Cheat.FreecamSavedPosition then
					Root.CFrame = Cheat.FreecamSavedPosition
				end
				Root.NetworkOwnerV3 = Cache.RakPeerId
				Cheat.FreecamSavedPosition = nil
			end

			if
				Flags.FakeLag
				and Flags.FakeLagActive
				and not (Flags.Desync and Flags.DesyncActive)
				and not Flags.IsManipping
			then
				local Now = os.clock()

				if not Cheat.FakeLagLastToggle then
					Cheat.FakeLagLastToggle = Now
					Cheat.FakeLagState = false
				end

				if Now - Cheat.FakeLagLastToggle >= Flags.FakeLagInterval then
					Cheat.FakeLagLastToggle = Now
					Cheat.FakeLagState = not Cheat.FakeLagState

					if Cheat.FakeLagState then
						-- desync on
						if not memory.is_enabled() then
							return
						end

						memory.writei32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.PhysicsSenderMaxBandwidthBps, -9999)
						memory.writei32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.DataSenderRate, -1)
					else
						-- desync off
						if not memory.is_enabled() then
							return
						end

						memory.writei32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.PhysicsSenderMaxBandwidthBps, 38760)
						memory.writei32(Cheat.Offsets.Base + Cheat.Offsets.FFlags.DataSenderRate, 60)
					end
				end
			end

			-- anti aim
			local IsShooting = Cache.UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
				and GetHeldWeapon(Char) ~= "None"

			if Flags.YawEnabled and not IsShooting then
				if os.clock() - LastYawMove >= (1 - (Flags.YawSpeed / 100)) then
					if Flags.YawType == "Spin" then
						memory.writebool(Humanoid.Address + Cheat.Offsets.Humanoid.AutoRotate, false)
						Root.CFrame = Root.CFrame * CFrame.Angles(0, math.rad(1), 0)
					elseif Flags.YawType == "Jitter" then
						memory.writebool(Humanoid.Address + Cheat.Offsets.Humanoid.AutoRotate, false)
						if math.random(1, 2) == 1 then
							Root.CFrame = CFrame.new(Root.Position)
								* CFrame.fromEulerAnglesXYZ(0, math.rad(Flags.YawMin), 0)
						else
							Root.CFrame = CFrame.new(Root.Position)
								* CFrame.fromEulerAnglesXYZ(0, math.rad(Flags.YawMax), 0)
						end
					else
						memory.writebool(Humanoid.Address + Cheat.Offsets.Humanoid.AutoRotate, true)
					end

					LastYawMove = os.clock()
				end
			elseif not memory.readbool(Humanoid.Address + Cheat.Offsets.Humanoid.AutoRotate) then
				memory.writebool(Humanoid.Address + Cheat.Offsets.Humanoid.AutoRotate, true)
			end
		end)
	end -- end of movement loop

	do -- misc
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

		Cache.RunService.Heartbeat:Connect(function(dt)
			-- card no clip
			if Flags.CardNoClip then
				for _, Part in Cache.Workspace.RocketFactoryPinkCardInvisWalls:GetChildren() do
					if Part:IsA("Part") then
						Part.CanCollide = not Flags.CardNoClip
					end
				end

				for _, Part in Cache.Workspace.Monuments:GetDescendants() do
					if Part:IsA("MeshPart") and Part.Name:find("FallenShippingContainer") then
						Part.CanCollide = not Flags.CardNoClip
					end
				end
			end
		end)

		do -- misc visuals
			Cache.RunService.PreRender:Connect(function()
				local ViewportSize = Cache.Camera.ViewportSize
				if Flags.DesyncEnabled and Flags.Desync then
					local Distance = (
						Cache.Character:FindFirstChild("HumanoidRootPart").Position - Flags.DesyncPosition
					).Magnitude
					local Color = Color4.new(1, 1, 1, 1)
					local Text = "Desynced " .. tostring(math.floor(Distance)) .. " Studs"
					local TextSize = immediate.calculate_text_size(Text, Cheat.Fonts.Font20)
					local CenterX = (ViewportSize.X / 2) - (TextSize.X / 2)

					if Distance >= 8 then
						Color = Color4.new(1, 0, 0, 1)
					end
					immediate.text(Vector2.new(CenterX, ViewportSize.Y - 250), Text, Cheat.Fonts.Font20, true, Color)
				end

				if Flags.IsManipping and Flags.ManipulationPosition then
					local Root = Cache.Character and Cache.Character:FindFirstChild("HumanoidRootPart")
					if Root then
						local Distance = (Root.Position - Flags.ManipulationPosition).Magnitude
						local Color = Color4.new(1, 1, 1, 1)
						local Text = "Manipulated " .. tostring(math.floor(Distance)) .. " Studs"
						local TextSize = immediate.calculate_text_size(Text, Cheat.Fonts.Font20)
						local CenterX = (ViewportSize.X / 2) - (TextSize.X / 2)

						if Distance >= 8 then
							Color = Color4.new(1, 0, 0, 1)
						end
						immediate.text(
							Vector2.new(CenterX, ViewportSize.Y - 250),
							Text,
							Cheat.Fonts.Font20,
							true,
							Color
						)
					end
				end

				if Cheat.FreecamSavedPosition then
					local Color = Color4.new(1, 1, 1, 1)
					local Text = "Server Position"
					immediate.text(Cheat.FreecamSavedPosition.Position, Text, Cheat.Fonts.Font20, true, Color)
				end

				if
					Flags.FakeLag
					and Flags.FakeLagActive
					and not (Flags.Desync and Flags.DesyncActive)
					and not Flags.IsManipping
				then
					local Color = Color4.new(1, 1, 1, 1)
					local Text = "Fakelag Enabled"
					local TextSize = immediate.calculate_text_size(Text, Cheat.Fonts.Font20)
					local CenterX = (ViewportSize.X / 2) - (TextSize.X / 2)

					immediate.text(Vector2.new(CenterX, ViewportSize.Y - 250), Text, Cheat.Fonts.Font20, true, Color)
				end
			end)
		end
	end -- end of misc loop
end -- end of main loops
