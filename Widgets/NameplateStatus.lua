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

local StatusTextures = {
	connection_away = { tex = "Interface\\AddOns\\Artificer\\Textures\\Status_Away.png" },
	connection_dnd = { tex = "Interface\\AddOns\\Artificer\\Textures\\Status_Busy.png" },
	connection_DCd = { tex = "Interface\\AddOns\\Artificer\\Textures\\Status_DCd.png" },
	chromie = { tex = "Interface\\AddOns\\Artificer\\Textures\\ChromieTimeIcon.blp" },
	group_member = { atlas = "socialqueuing-icon-group" },
	group_assist = { atlas = "RaidFrame-Icon-MainAssist" },
	group_leader = { atlas = "plunderstorm-glues-icon-leader" },
	guild_member = { atlas = "UI-HUD-MicroMenu-GuildCommunities-GuildColor-Mouseover" },
	friend_character = { atlas = "housefinder_friend-plot-icon" },
	friend_account = { atlas = "friendslist-recentallies-yellow" },
	friend_bnet = { atlas = "housefinder_bnet-friend-plot-icon" },
	ignored_character = { atlas = "transmog-icon-remove" },
	ignored_account = { atlas = "Housing_Customize_Dye_RemoveDye" },
};

local function LayoutContainerIcons(container)
	local padding = 2;
	local lastIcon = nil;
	local totalWidth = 0;

	for _, iconName in ipairs(statusi) do
		local icon = container[iconName];
		icon:ClearAllPoints();
		if icon:IsShown() then
			if not lastIcon then
				icon:SetPoint("LEFT", container, "LEFT", 0, 0);
			else
				icon:SetPoint("LEFT", lastIcon, "RIGHT", padding, 0);
			end
			totalWidth = totalWidth + icon:GetWidth() + (lastIcon and padding or 0);
			lastIcon = icon;
		end
	end

	container:SetWidth(math.max(totalWidth, 1));
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

function Artificer.UpdateNameplateStatusAppearance()
	local size = Artificer_DB.NameplateStatusSize or Artificer.Defaults.NameplateStatusSize;
	local colors = Artificer_DB.NameplateStatusColors or Artificer.Defaults.NameplateStatusColors;

	local function ApplyAppearance(container)
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

	if Artificer.NameplateStatusAdvancedFrame and Artificer.NameplateStatusAdvancedFrame.previewContainer then
		ApplyAppearance(Artificer.NameplateStatusAdvancedFrame.previewContainer);
	end

	for _, container in pairs(StatusContainers) do
		ApplyAppearance(container);
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
		f:SetSize(420, 580);
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
		dummyBounds:SetSize(380, 160);
		dummyBounds:SetPoint("TOP", f, "TOP", 0, -12.5);

		local dummyPlate = CreateFrame("Frame", nil, dummyBounds, "BackdropTemplate");
		local bg = dummyPlate:CreateTexture(nil, "BACKGROUND");
		bg:SetAllPoints();
		bg:SetAtlas("nameplates-bar-background-white");

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

		local activePreviewContainer = CreateFrame("Frame", nil, f, "BackdropTemplate");
		activePreviewContainer:SetBackdrop(backdropInfo);
		activePreviewContainer:SetSize(60, 60);
		activePreviewContainer:SetPoint("LEFT", dummyBounds, "RIGHT", 10, 0);

		local activePreviewLabel = activePreviewContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
		activePreviewLabel:SetPoint("BOTTOM", activePreviewContainer, "TOP", 0, 5);
		activePreviewLabel:SetText(L["Preview"] or "Preview");

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
			previewContainer:ClearAllPoints();
			previewContainer:SetPoint(pos.point, dummyPlate, pos.relativePoint, pos.x * f.previewScale, pos.y * f.previewScale);
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
			local icX, icY = self:GetCenter();
			local dX, dY = icX - dpX, icY - dpY;

			if not Artificer_DB.NameplateStatusPos then Artificer_DB.NameplateStatusPos = {}; end
			Artificer_DB.NameplateStatusPos.point = "CENTER";
			Artificer_DB.NameplateStatusPos.relativePoint = "CENTER";
			Artificer_DB.NameplateStatusPos.x = dX / f.previewScale;
			Artificer_DB.NameplateStatusPos.y = dY / f.previewScale;

			self:ClearAllPoints();
			self:SetPoint("CENTER", dummyPlate, "CENTER", dX, dY);

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

		local sizeSlider = CreateFrame("Frame", nil, f, "MinimalSliderWithSteppersTemplate");
		sizeSlider:SetPoint("TOPRIGHT", dummyBounds, "BOTTOMRIGHT", -20, -25);
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

		local startY = -230;
		for i, s in ipairs(statuses) do
			local yOff = startY - ((i - 1) * 26);

			local swatch = CreateFrame("Button", nil, f, "ColorSwatchTemplate");
			swatch:SetPoint("TOPLEFT", f, "TOPLEFT", 20, yOff);
			swatch:RegisterForClicks("AnyUp");

			local cLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal");
			cLabel:SetPoint("LEFT", swatch, "RIGHT", 10, 0);
			cLabel:SetText(s.name);
			cLabel:SetWidth(150);
			cLabel:SetJustifyH("LEFT");

			local desatCheck = CreateFrame("CheckButton", nil, f, "ChatConfigCheckButtonTemplate");
			desatCheck:SetPoint("LEFT", cLabel, "RIGHT", 10, 0);
			desatCheck:SetSize(24, 24);
			desatCheck.Text = desatCheck.Text or desatCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal");
			desatCheck.Text:SetPoint("LEFT", desatCheck, "RIGHT", 5, 0);
			desatCheck.Text:SetText(L["Desaturate"] or "Desaturate");

			local function GetCurrentColor()
				if Artificer_DB.NameplateStatusColors and Artificer_DB.NameplateStatusColors[s.key] then 
					return Artificer_DB.NameplateStatusColors[s.key];
				end
				return Artificer.Defaults.NameplateStatusColors[s.key] or { r=1, g=1, b=1, a=1, desat=false };
			end

			local function ApplyColor(t)
				if not t then return; end
				swatch.Color:SetVertexColor(t.r, t.g, t.b, t.a);
				if not Artificer_DB.NameplateStatusColors then Artificer_DB.NameplateStatusColors = {}; end
				Artificer_DB.NameplateStatusColors[s.key] = t;
				Artificer.UpdateNameplateStatusAppearance();

				if f.activePreviewContainer.currentKey == s.key then
					f.activePreviewIcon:SetVertexColor(t.r, t.g, t.b, t.a);
					f.activePreviewIcon:SetDesaturated(t.desat);
				end
			end

			local initColor = GetCurrentColor();
			swatch.Color:SetVertexColor(initColor.r, initColor.g, initColor.b, initColor.a);
			desatCheck:SetChecked(initColor.desat);

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

			swatch:HookScript("OnEnter", ShowPreview);
			swatch:HookScript("OnLeave", HidePreview);
			desatCheck:HookScript("OnEnter", ShowPreview);
			desatCheck:HookScript("OnLeave", HidePreview);

			swatch:SetScript("OnClick", function(_, button)
				if button == "RightButton" then
					MenuUtil.CreateContextMenu(swatch, function(owner, rootDescription)
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
					local newColor = { r = r, g = g, b = b, a = a, desat = desatCheck:GetChecked() };
					ApplyColor(newColor);
				end;
				info.cancelFunc = function()
					local r, g, b, a = ColorPickerFrame:GetPreviousValues();
					local newColor = { r = r, g = g, b = b, a = a, desat = desatCheck:GetChecked() };
					ApplyColor(newColor);

					f.activePreviewContainer:Hide();
					f.activePreviewContainer.currentKey = nil;
				end;
				ColorPickerFrame:SetupColorPickerAndShow(info);
			end);

			desatCheck:SetScript("OnClick", function(self)
				local current = GetCurrentColor();
				current.desat = self:GetChecked();
				ApplyColor(current);
			end);
		end

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
		for _, friendList in pairs(Artificer_DB.AccountFriends) do
			for _, friendName in ipairs(friendList) do
				if friendName == unitName or string.match(friendName, "^" .. unitName .. "-") then
					isFriend = true;
					break;
				end
			end
			if isFriend then break; end
		end
	end

	if Artificer_DB.AccountIgnores then
		for _, ignoreList in pairs(Artificer_DB.AccountIgnores) do
			for _, ignoredName in ipairs(ignoreList) do
				if ignoredName == unitName or string.match(ignoredName, "^" .. unitName .. "-") then
					isIgnored = true;
					break;
				end
			end
			if isIgnored then break; end
		end
	end

	return isFriend, isIgnored;
end

-- icons that require more immediate attention
local function UpdateFastIcons(unitToken, container)
	container.connection:Hide();
	container.group:Hide();

	if issecretvalue(unitToken) or issecretvalue(UnitExists(unitToken)) then return; end
	if not UnitExists(unitToken) or not UnitIsPlayer(unitToken) then return; end
	if not scrubsecretvalues(UnitIsFriend("player", unitToken)) then return; end

	local options = Artificer_DB.NameplateStatusTypes;

	-- AFK/DND/DC'd
	if options.connection then
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
	end

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

--icons that will be relatively slow or unlikely to change, so the update time is slower
local function UpdateSlowIcons(unitToken, container)
	container.chromie:Hide();
	container.guild:Hide();
	container.friend:Hide();
	container.ignored:Hide();

	if issecretvalue(unitToken) or issecretvalue(UnitExists(unitToken)) then return; end
	if not UnitExists(unitToken) or not UnitIsPlayer(unitToken) then return; end
	if not scrubsecretvalues(UnitIsFriend("player", unitToken)) then return; end

	local options = Artificer_DB.NameplateStatusTypes;
	local guid = UnitGUID(unitToken);
	local unitName = GetUnitName(unitToken, true);

	-- chromie time
	if options.chromie then
		local chromieID = scrubsecretvalues(UnitChromieTimeID(unitToken));
		if chromieID and chromieID > 0 then
			container.chromie.statusKey = "chromie";
			SetIconTexture(container.chromie, StatusTextures.chromie);
			container.chromie:Show();
		end
	end

	-- guild member
	if options.guild then
		local inGuild = scrubsecretvalues(UnitIsInMyGuild(unitToken));
		if inGuild then
			container.guild.statusKey = "guild_member";
			SetIconTexture(container.guild, StatusTextures.guild_member);
			container.guild:Show();
		end
	end

	local isAccFriend, isAccIgnored = false, false;
	if Artificer.IsAccountFriendOrIgnored then
		isAccFriend, isAccIgnored = Artificer:IsAccountFriendOrIgnored(unitName);
	end

	-- friends (bnet > account > character)
	if options.friend then
		local isBNetFriend = false;
		if C_BattleNet and C_BattleNet.GetAccountInfoByGUID then
			local accountInfo = C_BattleNet.GetAccountInfoByGUID(guid);
			if accountInfo and accountInfo.isFriend then
				isBNetFriend = true;
			end
		end
		
		local isCharFriend = C_FriendList and C_FriendList.IsFriend and C_FriendList.IsFriend(guid);

		if isBNetFriend then
			container.friend.statusKey = "friend_bnet";
			SetIconTexture(container.friend, StatusTextures.friend_bnet);
			container.friend:Show();
		elseif isAccFriend then
			container.friend.statusKey = "friend_account";
			SetIconTexture(container.friend, StatusTextures.friend_account);
			container.friend:Show();
		elseif isCharFriend then
			container.friend.statusKey = "friend_character";
			SetIconTexture(container.friend, StatusTextures.friend_character);
			container.friend:Show();
		end
	end

	-- ignored (account > character)
	if options.ignored then
		local isCharIgnored = false;
		if C_FriendList and C_FriendList.IsIgnoredByGUID then
			isCharIgnored = C_FriendList.IsIgnoredByGUID(guid);
		elseif C_FriendList and C_FriendList.IsIgnored then
			isCharIgnored = C_FriendList.IsIgnored(unitName);
		end

		if isAccIgnored then
			container.ignored.statusKey = "ignored_account";
			SetIconTexture(container.ignored, StatusTextures.ignored_account);
			container.ignored:Show();
		elseif isCharIgnored then
			container.ignored.statusKey = "ignored_character";
			SetIconTexture(container.ignored, StatusTextures.ignored_character);
			container.ignored:Show();
		end
	end

	LayoutContainerIcons(container);
end

local function UpdateSocialIcons(unitToken, container)
	container.friend:Hide();
	container.ignored:Hide();

	if not UnitExists(unitToken) or not UnitIsPlayer(unitToken) then
		LayoutContainerIcons(container); return;
	end
	if not scrubsecretvalues(UnitIsFriend("player", unitToken)) then
		LayoutContainerIcons(container); return;
	end

	local options = Artificer_DB.NameplateStatusTypes;
	local guid = UnitGUID(unitToken);

	if not guid or guid == "" then
		LayoutContainerIcons(container); return;
	end

	local unitName = UnitName(unitToken);
	local isAccountFriend, isAccountIgnored = false, false;
	if unitName then
		isAccountFriend, isAccountIgnored = Artificer:IsAccountFriendOrIgnored(unitName);
	end

	local isIgnored = isAccountIgnored or scrubsecretvalues(C_FriendList.IsIgnoredByGuid(guid));
	local isCharFriend = isAccountFriend or scrubsecretvalues(C_FriendList.IsFriend(guid));
	local isBNetFriend = false;
	local accountInfo = scrubsecretvalues(C_BattleNet.GetAccountInfoByGUID(guid));
	if accountInfo and accountInfo.isFriend then isBNetFriend = true; end

	if options.ignored and isIgnored then
		SetIconTexture(container.ignored, true, StatusTextures.ignored_character.atlas );
		container.ignored:Show();
	elseif options.friend and (isCharFriend or isBNetFriend) then
		SetIconTexture(container.friend, true, StatusTextures.friend_character.atlas );
		container.friend:Show();
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
	container:ClearAllPoints();
	container:SetParent(namePlateFrame);
	container:SetPoint(pos.point, namePlateFrame, pos.relativePoint, pos.x, pos.y);
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

local function ProcessStatusUnit(unitToken)
	local namePlate = C_NamePlate.GetNamePlateForUnit(unitToken);
	if not namePlate then return; end
	local unitFrame = namePlate:GetName();

	local containerKey = "NamePlateStatus" .. string.match(unitToken, "%d+");
	local container = StatusContainers[containerKey];
	if not container then return; end

	if UnitExists(unitToken) and UnitIsPlayer(unitToken) and scrubsecretvalues(UnitIsFriend("player", unitToken)) then
		SetContainerPosition(container, _G[unitFrame]);
		UpdateFastIcons(unitToken, container);
		UpdateSlowIcons(unitToken, container);
		container:Show();
	else
		container:Hide();
	end
end

local function FastProcessStatusUnit(unitToken)
	if not Artificer_DB.Widgets.NameplateStatusIndicator then return; end

	local namePlate = C_NamePlate.GetNamePlateForUnit(unitToken);
	if not namePlate then return; end
	local unitFrame = namePlate:GetName();

	local containerKey = "NamePlateStatus" .. string.match(unitToken, "%d+");
	local container = StatusContainers[containerKey];
	if not container then return; end

	if UnitExists(unitToken) and UnitIsPlayer(unitToken) and scrubsecretvalues(UnitIsFriend("player", unitToken)) then
		SetContainerPosition(container, _G[unitFrame]);
		UpdateFastIcons(unitToken, container);
		container:Show();
	else
		container:Hide();
	end
end

local function SlowProcessStatusUnit(unitToken)
	if not Artificer_DB.Widgets.NameplateStatusIndicator then return; end

	local containerKey = "NamePlateStatus" .. string.match(unitToken, "%d+");
	local container = StatusContainers[containerKey];

	if not container or not container:IsShown() then return; end

	UpdateSlowIcons(unitToken, container);
end

local function OnSocialUpdate(event)
	if not Artificer_DB.Widgets.NameplateStatusIndicator then return; end

	if event == "IGNORELIST_UPDATE" then
		Artificer.AccountIgnores:SyncCurrentCharacter();
	elseif event == "FRIENDLIST_UPDATE" then
		Artificer.AccountFriends:SyncCurrentCharacter();
	end

	for i = 1, MAX_NAMEPLATES do
		local unitToken = format(STATUS_TOKEN, i);
		local containerKey = "NamePlateStatus" .. i;
		local container = StatusContainers[containerKey];
		if container and container:IsShown() then
			UpdateSocialIcons(unitToken, container);
		end
	end
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
	end
end

function Artificer.RefreshNameplateStatusIndicator()
	local isEnabled = Artificer_DB.Widgets.NameplateStatusIndicator;

	if isEnabled then
		eventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED");
		eventFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED");
		eventFrame:SetScript("OnEvent", OnNamePlateStatusEvent);
	else
		eventFrame:UnregisterEvent("NAME_PLATE_UNIT_ADDED");
		eventFrame:UnregisterEvent("NAME_PLATE_UNIT_REMOVED");
		eventFrame:SetScript("OnEvent", nil);
		HideAllStatuses();
	end

	Artificer.NameplateRodeo:Refresh();
end

Artificer.NameplateRodeo:RegisterFast(FastProcessStatusUnit);
Artificer.NameplateRodeo:RegisterSlow(SlowProcessStatusUnit);
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
