local addonName, Artificer = ...;

local L = Artificer.L;

Artificer.Widgets = {};

local Defaults = {
	-- example test settings
	--ShowMinimapIcon = true,
	--uiScale = 1.0,
	--logLevel = 2,
	
	-- Widgets
	Widgets = {
		FishReelIn = true,
		ChromieTimeIcon = true,
		HideMacroText = false,
		ArrowKeyEditbox = true,
		OutfitIcon = true,
		ServerNotifications = true,
		AutoLoot = true,
		PetBattleMapFilter = false,
		CooldownManagerEnabled = false,
		PartySync = true,
		HideCraftingResults = false,
		MovableCurrencyTransfer = false,
	},

	OutfitSwapSounds = {
		impact = true,
		A = true,
		B = true,
		C = true,
		D = true,
	},
};

Artificer.CVars = {
	["minimapTrackingShowAll"] = {
		settings = "checkbox",
		default = "0",
		label = L["CVar_minimapTrackingShowAll"],
		description = L["CVar_minimapTrackingShowAllTT"],
	},
	["weatherDensity"] = {
		settings = "slider",
		default = "2",
		min = "0",
		max = "3",
		label = L["CVar_weatherDensity"],
		description = L["CVar_weatherDensityTT"],
	},
	["AutoPushSpellToActionBar"] = {
		settings = "checkbox",
		default = "1",
		label = L["CVar_AutoPushSpellToActionBar"],
		description = L["CVar_AutoPushSpellToActionBarTT"],
	},
};

--[[ -- other CVars to look at?
    "titleBarShortName",
    "titleBarShowAccountName",
    "titleBarShowBuildInfo",
    "titleBarShowCharacterName",
    "titleBarShowConfigName",
    "titleBarShowGxInfo",
    "titleBarShowPID",
    "titleBarShowRealmName",
    "consoleShowSpamMessages",
    "consoleShowDebugMessages",
    "lfgDebug",
    "EnableAirlockLogging",
    "Errors",
    "ErrorFileLog",
    "persistMoveLogOnTransfer",
    "PraiseTheSun",
    "nameplateShowOnlyNameForFriendlyPlayerUnits"
]]

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_LOGOUT")

local function StoreCVar(cvarName)
	if not Artificer_DB.StoredCVars then Artificer_DB.StoredCVars = {} end
	
	if Artificer_DB.StoredCVars[cvarName] == nil then
		local currentVal = C_CVar.GetCVar(cvarName);
		Artificer_DB.StoredCVars[cvarName] = currentVal;
	end
end

local function RestoreCVars()
	if not Artificer_DB or not Artificer_DB.StoredCVars then return end
	
	for cvar, val in pairs(Artificer_DB.StoredCVars) do
		C_CVar.SetCVar(cvar, val);
	end
	
	Artificer_DB.StoredCVars = nil;
end

f:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" and ... == addonName then
		if not Artificer_DB then Artificer_DB = {}; end
		if not Artificer_DB.StoredCVars then Artificer_DB.StoredCVars = {}; end

		for k, v in pairs(Defaults) do
			if k == "Widgets" then
				if not Artificer_DB.Widgets then Artificer_DB.Widgets = {}; end
				for widgetKey, widgetValue in pairs(v) do
					if Artificer_DB.Widgets[widgetKey] == nil then
						Artificer_DB.Widgets[widgetKey] = widgetValue;
					end
				end
			elseif k == "OutfitSwapSounds" then
				if not Artificer_DB.OutfitSwapSounds then Artificer_DB.OutfitSwapSounds = {}; end
				for soundKey, soundValue in pairs(v) do
					if Artificer_DB.OutfitSwapSounds[soundKey] == nil then
						Artificer_DB.OutfitSwapSounds[soundKey] = soundValue;
					end
				end
			elseif Artificer_DB[k] == nil then
				Artificer_DB[k] = v;
			end
		end

		if Artificer.CVars then
			for cvarName, data in pairs(Artificer.CVars) do
				StoreCVar(cvarName);

				if Artificer_DB[cvarName] == nil then
					local currentVal = GetCVar(cvarName);
					if currentVal == nil then currentVal = data.default; end
					
					if data.settings == "checkbox" then
						Artificer_DB[cvarName] = (currentVal == "1");
					else
						Artificer_DB[cvarName] = currentVal;
					end
				end

				local valToApply = Artificer_DB[cvarName];
				if data.settings == "checkbox" then
					valToApply = valToApply and "1" or "0";
				end
				C_CVar.SetCVar(cvarName, valToApply);
			end
		end

		if not Artificer_DB.Characters then Artificer_DB.Characters = {}; end

		local charKey = UnitName("player") .. " - " .. GetRealmName()
		Artificer.CharKey = charKey

		if not Artificer_DB.Characters[charKey] then
			Artificer_DB.Characters[charKey] = {};
		end

		Artificer.GetCharDB = function()
			return Artificer_DB.Characters[Artificer.CharKey];
		end

		local charDB = Artificer.GetCharDB()

	elseif event == "PLAYER_LOGIN" then
		SLASH_ARTIFICER1 = L["SLASH_ARTI1"]
		SLASH_ARTIFICER2 = L["SLASH_ARTI2"]
		SLASH_ARTIFICER3 = L["SLASH_ARTI3"]
		SLASH_ARTIFICER4 = L["SLASH_ARTI4"]
		SlashCmdList["ARTIFICER"] = function(msg)
			Artificer:ToggleSettings();
		end
	elseif event == "PLAYER_LOGOUT" then
		RestoreCVars();
	end
end)