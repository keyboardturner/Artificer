local addonName, Artificer = ...;

local L = Artificer.L;

local MapAmbienceFrame = CreateFrame("Frame")
MapAmbienceFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
MapAmbienceFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
MapAmbienceFrame:RegisterEvent("ZONE_CHANGED")
MapAmbienceFrame:RegisterEvent("PLAYER_LOGOUT")
MapAmbienceFrame:RegisterEvent("PLAYER_STOPPED_MOVING")

local originalAmbience = nil;
local isAmbienceModified = false;
local isLowering = false;
local isRestoring = false;
local TARGET_MAP_ID = 2424;
local RESTORE_DURATION = 2.5;
local LOWER_DURATION = 2.5;

local activeTicker = nil;

local function CancelTicker()
	if activeTicker then
		activeTicker:Cancel();
		activeTicker = nil;
	end
	isLowering = false;
	isRestoring = false;
end

local function StartGradualLower(fromVol, toVol)
	CancelTicker();

	local elapsed = 0;
	local TICK = 0.05;

	isLowering = true;

	activeTicker = C_Timer.NewTicker(TICK, function()
		elapsed = elapsed + TICK;
		local t = math.min(elapsed / LOWER_DURATION, 1.0);
		local vol = fromVol + (toVol - fromVol) * t;
		C_CVar.SetCVar("Sound_AmbienceVolume", tostring(vol));

		if t >= 1.0 then
			CancelTicker();
		end
	end);
end

local function StartGradualRestore(fromVol, toVol)
	CancelTicker();

	local elapsed = 0;
	local TICK = 0.05;

	isRestoring = true;

	activeTicker = C_Timer.NewTicker(TICK, function()
		elapsed = elapsed + TICK;
		local t = math.min(elapsed / RESTORE_DURATION, 1.0);
		local vol = fromVol + (toVol - fromVol) * t;
		C_CVar.SetCVar("Sound_AmbienceVolume", tostring(vol));

		if t >= 1.0 then
			CancelTicker();
			isAmbienceModified = false;
			originalAmbience = nil;
		end
	end);
end

function Artificer:UpdateMapAmbience(ambiencePercent)
	local currentMapID = C_Map.GetBestMapForUnit("player");
	if not currentMapID then return; end

	if type(ambiencePercent) ~= "number" then ambiencePercent = 25 end

	if currentMapID == TARGET_MAP_ID then

		if isRestoring then
			local currentVol = tonumber(C_CVar.GetCVar("Sound_AmbienceVolume")) or 0.5;
			local baseVol = tonumber(originalAmbience) or 0.5;
			local targetVol = baseVol * (ambiencePercent / 100);
			StartGradualLower(currentVol, targetVol);
			return;
		end

		if not isAmbienceModified then
			originalAmbience = C_CVar.GetCVar("Sound_AmbienceVolume");
			isAmbienceModified = true;

			local baseVol = tonumber(originalAmbience) or 0.5;
			local targetVol = baseVol * (ambiencePercent / 100);
			StartGradualLower(baseVol, targetVol);

		elseif not isLowering then
			local baseVol = tonumber(originalAmbience) or 0.5;
			local targetVol = baseVol * (ambiencePercent / 100);
			C_CVar.SetCVar("Sound_AmbienceVolume", tostring(targetVol));
		end

	else

		if isLowering then
			local currentVol = tonumber(C_CVar.GetCVar("Sound_AmbienceVolume")) or 0;
			local targetVol = tonumber(originalAmbience) or 0.5;
			StartGradualRestore(currentVol, targetVol);

		elseif isAmbienceModified and not isRestoring then
			local currentVol = tonumber(C_CVar.GetCVar("Sound_AmbienceVolume")) or 0;
			local targetVol = tonumber(originalAmbience) or 0.5;
			StartGradualRestore(currentVol, targetVol);
		end
	end
end

MapAmbienceFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGOUT" then
		CancelTicker();
		if isAmbienceModified and originalAmbience then
			C_CVar.SetCVar("Sound_AmbienceVolume", originalAmbience);
		end
		isAmbienceModified = false;
		originalAmbience = nil;
		return;
	end

	local ambiencePercent = 25;
	if Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.MapAmbience ~= nil then
		if type(Artificer_DB.Widgets.MapAmbience) == "number" then
			ambiencePercent = Artificer_DB.Widgets.MapAmbience;
		end
	end

	Artificer:UpdateMapAmbience(ambiencePercent);
end)