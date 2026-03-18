local addonName, Artificer = ...;

local L = Artificer.L;

--[[
Enum.PreyHuntProgressState = {
	0 = Cold – all three indicators empty
	1 = Warm – one indicator lit
	2 = Hot – two indicators lit
	3 = Final – all three indicators lit
}
--]]

local INDICATOR_SIZE = 32;
local INDICATOR_GAP = 2;
local EDGE_GAP = 6;
local BAR_LONG = 100;
local BAR_SHORT = 12;
local NOTCH_CROSS = 6;

local ATLAS_EMPTY = "threatindicator-cold";
local ATLAS_FULL = "threatindicator-warm";

local WIDGET_SET_ID = 283;
local PREY_TYPE = Enum.UIWidgetVisualizationType.PreyHuntProgress;

local function GetStyle()
	return (Artificer_DB and Artificer_DB.PreyBar and Artificer_DB.PreyBar.PreyBarStyle) or Artificer.Defaults.PreyBar.PreyBarStyle;
end

local function GetPosition()
	return (Artificer_DB and Artificer_DB.PreyBar and Artificer_DB.PreyBar.PreyBarPosition) or Artificer.Defaults.PreyBar.PreyBarPosition;
end

local function SetAlphaAnimated(frame, targetAlpha, duration)
	if not frame then return end
	duration = duration or 0.3

	if not frame.fadeAnimGroup then
		frame.fadeAnimGroup = frame:CreateAnimationGroup();
		local alphaAnim = frame.fadeAnimGroup:CreateAnimation("Alpha");
		alphaAnim:SetOrder(1);
		frame.fadeAnim = alphaAnim;

		frame.fadeAnimGroup:SetScript("OnFinished", function()
			frame:SetAlpha(frame.targetAlpha);
		end)
		frame.targetAlpha = frame:GetAlpha();
	end

	if frame.targetAlpha == targetAlpha then
		if not frame.fadeAnimGroup:IsPlaying() then
			frame:SetAlpha(targetAlpha);
		end
		return;
	end

	frame.fadeAnimGroup:Stop()
	frame.targetAlpha = targetAlpha

	if targetAlpha > 0 and not frame:IsShown() then
		frame:SetAlpha(0);
		frame:Show();
	end

	frame.fadeAnim:SetFromAlpha(frame:GetAlpha())
	frame.fadeAnim:SetToAlpha(targetAlpha)
	frame.fadeAnim:SetDuration(duration)
	frame.fadeAnimGroup:Play()
end

local function SuppressBlizzWidget(widgetFrame)
    if not widgetFrame then return end
    widgetFrame:Hide()
    if not widgetFrame._artificerSuppressHooked then
        widgetFrame:HookScript("OnShow", function(self)
            local db = Artificer_DB and Artificer_DB.PreyBar;
            if db and db.HideBlizzWidget then
                self:Hide();
            end
        end)
        widgetFrame._artificerSuppressHooked = true;
    end
end

local function MakeIcon(parent)
	local f = CreateFrame("Frame", nil, parent or UIParent);
	f:SetSize(INDICATOR_SIZE, INDICATOR_SIZE);
	f:SetFrameStrata("MEDIUM");
	local tex = f:CreateTexture(nil, "ARTWORK");
	tex:SetAllPoints(f);
	f.texture = tex;
	f:Hide();
	return f;
end

local function MakeStatusBar(parent)
	local container = CreateFrame("Frame", nil, parent or UIParent)
	container:SetSize(BAR_LONG, BAR_SHORT)
	container:SetFrameStrata("MEDIUM")

	local bg = container:CreateTexture(nil, "BACKGROUND", nil, 0)
	bg:SetAtlas("CovenantSanctum-Level-Border-Venthyr", false)
	bg:SetPoint("TOPLEFT", container, "TOPLEFT", -19, 18)
	bg:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", 19, -18)
	container.bg = bg

	local clip = CreateFrame("Frame", nil, container)
	clip:SetClipsChildren(true)
	clip:SetFrameLevel(container:GetFrameLevel() + 1)
	clip:SetPoint("TOPLEFT", container, "TOPLEFT")
	clip:SetPoint("BOTTOMLEFT", container, "BOTTOMLEFT")
	clip:SetWidth(1)
	clip:SetHeight(BAR_SHORT)
	container.clip = clip

	local fill = clip:CreateTexture(nil, "ARTWORK", nil, 1)
	fill:SetAtlas("housing-dashboard-fillbar-fill", false)
	fill:SetSize(BAR_LONG, BAR_SHORT)
	fill:SetPoint("LEFT", clip, "LEFT")
	fill:SetDesaturated(true)
	fill:SetVertexColor(1, 0, 0)
	container.fill = fill

	local notches = {}
	for i = 1, 2 do
		local n = container:CreateTexture(nil, "OVERLAY", nil, 2);
		n:SetAtlas("CovenantSanctum-Reservoir-Spark-Venthyr", false);
		n:SetSize(NOTCH_CROSS*3.5, BAR_SHORT*1.3); -- hegiht, width

		n:SetRotation(math.rad(90));
		
		notches[i] = n;
	end
	notches[1]:SetPoint("CENTER", container, "LEFT", BAR_LONG / 3, 0)
	notches[2]:SetPoint("CENTER", container, "LEFT", BAR_LONG * 2 / 3, 0)
	container.notches = notches

	container.fillValue = 0

	function container:SetValue(val)
		self.fillValue = val;
		self.clip:SetWidth(math.max(1, BAR_LONG * (val / 3)));
	end

	container:Hide();
	return container;
end

local function CreateIndicatorGroup()
	local grp = {}
	
	-- reworking how the icons are made a little bit
	grp.masterFrame = CreateFrame("Frame", nil, UIParent)
	grp.masterFrame:SetSize(1, 1)
	grp.masterFrame:Show()

	grp.icons = {}
	for i = 1, 3 do
		grp.icons[i] = MakeIcon(grp.masterFrame);
	end

	grp.sbFrame = MakeStatusBar(grp.masterFrame)

	function grp:HideAll()
		SetAlphaAnimated(self.masterFrame, 0);
	end

	function grp:ShowForStyle(style)
		SetAlphaAnimated(self.masterFrame, 1);
		
		if style == "statusbar" then
			self.sbFrame:Show()
			for i = 1, 3 do
				self.icons[i]:Hide();
			end
		else
			self.sbFrame:Hide()
			for i = 1, 3 do
				self.icons[i]:Show();
			end
		end
	end

	function grp:Update(state)
		local style = GetStyle();
		if style == "statusbar" then
			self.sbFrame:SetValue(state);
		else
			for i = 1, 3 do
				self.icons[i].texture:SetAtlas(i <= state and ATLAS_FULL or ATLAS_EMPTY, true);
			end
		end
	end

	function grp:AnchorTo(widgetFrame)
		local style = GetStyle()
		local position = GetPosition()
		local isHoriz = (position == "top" or position == "bottom")

		for i = 1, 3 do self.icons[i]:ClearAllPoints() end
		self.sbFrame:ClearAllPoints()

		if style == "corner" then
			self.icons[1]:SetPoint("TOPRIGHT", widgetFrame, "BOTTOMLEFT", -EDGE_GAP*-2, EDGE_GAP*3);
			self.icons[2]:SetPoint("TOPLEFT", widgetFrame, "BOTTOMRIGHT", EDGE_GAP*-2, EDGE_GAP*3);
			self.icons[3]:SetPoint("BOTTOM", widgetFrame, "TOP", 0, -EDGE_GAP);

		elseif style == "row" then
			if isHoriz then
				local myPoint, theirPoint, offY; -- what's your point?
				if position == "top" then
					myPoint, theirPoint, offY = "BOTTOM", "TOP", EDGE_GAP;
				else
					myPoint, theirPoint, offY = "TOP", "BOTTOM", -EDGE_GAP;
				end

				self.icons[2]:SetPoint(myPoint, widgetFrame, theirPoint, 0, offY);
				self.icons[1]:SetPoint("RIGHT", self.icons[2], "LEFT", -INDICATOR_GAP, 0);
				self.icons[3]:SetPoint("LEFT", self.icons[2], "RIGHT", INDICATOR_GAP, 0);
			else
				local myPoint, theirPoint, offX;
				if position == "left" then
					myPoint, theirPoint, offX = "RIGHT", "LEFT", -EDGE_GAP;
				else
					myPoint, theirPoint, offX = "LEFT", "RIGHT", EDGE_GAP;
				end
				self.icons[2]:SetPoint(myPoint, widgetFrame, theirPoint, offX, 0);
				self.icons[1]:SetPoint("TOP", self.icons[2], "BOTTOM", 0, -INDICATOR_GAP);
				self.icons[3]:SetPoint("BOTTOM", self.icons[2], "TOP", 0, INDICATOR_GAP);
			end

		elseif style == "statusbar" then
			if position == "top" then
				self.sbFrame:SetPoint("BOTTOM", widgetFrame, "TOP", 0, EDGE_GAP);
			elseif position == "bottom" then
				self.sbFrame:SetPoint("TOP", widgetFrame, "BOTTOM", 0, -EDGE_GAP);
			elseif position == "left" then
				self.sbFrame:SetPoint("RIGHT", widgetFrame, "LEFT", -EDGE_GAP, 0);
			elseif position == "right" then
				self.sbFrame:SetPoint("LEFT", widgetFrame, "RIGHT", EDGE_GAP, 0);
			end
			self.sbFrame:SetValue(self.sbFrame.fillValue or 0);
		end
	end

	return grp
end

local Indicators = nil;
local trackedWidget = nil;

local function FindPreyWidgetFrame()
	local container = UIWidgetPowerBarContainerFrame
	if not container then return nil, nil end

	local children = container:GetLayoutChildren()
	for _, child in ipairs(children) do
		if child.widgetType == PREY_TYPE then
			return child, child.widgetID;
		end
	end

	local widgets = C_UIWidgetManager.GetAllWidgetsBySetID(WIDGET_SET_ID)
	if widgets then
		for _, w in ipairs(widgets) do
			if w.widgetType == PREY_TYPE then
				local children2 = container:GetLayoutChildren();
				for _, child in ipairs(children2) do
					if child.widgetID == w.widgetID then
						return child, w.widgetID;
					end
				end
			end
		end
	end

	return nil, nil;
end

local function UpdateIndicators()
	if not (Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.PreyBarEnabled) then
		Indicators:HideAll()
		if trackedWidget then
			SetAlphaAnimated(trackedWidget, 1);
		end
		return
	end

	local widgetFrame, widgetID = FindPreyWidgetFrame()
	if not widgetFrame then
		Indicators:HideAll();
		trackedWidget = nil;
		return;
	end

	local info = C_UIWidgetManager.GetPreyHuntProgressWidgetVisualizationInfo(widgetID)
	if not info or info.shownState ~= Enum.WidgetShownState.Shown then
		Indicators:HideAll();
		return
	end

	local db = Artificer_DB and Artificer_DB.PreyBar
	
	local inCombat = InCombatLockdown() or UnitAffectingCombat("player")
	local hideForCombat = db and db.HideInCombat and inCombat
	local hideForNotFull = db and db.HideBlizzWidget and info.progressState < 3

	if hideForCombat or hideForNotFull then
		SetAlphaAnimated(widgetFrame, 0);
		widgetFrame:EnableMouse(false);
	else
		SetAlphaAnimated(widgetFrame, 1);
		widgetFrame:EnableMouse(true);
	end

	if not widgetFrame:IsVisible() then
		Indicators:HideAll();
		return;
	end

	if hideForCombat then
		Indicators:HideAll();
		return;
	end

	if widgetFrame ~= trackedWidget then
		trackedWidget = widgetFrame;
		Indicators:AnchorTo(widgetFrame);
	end
	
	Indicators:ShowForStyle(GetStyle())
	Indicators:Update(info.progressState)
end

function Artificer.Widgets.ApplyPreyBarSettings()
	if not Indicators then return end

	local db = Artificer_DB and Artificer_DB.PreyBar
	if trackedWidget and not (db and db.HideBlizzWidget) then
		SetAlphaAnimated(trackedWidget, 1);
		trackedWidget:EnableMouse(true);
	end

	trackedWidget = nil
	UpdateIndicators()
end

function Artificer:OpenPreyBarAdvancedSettings()
	if not self.PreyBarAdvancedFrame then
		local f = CreateFrame("Frame", "ArtificerPreyBarAdvancedFrame", Artificer.SettingsFrame, "DialogBorderTranslucentTemplate")
		f:ClearAllPoints()
		f:SetSize(300, 270)
		f:SetPoint("LEFT", Artificer.SettingsFrame, "RIGHT", 45, 0)
		f:EnableMouse(true)
		f:Hide()

		tinsert(UISpecialFrames, "ArtificerPreyBarAdvancedFrame")

		f:SetScript("OnHide", function() PlaySound(840) end)
		f:SetScript("OnShow", function() PlaySound(839) end)

		local closeButton = CreateFrame("Button", nil, f, "UIPanelCloseButtonNoScripts")
		closeButton:SetPoint("TOPRIGHT", 0, 0)
		closeButton:SetScript("OnClick", function() f:Hide() end)

		local titleBG = CreateFrame("Frame", nil, f, "DialogBorderTranslucentTemplate")
		titleBG:ClearAllPoints()
		titleBG:SetSize(160, 40)
		titleBG:SetPoint("BOTTOM", f, "TOP", 0, -15)

		local titleText = titleBG:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		titleText:SetPoint("CENTER")
		titleText:SetText(L["Widget_PreyBar"])
		titleBG:SetWidth(titleText:GetWidth() * 1.2)

		local yOff = -25

		local styleLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		styleLabel:SetPoint("TOPLEFT", f, "TOPLEFT", 20, yOff)
		styleLabel:SetText(L["PreyBar_Style"])

		local STYLE_OPTIONS = {
			{ text = L["PreyBar_Style_Corner"], value = "corner" },
			{ text = L["PreyBar_Style_Row"], value = "row" },
			{ text = L["PreyBar_Style_Statusbar"], value = "statusbar" },
		}

		local styleDropdown = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate")
		styleDropdown:SetPoint("TOPLEFT", styleLabel, "BOTTOMLEFT", 0, -6)
		styleDropdown:SetWidth(200)

		local function GetCurrentStyle()
			return (Artificer_DB and Artificer_DB.PreyBar and Artificer_DB.PreyBar.PreyBarStyle) or "statusbar";
		end

		local function GetStyleText(val)
			for _, opt in ipairs(STYLE_OPTIONS) do
				if opt.value == val then
					return opt.text;
				end
			end
			return STYLE_OPTIONS[1].text;
		end

		local function UpdateStyleText()
			styleDropdown.Text:SetText(GetStyleText(GetCurrentStyle()));
		end

		local positionDropdown, positionLabel, positionDesc

		local function RefreshPositionVisibility()
			local style = GetCurrentStyle();
			local show = (style == "row" or style == "statusbar");
			if positionLabel then
				positionLabel:SetShown(show);
			end
			if positionDropdown then
				positionDropdown:SetShown(show);
			end
			if positionDesc then
				positionDesc:SetShown(show);
			end
		end

		styleDropdown:SetupMenu(function(dropdown, rootDescription)
			for _, opt in ipairs(STYLE_OPTIONS) do
				rootDescription:CreateRadio(opt.text, function()
					return GetCurrentStyle() == opt.value;
				end, function()
					if Artificer_DB then
						if not Artificer_DB.PreyBar then
							Artificer_DB.PreyBar = {};
						end
						Artificer_DB.PreyBar.PreyBarStyle = opt.value;
					end
					UpdateStyleText();
					RefreshPositionVisibility();
					if Artificer.Widgets.ApplyPreyBarSettings then
						Artificer.Widgets.ApplyPreyBarSettings();
					end
				end)
			end
		end)
		UpdateStyleText()

		local POSITION_OPTIONS = {
			{ text = L["PreyBar_Position_Top"], value = "top" },
			{ text = L["PreyBar_Position_Bottom"], value = "bottom" },
			{ text = L["PreyBar_Position_Left"], value = "left" },
			{ text = L["PreyBar_Position_Right"], value = "right" },
		}

		positionLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		positionLabel:SetPoint("TOPLEFT", styleDropdown, "BOTTOMLEFT", 0, -16)
		positionLabel:SetText(L["PreyBar_Position"])

		positionDesc = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
		positionDesc:SetPoint("TOPLEFT", positionLabel, "BOTTOMLEFT", 0, -4)
		positionDesc:SetPoint("RIGHT", f, "RIGHT", -14, 0)
		positionDesc:SetText(L["PreyBar_PositionTT"])
		positionDesc:SetJustifyH("LEFT")
		positionDesc:SetTextColor(0.7, 0.7, 0.7)

		local function GetCurrentPosition()
			return (Artificer_DB and Artificer_DB.PreyBar and Artificer_DB.PreyBar.PreyBarPosition) or "bottom";
		end

		local function GetPositionText(val)
			for _, opt in ipairs(POSITION_OPTIONS) do
				if opt.value == val then
					return opt.text;
				end
			end
			return POSITION_OPTIONS[1].text;
		end

		local function UpdatePositionText()
			positionDropdown.Text:SetText(GetPositionText(GetCurrentPosition()));
		end

		positionDropdown = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate")
		positionDropdown:SetPoint("TOPLEFT", positionDesc, "BOTTOMLEFT", 0, -6)
		positionDropdown:SetWidth(200)

		positionDropdown:SetupMenu(function(dropdown, rootDescription)
			for _, opt in ipairs(POSITION_OPTIONS) do
				rootDescription:CreateRadio(opt.text, function()
					return GetCurrentPosition() == opt.value;
				end, function()
					if Artificer_DB then
						if not Artificer_DB.PreyBar then
							Artificer_DB.PreyBar = {};
						end
						Artificer_DB.PreyBar.PreyBarPosition = opt.value;
					end
					UpdatePositionText();
					if Artificer.Widgets.ApplyPreyBarSettings then
						Artificer.Widgets.ApplyPreyBarSettings();
					end
				end)
			end
		end)
		UpdatePositionText()

		local hideCheck = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
		hideCheck:SetPoint("TOPLEFT", positionDropdown, "BOTTOMLEFT", -2, -16)
		hideCheck:SetSize(24, 24)

		local hideCheckLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		hideCheckLabel:SetPoint("LEFT", hideCheck, "RIGHT", 4, 0)
		hideCheckLabel:SetText(L["PreyBar_HideBlizzWidget"])

		hideCheck:SetScript("OnClick", function(self)
			if Artificer_DB then
				if not Artificer_DB.PreyBar then
					Artificer_DB.PreyBar = {};
				end
				Artificer_DB.PreyBar.HideBlizzWidget = self:GetChecked();
			end
			if Artificer.Widgets.ApplyPreyBarSettings then
				Artificer.Widgets.ApplyPreyBarSettings();
			end
		end)

		local combatCheck = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
		combatCheck:SetPoint("TOPLEFT", hideCheck, "BOTTOMLEFT", 0, -18)
		combatCheck:SetSize(24, 24)

		local combatCheckLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		combatCheckLabel:SetPoint("LEFT", combatCheck, "RIGHT", 4, 0)
		combatCheckLabel:SetText(L["PreyBar_HideInCombat"])

		combatCheck:SetScript("OnClick", function(self)
			if Artificer_DB then
				if not Artificer_DB.PreyBar then
					Artificer_DB.PreyBar = {};
				end
				Artificer_DB.PreyBar.HideInCombat = self:GetChecked();
			end
			if Artificer.Widgets.ApplyPreyBarSettings then
				Artificer.Widgets.ApplyPreyBarSettings();
			end
		end)

		f:HookScript("OnShow", function()
			UpdateStyleText();
			UpdatePositionText();
			RefreshPositionVisibility();
			local db = Artificer_DB and Artificer_DB.PreyBar;
			
			hideCheck:SetChecked(db and db.HideBlizzWidget ~= nil and db.HideBlizzWidget or Artificer.Defaults.PreyBar.HideBlizzWidget);
			combatCheck:SetChecked(db and db.HideInCombat ~= nil and db.HideInCombat or Artificer.Defaults.PreyBar.HideInCombat);
		end)

		self.PreyBarAdvancedFrame = f
	end

	if self.PreyBarAdvancedFrame:IsVisible() then
		self.PreyBarAdvancedFrame:Hide();
	else
		Artificer:CloseAllAdvancedFrames();
		self.PreyBarAdvancedFrame:Show();
	end
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("PLAYER_LOGIN")
loader:RegisterEvent("UPDATE_UI_WIDGET")
loader:RegisterEvent("PLAYER_ENTERING_WORLD")
loader:RegisterEvent("PLAYER_REGEN_DISABLED")
loader:RegisterEvent("PLAYER_REGEN_ENABLED")

loader:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		Indicators = CreateIndicatorGroup();
	end

	if Indicators then
		UpdateIndicators();
	end
end)