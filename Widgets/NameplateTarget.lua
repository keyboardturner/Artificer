local addonName, Artificer = ...;

local L = Artificer.L;

local NAMEPLATE_TOKEN = "nameplate%d";
local MAX_NAMEPLATES = 50;

local NamePlateTextures = {};
local eventFrame = CreateFrame("Frame");
local isRodeoActive = false;

local TARGET_STYLES = {
	{ key = "hero_ring",	name = L["FNP_HeroTalentRing"],	atlas	= "talents-heroclass-ring-minimize-show" },
	{ key = "crosshair",	name = L["FNP_ArtificerEye"],	texture	= "Interface\\AddOns\\Artificer\\Textures\\Artificer_Eye.blp" },
	{ key = "lfg_eye",		name = L["FNP_LFGEye"],			atlas	= "RaidFrame-Icon-LFR" },
};

local DEFAULT_STYLE_KEY = TARGET_STYLES[1].key;

local function GetStyleByKey(key)
	for _, style in ipairs(TARGET_STYLES) do
		if style.key == key then
			return style;
		end
	end
	return TARGET_STYLES[1];
end

function Artificer.UpdateNameplateTargetAppearance()
	local styleKey = (Artificer_DB and Artificer_DB.NameplateTargetStyle) or DEFAULT_STYLE_KEY
	local size = (Artificer_DB and Artificer_DB.NameplateTargetSize) or 32
	local styleData = GetStyleByKey(styleKey)

	local color = (Artificer_DB and Artificer_DB.NameplateTargetColor) or { r = 1, g = 1, b = 1, a = 1 }

	local function ApplyToIcon(frame)
		if not frame then return end
		frame:SetSize(size, size)
		
		if styleData.atlas then
			frame.tex:SetTexture(nil);
			frame.tex:SetAtlas(styleData.atlas);
		else
			frame.tex:SetAtlas(nil);
			frame.tex:SetTexture(styleData.texture);
		end

		frame.tex:SetVertexColor(color.r, color.g, color.b, color.a)
	end

	if Artificer.NameplateAdvancedFrame and Artificer.NameplateAdvancedFrame.Icon then
		ApplyToIcon(Artificer.NameplateAdvancedFrame.Icon);
	end

	for i = 1, MAX_NAMEPLATES do
		local key = "NamePlate" .. i
		if NamePlateTextures[key] then
			ApplyToIcon(NamePlateTextures[key]);
		end
	end
end

function Artificer:OpenNameplateAdvancedSettings()
	if not self.NameplateAdvancedFrame then
		local f = CreateFrame("Frame", "ArtificerNameplateAdvancedFrame", Artificer.SettingsFrame, "DialogBorderTranslucentTemplate")
		f:ClearAllPoints()
		f:SetSize(375, 400)
		f:SetPoint("LEFT", Artificer.SettingsFrame, "RIGHT", 45, 0)
		--f:SetMovable(true)
		f:EnableMouse(true)
		--f:RegisterForDrag("LeftButton")
		f:Hide()

		tinsert(UISpecialFrames, "ArtificerNameplateAdvancedFrame")

		f:SetScript("OnShow", function()
			PlaySound(839);
		end)
		f:SetScript("OnHide", function()
			PlaySound(840);
		end)

		local closeButton = CreateFrame("Button", nil, f, "UIPanelCloseButtonNoScripts");
		closeButton:SetPoint("TOPRIGHT", 0, 0);
		closeButton:SetScript("OnClick", function()
			f:Hide();
		end);
		
		local plateTextBG = CreateFrame("Frame", "ArtificerNameplateAdvancedFrameTitle", f, "DialogBorderTranslucentTemplate")
		plateTextBG:ClearAllPoints()
		plateTextBG:SetSize(100, 40)
		plateTextBG:SetPoint("BOTTOM", f, "TOP", 0, -15)

		local plateText = plateTextBG:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		plateText:SetPoint("CENTER")
		plateText:SetText(L["FNP_DragIcon"])
		plateTextBG:SetWidth(plateText:GetWidth()*1.2)

		local backdropInfo = {
			bgFile = "interface\\reforging\\itemupgradetooltipfullmask",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = false,
			tileEdge = true,
			tileSize = 8,
			edgeSize = 8,
			insets = { left = 1, right = 1, top = 1, bottom = 1 },
		};

		local dummyBounds = CreateFrame("Frame", nil, f, "BackdropTemplate")
		dummyBounds:SetBackdrop(backdropInfo)
		dummyBounds:SetSize(350,200)
		dummyBounds:SetPoint("TOP", f, "TOP", 0, -12.5)
		
		local width, height = C_NamePlate.GetNamePlateSize()
		if not width or width == 0 then width, height = 110, 45 end
		
		local dummyPlate = CreateFrame("Frame", nil, dummyBounds, "BackdropTemplate")
		dummyPlate:SetSize(width, height)
		dummyPlate:SetPoint("CENTER", 0, 0)
		
		local bg = dummyPlate:CreateTexture(nil, "BACKGROUND")
		bg:SetAllPoints()
		bg:SetAtlas("nameplates-bar-background-white")
		
		local icon = CreateFrame("Frame", nil, dummyPlate)
		icon:SetSize(32, 32)
		icon.tex = icon:CreateTexture(nil, "ARTWORK")
		icon.tex:SetAllPoints()
		
		--icon:SetMovable(false)
		icon:EnableMouse(true)
		--icon:RegisterForDrag("LeftButton")

		local dragOffsetX, dragOffsetY = 0, 0;

		icon:SetScript("OnMouseDown", function(self, button)
			if button ~= "LeftButton" then return; end
			local scale = UIParent:GetEffectiveScale();
			local mouseX, mouseY = GetCursorPosition();
			mouseX, mouseY = mouseX / scale, mouseY / scale;

			local iconX, iconY = self:GetCenter();
			dragOffsetX = mouseX - iconX;
			dragOffsetY = mouseY - iconY;

			self:SetScript("OnUpdate", function(self)
				local mx, my = GetCursorPosition();
				mx, my = mx / scale, my / scale;

				local halfW = self:GetWidth() / 2;
				local halfH = self:GetHeight() / 2;

				local targetX = mx - dragOffsetX;
				local targetY = my - dragOffsetY;
				targetX = math.max(dummyBounds:GetLeft() + halfW, math.min(dummyBounds:GetRight() - halfW, targetX));
				targetY = math.max(dummyBounds:GetBottom() + halfH, math.min(dummyBounds:GetTop() - halfH, targetY));

				self:ClearAllPoints();
				self:SetPoint("CENTER", UIParent, "BOTTOMLEFT", targetX, targetY);
			end);
		end);

		icon:SetScript("OnMouseUp", function(self, button)
			if button ~= "LeftButton" then return; end
			self:SetScript("OnUpdate", nil);

			local dpX, dpY = dummyPlate:GetCenter();
			local icX, icY = self:GetCenter();
			local dX = icX - dpX;
			local dY = icY - dpY;

			if not Artificer_DB.NameplateTargetPos then Artificer_DB.NameplateTargetPos = {}; end
			Artificer_DB.NameplateTargetPos.point = "CENTER";
			Artificer_DB.NameplateTargetPos.relativePoint = "CENTER";
			Artificer_DB.NameplateTargetPos.x = dX;
			Artificer_DB.NameplateTargetPos.y = dY;

			self:ClearAllPoints();
			self:SetPoint("CENTER", dummyPlate, "CENTER", dX, dY);

			if Artificer.UpdateNameplateTargetPositions then
				Artificer.UpdateNameplateTargetPositions();
			end
		end);

		local styleDropdown = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate")
		styleDropdown:SetPoint("TOPLEFT", dummyBounds, "BOTTOMLEFT", 20, -30)
		styleDropdown:SetWidth(150)
		
		local styleLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		styleLabel:SetPoint("BOTTOMLEFT", styleDropdown, "TOPLEFT", 0, 5)
		styleLabel:SetText(L["FNP_IconStyle"])

		local function UpdateDropdownText()
			local currentKey = (Artificer_DB and Artificer_DB.NameplateTargetStyle) or DEFAULT_STYLE_KEY;
			local style = GetStyleByKey(currentKey);
			styleDropdown.Text:SetText(style.name);
		end

		styleDropdown:SetupMenu(function(dropdown, rootDescription)
			for _, style in ipairs(TARGET_STYLES) do
				rootDescription:CreateRadio(style.name, function()
					return ((Artificer_DB and Artificer_DB.NameplateTargetStyle) or DEFAULT_STYLE_KEY) == style.key
				end, function()
					if not Artificer_DB then return; end
					Artificer_DB.NameplateTargetStyle = style.key;
					UpdateDropdownText();
					Artificer.UpdateNameplateTargetAppearance();
				end);
			end
		end)
		UpdateDropdownText()

		local sizeSlider = CreateFrame("Frame", nil, f, "MinimalSliderWithSteppersTemplate")
		sizeSlider:SetPoint("TOPLEFT", styleDropdown, "BOTTOMLEFT", 0, -40)
		sizeSlider:SetWidth(200)

		local sizeLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		sizeLabel:SetPoint("BOTTOMLEFT", sizeSlider, "TOPLEFT", 0, 5)
		sizeLabel:SetText(L["FNP_IconSize"])

		local options = Settings.CreateSliderOptions(16, 64, 2)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value) return tostring(math.floor(value)) end)
		
		local currentSize = (Artificer_DB and Artificer_DB.NameplateTargetSize) or 32
		sizeSlider:Init(currentSize, options.minValue, options.maxValue, options.steps, options.formatters)
		
		sizeSlider:RegisterCallback("OnValueChanged", function(self, value)
			if not Artificer_DB then return; end
			Artificer_DB.NameplateTargetSize = value;
			Artificer.UpdateNameplateTargetAppearance();
		end, sizeSlider);

		local colorLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		colorLabel:SetPoint("TOPLEFT", sizeSlider, "BOTTOMLEFT", 0, -10)
		colorLabel:SetText(L["FNP_IconColor"])

		local _colorClipboard = nil

		local colorSwatch = CreateFrame("Button", nil, f, "ColorSwatchTemplate")
		colorSwatch:SetPoint("LEFT", colorLabel, "RIGHT", 10, 0)
		colorSwatch:RegisterForClicks("AnyUp")

		local function GetCurrentColor()
			if Artificer_DB and Artificer_DB.NameplateTargetColor then
				return Artificer_DB.NameplateTargetColor;
			end
			return { r = 1, g = 1, b = 1, a = 1 };
		end

		local function ApplyColor(t)
			if not t then return end
			colorSwatch.Color:SetVertexColor(t.r, t.g, t.b, t.a);
			if Artificer_DB then
				Artificer_DB.NameplateTargetColor = t;
			end
			Artificer.UpdateNameplateTargetAppearance()
		end

		local initColor = GetCurrentColor()
		colorSwatch.Color:SetVertexColor(initColor.r, initColor.g, initColor.b, initColor.a)

		colorSwatch:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(L["FNP_IconColor"]);
			GameTooltip:AddLine(L["LC_OpenColorPicker"], 1, 1, 1);
			GameTooltip:AddLine(L["RC_OpenDropdown"], 1, 1, 1);
			GameTooltip:Show();
		end)
		colorSwatch:SetScript("OnLeave", GameTooltip_Hide)

		colorSwatch:SetScript("OnClick", function(_, button)
			if button == "RightButton" then
				MenuUtil.CreateContextMenu(colorSwatch, function(owner, rootDescription)
					rootDescription:CreateTitle(L["ColorOptions"]);

					rootDescription:CreateButton(L["CopyColor"], function()
						_colorClipboard = CopyTable(GetCurrentColor());
					end)

					local pasteBtn = rootDescription:CreateButton(L["PasteColor"], function()
						if not _colorClipboard then return; end
						ApplyColor(CopyTable(_colorClipboard));
					end)
					if not _colorClipboard then pasteBtn:SetEnabled(false); end

					rootDescription:CreateButton(RESET_TO_DEFAULT, function()
						ApplyColor({ r = 1, g = 1, b = 1, a = 1 });
					end);
				end)
				return
			end

			local current = GetCurrentColor()
			local info = {}
			info.r, info.g, info.b, info.opacity = current.r, current.g, current.b, current.a
			info.hasOpacity = true

			info.swatchFunc = function()
				local r, g, b = ColorPickerFrame:GetColorRGB();
				local a = ColorPickerFrame:GetColorAlpha();
				local saved = GetCurrentColor();
				saved.r, saved.g, saved.b, saved.a = r, g, b, a;
				ApplyColor(saved);
			end

			info.cancelFunc = function()
				local r, g, b, a = ColorPickerFrame:GetPreviousValues();
				local saved = GetCurrentColor();
				saved.r, saved.g, saved.b, saved.a = r, g, b, a;
				ApplyColor(saved);
			end

			ColorPickerFrame:SetupColorPickerAndShow(info)
		end)
		
		self.NameplateAdvancedFrame = f;
		f.Icon = icon;
		f.DummyPlate = dummyPlate;
		f.ColorSwatch = colorSwatch;
		f.GetCurrentColor = GetCurrentColor;
	end
	
	local pos = Artificer_DB.NameplateTargetPos or { point = "RIGHT", relativePoint = "LEFT", x = 0, y = 0 }
	self.NameplateAdvancedFrame.Icon:ClearAllPoints()
	self.NameplateAdvancedFrame.Icon:SetPoint(pos.point, self.NameplateAdvancedFrame.DummyPlate, pos.relativePoint, pos.x, pos.y)

	local c = self.NameplateAdvancedFrame.GetCurrentColor()
	self.NameplateAdvancedFrame.ColorSwatch.Color:SetVertexColor(c.r, c.g, c.b, c.a)

	Artificer.UpdateNameplateTargetAppearance()
	
	if self.NameplateAdvancedFrame:IsVisible() then
		self.NameplateAdvancedFrame:Hide();
	else
		self.NameplateAdvancedFrame:Show();
	end
end

local function SetTargetIconPosition(iconFrame, targetPlate)
	local pos = Artificer_DB.NameplateTargetPos or { point = "RIGHT", relativePoint = "LEFT", x = 0, y = 0 };
	iconFrame:ClearAllPoints();
	iconFrame:SetParent(targetPlate);
	iconFrame:SetPoint(pos.point, targetPlate, pos.relativePoint, pos.x, pos.y);
end

function Artificer.UpdateNameplateTargetPositions()
	for i = 1, MAX_NAMEPLATES do
		local key = "NamePlate" .. i;
		if NamePlateTextures[key] and NamePlateTextures[key]:IsShown() and _G[key] then
			SetTargetIconPosition(NamePlateTextures[key], _G[key]);
		end
	end
end

for i = 1, MAX_NAMEPLATES do
	local key = "NamePlate" .. i;
	NamePlateTextures[key] = CreateFrame("Frame", nil, WorldFrame);
	--NamePlateTextures[key]:SetSize(32, 32);

	NamePlateTextures[key].tex = NamePlateTextures[key]:CreateTexture();
	NamePlateTextures[key].tex:SetAllPoints();
	--NamePlateTextures[key].tex:SetAtlas("talents-heroclass-ring-minimize-show");
	NamePlateTextures[key]:Hide();
end

local function processUnit(unitToken)
	local namePlate = C_NamePlate.GetNamePlateForUnit(unitToken);
	if not namePlate then return; end
	local unitFrame = namePlate:GetName();

	if issecretvalue(unitToken) then return end
	if issecretvalue(UnitExists(unitToken)) then return; end
	if issecretvalue(UnitGUID(unitToken)) then return; end
	if issecretvalue(C_PlayerInfo.GUIDIsPlayer(UnitGUID(unitToken))) then return; end

	if UnitExists(unitToken) and C_PlayerInfo.GUIDIsPlayer(UnitGUID(unitToken)) then
		local targetToken = unitToken .. "target";
		if issecretvalue(targetToken) or issecretvalue(UnitExists(targetToken)) or issecretvalue(UnitName(targetToken)) then return; end

		if UnitExists(targetToken) and UnitName(targetToken) == UnitName("player") then
			if NamePlateTextures[unitFrame] then
				SetTargetIconPosition(NamePlateTextures[unitFrame], _G[unitFrame]);
				NamePlateTextures[unitFrame]:Show();
			end
		else
			if NamePlateTextures[unitFrame] then
				NamePlateTextures[unitFrame]:Hide();
			end
		end
	end
end

local function onNamePlateEvent(self, event, unitToken)
	if not Artificer_DB.Widgets.NameplateTargetIndicator then return end

	local namePlate = C_NamePlate.GetNamePlateForUnit(unitToken);
	if not namePlate then return end
	local unitFrame = namePlate:GetName();

	if event == "NAME_PLATE_UNIT_REMOVED" then
		NamePlateTextures[unitFrame]:ClearAllPoints();
		NamePlateTextures[unitFrame]:Hide();
	elseif event == "NAME_PLATE_UNIT_ADDED" then
		local targetToken = unitToken .. "target";
		if issecretvalue(targetToken) or issecretvalue(UnitExists(targetToken)) or issecretvalue(UnitName(targetToken)) or issecretvalue(UnitName("player")) then return end
		if UnitExists(targetToken) and UnitName(targetToken) == UnitName("player") then
			SetTargetIconPosition(NamePlateTextures[unitFrame], _G[unitFrame]);
			NamePlateTextures[unitFrame]:Show();
		end
	end
end

local function Rodeo()
	if not isRodeoActive then return end

	C_Timer.After(1, Rodeo);

	for i = 1, MAX_NAMEPLATES do
		processUnit(format(NAMEPLATE_TOKEN, i));
	end
end

local function hideAll()
	for i = 1, MAX_NAMEPLATES do
		local key = "NamePlate" .. i;
		NamePlateTextures[key]:ClearAllPoints();
		NamePlateTextures[key]:Hide();
	end
end

function Artificer.RefreshNameplateTargetIndicator()
	local isEnabled = Artificer_DB.Widgets.NameplateTargetIndicator;

	if isEnabled then
		eventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED");
		eventFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED");
		eventFrame:SetScript("OnEvent", onNamePlateEvent);

		if not isRodeoActive then
			isRodeoActive = true;
			Rodeo();
		end
	else
		eventFrame:UnregisterEvent("NAME_PLATE_UNIT_ADDED");
		eventFrame:UnregisterEvent("NAME_PLATE_UNIT_REMOVED");
		eventFrame:SetScript("OnEvent", nil);

		isRodeoActive = false;
		hideAll();
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		Artificer.UpdateNameplateTargetAppearance();
		Artificer.RefreshNameplateTargetIndicator();
	end
end)