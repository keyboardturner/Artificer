local addonName, Artificer = ...;

local L = Artificer.L;

local LDB = LibStub("LibDataBroker-1.1")
local LDBIcon = LibStub("LibDBIcon-1.0")

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
		AutoLoot = 1, -- changed from true
		BlockGuildInvites = 1,
		PetBattleMapFilter = 1, -- changed from false
		CooldownManagerEnabled = 1, -- changed from false
		PartySync = true,
		HideCraftingResults = false,
		MovableCurrencyTransfer = false,
		AddonCompartmentMover = false,
		CollapseBuffs = false,
		NameplateTargetIndicator = false,
		MinimapRightClick = "outfitsound",
		HideTutorials = false,
		PreyBarEnabled = true,
		BlockTrades = true,
		MapAmbience = 25,
		OutfitLinkOnClose = true,
		DamageMeter = 1,
		DamageWipe = 1,
		HideScreenshotText = false,
		ChatTooltipVisibility = 2,
		DeleteConfirm = false,
		AutoCollapseTracker = {
			rested = false,
			mythicplus = false,
			raid = false,
			scenario = false,
			arena = false,
			bg = false,
			petbattle = false,
		},
		FilteredOverlays = {},
		NameplateStatusIndicator = false,
		AccountIgnoresWindow = true,
	},

	NameplateTargetPos = {
		point = "RIGHT",
		relativePoint = "LEFT",
		x = 0,
		y = 0,
	},

	NameplateStatusPos = {
		point = "CENTER",
		relativePoint = "CENTER",
		x = 0,
		y = 40,
	},
	NameplateStatusTypes = {
		connection = true,
		chromie = true,
		group = true,
		guild = true,
		friend = true,
		ignored = true,
	},
	NameplateStatusColors = {
		connection_away = { r=1, g=1, b=1, a=1, desat = false, },
		connection_dnd = { r=1, g=1, b=1, a=1, desat = false, },
		connection_DCd = { r=1, g=1, b=1, a=1, desat = false, },

		chromie = { r=1, g=1, b=1, a=1, desat = false, },

		group_member = { r=1, g=1, b=1, a=1, desat = false, },
		group_assist = { r=1, g=1, b=1, a=1, desat = false, },
		group_leader = { r=1, g=1, b=1, a=1, desat = false, },

		guild_member = { r=1, g=1, b=1, a=1, desat = false, },

		friend_character = { r=1, g=1, b=1, a=1, desat = true, },
		friend_account = { r=1, g=1, b=1, a=1, desat = true, },
		friend_bnet = { r=1, g=1, b=1, a=1, desat = true, },

		ignored_character = { r=1, g=1, b=1, a=1, desat = false, },
		ignored_account = { r=1, g=1, b=1, a=1, desat = false, },
		--ignored_muted = { r=1, g=1, b=1, a=1, desat = false, },
	};
	NameplateStatusSize = 30,

	OutfitSwapSounds = {
		impact = true,
		A = true,
		B = true,
		C = true,
		D = true,
	},

	PreyBar = {
		PreyBarStyle = "statusbar",
		PreyBarPosition = "bottom",
		HideBlizzWidget = true,
		HideInCombat = true,
	},

	ProfessionToasts = {
		enabled = false,
		bgStyle = "mobileicon",
		width = 330,
		height = 50,
		fontSize = 24,
		textColor = { r = .93, g = .76, b = 0, a = 1 },
		bgColor = { r = 1, g = 1, b = 1, a = 1 },
		borderColor = { r = 1, g = 1, b = 1, a = 1 },
		borderDesat = false,
		bgDesat = false,
		showProfBg = true,
		singleLine = false,
		borderStyle = "questtracker",
		playSound = true,
	},
};

Artificer.Defaults = Defaults;

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
	["minimapTrackingClosestOnly"] = {
		settings = "checkbox",
		default = "1",
		label = L["CVar_minimapTrackingClosestOnly"],
		description = L["CVar_minimapTrackingClosestOnlyTT"]
	},
	["autoDismount"] = {
		settings = "checkbox",
		default = "1",
		label = L["CVar_autoDismount"],
		description = L["CVar_autoDismountTT"]
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

local function Print(text)
	local textColor = CreateColor(.93, .65, .37):GenerateHexColor();
	local addonNameColored = WrapTextInColorCode(L["TOC_Title"], textColor);
	local addonNameJoiner = string.join(": ", addonNameColored, "%s");
	local text = string.format(addonNameJoiner, text);
	
	return DEFAULT_CHAT_FRAME:AddMessage(text, 1, 1, 1);
end

Artificer.Print = Print;

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

Artificer.StoreCVar = StoreCVar;

local function RestoreCVars()
	if not Artificer_DB or not Artificer_DB.StoredCVars then return end
	
	for cvar, val in pairs(Artificer_DB.StoredCVars) do
		C_CVar.SetCVar(cvar, val);
	end
	
	Artificer_DB.StoredCVars = nil;
end

local settingLabelTT = {
	["cancelaura"] = L["CancelAuraManager"],
	["outfitsound"] = L["OutfitSoundManager"],
	["abandonquest"] = L["AbandonQuestManager"],
	["none"] = L["None"],
};

function Artificer_OnAddonCompartmentClick(addonName, buttonName, menuButtonFrame)
	if buttonName == "RightButton" then
		Artificer:MinimapRightClickAction();
	else
		Artificer:ToggleSettings();
	end
end

function Artificer_OnAddonCompartmentEnter(addonName, menuButtonFrame)
	local setting = Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.MinimapRightClick or "outfitsound";
	GameTooltip:SetOwner(menuButtonFrame, "ANCHOR_LEFT");
	GameTooltip:AddLine(L["TOC_Title"]);
	GameTooltip:AddLine(string.format(L["LeftClick"], L["OpenSettings"]), .93, .65, .37);
	if setting then
		local settingAction = settingLabelTT[setting]
		GameTooltip:AddLine(string.format(L["RightClick"], settingAction), .93, .65, .37);
	end
	GameTooltip:Show();
end

function Artificer_OnAddonCompartmentLeave(addonName, menuButtonFrame)
	GameTooltip:Hide();
end

function Artificer:MinimapRightClickAction()
	local setting = Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.MinimapRightClick or "outfitsound";
	if setting == "cancelaura" then
		if Artificer.ToggleCancelAuraUI then Artificer:ToggleCancelAuraUI(); end
	elseif setting == "outfitsound" then
		if Artificer.ToggleOutfitSoundUI then Artificer:ToggleOutfitSoundUI(); end
	elseif setting == "abandonquest" then
		if Artificer.ToggleAbandonQuestUI then Artificer:ToggleAbandonQuestUI(); end
	end
end

f:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" and ... == addonName then
		if not Artificer_DB then Artificer_DB = {}; end
		if not Artificer_DB.MinimapIcon then 
			Artificer_DB.MinimapIcon = { hide = false };
		end
		if not Artificer_DB.StoredCVars then Artificer_DB.StoredCVars = {}; end

		if Artificer_DB.Widgets then
			local legacyKeys = {"AutoLoot", "PetBattleMapFilter", "CooldownManagerEnabled"}
			for _, key in ipairs(legacyKeys) do
				if type(Artificer_DB.Widgets[key]) == "boolean" then
					Artificer_DB.Widgets[key] = Artificer_DB.Widgets[key] and 2 or 1;
				end
			end
		end

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
			elseif k == "PreyBar" then
				if not Artificer_DB.PreyBar then Artificer_DB.PreyBar = {}; end
				for pbKey, pbValue in pairs(v) do
					if Artificer_DB.PreyBar[pbKey] == nil then
						Artificer_DB.PreyBar[pbKey] = pbValue;
					end
				end
			elseif k == "ProfessionToasts" then
				if not Artificer_DB.ProfessionToasts then Artificer_DB.ProfessionToasts = {}; end
				for ptKey, ptValue in pairs(v) do
					if Artificer_DB.ProfessionToasts[ptKey] == nil then
						Artificer_DB.ProfessionToasts[ptKey] = ptValue;
					end
				end
			elseif Artificer_DB[k] == nil then
				Artificer_DB[k] = v;
			end
		end

		local artificerLDB = LDB:NewDataObject("Artificer", {
			type = "launcher",
			text = L["TOC_Title"],
			icon = "Interface\\AddOns\\Artificer\\Textures\\ArtificerIcon_Small",
			OnClick = function(clickedFrame, button)
				if button == "RightButton" then
					Artificer:MinimapRightClickAction();
				else
					Artificer:ToggleSettings();
				end
			end,
			OnTooltipShow = function(tooltip)
				local setting = Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.MinimapRightClick or "outfitsound";
				tooltip:AddLine(L["TOC_Title"]);
				tooltip:AddLine(string.format(L["LeftClick"], L["OpenSettings"]), .93, .65, .37);
				if setting then
					local settingAction = settingLabelTT[setting];
					tooltip:AddLine(string.format(L["RightClick"], settingAction), .93, .65, .37);
				end
			end,
		})

		LDBIcon:Register("Artificer", artificerLDB, Artificer_DB.MinimapIcon);
		
		Artificer.MinimapIconLib = LDBIcon;

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