local addonName, Artificer = ...

local L = Artificer.L;
local Defaults = Artificer.Defaults

local FADE_IN_DURATION = 0.4;
local FADE_HOLD_DURATION = 4.0;
local FADE_OUT_DURATION = 1.2;

local PREVIEW_SKILL = L["HERBALISM"];
local PREVIEW_LEVEL = "75";

local ProfessionData = {
	[129] = { -- First Aid
		name = L["FIRST_AID"],
		--spec = nil, -- does not have an equivalent atlas
		icon = "Mobile-FirstAid",
	},
	[164] = { -- Blacksmithing
		name = L["BLACKSMITHING"],
		spec = "Professions-Specializations-Preview-Art-Blacksmithing",
		icon = "Mobile-Blacksmithing",
		sounds = { 268061, 185037 },
	},
	[165] = { -- Leatherworking
		name = L["LEATHERWORKING"],
		spec = "Professions-Specializations-Preview-Art-Leatherworking",
		icon = "Mobile-Leatherworking",
		randomSoundFiles = {
			{ 4577735, 4577737, 4577739, 4577741, 4577743, 4577745, 4577747, 4577749, 4577751, 4577753 },
		},
		soundFiles = { 567571 },
	},
	[171] = { -- Alchemy
		name = L["ALCHEMY"],
		spec = "Professions-Specializations-Preview-Art-Alchemy",
		icon = "Mobile-Alchemy",
		sounds = { 119572, 138521 },
	},
	[182] = { -- Herbalism
		name = L["HERBALISM"],
		spec = "Professions-Specializations-Preview-Art-Herbalism",
		icon = "Mobile-Herbalism",
		sounds = { 171203, 187682 },
	},
	[185] = { -- Cooking
		name = L["COOKING"],
		spec = "Professions-Specializations-Preview-Art-Cooking",
		icon = "Mobile-Cooking",
		sounds = { 123061, 123058, 123070, 230317 },
	},
	[186] = { -- Mining
		name = L["MINING"],
		spec = "Professions-Specializations-Preview-Art-Mining",
		icon = "Mobile-Mining",
		sounds = { 89092, 98194, 115701 },
	},
	[197] = { -- Tailoring
		name = L["TAILORING"],
		spec = "Professions-Specializations-Preview-Art-Tailoring",
		icon = "Mobile-Tailoring",
		randomSoundFiles = {
			{ 4612169, 4612171, 4612173, 4612175, 4612177, 4612179, 4612181, 4612183, 4612185, 4612187 },
		},
		sounds = { 215234 },
	},
	[202] = { -- Engineering
		name = L["ENGINEERING"],
		spec = "Professions-Specializations-Preview-Art-Engineering",
		icon = "Mobile-Enginnering",
		randomSoundFiles = {
			{ 3088157, 3088158, 3088159, 3088160 },
			{ 569377, 569268, 569482, 569702, 568720 },
		},
		sounds = { 39000 },
	},
	[333] = { -- Enchanting
		name = L["ENCHANTING"],
		spec = "Professions-Specializations-Preview-Art-Enchanting",
		icon = "Mobile-Enchanting",
		sounds = { 23747, 20561 },
	},
	[356] = { -- Fishing
		name = L["FISHING"],
		spec = "Professions-Specializations-Preview-Art-Fishing",
		icon = "Mobile-Fishing",
		randomSoundFiles = {
			{ 2066763, 2066764, 2066765, 2066766, 2066767 },
		},
		sounds = { 203692 },
	},
	[393] = { -- Skinning
		name = L["SKINNING"],
		spec = "Professions-Specializations-Preview-Art-Skinning",
		icon = "Mobile-Skinning",
		randomSoundFiles = {
			{ 5905077, 5905079, 5905081, 5905083, 5905085, 5905087, 5905089, 5905091, 5905093, 5905095, 5905097, 5905099, 5905101, 5905103, 5905105, 5905107, 5905109, 5905111 },
			{ 4577735, 4577737, 4577739, 4577741, 4577743, 4577745, 4577747, 4577749, 4577751, 4577753 },
		},
		soundFiles = { 567571 },
	},
	[755] = { -- Jewelcrafting
		name = L["JEWELCRAFTING"],
		spec = "Professions-Specializations-Preview-Art-Jewelcrafting",
		icon = "Mobile-Jewelcrafting",
		randomSoundFiles = {
			{ 4685798, 4685800, 4685802, 4685804 }
		},
		soundFiles = { 567493 },
		sounds = { 4815, 128888 },
	},
	[773] = { -- Inscription
		name = L["INSCRIPTION"],
		spec = "Professions-Specializations-Preview-Art-Inscription",
		icon = "Mobile-Inscription",
		randomSoundFiles = {
			{ 1668195, 1668196, 1668197, 1668198, 1668199, 1668200 },
			{ 3092221, 3092222, 3092223, 3092224, 3092225, 3092226 },
		},
		soundFiles = { 567487 },
		sounds = { 128885 },
	},
	[794] = { -- Archaeology
		name = L["ARCHAEOLOGY"],
		--spec = nil, -- does not have an equivalent atlas
		icon = "Mobile-Archeology",
		randomSoundFiles = {
			{ 5927790, 5927792, 5927794, 5927796, 5927798, 5927800 },
		},
		sounds = { 23314 },
	},
};

-- review the margins later
local BORDER_STYLES = {
	{ key = "housingcontainer",				label = L["BorderStyle_housingcontainer"],				atlas = "housing-basic-container",						margins = {20, 20, 20, 20} },
	{ key = "shopheader",					label = L["BorderStyle_shopheader"],					atlas = "shop-header-menu-BG",							margins = {15, 15, 15, 15} },
	{ key = "questtracker",					label = L["BorderStyle_questtracker"],					atlas = "UI-QuestTracker-Primary-Objective-Header",		margins = {14, 14, 14, 14} },
	{ key = "achievementalert",				label = L["BorderStyle_achievementalert"],				atlas = "UI-Achievement-Alert-Background-Mini",			margins = {12, 12, 12, 12} },
	{ key = "shipmisson",					label = L["BorderStyle_shipmisson"],					atlas = "ShipMission_Toast",							margins = {12, 12, 12, 12} },
	{ key = "housingitem",					label = L["BorderStyle_housingitem"],					atlas = "housing-item-toast-frame",						margins = {12, 12, 12, 12} },
	{ key = "artifactlevel",				label = L["BorderStyle_artifactlevel"],					atlas = "AftLevelup-ToastBG",							margins = {12, 12, 12, 12} },
	{ key = "shoptoast",					label = L["BorderStyle_shoptoast"],						atlas = "shop-toast",									margins = {12, 12, 12, 12} },
	{ key = "legioninvasion",				label = L["BorderStyle_legioninvasion"],				atlas = "legioninvasion-title-bg",						margins = {12, 12, 12, 12} },
	{ key = "lootroll",						label = L["BorderStyle_lootroll"],						atlas = "lootroll-itementry-background",				margins = {12, 12, 12, 12} },
	{ key = "activities",					label = L["BorderStyle_activities"],					atlas = "activities-complete",							margins = {12, 12, 12, 12} },
	{ key = "midnightscenariotitle",		label = L["BorderStyle_midnightscenariotitle"],			atlas = "midnight-scenario-titlebg",					margins = {12, 12, 12, 12} },
	{ key = "thewarwithinscenariotitle",	label = L["BorderStyle_thewarwithinscenariotitle"],		atlas = "thewarwithin-scenario-titlebg",				margins = {12, 12, 12, 12} },
	{ key = "dragonflightscenariotitle",	label = L["BorderStyle_dragonflightscenariotitle"],		atlas = "dragonflight-scenario-TitleBG",				margins = {12, 12, 12, 12} },
	{ key = "dragonflightscenarioframe",	label = L["BorderStyle_dragonflightscenarioframe"],		atlas = "dragonflight-scenario-frame",					margins = {12, 12, 12, 12} },
	{ key = "evergreenscenariotitle",		label = L["BorderStyle_evergreenscenariotitle"],		atlas = "evergreen-scenario-titlebg",					margins = {12, 12, 12, 12} },
};

local function PlayProfessionSound(profID)
	local data = ProfessionData[profID]

	if data then
		if data.randomSoundFiles then
			for _, kit in ipairs(data.randomSoundFiles) do
				if #kit > 0 then
					PlaySoundFile(kit[math.random(1, #kit)]);
				end
			end
		end
		
		if data.soundFiles then
			for _, soundFileID in ipairs(data.soundFiles) do
				PlaySoundFile(soundFileID);
			end
		end

		if data.sounds then
			for _, soundID in ipairs(data.sounds) do
				PlaySound(soundID);
			end
		end
	else
		--unmapped professions
		PlaySound(44292);
		PlaySound(44295);
	end

	PlaySound(44292);
end

local function FindProfessionID(skill)
	local skillLower = string.lower(skill)
	for profID, data in pairs(ProfessionData) do
		if data.name and string.find(skillLower, string.lower(data.name), 1, true) then
			return profID;
		end
	end
	return nil;
end

local function GetDB()
	return Artificer_DB and Artificer_DB.ProfessionToasts;
end

local function IsEnabled()
	local db = GetDB();
	return db and db.enabled ~= false;
end

local function GetFrameSize()
	local db = GetDB();
	return (db and db.width) or Defaults.ProfessionToasts.width, (db and db.height) or Defaults.ProfessionToasts.height;
end

local function GetFontSize()
	local db = GetDB();
	return (db and db.fontSize) or Defaults.ProfessionToasts.fontSize;
end

local function GetTextColor()
	local db = GetDB();
	local c = (db and db.textColor) or Defaults.ProfessionToasts.textColor;
	return c.r, c.g, c.b, c.a;
end

local function GetBgColor()
	local db = GetDB();
	local c = (db and db.bgColor) or Defaults.ProfessionToasts.bgColor;
	return c.r, c.g, c.b, c.a;
end

local function GetBorderColor()
	local db = GetDB();
	local c = (db and db.borderColor) or Defaults.ProfessionToasts.borderColor;
	return c.r, c.g, c.b, c.a;
end

local function GetBorderStyleData()
	local db = GetDB();
	local key = (db and db.borderStyle) or Defaults.ProfessionToasts.borderStyle;
	for _, s in ipairs(BORDER_STYLES) do
		if s.key == key then
			return s;
		end
	end
	return BORDER_STYLES[1];
end

local function GetShowProfBg()
	local db = GetDB();
	if db and db.showProfBg ~= nil then
		return db.showProfBg;
	end
	return Defaults.ProfessionToasts.showProfBg;
end

local function GetBgStyle()
	local db = GetDB();
	if db and db.bgStyle ~= nil then
		return db.bgStyle;
	end
	return Defaults.ProfessionToasts.bgStyle;
end

local function IsSingleLine()
	local db = GetDB();
	if db and db.singleLine ~= nil then
		return db.singleLine;
	end
	return Defaults.ProfessionToasts.singleLine;
end

local ToastFrame;
local fadeState = "hidden";
local fadeElapsed = 0;
local holdTimer = nil;
local advancedPanelOpen = false;

local function StopFade()
	if ToastFrame then
		ToastFrame:SetScript("OnUpdate", nil);
	end
	if holdTimer then
		holdTimer:Cancel();
		holdTimer = nil;
	end
end

local function StartFadeUpdate()
	ToastFrame:SetScript("OnUpdate", function(self, elapsed)
		fadeElapsed = fadeElapsed + elapsed

		if fadeState == "fadein" then
			local alpha = math.min(fadeElapsed / FADE_IN_DURATION, 1)
			self:SetAlpha(alpha)
			if alpha >= 1 then
				self:SetAlpha(1);
				fadeState = "hold";
				fadeElapsed = 0;
				self:SetScript("OnUpdate", nil);

				if not advancedPanelOpen then
					holdTimer = C_Timer.After(FADE_HOLD_DURATION, function()
						holdTimer = nil;
						if fadeState == "hold" and not advancedPanelOpen then
							fadeState = "fadeout";
							fadeElapsed = 0;
							StartFadeUpdate();
						end
					end)
				end
			end

		elseif fadeState == "fadeout" then
			local alpha = math.max(1 - fadeElapsed / FADE_OUT_DURATION, 0);
			self:SetAlpha(alpha);
			if alpha <= 0 then
				self:SetAlpha(0);
				self:Hide();
				fadeState = "hidden";
				self:SetScript("OnUpdate", nil);
			end
		end
	end)
end

local function ShowToast()
	StopFade();
	fadeState = "fadein";
	fadeElapsed = 0;
	ToastFrame:SetAlpha(0);
	ToastFrame:Show();
	StartFadeUpdate();
end

local function HideToast()
	if fadeState == "hidden" then return; end
	local currentAlpha = ToastFrame:GetAlpha();
	StopFade();
	fadeState = "fadeout";
	fadeElapsed = (1 - currentAlpha) * FADE_OUT_DURATION;
	StartFadeUpdate();
end

local function PinToast()
	StopFade();
	advancedPanelOpen = true;
	fadeState = "hold";
	fadeElapsed = 0;
	ToastFrame:SetAlpha(1);
	ToastFrame:Show();
end

local function UnpinToast()
	advancedPanelOpen = false;
	HideToast();
end

local function ApplyLayout()
	if not ToastFrame then return; end
	local fs = GetFontSize()
	local r, g, b, a = GetTextColor()

	if IsSingleLine() then
		ToastFrame.LevelText:Hide();
		ToastFrame.SkillText:ClearAllPoints();
		ToastFrame.SkillText:SetPoint("CENTER", ToastFrame, "CENTER", 0, 0);
		ToastFrame.SkillText:SetFont(STANDARD_TEXT_FONT, fs);
		ToastFrame.SkillText:SetTextColor(r, g, b, a);
	else
		ToastFrame.LevelText:Show();
		ToastFrame.SkillText:ClearAllPoints();
		ToastFrame.SkillText:SetPoint("TOP", ToastFrame, "TOP", 0, -6);
		ToastFrame.SkillText:SetFont(STANDARD_TEXT_FONT, math.max(fs - 6, 10));
		ToastFrame.SkillText:SetTextColor(r, g, b, a);
		ToastFrame.LevelText:ClearAllPoints();
		ToastFrame.LevelText:SetPoint("CENTER", ToastFrame, "CENTER", 0, -8);
		ToastFrame.LevelText:SetFont(STANDARD_TEXT_FONT, fs);
		ToastFrame.LevelText:SetTextColor(r, g, b, a);
	end
end

local function SetToastContent(skill, level)
	if not ToastFrame then return; end
	if IsSingleLine() and skill and level then
		ToastFrame.SkillText:SetText(skill .. " " .. level);
	else
		ToastFrame.SkillText:SetText(skill);
		ToastFrame.LevelText:SetText(level);
	end
	ApplyLayout();
end

local function CreateToastFrame()
	local w, h = GetFrameSize()

	local f = CreateFrame("Frame", "ArtificerProfessionToast", UIParent)
	f:SetSize(w, h)
	f:SetAlpha(0)
	f:Hide()
	f:SetFrameStrata("HIGH")
	f:SetClampedToScreen(true)

	if Artificer_DB and Artificer_DB.FramePositions and Artificer_DB.FramePositions["ProfessionToast"] then
		local pos = Artificer_DB.FramePositions["ProfessionToast"];
		f:SetPoint(pos.point, UIParent, pos.relativePoint, pos.x, pos.y);
	else
		f:SetPoint("TOP", UIParent, "TOP", 0, -260);
	end

	local styleData = GetBorderStyleData()
	f.Border = f:CreateTexture(nil, "BORDER", nil, 1)
	f.Border:SetPoint("TOPLEFT", -6, 6)
	f.Border:SetPoint("BOTTOMRIGHT", 6, -6)
	f.Border:SetAtlas(styleData.atlas)
	f.Border:SetTextureSliceMargins(unpack(styleData.margins))
	f.Border:SetTextureSliceMode(Enum.UITextureSliceMode.Stretched)

	f.BgTex = f:CreateTexture(nil, "ARTWORK", nil, 0)
	f.BgTex:SetAllPoints()
	f.BgTex:SetTexture(130660)

	local bgMask = f:CreateMaskTexture(nil, "ARTWORK", nil, 0)
	bgMask:SetPoint("TOPLEFT", 15, 0)
	bgMask:SetPoint("BOTTOMRIGHT", -15, 0)
	bgMask:SetTexture("Interface\\AddOns\\Artificer\\Textures\\gradientmask_1.png") -- 4685163
	--bgMask:SetTexCoord(0.0009765625, 0.712890625, 0.4189453125, 0.58837890625)
	f.BgTex:AddMaskTexture(bgMask)

	f.BgMask = bgMask

	f.SkillText = f:CreateFontString(nil, "OVERLAY")
	f.SkillText:SetFont(STANDARD_TEXT_FONT, math.max(GetFontSize() - 6, 10))
	f.SkillText:SetPoint("TOP", f, "TOP", 0, -6)
	f.SkillText:SetTextColor(GetTextColor())

	f.LevelText = f:CreateFontString(nil, "OVERLAY")
	f.LevelText:SetFont(STANDARD_TEXT_FONT, GetFontSize())
	f.LevelText:SetPoint("CENTER", f, "CENTER", 0, -8)
	f.LevelText:SetTextColor(GetTextColor())

	f:EnableMouse(true)
	f:SetMovable(false)
	f:RegisterForDrag("LeftButton")
	f:SetScript("OnDragStart", function(self)
		if self:IsMovable() then
			self:StartMoving();
		end
	end)
	f:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing();
		Artificer:SaveFramePosition(self, "ProfessionToast");
	end)

	return f
end

local function SetProfessionBackground(profID)
	if not ToastFrame then return end
	local bgStyle = GetBgStyle()
	local atlas
	
	local profData = ProfessionData[profID]
	if profData then
		if bgStyle == "mobileicon" then
			atlas = profData.icon;
		else
			atlas = profData.spec;
		end
	end

	if atlas then
		ToastFrame.BgTex:SetAtlas(atlas);
	else
		ToastFrame.BgTex:SetAtlas(nil);
		ToastFrame.BgTex:SetTexture(130660);
	end
end

function Artificer.ApplyProfessionToastSettings()
	if not ToastFrame then return end

	local w, h = GetFrameSize()
	ToastFrame:SetSize(w, h)

	local styleData = GetBorderStyleData()
	ToastFrame.Border:SetAtlas(styleData.atlas)
	ToastFrame.Border:SetTextureSliceMargins(unpack(styleData.margins))
	ToastFrame.Border:SetTextureSliceMode(Enum.UITextureSliceMode.Stretched)
	ToastFrame.Border:SetVertexColor(GetBorderColor())
	ToastFrame.Border:SetDesaturated(GetDB() and GetDB().borderDesat == true)

	ToastFrame.BgTex:SetVertexColor(GetBgColor())
	ToastFrame.BgTex:SetShown(GetShowProfBg())
	ToastFrame.BgTex:SetDesaturated(GetDB() and GetDB().bgDesat == true)

	local bgStyle = GetBgStyle()
	ToastFrame.BgTex:ClearAllPoints()
	
	if bgStyle == "mobileicon" then
		ToastFrame.BgTex:RemoveMaskTexture(ToastFrame.BgMask);
		local iconSize = h*.6;
		ToastFrame.BgTex:SetSize(iconSize, iconSize);
		ToastFrame.BgTex:SetPoint("LEFT", ToastFrame, "LEFT", 25, 0);
	else
		ToastFrame.BgTex:AddMaskTexture(ToastFrame.BgMask);
		ToastFrame.BgTex:SetAllPoints();
	end

	ApplyLayout()
end


local function OnProfessionSkillUp(_, eventMessage)
	if not IsEnabled() then return end

	local pattern = ERR_SKILL_UP_SI:gsub("%%s", "(.+)"):gsub("%%d", "(%%d+)")
	local skill, skillLevel = string.match(eventMessage, pattern)
	if not skill or not skillLevel then return end

	local profID = FindProfessionID(skill)

	if not ToastFrame then ToastFrame = CreateToastFrame() end

	SetProfessionBackground(profID)
	SetToastContent(skill, skillLevel)

	local db = GetDB()
	if db and db.playSound ~= false then
		PlayProfessionSound(profID);
	end

	ShowToast()
end


function Artificer:OpenProfessionToastAdvancedSettings()
	if not ToastFrame then ToastFrame = CreateToastFrame() end

	if not self.ProfToastAdvancedFrame then
		local f = CreateFrame("Frame", "ArtificerProfToastAdvancedFrame", Artificer.SettingsFrame, "DialogBorderTranslucentTemplate")
		f:ClearAllPoints()
		f:SetSize(375, 590)
		f:SetPoint("LEFT", Artificer.SettingsFrame, "RIGHT", 45, 0)
		f:EnableMouse(true)
		f:Hide()
		tinsert(UISpecialFrames, "ArtificerProfToastAdvancedFrame")

		f:SetScript("OnShow", function()
			PlaySound(839);
			SetProfessionBackground(182);
			SetToastContent(PREVIEW_SKILL, PREVIEW_LEVEL);
			Artificer.ApplyProfessionToastSettings();
			ToastFrame:SetMovable(true);
			PinToast();
		end)

		f:SetScript("OnHide", function()
			PlaySound(840);
			ToastFrame:SetMovable(false);
			UnpinToast();
		end)

		local closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButtonNoScripts")
		closeBtn:SetPoint("TOPRIGHT", 0, 0)
		closeBtn:SetScript("OnClick", function() f:Hide() end)

		local titleBG = CreateFrame("Frame", nil, f, "DialogBorderTranslucentTemplate")
		titleBG:ClearAllPoints()
		titleBG:SetSize(160, 40)
		titleBG:SetPoint("BOTTOM", f, "TOP", 0, -15)

		local titleText = titleBG:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		titleText:SetPoint("CENTER")
		titleText:SetText(L["Widget_ProfessionToasts"])
		titleBG:SetWidth(titleText:GetWidth() * 1.2)

		local CX = 25 -- left margin
		local yOff = -25

		local function MakeLabel(text, yOffset)
			local fs = f:CreateFontString(nil, "OVERLAY", "GameFontNormal");
			fs:SetPoint("TOPLEFT", f, "TOPLEFT", CX, yOffset);
			fs:SetText(text);
			return fs;
		end

		local function MakeSeparator(yOffset)
			local sep = f:CreateTexture(nil, "ARTWORK");
			sep:SetPoint("TOPLEFT", f, "TOPLEFT", CX, yOffset);
			sep:SetPoint("TOPRIGHT", f, "TOPRIGHT", -CX, yOffset);
			sep:SetHeight(1);
			sep:SetColorTexture(1, 1, 1, 0.12);
		end

		local function MakeSlider(yOffset, minVal, maxVal, step, initVal, onChange)
			local opts = Settings.CreateSliderOptions(minVal, maxVal, step);
			opts:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(v) return tostring(math.floor(v)); end);
			local sl = CreateFrame("Frame", nil, f, "MinimalSliderWithSteppersTemplate");
			sl:SetPoint("TOPLEFT", f, "TOPLEFT", CX, yOffset);
			sl:SetWidth(220);
			sl:Init(initVal, opts.minValue, opts.maxValue, opts.steps, opts.formatters);
			sl:RegisterCallback("OnValueChanged", onChange, sl);
			return sl;
		end

		local function MakeColorRow(labelText, yOffset, dbKey, defColor, onApply, desatKey, onDesatApply)
			local lbl = MakeLabel(labelText, yOffset)

			local swatch = CreateFrame("Button", nil, f, "ColorSwatchTemplate")
			swatch:SetPoint("LEFT", lbl, "RIGHT", 10, 0)
			swatch:RegisterForClicks("AnyUp")

			local function GetColor()
				local db = GetDB();
				return CopyTable((db and db[dbKey]) or defColor);
			end

			local function ApplyColor(t)
				if not t then return; end
				t.a = t.a or 1;
				swatch.Color:SetVertexColor(t.r, t.g, t.b, t.a);
				if Artificer_DB and Artificer_DB.ProfessionToasts then
					Artificer_DB.ProfessionToasts[dbKey] = t;
				end
				if onApply then
					onApply(t);
				end
			end

			if desatKey then
				local desatCb = CreateFrame("CheckButton", nil, f, "ChatConfigCheckButtonTemplate")
				desatCb:SetPoint("LEFT", swatch, "RIGHT", 10, 0)
				desatCb:SetSize(24, 24)
				desatCb.Text:SetText(L["Desaturate"])
				
				local function GetDesat()
					local db = GetDB()
					return db and db[desatKey] == true
				end
				
				desatCb:SetChecked(GetDesat())
				desatCb:SetScript("OnClick", function(self)
					local isChecked = self:GetChecked()
					if Artificer_DB and Artificer_DB.ProfessionToasts then
						Artificer_DB.ProfessionToasts[desatKey] = isChecked;
					end
					if onDesatApply then
						onDesatApply(isChecked);
					end
				end)
				
				swatch.DesatCheckbox = desatCb
				swatch.GetDesat = GetDesat
			end

			local ic = GetColor()
			swatch.Color:SetVertexColor(ic.r, ic.g, ic.b, ic.a)

			swatch:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				GameTooltip:SetText(labelText);
				GameTooltip:AddLine(L["LC_OpenColorPicker"] or "Left-click to open color picker", 1, 1, 1);
				GameTooltip:AddLine(L["RC_OpenDropdown"] or "Right-click for options", 1, 1, 1);
				GameTooltip:Show();
			end)
			swatch:SetScript("OnLeave", GameTooltip_Hide)

			swatch:SetScript("OnClick", function(_, button)
				if button == "RightButton" then
					MenuUtil.CreateContextMenu(swatch, function(_, rootDescription)
						rootDescription:CreateTitle(labelText)
						rootDescription:CreateButton(L["CopyColor"] or "Copy Color", function()
							Artificer.ColorClipboard = CopyTable(GetColor());
						end)
						local pasteBtn = rootDescription:CreateButton(
								L["PasteColor"] or "Paste Color",
								function()
									if Artificer.ColorClipboard then
										ApplyColor(CopyTable(Artificer.ColorClipboard));
									end
								end)
						if not Artificer.ColorClipboard then pasteBtn:SetEnabled(false) end
						rootDescription:CreateButton(RESET_TO_DEFAULT, function()
							ApplyColor(CopyTable(defColor));
						end)
					end)
					return;
				end

				local cur = GetColor()
				ColorPickerFrame:SetupColorPickerAndShow({
					r = cur.r, g = cur.g, b = cur.b, opacity = cur.a,
					hasOpacity = true,
					swatchFunc = function()
						local r2, g2, b2 = ColorPickerFrame:GetColorRGB();
						local a2 = ColorPickerFrame:GetColorAlpha();
						local saved = GetColor();
						saved.r, saved.g, saved.b, saved.a = r2, g2, b2, a2;
						ApplyColor(saved);
					end,
					cancelFunc = function()
						local r2, g2, b2, a2 = ColorPickerFrame:GetPreviousValues();
						local saved = GetColor();
						saved.r, saved.g, saved.b, saved.a = r2, g2, b2, a2;
						ApplyColor(saved);
					end,
				})
			end)

			swatch.GetColor = GetColor;
			return swatch;
		end

		local function MakeCheckbox(labelText, yOffset, getVal, setVal)
			local cb = CreateFrame("CheckButton", nil, f, "ChatConfigCheckButtonTemplate")
			cb:SetPoint("TOPLEFT", f, "TOPLEFT", CX - 4, yOffset)
			cb:SetSize(24, 24)
			cb.Text:SetText(labelText)
			cb:SetChecked(getVal())
			cb:SetScript("OnClick", function(self)
				setVal(self:GetChecked());
				Artificer.ApplyProfessionToastSettings();
				if advancedPanelOpen then
					SetToastContent(PREVIEW_SKILL, PREVIEW_LEVEL);
				end
			end)
			return cb;
		end

		MakeLabel(L["FrameWidth"], yOff)
		MakeSlider(yOff - 15, 150, 500, 10,
			(GetDB() and GetDB().width) or Defaults.ProfessionToasts.width,
			function(_, value)
				if Artificer_DB and Artificer_DB.ProfessionToasts then
					Artificer_DB.ProfessionToasts.width = value;
					Artificer.ApplyProfessionToastSettings();
				end
			end)
		yOff = yOff - 60

		MakeLabel(L["FrameHeight"], yOff)
		MakeSlider(yOff - 15, 20, 100, 5,
			(GetDB() and GetDB().height) or Defaults.ProfessionToasts.height,
			function(_, value)
				if Artificer_DB and Artificer_DB.ProfessionToasts then
					Artificer_DB.ProfessionToasts.height = value;
					Artificer.ApplyProfessionToastSettings();
				end
			end)
		yOff = yOff - 60

		MakeLabel(L["FontSize"], yOff)
		MakeSlider(yOff - 15, 10, 48, 1,
			GetFontSize(),
			function(_, value)
				if Artificer_DB and Artificer_DB.ProfessionToasts then
					Artificer_DB.ProfessionToasts.fontSize = value
					Artificer.ApplyProfessionToastSettings()
					if advancedPanelOpen then
						SetToastContent(PREVIEW_SKILL, PREVIEW_LEVEL);
					end
				end
			end)
		yOff = yOff - 68

		--MakeSeparator(yOff); yOff = yOff - 16

		local textSwatch = MakeColorRow(
			L["FontColor"], yOff, "textColor", Defaults.ProfessionToasts.textColor,
			function()
				Artificer.ApplyProfessionToastSettings();
			end)
		f.TextColorSwatch = textSwatch
		yOff = yOff - 32

		local bgSwatch = MakeColorRow(
			L["BackgroundColor"], yOff, "bgColor", Defaults.ProfessionToasts.bgColor,
			function(t)
				if ToastFrame then
					ToastFrame.BgTex:SetVertexColor(t.r, t.g, t.b, t.a);
				end
			end,
			"bgDesat",
			function(val)
				if ToastFrame then
					ToastFrame.BgTex:SetDesaturated(val);
				end
			end)
		f.BgColorSwatch = bgSwatch
		yOff = yOff - 32

		local borderSwatch = MakeColorRow(
			L["BorderColor"], yOff, "borderColor", Defaults.ProfessionToasts.borderColor,
			function(t)
				if ToastFrame then
					ToastFrame.Border:SetVertexColor(t.r, t.g, t.b, t.a);
				end
			end,
			"borderDesat",
			function(val)
				if ToastFrame then
					ToastFrame.Border:SetDesaturated(val);
				end
			end)
		f.BorderColorSwatch = borderSwatch
		yOff = yOff - 46

		--MakeSeparator(yOff); yOff = yOff - 16

		MakeLabel(L["BackgroundStyle"] or "Background Style", yOff)
		yOff = yOff - 25

		local bgStyleDropdown = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate")
		bgStyleDropdown:SetPoint("TOPLEFT", f, "TOPLEFT", CX, yOff)
		bgStyleDropdown:SetWidth(200)

		local bgStyles = {
			{ key = "specart", label = L["SpecializationArt"] },
			{ key = "mobileicon", label = L["MobileIcons"] },
		}

		local function UpdateBgStyleDropdownText()
			local currentKey = GetBgStyle()
			for _, style in ipairs(bgStyles) do
				if style.key == currentKey then
					bgStyleDropdown.Text:SetText(style.label);
					break;
				end
			end
		end

		bgStyleDropdown:SetupMenu(function(_, rootDescription)
			for _, style in ipairs(bgStyles) do
				rootDescription:CreateRadio(style.label,
					function() return GetBgStyle() == style.key end,
					function()
						if Artificer_DB and Artificer_DB.ProfessionToasts then
							Artificer_DB.ProfessionToasts.bgStyle = style.key;
						end
						UpdateBgStyleDropdownText();
						SetProfessionBackground(182);
						Artificer.ApplyProfessionToastSettings();
					end)
			end
		end)
		UpdateBgStyleDropdownText()
		f.BgStyleDropdown = bgStyleDropdown
		yOff = yOff - 46

		MakeLabel(L["BorderStyle"], yOff)
		yOff = yOff - 25

		local borderDropdown = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate")
		borderDropdown:SetPoint("TOPLEFT", f, "TOPLEFT", CX, yOff)
		borderDropdown:SetWidth(200)

		local function UpdateBorderDropdownText()
			borderDropdown.Text:SetText(GetBorderStyleData().label)
		end

		borderDropdown:SetupMenu(function(_, rootDescription)
			for _, style in ipairs(BORDER_STYLES) do
				rootDescription:CreateRadio(style.label,
					function()
						return ((GetDB() and GetDB().borderStyle) or Defaults.ProfessionToasts.borderStyle) == style.key;
					end,
					function()
						if Artificer_DB and Artificer_DB.ProfessionToasts then
							Artificer_DB.ProfessionToasts.borderStyle = style.key;
						end
						UpdateBorderDropdownText();
						Artificer.ApplyProfessionToastSettings();
					end)
			end
		end)
		UpdateBorderDropdownText()

		f.BorderDropdown = borderDropdown
		yOff = yOff - 46

		--MakeSeparator(yOff); yOff = yOff - 16

		local singleLineCheck = MakeCheckbox(
			L["SingleLine"], yOff, IsSingleLine,
			function(val)
				if Artificer_DB and Artificer_DB.ProfessionToasts then
					Artificer_DB.ProfessionToasts.singleLine = val;
				end
			end)
		f.SingleLineCheck = singleLineCheck
		yOff = yOff - 32

		local soundCheck = MakeCheckbox(
			L["PlaySound"], yOff,
			function() 
				local db = GetDB(); 
				if db and db.playSound ~= nil then
					return db.playSound;
				end
				return Defaults.ProfessionToasts.playSound;
			end,
			function(val)
				if Artificer_DB and Artificer_DB.ProfessionToasts then
					Artificer_DB.ProfessionToasts.playSound = val;
				end
			end)
		f.SoundCheck = soundCheck
		yOff = yOff - 42

		--MakeSeparator(yOff); yOff = yOff - 14

		local resetBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
		resetBtn:SetSize(155, 24)
		resetBtn:SetPoint("TOPLEFT", f, "TOPLEFT", CX, yOff)
		resetBtn:SetText(L["ResetPosition"])
		resetBtn:SetScript("OnClick", function()
			ToastFrame:ClearAllPoints();
			ToastFrame:SetPoint("TOP", UIParent, "TOP", 0, -260);
			Artificer:SaveFramePosition(ToastFrame, "ProfessionToast");
		end)

		self.ProfToastAdvancedFrame = f
	end

	local adv = self.ProfToastAdvancedFrame
	do
		local db = GetDB() or {};

		for _, swatch in ipairs({ adv.TextColorSwatch, adv.BgColorSwatch, adv.BorderColorSwatch }) do
			local c = swatch.GetColor();
			swatch.Color:SetVertexColor(c.r, c.g, c.b, c.a or 1);
			
			if swatch.DesatCheckbox then
				swatch.DesatCheckbox:SetChecked(swatch.GetDesat());
			end
		end

		adv.BorderDropdown.Text:SetText(GetBorderStyleData().label);

		adv.SingleLineCheck:SetChecked(IsSingleLine());
		adv.SoundCheck:SetChecked(db.playSound ~= false);
	end


	if self.ProfToastAdvancedFrame:IsVisible() then
		self.ProfToastAdvancedFrame:Hide();
	else
		Artificer:CloseAllAdvancedFrames();
		self.ProfToastAdvancedFrame:Show();
	end
end

local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("PLAYER_LOGIN")
initFrame:SetScript("OnEvent", function(self, event)
	if event ~= "PLAYER_LOGIN" then return; end
	self:UnregisterEvent("PLAYER_LOGIN")

	if not ToastFrame then ToastFrame = CreateToastFrame() end
	Artificer.ApplyProfessionToastSettings()

	self:RegisterEvent("CHAT_MSG_SKILL")
	self:SetScript("OnEvent", function(_, evt, ...)
		if evt == "CHAT_MSG_SKILL" then
			OnProfessionSkillUp(nil, ...);
		end
	end)
end)


local AchievementIDs = { -- [achievementID] = criteriaID
	[62357] = 112615, -- Classic
	[62358] = 112674, -- TBC
	[62359] = 251762, -- Wrath
	[62360] = 112675, -- Cata
	[62361] = 251763, -- MoP
	[62362] = 112682, -- WoD
	[62363] = 112683, -- Legion
	[62364] = 112678, -- BFA
	[62365] = 112673, -- SLs
	[62366] = 112680, -- DF
	[62369] = 112679, -- TWW
	[62370] = 112681, -- Midnight
};

local achievementCache = {};

local function SetAchievementBackground(achID)
	if not ToastFrame then return end

	local iconFileID = select(10, GetAchievementInfo(achID));

	ToastFrame.BgTex:SetAtlas(nil);
	if iconFileID then
		ToastFrame.BgTex:SetTexture(iconFileID);
	else
		ToastFrame.BgTex:SetTexture(130660);
	end
end

local function CacheAchievementProgress()
	for achID, critID in pairs(AchievementIDs) do
		local _, _, _, quantity = GetAchievementCriteriaInfoByID(achID, critID);
		achievementCache[achID] = quantity or 0;
	end
end

local function OnAchievementCriteriaUpdate()
	if not IsEnabled() then return end

	for achID, critID in pairs(AchievementIDs) do
		local criteriaString, _, completed, quantity, reqQuantity = GetAchievementCriteriaInfoByID(achID, critID);

		if quantity ~= nil then
			local prev = achievementCache[achID] or 0;

			if quantity > prev then
				achievementCache[achID] = quantity;

				local _, achievementName = GetAchievementInfo(achID);
				local label = (achievementName and achievementName ~= "") and achievementName or (criteriaString and criteriaString ~= "" and criteriaString);

				-- reqQuantity would be used but the equivalent for professions max skill level is annoyingly still not able to be queried
				local progressText = quantity; -- string.format("%d / %d", quantity, reqQuantity);
				

				if not ToastFrame then
					ToastFrame = CreateToastFrame();
				end

				SetAchievementBackground(achID);
				SetToastContent(label, progressText);

				local db = GetDB();
				if db and db.playSound ~= false then
					PlayProfessionSound(nil);
				end

				ShowToast();
			end
		end
	end
end

local achievTrackerFrame = CreateFrame("Frame");
achievTrackerFrame:RegisterEvent("PLAYER_LOGIN");
achievTrackerFrame:RegisterEvent("CRITERIA_UPDATE");
achievTrackerFrame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		CacheAchievementProgress();
	elseif event == "CRITERIA_UPDATE" then
		OnAchievementCriteriaUpdate();
	end
end);