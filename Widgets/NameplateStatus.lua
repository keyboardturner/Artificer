local addonName, Artificer = ...;
local L = Artificer.L;

local MAX_NAMEPLATES = 50;
local STATUS_TOKEN = "nameplate%d";

local StatusContainers = {};
local eventFrame = CreateFrame("Frame");

local statusi = {
	"connection",
	"chromie",
	"group",
	"guild",
	"friend",
	"ignored",
};

local THROTTLE_DELAY = 1.0;
local isTimerRunning = false;
local pendingUpdates = {
	social = false,
	guild = false,
	group = false,
	connectionTokens = {},
};

local StatusTextures = {
	connection_away = { tex = "Interface\\AddOns\\Artificer\\Textures\\Status_Away.png" },
	connection_dnd = { tex = "Interface\\AddOns\\Artificer\\Textures\\Status_Busy.png" },
	connection_DCd = { tex = "Interface\\AddOns\\Artificer\\Textures\\Status_DCd.png" },
	chromie = { tex = "Interface\\AddOns\\Artificer\\Textures\\ChromieTimeIcon.blp" },
	group_member = { tex = "Interface\\AddOns\\Artificer\\Textures\\GroupMember.png" },
	group_assist = { tex = "Interface\\AddOns\\Artificer\\Textures\\Group_Assist.png" },
	group_leader = { tex = "Interface\\AddOns\\Artificer\\Textures\\Group_Leader.png" },
	guild_member = { tex = "Interface\\AddOns\\Artificer\\Textures\\GuildMember.png" },
	friend_character = { tex = "Interface\\AddOns\\Artificer\\Textures\\Friend.png" },
	friend_account = { tex = "Interface\\AddOns\\Artificer\\Textures\\Friend_Warband.png" },
	friend_bnet = { tex = "Interface\\AddOns\\Artificer\\Textures\\Friend_BNet.png" },
	ignored_character = { tex = "Interface\\AddOns\\Artificer\\Textures\\Ignored.png" },
	ignored_account = { tex = "Interface\\AddOns\\Artificer\\Textures\\Ignored_Warband.png" },
};

local function LayoutContainerIcons(container)
	local padding = 2;
	local visibleIcons = {};

	for _, iconName in ipairs(statusi) do
		local icon = container[iconName];
		if icon:IsShown() then
			table.insert(visibleIcons, icon);
		end
	end

	local totalWidth = 0;
	for _, icon in ipairs(visibleIcons) do
		totalWidth = totalWidth + icon:GetWidth();
	end
	totalWidth = totalWidth + math.max(0, (#visibleIcons - 1) * padding);

	container:SetWidth(math.max(totalWidth, 1));

	local growth = (Artificer_DB and Artificer_DB.NameplateStatusGrowthDir) or "CENTER";
	local lastIcon = nil;

	if growth == "RIGHT_TO_LEFT" then
		for _, icon in ipairs(visibleIcons) do
			icon:ClearAllPoints();
			if not lastIcon then
				icon:SetPoint("RIGHT", container, "RIGHT", 0, 0);
			else
				icon:SetPoint("RIGHT", lastIcon, "LEFT", -padding, 0);
			end
			lastIcon = icon;
		end
	elseif growth == "LEFT_TO_RIGHT" then
		for _, icon in ipairs(visibleIcons) do
			icon:ClearAllPoints();
			if not lastIcon then
				icon:SetPoint("LEFT", container, "LEFT", 0, 0);
			else
				icon:SetPoint("LEFT", lastIcon, "RIGHT", padding, 0);
			end
			lastIcon = icon;
		end
	else -- center
		local currentOffset = -totalWidth / 2;
		for _, icon in ipairs(visibleIcons) do
			icon:ClearAllPoints();
			icon:SetPoint("LEFT", container, "CENTER", currentOffset, 0);
			currentOffset = currentOffset + icon:GetWidth() + padding;
		end
	end
end

local function SetIconTexture(iconFrame, textureData)
	if not textureData then return end

	if textureData.atlas then
		iconFrame.tex:SetTexture(nil);
		iconFrame.tex:SetAtlas(textureData.atlas);
	elseif textureData.tex then
		iconFrame.tex:SetAtlas(nil);
		iconFrame.tex:SetTexture(textureData.tex);
	end
end

local function ApplyContainerAppearance(container)
	local size = Artificer_DB.NameplateStatusSize or Artificer.Defaults.NameplateStatusSize;
	local colors = Artificer_DB.NameplateStatusColors or Artificer.Defaults.NameplateStatusColors;

	for _, key in ipairs(statusi) do
		local icon = container[key];
		icon:SetSize(size, size);

		local colorKey = icon.statusKey or key;
		local c = colors[colorKey] or { r=1, g=1, b=1, a=1, desat=false };

		icon.tex:SetVertexColor(c.r, c.g, c.b, c.a);
		icon.tex:SetDesaturated(c.desat);
	end
	LayoutContainerIcons(container);
end

function Artificer.UpdateNameplateStatusAppearance()
	if Artificer.NameplateStatusAdvancedFrame and Artificer.NameplateStatusAdvancedFrame.previewContainer then
		ApplyContainerAppearance(Artificer.NameplateStatusAdvancedFrame.previewContainer);
	end

	for _, container in pairs(StatusContainers) do
		ApplyContainerAppearance(container);
	end
end

function Artificer.UpdateStatusPreviewVisibility()
	local f = Artificer.NameplateStatusAdvancedFrame;
	if not f or not f.previewContainer then return; end

	local options = Artificer_DB.NameplateStatusTypes;
	local p = f.previewContainer;

	if options.connection then
		p.connection.statusKey = "connection_away";
		SetIconTexture(p.connection, StatusTextures.connection_away);
		p.connection:Show();
	else
		p.connection:Hide();
	end
	if options.chromie then
		p.chromie.statusKey = "chromie";
		SetIconTexture(p.chromie, StatusTextures.chromie);
		p.chromie:Show();
	else
		p.chromie:Hide();
	end
	if options.group then
		p.group.statusKey = "group_member";
		SetIconTexture(p.group, StatusTextures.group_member);
		p.group:Show();
	else
		p.group:Hide();
	end
	if options.guild then
		p.guild.statusKey = "guild_member";
		SetIconTexture(p.guild, StatusTextures.guild_member);
		p.guild:Show();
	else
		p.guild:Hide();
	end

	p.ignored:Hide(); p.friend:Hide();
	if options.ignored then
		p.ignored.statusKey = "ignored_character";
		SetIconTexture(p.ignored, StatusTextures.ignored_character);
		p.ignored:Show();
	elseif options.friend then
		p.friend.statusKey = "friend_character";
		SetIconTexture(p.friend, StatusTextures.friend_character);
		p.friend:Show();
	end

	LayoutContainerIcons(p);
end

function Artificer:OpenNameplateStatusAdvancedSettings()
	if not self.NameplateStatusAdvancedFrame then
		local f = CreateFrame("Frame", "ArtificerNameplateStatusAdvancedFrame", Artificer.SettingsFrame, "DialogBorderTranslucentTemplate");
		f:ClearAllPoints();
		f:SetSize(550, 580);
		f:SetPoint("LEFT", Artificer.SettingsFrame, "RIGHT", 45, 0);
		f:EnableMouse(true);
		f:Hide();

		tinsert(UISpecialFrames, "ArtificerNameplateStatusAdvancedFrame");

		f.previewScale = 1;

		f:SetScript("OnHide", function() PlaySound(840); end);

		local closeButton = CreateFrame("Button", nil, f, "UIPanelCloseButtonNoScripts");
		closeButton:SetPoint("TOPRIGHT", 0, 0);
		closeButton:SetScript("OnClick", function() f:Hide(); end);

		local plateTextBG = CreateFrame("Frame", "ArtificerNameplateStatusAdvancedFrameTitle", f, "DialogBorderTranslucentTemplate");
		plateTextBG:ClearAllPoints();
		plateTextBG:SetSize(100, 40);
		plateTextBG:SetPoint("BOTTOM", f, "TOP", 0, -15);

		local plateText = plateTextBG:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		plateText:SetPoint("CENTER");
		plateText:SetText(L["FNP_DragIcon"] or "Drag Icons to Position");
		plateTextBG:SetWidth(plateText:GetWidth() * 1.2);

		local backdropInfo = {
			bgFile = "interface\\reforging\\itemupgradetooltipfullmask",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = false, tileEdge = true, tileSize = 8, edgeSize = 8,
			insets = { left = 1, right = 1, top = 1, bottom = 1 },
		};

		local dummyBounds = CreateFrame("Frame", nil, f, "BackdropTemplate");
		dummyBounds:SetBackdrop(backdropInfo);
		dummyBounds:SetWidth(f:GetWidth()-20);
		dummyBounds:SetHeight(200);
		dummyBounds:SetPoint("TOP", f, "TOP", 0, -12.5);

		local dummyPlate = CreateFrame("Frame", nil, dummyBounds, "BackdropTemplate");
		local bg = dummyPlate:CreateTexture(nil, "BACKGROUND");
		bg:SetAllPoints();
		bg:SetAtlas("transmog-setCard-transmogrified");

		f.DummyPlate = dummyPlate;

		local previewContainer = CreateFrame("Frame", nil, dummyPlate);
		previewContainer:SetSize(64, 16);

		local function CreatePreviewIcon()
			local icon = CreateFrame("Frame", nil, previewContainer);
			icon.tex = icon:CreateTexture(nil, "ARTWORK");
			icon.tex:SetAllPoints();
			icon:Hide();
			return icon;
		end

		previewContainer.connection = CreatePreviewIcon();
		previewContainer.chromie = CreatePreviewIcon();
		previewContainer.group = CreatePreviewIcon();
		previewContainer.guild = CreatePreviewIcon();
		previewContainer.friend = CreatePreviewIcon();
		previewContainer.ignored = CreatePreviewIcon();

		f.previewContainer = previewContainer;

		local function ResetStatusPosition(axis)
			if not Artificer_DB.NameplateStatusPos then
				Artificer_DB.NameplateStatusPos = { point = "CENTER", relativePoint = "CENTER", x = 0, y = 0 };
			end

			if axis == "X" then
				Artificer_DB.NameplateStatusPos.x = 0;
			elseif axis == "Y" then
				Artificer_DB.NameplateStatusPos.y = 0;
			end

			local pos = Artificer_DB.NameplateStatusPos;
			local anchorPoint = pos.point or "CENTER";
			f.previewContainer:ClearAllPoints();
			f.previewContainer:SetPoint(anchorPoint, dummyPlate, "CENTER", pos.x * f.previewScale, pos.y * f.previewScale);

			if Artificer.UpdateNameplateStatusPositions then
				Artificer.UpdateNameplateStatusPositions();
			end
		end

		local vLine = CreateFrame("Button", nil, dummyBounds);
		vLine:SetWidth(4);
		vLine:SetPoint("TOP", dummyBounds, "TOP", 0, 0);
		vLine:SetPoint("BOTTOM", dummyBounds, "BOTTOM", 0, 0);
		vLine:SetFrameLevel(dummyPlate:GetFrameLevel() + 1);
		local vTex = vLine:CreateTexture(nil, "BACKGROUND");
		vTex:SetAllPoints();
		vTex:SetColorTexture(0, 1, 1, 0.2);
		vLine:SetScript("OnEnter", function(self)
			vTex:SetColorTexture(0, 1, 1, 0.6);
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(L["FNP_AlignHorizontally"], 1, 1, 1);
			GameTooltip:Show();
		end)
		vLine:SetScript("OnLeave", function()
			vTex:SetColorTexture(0, 1, 1, 0.2);
			GameTooltip_Hide();
		end)
		vLine:SetScript("OnClick", function() ResetStatusPosition("X"); end);

		local hLine = CreateFrame("Button", nil, dummyBounds);
		hLine:SetHeight(4);
		hLine:SetPoint("LEFT", dummyBounds, "LEFT", 0, 0);
		hLine:SetPoint("RIGHT", dummyBounds, "RIGHT", 0, 0);
		hLine:SetFrameLevel(dummyPlate:GetFrameLevel() + 1);
		local hTex = hLine:CreateTexture(nil, "BACKGROUND");
		hTex:SetAllPoints();
		hTex:SetColorTexture(0, 1, 1, 0.2);
		hLine:SetScript("OnEnter", function(self)
			hTex:SetColorTexture(0, 1, 1, 0.6);
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(L["FNP_AlignVertically"], 1, 1, 1);
			GameTooltip:Show();
		end)
		hLine:SetScript("OnLeave", function()
			hTex:SetColorTexture(0, 1, 1, 0.2);
			GameTooltip_Hide();
		end)
		hLine:SetScript("OnClick", function() ResetStatusPosition("Y"); end);
		
		f.previewContainer:SetFrameLevel(vLine:GetFrameLevel() + 2);

		local activePreviewContainer = CreateFrame("Frame", nil, f, "BackdropTemplate");
		activePreviewContainer:SetBackdrop(backdropInfo);
		activePreviewContainer:SetSize(60, 60);
		activePreviewContainer:SetPoint("LEFT", dummyBounds, "RIGHT", 10, 0);

		local activePreviewLabel = activePreviewContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
		activePreviewLabel:SetPoint("BOTTOM", activePreviewContainer, "TOP", 0, 5);
		activePreviewLabel:SetText(L["FNP_Preview"]);

		local activePreviewIcon = activePreviewContainer:CreateTexture(nil, "ARTWORK");
		activePreviewIcon:SetPoint("CENTER");
		activePreviewContainer:Hide();

		f.activePreviewContainer = activePreviewContainer;
		f.activePreviewIcon = activePreviewIcon;

		local function UpdateDummyPlate()
			local w, h = C_NamePlate.GetNamePlateSize();
			if not w or w == 0 then
				w, h = 110, 45;
			end
			local maxW, maxH = dummyBounds:GetWidth() - 20, dummyBounds:GetHeight() - 20;
			f.previewScale = math.min(maxW / w, maxH / h, 1);
			dummyPlate:SetSize(w * f.previewScale, h * f.previewScale);
			dummyPlate:SetPoint("CENTER", dummyBounds, "CENTER", 0, 0);
		end

		f:SetScript("OnShow", function()
			PlaySound(839);
			UpdateDummyPlate();
			local pos = Artificer_DB.NameplateStatusPos or Artificer.Defaults.NameplateStatusPos;
			local growth = Artificer_DB.NameplateStatusGrowthDir or "CENTER";
			
			local anchorPoint = "CENTER";
			if growth == "LEFT_TO_RIGHT" then anchorPoint = "LEFT";
			elseif growth == "RIGHT_TO_LEFT" then anchorPoint = "RIGHT"; end

			previewContainer:ClearAllPoints();
			previewContainer:SetPoint(anchorPoint, dummyPlate, "CENTER", pos.x * f.previewScale, pos.y * f.previewScale);
			Artificer.UpdateStatusPreviewVisibility();
			Artificer.UpdateNameplateStatusAppearance();
		end);

		previewContainer:EnableMouse(true);
		local dragOffsetX, dragOffsetY = 0, 0;

		previewContainer:SetScript("OnMouseDown", function(self, button)
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
				local halfW, halfH = self:GetWidth() / 2, self:GetHeight() / 2;
				local targetX = mx - dragOffsetX;
				local targetY = my - dragOffsetY;
				targetX = math.max(dummyBounds:GetLeft() + halfW, math.min(dummyBounds:GetRight() - halfW, targetX));
				targetY = math.max(dummyBounds:GetBottom() + halfH, math.min(dummyBounds:GetTop() - halfH, targetY));
				self:ClearAllPoints();
				self:SetPoint("CENTER", UIParent, "BOTTOMLEFT", targetX, targetY);
			end);
		end);

		previewContainer:SetScript("OnMouseUp", function(self, button)
			if button ~= "LeftButton" then return; end
			self:SetScript("OnUpdate", nil);

			local dpX, dpY = dummyPlate:GetCenter();
			local cX, cY = self:GetCenter();
			local growth = Artificer_DB.NameplateStatusGrowthDir or "CENTER";
			local halfW = self:GetWidth() / 2;

			local icX = cX;
			local anchorPoint = "CENTER";

			if growth == "LEFT_TO_RIGHT" then
				icX = cX - halfW;
				anchorPoint = "LEFT";
			elseif growth == "RIGHT_TO_LEFT" then
				icX = cX + halfW;
				anchorPoint = "RIGHT";
			end

			local dX, dY = icX - dpX, cY - dpY;

			if not Artificer_DB.NameplateStatusPos then Artificer_DB.NameplateStatusPos = {}; end
			Artificer_DB.NameplateStatusPos.point = anchorPoint;
			Artificer_DB.NameplateStatusPos.relativePoint = "CENTER";
			Artificer_DB.NameplateStatusPos.x = dX / f.previewScale;
			Artificer_DB.NameplateStatusPos.y = dY / f.previewScale;

			self:ClearAllPoints();
			self:SetPoint(anchorPoint, dummyPlate, "CENTER", dX, dY);

			if Artificer.UpdateNameplateStatusPositions then
				Artificer.UpdateNameplateStatusPositions();
			end
		end);

		local dropdownLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		dropdownLabel:SetPoint("TOPLEFT", dummyBounds, "BOTTOMLEFT", 20, -15);
		dropdownLabel:SetText(L["FNP_StatusOptions"]);

		local dropdown = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate");
		dropdown:SetPoint("TOPLEFT", dropdownLabel, "BOTTOMLEFT", 0, -5);
		dropdown:SetWidth(180);
		dropdown:SetDefaultText(L["FNP_StatusIndicator"]);

		local function GeneratorFunction(dropdown, rootDescription)
			local function IsSelected(key) return Artificer_DB.NameplateStatusTypes[key] == true; end
			local function SetSelected(key)
				Artificer_DB.NameplateStatusTypes[key] = not Artificer_DB.NameplateStatusTypes[key];
				Artificer.UpdateStatusPreviewVisibility();
				if Artificer.RefreshNameplateStatusIndicator then Artificer.RefreshNameplateStatusIndicator(); end
			end
			rootDescription:CreateCheckbox(L["FNP_StatusConnection"], function() return IsSelected("connection") end, function() SetSelected("connection") end);
			rootDescription:CreateCheckbox(L["FNP_StatusChromie"], function() return IsSelected("chromie") end, function() SetSelected("chromie") end);
			rootDescription:CreateCheckbox(L["FNP_StatusGroup"], function() return IsSelected("group") end, function() SetSelected("group") end);
			rootDescription:CreateCheckbox(L["FNP_StatusGuild"], function() return IsSelected("guild") end, function() SetSelected("guild") end);
			rootDescription:CreateCheckbox(L["FNP_StatusFriend"], function() return IsSelected("friend") end, function() SetSelected("friend") end);
			rootDescription:CreateCheckbox(L["FNP_StatusIgnored"], function() return IsSelected("ignored") end, function() SetSelected("ignored") end);
		end
		dropdown:SetupMenu(GeneratorFunction);

		local growthDropdownLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		growthDropdownLabel:SetPoint("TOPLEFT", dropdown, "BOTTOMLEFT", 0, -10);
		growthDropdownLabel:SetText(L["FNP_GrowthDirection"]);

		local growthDropdown = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate");
		growthDropdown:SetPoint("TOPLEFT", growthDropdownLabel, "BOTTOMLEFT", 0, -5);
		growthDropdown:SetWidth(180);

		local function GrowthGeneratorFunction(dropdown, rootDescription)
			local function IsSelected(key) return (Artificer_DB.NameplateStatusGrowthDir or "CENTER") == key; end
			local function SetSelected(key)
				Artificer_DB.NameplateStatusGrowthDir = key;
				
				local pos = Artificer_DB.NameplateStatusPos or Artificer.Defaults.NameplateStatusPos;
				if key == "LEFT_TO_RIGHT" then pos.point = "LEFT";
				elseif key == "RIGHT_TO_LEFT" then pos.point = "RIGHT";
				else pos.point = "CENTER"; end

				f.previewContainer:ClearAllPoints();
				f.previewContainer:SetPoint(pos.point, dummyPlate, "CENTER", pos.x * f.previewScale, pos.y * f.previewScale);

				Artificer.UpdateNameplateStatusAppearance();
				if Artificer.RefreshNameplateStatusIndicator then Artificer.RefreshNameplateStatusIndicator(); end
				if Artificer.UpdateNameplateStatusPositions then Artificer.UpdateNameplateStatusPositions(); end
			end
			rootDescription:CreateRadio(L["FNP_Center"], function() return IsSelected("CENTER") end, function() SetSelected("CENTER") end);
			rootDescription:CreateRadio(L["FNP_LeftToRight"], function() return IsSelected("LEFT_TO_RIGHT") end, function() SetSelected("LEFT_TO_RIGHT") end);
			rootDescription:CreateRadio(L["FNP_RightToLeft"], function() return IsSelected("RIGHT_TO_LEFT") end, function() SetSelected("RIGHT_TO_LEFT") end);
		end
		growthDropdown:SetupMenu(GrowthGeneratorFunction);
		growthDropdown:SetDefaultText(L["GrowthDirection"] or "Growth Direction");

		local sizeSlider = CreateFrame("Frame", nil, f, "MinimalSliderWithSteppersTemplate");
		sizeSlider:SetPoint("TOPRIGHT", dummyBounds, "BOTTOMRIGHT", -30, -25);
		sizeSlider:SetWidth(160);

		local sizeLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		sizeLabel:SetPoint("BOTTOMLEFT", sizeSlider, "TOPLEFT", 0, 0);
		sizeLabel:SetText(L["FNP_IconSize"]);

		local optionsOpts = Settings.CreateSliderOptions(8, 64, 2);
		optionsOpts:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value) return tostring(math.floor(value)); end);

		local currentSize = Artificer_DB.NameplateStatusSize or Artificer.Defaults.NameplateStatusSize;
		sizeSlider:Init(currentSize, optionsOpts.minValue, optionsOpts.maxValue, optionsOpts.steps, optionsOpts.formatters);

		sizeSlider:RegisterCallback("OnValueChanged", function(self, value)
			Artificer_DB.NameplateStatusSize = value;
			if f.activePreviewIcon then 
				f.activePreviewIcon:SetSize(value, value); 
			end
			Artificer.UpdateNameplateStatusAppearance();
		end, sizeSlider);

		local statuses = {
			{ key = "connection_away", name = L["FNP_StatusConnectionAway"] },
			{ key = "connection_dnd", name = L["FNP_StatusConnectionDND"] },
			{ key = "connection_DCd", name = L["FNP_StatusConnectionDCd"] },
			{ key = "chromie", name = L["FNP_StatusChromie"] },
			{ key = "group_member", name = L["FNP_StatusGroupMember"] },
			{ key = "group_assist", name = L["FNP_StatusGroupAssist"] },
			{ key = "group_leader", name = L["FNP_StatusGroupLeader"] },
			{ key = "guild_member", name = L["FNP_StatusGuildMember"] },
			{ key = "friend_character", name = L["FNP_StatusFriendChar"] },
			{ key = "friend_account", name = L["FNP_StatusFriendAcc"] },
			{ key = "friend_bnet", name = L["FNP_StatusFriendBNet"] },
			{ key = "ignored_character", name = L["FNP_StatusIgnoredChar"] },
			{ key = "ignored_account", name = L["FNP_StatusIgnoredAcc"] },
		};

		local scrollBox = CreateFrame("Frame", nil, f, "WowScrollBoxList");
		scrollBox:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 15, 250);
		scrollBox:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -35, 15);

		local scrollBar = CreateFrame("EventFrame", nil, f, "MinimalScrollBar");
		scrollBar:SetPoint("TOPLEFT", scrollBox, "TOPRIGHT", 5, 0);
		scrollBar:SetPoint("BOTTOMLEFT", scrollBox, "BOTTOMRIGHT", 5, 0);

		local scrollView = CreateScrollBoxListLinearView();
		scrollView:SetElementExtent(28);
		ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, scrollView);

		scrollView:SetElementInitializer("Frame", function(rowFrame, s)
			if not rowFrame.isInitialized then
				rowFrame.swatch = CreateFrame("Button", nil, rowFrame, "ColorSwatchTemplate");
				rowFrame.swatch:SetPoint("LEFT", rowFrame, "LEFT", 5, 0);
				rowFrame.swatch:RegisterForClicks("AnyUp");

				rowFrame.cLabel = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
				rowFrame.cLabel:SetPoint("LEFT", rowFrame.swatch, "RIGHT", 10, 0);
				rowFrame.cLabel:SetWidth(150);
				rowFrame.cLabel:SetJustifyH("LEFT");

				rowFrame.desatCheck = CreateFrame("CheckButton", nil, rowFrame, "ChatConfigCheckButtonTemplate");
				rowFrame.desatCheck:SetPoint("LEFT", rowFrame.cLabel, "RIGHT", 10, 0);
				rowFrame.desatCheck:SetSize(24, 24);
				rowFrame.desatCheck.Text = rowFrame.desatCheck.Text or rowFrame.desatCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal");
				rowFrame.desatCheck.Text:SetPoint("LEFT", rowFrame.desatCheck, "RIGHT", 5, 0);
				rowFrame.desatCheck.Text:SetText(L["Desaturate"] or "Desaturate");
				
				rowFrame.isInitialized = true;
			end

			rowFrame.cLabel:SetText(s.name);

			local function GetCurrentColor()
				if Artificer_DB.NameplateStatusColors and Artificer_DB.NameplateStatusColors[s.key] then 
					return Artificer_DB.NameplateStatusColors[s.key];
				end
				return Artificer.Defaults.NameplateStatusColors[s.key] or { r=1, g=1, b=1, a=1, desat=false };
			end

			local function ApplyColor(t)
				if not t then return; end
				rowFrame.swatch.Color:SetVertexColor(t.r, t.g, t.b, t.a);
				if not Artificer_DB.NameplateStatusColors then Artificer_DB.NameplateStatusColors = {}; end
				Artificer_DB.NameplateStatusColors[s.key] = t;
				Artificer.UpdateNameplateStatusAppearance();

				if f.activePreviewContainer.currentKey == s.key then
					f.activePreviewIcon:SetVertexColor(t.r, t.g, t.b, t.a);
					f.activePreviewIcon:SetDesaturated(t.desat);
				end
			end

			local initColor = GetCurrentColor();
			rowFrame.swatch.Color:SetVertexColor(initColor.r, initColor.g, initColor.b, initColor.a);
			rowFrame.desatCheck:SetChecked(initColor.desat);

			local function ShowPreview()
				local texInfo = StatusTextures[s.key]
				if texInfo then
					if texInfo.atlas then
						f.activePreviewIcon:SetTexture(nil);
						f.activePreviewIcon:SetAtlas(texInfo.atlas);
					else
						f.activePreviewIcon:SetAtlas(nil);
						f.activePreviewIcon:SetTexture(texInfo.tex);
					end
					
					local c = GetCurrentColor();
					f.activePreviewIcon:SetVertexColor(c.r, c.g, c.b, c.a);
					f.activePreviewIcon:SetDesaturated(c.desat);
					
					local curSize = Artificer_DB.NameplateStatusSize or Artificer.Defaults.NameplateStatusSize;
					f.activePreviewIcon:SetSize(curSize, curSize);
					
					f.activePreviewContainer.currentKey = s.key;
					f.activePreviewContainer:Show();
				end
			end

			local function HidePreview()
				if ColorPickerFrame:IsShown() and f.activePreviewContainer.currentKey == s.key then return end
				f.activePreviewContainer:Hide();
				if f.activePreviewContainer.currentKey == s.key then
					f.activePreviewContainer.currentKey = nil;
				end
			end

			rowFrame.swatch:SetScript("OnEnter", ShowPreview);
			rowFrame.swatch:SetScript("OnLeave", HidePreview);
			rowFrame.desatCheck:SetScript("OnEnter", ShowPreview);
			rowFrame.desatCheck:SetScript("OnLeave", HidePreview);

			rowFrame.swatch:SetScript("OnClick", function(_, button)
				if button == "RightButton" then
					MenuUtil.CreateContextMenu(rowFrame.swatch, function(owner, rootDescription)
						rootDescription:CreateTitle(L["ColorOptions"]);
						rootDescription:CreateButton(L["CopyColor"], function() Artificer.ColorClipboard = CopyTable(GetCurrentColor()); end);
						local pasteBtn = rootDescription:CreateButton(L["PasteColor"], function()
							if Artificer.ColorClipboard then ApplyColor(CopyTable(Artificer.ColorClipboard)); end
						end);
						if not Artificer.ColorClipboard then pasteBtn:SetEnabled(false); end
						rootDescription:CreateButton(RESET_TO_DEFAULT, function() 
							ApplyColor(CopyTable(Artificer.Defaults.NameplateStatusColors[s.key] or { r=1, g=1, b=1, a=1, desat=false })); 
						end);
					end);
					return;
				end

				local current = GetCurrentColor();
				local info = { r = current.r, g = current.g, b = current.b, opacity = current.a, hasOpacity = true };

				ShowPreview();

				info.swatchFunc = function()
					local r, g, b = ColorPickerFrame:GetColorRGB();
					local a = ColorPickerFrame:GetColorAlpha();
					local newColor = { r = r, g = g, b = b, a = a, desat = rowFrame.desatCheck:GetChecked() };
					ApplyColor(newColor);
				end;
				info.cancelFunc = function()
					local r, g, b, a = ColorPickerFrame:GetPreviousValues();
					local newColor = { r = r, g = g, b = b, a = a, desat = rowFrame.desatCheck:GetChecked() };
					ApplyColor(newColor);

					f.activePreviewContainer:Hide();
					f.activePreviewContainer.currentKey = nil;
				end;
				ColorPickerFrame:SetupColorPickerAndShow(info);
			end);

			rowFrame.desatCheck:SetScript("OnClick", function(self)
				local current = GetCurrentColor();
				current.desat = self:GetChecked();
				ApplyColor(current);
			end);
		end);

		local dataProvider = CreateDataProvider(statuses);
		scrollView:SetDataProvider(dataProvider);

		self.NameplateStatusAdvancedFrame = f;
	end

	if self.NameplateStatusAdvancedFrame:IsVisible() then
		self.NameplateStatusAdvancedFrame:Hide();
	else
		Artificer:CloseAllAdvancedFrames();
		self.NameplateStatusAdvancedFrame:Show();
	end
end

function Artificer:IsAccountFriendOrIgnored(unitName)
	if not unitName then return false, false; end

	local isFriend = false;
	local isIgnored = false;

	if Artificer_DB.AccountFriends then
		for ownerName, friendList in pairs(Artificer_DB.AccountFriends) do
			for _, friendName in ipairs(friendList) do
				if friendName == unitName or string.match(friendName, "^" .. unitName:gsub("([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1") .. "%-") then
					isFriend = true;
					if Artificer_DB.debug then
						print("Friend: ",friendName .. " - " .. ownerName);
					end
					break;
				end
			end
			if isFriend then break; end
		end
	end

	if Artificer_DB.AccountIgnores then
		for ownerName, ignoreList in pairs(Artificer_DB.AccountIgnores) do
			for _, ignoredName in ipairs(ignoreList) do
				if ignoredName == unitName or string.match(ignoredName, "^" .. unitName:gsub("([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1") .. "%-") then
					isIgnored = true;
					if Artificer_DB.debug then
						print("Ignored: ",ignoredName .. " - " .. ownerName);
					end
					break;
				end
			end
			if isIgnored then break; end
		end
	end

	return isFriend, isIgnored;
end

local function UpdateGroupIcon(unitToken, container)
	container.group:Hide();

	if issecretvalue(unitToken) or issecretvalue(UnitExists(unitToken)) then return; end
	if not UnitExists(unitToken) or not UnitIsPlayer(unitToken) then return; end
	if not scrubsecretvalues(UnitIsFriend("player", unitToken)) then return; end

	local options = Artificer_DB.NameplateStatusTypes;

	-- group member (leader > assist > party/raid)
	if options.group then
		local isLeader = scrubsecretvalues(UnitIsGroupLeader(unitToken));
		local isAssist = scrubsecretvalues(UnitIsGroupAssistant(unitToken));
		local inParty = scrubsecretvalues(UnitInParty(unitToken));
		local inRaid = scrubsecretvalues(UnitInRaid(unitToken));

		if isLeader then
			container.group.statusKey = "group_leader";
			SetIconTexture(container.group, StatusTextures.group_leader);
			container.group:Show();
		elseif isAssist then
			container.group.statusKey = "group_assist";
			SetIconTexture(container.group, StatusTextures.group_assist);
			container.group:Show();
		elseif inParty or inRaid then
			container.group.statusKey = "group_member";
			SetIconTexture(container.group, StatusTextures.group_member);
			container.group:Show();
		end
	end

	LayoutContainerIcons(container);
end

local function UpdateChromieIcon(unitToken, container)
	container.chromie:Hide();

	if issecretvalue(unitToken) or issecretvalue(UnitExists(unitToken)) then return; end
	if not UnitExists(unitToken) or not UnitIsPlayer(unitToken) then return; end
	if not scrubsecretvalues(UnitIsFriend("player", unitToken)) then return; end

	local options = Artificer_DB.NameplateStatusTypes;
	
	-- chromie time
	if options.chromie then
		local chromieID = scrubsecretvalues(UnitChromieTimeID(unitToken));
		if chromieID and chromieID > 0 then
			container.chromie.statusKey = "chromie";
			SetIconTexture(container.chromie, StatusTextures.chromie);
			container.chromie:Show();
		end
	end

	LayoutContainerIcons(container);
end

local function UpdateSocialIcons(unitToken, container)
	container.friend:Hide();
	container.ignored:Hide();

	if issecretvalue(unitToken) or issecretvalue(UnitExists(unitToken)) then return; end
	if not UnitExists(unitToken) or not UnitIsPlayer(unitToken) then return; end
	if not scrubsecretvalues(UnitIsFriend("player", unitToken)) then return; end

	local options = Artificer_DB.NameplateStatusTypes;
	local guid = UnitGUID(unitToken);
	local unitName = GetUnitName(unitToken, true);

	local isAccFriend, isAccIgnored = false, false;
	if Artificer.IsAccountFriendOrIgnored then
		isAccFriend, isAccIgnored = Artificer:IsAccountFriendOrIgnored(unitName);
	end

	-- friends (character > bnet > account)
	if options.friend then
		local isBNetFriend = false;
		if C_BattleNet and C_BattleNet.GetAccountInfoByGUID then
			local accountInfo = C_BattleNet.GetAccountInfoByGUID(guid);
			if accountInfo and accountInfo.isFriend then
				isBNetFriend = true;
			end
		end
		
		local isCharFriend = C_FriendList and C_FriendList.IsFriend and C_FriendList.IsFriend(guid);

		if isCharFriend then
			container.friend.statusKey = "friend_character";
			SetIconTexture(container.friend, StatusTextures.friend_character);
			container.friend:Show();
		elseif isBNetFriend then
			container.friend.statusKey = "friend_bnet";
			SetIconTexture(container.friend, StatusTextures.friend_bnet);
			container.friend:Show();
		elseif isAccFriend then
			container.friend.statusKey = "friend_account";
			SetIconTexture(container.friend, StatusTextures.friend_account);
			container.friend:Show();
		end
	end

	-- ignored (character > account)
	if options.ignored then
		local isCharIgnored = false;
		if C_FriendList and C_FriendList.IsIgnoredByGUID then
			isCharIgnored = C_FriendList.IsIgnoredByGUID(guid);
		elseif C_FriendList and C_FriendList.IsIgnored then
			isCharIgnored = C_FriendList.IsIgnored(unitName);
		end

		if isCharIgnored then
			container.ignored.statusKey = "ignored_character";
			SetIconTexture(container.ignored, StatusTextures.ignored_character);
			container.ignored:Show();
		elseif isAccIgnored then
			container.ignored.statusKey = "ignored_account";
			SetIconTexture(container.ignored, StatusTextures.ignored_account);
			container.ignored:Show();
		end
	end

	LayoutContainerIcons(container);
end

local function CreateContainer(index)
	local container = CreateFrame("Frame", nil, WorldFrame);
	container:SetSize(64, 16);
	container:Hide();

	local function CreateIcon()
		local f = CreateFrame("Frame", nil, container);
		f:SetSize(16, 16);
		f.tex = f:CreateTexture(nil, "ARTWORK");
		f.tex:SetAllPoints();
		f:Hide();
		return f;
	end

	container.connection = CreateIcon();
	container.chromie = CreateIcon();
	container.group = CreateIcon();
	container.guild = CreateIcon();
	container.friend = CreateIcon();
	container.ignored = CreateIcon();

	local key = "NamePlateStatus" .. index;
	StatusContainers[key] = container;
	return container;
end

for i = 1, MAX_NAMEPLATES do
	CreateContainer(i);
end

local function SetContainerPosition(container, namePlateFrame)
	local pos = Artificer_DB.NameplateStatusPos or Artificer.Defaults.NameplateStatusPos;
	local growth = Artificer_DB.NameplateStatusGrowthDir or "CENTER";
	local anchorPoint = "CENTER";

	if growth == "LEFT_TO_RIGHT" then 
		anchorPoint = "LEFT";
	elseif growth == "RIGHT_TO_LEFT" then 
		anchorPoint = "RIGHT"; 
	end

	container:ClearAllPoints();
	container:SetParent(namePlateFrame);
	container:SetPoint(anchorPoint, namePlateFrame, pos.relativePoint, pos.x, pos.y);
end

function Artificer.UpdateNameplateStatusPositions()
	for i = 1, MAX_NAMEPLATES do
		local key = "NamePlateStatus" .. i;
		local unitFrame = "NamePlate" .. i;
		if StatusContainers[key] and StatusContainers[key]:IsShown() and _G[unitFrame] then
			SetContainerPosition(StatusContainers[key], _G[unitFrame]);
		end
	end
end

local function UpdateConnectionIcon(unitToken, container)
	container.connection:Hide();

	if issecretvalue(unitToken) or issecretvalue(UnitExists(unitToken)) then return; end
	if not UnitExists(unitToken) or not UnitIsPlayer(unitToken) then return; end
	if not scrubsecretvalues(UnitIsFriend("player", unitToken)) then return; end

	local options = Artificer_DB.NameplateStatusTypes;
	if not options.connection then return; end

	local isConnected = scrubsecretvalues(UnitIsConnected(unitToken));
	local isAFK = scrubsecretvalues(UnitIsAFK(unitToken));
	local isDND = scrubsecretvalues(UnitIsDND(unitToken));

	if isConnected == false then
		container.connection.statusKey = "connection_DCd";
		SetIconTexture(container.connection, StatusTextures.connection_DCd);
		container.connection:Show();
	elseif isDND then
		container.connection.statusKey = "connection_dnd";
		SetIconTexture(container.connection, StatusTextures.connection_dnd);
		container.connection:Show();
	elseif isAFK then
		container.connection.statusKey = "connection_away";
		SetIconTexture(container.connection, StatusTextures.connection_away);
		container.connection:Show();
	end

	LayoutContainerIcons(container);
end

local function UpdateGuildIcon(unitToken, container)
	container.guild:Hide();

	if issecretvalue(unitToken) or issecretvalue(UnitExists(unitToken)) then return; end
	if not UnitExists(unitToken) or not UnitIsPlayer(unitToken) then return; end
	if not scrubsecretvalues(UnitIsFriend("player", unitToken)) then return; end

	local options = Artificer_DB.NameplateStatusTypes;
	if not options.guild then return; end

	local inGuild = scrubsecretvalues(UnitIsInMyGuild(unitToken));
	if inGuild then
		container.guild.statusKey = "guild_member";
		SetIconTexture(container.guild, StatusTextures.guild_member);
		container.guild:Show();
	end

	LayoutContainerIcons(container);
end

local function ProcessStatusUnit(unitToken)
	local namePlate = C_NamePlate.GetNamePlateForUnit(unitToken);
	if not namePlate then return; end
	local unitFrame = namePlate:GetName();

	local containerKey = "NamePlateStatus" .. string.match(unitToken, "%d+");
	local container = StatusContainers[containerKey];
	if not container then return; end

	if UnitExists(unitToken) and UnitIsPlayer(unitToken) and scrubsecretvalues(UnitIsFriend("player", unitToken)) then
		SetContainerPosition(container, _G[unitFrame]);
		UpdateGroupIcon(unitToken, container);
		UpdateConnectionIcon(unitToken, container);
		UpdateChromieIcon(unitToken, container);
		UpdateSocialIcons(unitToken, container);
		UpdateGuildIcon(unitToken, container);
		ApplyContainerAppearance(container);
		container:Show();
	else
		container:Hide();
	end
end

local function ProcessPendingUpdates()
	isTimerRunning = false;
	
	if pendingUpdates.social then
		pendingUpdates.social = false;
		for i = 1, MAX_NAMEPLATES do
			local unitToken = format(STATUS_TOKEN, i);
			local containerKey = "NamePlateStatus" .. i;
			local container = StatusContainers[containerKey];
			if container and container:IsShown() then
				UpdateSocialIcons(unitToken, container);
			end
		end
	end

	if pendingUpdates.guild then
		pendingUpdates.guild = false;
		for i = 1, MAX_NAMEPLATES do
			local token = format(STATUS_TOKEN, i);
			local containerKey = "NamePlateStatus" .. i;
			local container = StatusContainers[containerKey];
			if container and container:IsShown() then
				UpdateGuildIcon(token, container);
			end
		end
	end

	if pendingUpdates.group then
		pendingUpdates.group = false;
		for i = 1, MAX_NAMEPLATES do
			local token = format(STATUS_TOKEN, i);
			local containerKey = "NamePlateStatus" .. i;
			local container = StatusContainers[containerKey];
			if container and container:IsShown() then
				UpdateGroupIcon(token, container);
			end
		end
	end

	for unitToken in pairs(pendingUpdates.connectionTokens) do
		local containerKey = "NamePlateStatus" .. string.match(unitToken, "%d+");
		local container = StatusContainers[containerKey];
		if container and container:IsShown() then
			UpdateConnectionIcon(unitToken, container);
		end
	end
	
	wipe(pendingUpdates.connectionTokens);
end

local function TriggerThrottle()
	if not isTimerRunning then
		isTimerRunning = true;
		C_Timer.After(THROTTLE_DELAY, ProcessPendingUpdates);
	end
end

local function OnSocialUpdate(event)
	if not Artificer_DB.Widgets.NameplateStatusIndicator then return; end

	if event == "IGNORELIST_UPDATE" then
		Artificer.AccountIgnores:SyncCurrentCharacter();
	elseif event == "FRIENDLIST_UPDATE" then
		Artificer.AccountFriends:SyncCurrentCharacter();
	end

	pendingUpdates.social = true;
	TriggerThrottle();
end

local function HideAllStatuses()
	for _, container in pairs(StatusContainers) do
		container:ClearAllPoints();
		container:Hide();
	end
end

local function OnNamePlateStatusEvent(self, event, unitToken)
	if not Artificer_DB.Widgets.NameplateStatusIndicator then return; end

	if event == "NAME_PLATE_UNIT_REMOVED" then
		local containerKey = "NamePlateStatus" .. string.match(unitToken, "%d+");
		if StatusContainers[containerKey] then
			StatusContainers[containerKey]:ClearAllPoints();
			StatusContainers[containerKey]:Hide();
		end
	elseif event == "NAME_PLATE_UNIT_ADDED" then
		ProcessStatusUnit(unitToken);
	elseif event == "PLAYER_FLAGS_CHANGED" or event == "UNIT_CONNECTION" then
		if not unitToken or not string.match(unitToken, "^nameplate%d") then return; end
		pendingUpdates.connectionTokens[unitToken] = true;
		TriggerThrottle();
	elseif event == "PLAYER_GUILD_UPDATE" then
		pendingUpdates.guild = true;
		TriggerThrottle();
	elseif event == "GROUP_ROSTER_UPDATE" then
		pendingUpdates.group = true;
		TriggerThrottle();
	end
end

function Artificer.RefreshNameplateStatusIndicator()
	local isEnabled = Artificer_DB.Widgets.NameplateStatusIndicator;

	if isEnabled then
		eventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED");
		eventFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED");
		eventFrame:RegisterEvent("PLAYER_FLAGS_CHANGED");
		eventFrame:RegisterEvent("UNIT_CONNECTION");
		eventFrame:RegisterEvent("PLAYER_GUILD_UPDATE");
		eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE");
		eventFrame:SetScript("OnEvent", OnNamePlateStatusEvent);
	else
		eventFrame:UnregisterEvent("NAME_PLATE_UNIT_ADDED");
		eventFrame:UnregisterEvent("NAME_PLATE_UNIT_REMOVED");
		eventFrame:UnregisterEvent("PLAYER_FLAGS_CHANGED");
		eventFrame:UnregisterEvent("UNIT_CONNECTION");
		eventFrame:UnregisterEvent("PLAYER_GUILD_UPDATE");
		eventFrame:UnregisterEvent("GROUP_ROSTER_UPDATE");
		eventFrame:SetScript("OnEvent", nil);
		HideAllStatuses();
	end

	Artificer.NameplateRodeo:Refresh();
end

Artificer.NameplateRodeo:RegisterSocial(OnSocialUpdate);

local loader = CreateFrame("Frame");
loader:RegisterEvent("PLAYER_LOGIN");
loader:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		if not Artificer_DB.NameplateStatusTypes then
			Artificer_DB.NameplateStatusTypes = CopyTable(Artificer.Defaults.NameplateStatusTypes)
		end
		if not Artificer_DB.NameplateStatusSize then
			Artificer_DB.NameplateStatusSize = Artificer.Defaults.NameplateStatusSize;
		end

		Artificer.UpdateNameplateStatusAppearance();
		Artificer.RefreshNameplateStatusIndicator();
	end
end);
