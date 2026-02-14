local addonName, Artificer = ...;

local L = Artificer.L;
local allSettingsData = {};
local ScrollView;

local function IsSettingSeen(key)
	return Artificer_DB and Artificer_DB.SeenSettings and Artificer_DB.SeenSettings[key];
end

local function MarkSettingSeen(key)
	if not Artificer_DB then return end
	if not Artificer_DB.SeenSettings then Artificer_DB.SeenSettings = {}; end
	Artificer_DB.SeenSettings[key] = true;
end

local function UpdateNewIndicator(button, data)
	if data.isNew and not IsSettingSeen(data.key) then
		MarkSettingSeen(data.key);
		if button.NewIndicator then button.NewIndicator:Hide(); end
	end
end

local function GetDBValue(key)
	if Artificer_DB and Artificer_DB[key] ~= nil then
		return Artificer_DB[key];
	end
	return nil;
end

local function SetDBValue(key, value)
	if Artificer_DB then
		Artificer_DB[key] = value;
	end
end

local function GetWidgetValue(key)
	if Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets[key] ~= nil then
		return Artificer_DB.Widgets[key];
	end
	return nil;
end

local function SetWidgetValue(key, value)
	if Artificer_DB then
		if not Artificer_DB.Widgets then Artificer_DB.Widgets = {}; end
		Artificer_DB.Widgets[key] = value;
	end
end


local function InitializeCheckbox(button, data)
	button:SetHeight(30)
	
	if not button.checkbox then
		button.checkbox = CreateFrame("CheckButton", nil, button, "ChatConfigCheckButtonTemplate")
		button.checkbox:SetPoint("LEFT", 10, 0)
		button.checkbox:SetSize(24, 24)
		
		button.label = button.checkbox.Text
		button.label:ClearAllPoints()
		button.label:SetPoint("LEFT", button.checkbox, "RIGHT", 5, 0)
		button.label:SetPoint("RIGHT", button, "RIGHT", -5, 0)
		button.label:SetJustifyH("LEFT")
	end
	
	button.checkbox:Show()
	button.label:Show()
	
	button.label:SetText(data.label)
	
	button.checkbox:SetScript("OnEnter", function(self)
		UpdateNewIndicator(button, data);
		if data.tooltip then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(data.label, 1, 1, 1);
			GameTooltip:AddLine(data.tooltip, nil, nil, nil, true);
			GameTooltip:Show();
		end
	end)
	button.checkbox:SetScript("OnLeave", GameTooltip_Hide)

	local isChecked
	if data.isWidget then
		isChecked = GetWidgetValue(data.key);
	else
		isChecked = GetDBValue(data.key);
	end
	
	button.checkbox:SetChecked(isChecked)
	
	button.checkbox:SetScript("OnClick", function(self)
		local val = self:GetChecked()
		if data.isWidget then
			SetWidgetValue(data.key, val)
		else
			SetDBValue(data.key, val)
		end
		if data.callback then data.callback(val); end
	end)
end

local function InitializeDropdown(button, data)
	button:SetHeight(30)
	
	if not button.dropdown then
		button.dropdown = CreateFrame("DropdownButton", nil, button, "WowStyle1DropdownTemplate")
		button.dropdown:SetPoint("LEFT", 10, -5)
		button.dropdown:SetWidth(150)
		
		button.dropdownLabel = button:CreateFontString(nil, "OVERLAY", "GameTooltipText")
		button.dropdownLabel:SetPoint("LEFT", button.dropdown, "RIGHT", 10, 0)
		button.dropdownLabel:SetJustifyH("LEFT")
	end
	
	button.dropdown:Show()
	button.dropdownLabel:Show()
	button.dropdownLabel:SetText(data.label)
	
	local function GetCurrentValue()
		return GetDBValue(data.key) or data.defaultValue or 1
	end

	local function UpdateDropdownText()
		local currentVal = GetCurrentValue()
		for _, opt in ipairs(data.options) do
			if opt.value == currentVal then
				button.dropdown.Text:SetText(opt.text);
				break;
			end
		end
	end

	local function GeneratorFunction(dropdown, rootDescription)
		rootDescription:SetScrollMode(300)
		for _, option in ipairs(data.options) do
			rootDescription:CreateRadio(option.text, function() return GetCurrentValue() == option.value end, function()
				SetDBValue(data.key, option.value);
				UpdateDropdownText();
				if data.callback then data.callback(option.value); end
			end, option.value)
		end
	end
	
	button.dropdown:SetupMenu(GeneratorFunction)
	UpdateDropdownText()
	
	if data.tooltip or data.isNew then
		button.dropdown:SetScript("OnEnter", function(self)
			UpdateNewIndicator(button, data);
			if data.tooltip then
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				GameTooltip:SetText(data.label, 1, 1, 1);
				GameTooltip:AddLine(data.tooltip, nil, nil, nil, true);
				GameTooltip:Show();
			end
		end)
		button.dropdown:SetScript("OnLeave", GameTooltip_Hide)
	end
end

local function InitializeMultiCheckbox(button, data)
	button:SetHeight(30)
	
	if not button.multicheckbox then
		button.multicheckbox = CreateFrame("DropdownButton", nil, button, "WowStyle1FilterDropdownTemplate");
		button.multicheckbox:SetPoint("LEFT", 10, -5);
		button.multicheckbox:SetWidth(150);
		
		button.multicheckboxLabel = button:CreateFontString(nil, "OVERLAY", "GameTooltipText");
		button.multicheckboxLabel:SetPoint("LEFT", button.multicheckbox, "RIGHT", 10, 0);
		button.multicheckboxLabel:SetJustifyH("LEFT");
	end
	
	button.multicheckbox:Show()
	button.multicheckboxLabel:Show()
	button.multicheckboxLabel:SetText(data.label)
	
	local function GetCurrentValues()
		local values = GetDBValue(data.key)
		if not values then
			-- Initialize with defaults
			values = {}
			for _, opt in ipairs(data.options) do
				values[opt.key] = opt.default ~= false
			end
			SetDBValue(data.key, values)
		end
		return values
	end

	local function UpdateDropdownText()
		local values = GetCurrentValues()
		local selected = {}
		
		for _, opt in ipairs(data.options) do
			if values[opt.key] then
				table.insert(selected, opt.text)
			end
		end
		
		if #selected == 0 then
			button.multicheckbox.Text:SetText(L["None"]);
		elseif #selected == #data.options then
			button.multicheckbox.Text:SetText(L["All"]);
		else
			button.multicheckbox.Text:SetText(table.concat(selected, ", "));
		end
	end

	local function GeneratorFunction(dropdown, rootDescription)
		rootDescription:SetScrollMode(300)
		local values = GetCurrentValues()
		
		for _, option in ipairs(data.options) do
			local checkbox = rootDescription:CreateCheckbox(
				option.text,
				function() return values[option.key] end,
				function()
					values[option.key] = not values[option.key];
					SetDBValue(data.key, values);
					UpdateDropdownText();
					if data.callback then data.callback(values) end;
				end
			)
		end
	end
	
	button.multicheckbox:SetupMenu(GeneratorFunction)
	UpdateDropdownText()
	
	if data.tooltip then
		button.multicheckbox:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(data.label, 1, 1, 1);
			GameTooltip:AddLine(data.tooltip, nil, nil, nil, true);
			GameTooltip:Show();
		end)
		button.multicheckbox:SetScript("OnLeave", GameTooltip_Hide)
	end
end

local function InitializeSlider(button, data)
	button:SetHeight(30)
	
	if not button.slider then
		local options = Settings.CreateSliderOptions(data.min, data.max, data.step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, data.formatter)
		
		button.slider = CreateFrame("Frame", nil, button, "MinimalSliderWithSteppersTemplate")
		button.slider:SetPoint("LEFT", 10, -5)
		button.slider:SetWidth(200)
		local currentVal = tonumber(GetDBValue(data.key)) or data.defaultValue
		
		button.slider:Init(currentVal, options.minValue, options.maxValue, options.steps, options.formatters)
		
		button.sliderLabel = button:CreateFontString(nil, "OVERLAY", "GameTooltipText")
		button.sliderLabel:SetPoint("LEFT", button.slider, "RIGHT", 50, 0)
		button.sliderLabel:SetTextColor(1, 1, 1)
	end
	
	button.slider:Show()
	button.sliderLabel:Show()
	button.sliderLabel:SetText(data.label)
	
	if button.slider.OnValueChangedCallback then
		button.slider:UnregisterCallback("OnValueChanged", button.slider.OnValueChangedCallback);
	end

	local function OnValueChanged(self, value)
		if button.slider.isInitializing then return end
		SetDBValue(data.key, value)
		if data.callback then data.callback(value); end
	end

	button.slider.OnValueChangedCallback = OnValueChanged
	button.slider:RegisterCallback("OnValueChanged", OnValueChanged, button.slider)

	button.slider.isInitializing = true
	local currentVal = tonumber(GetDBValue(data.key)) or data.defaultValue
	button.slider:SetValue(currentVal)
	button.slider.isInitializing = false

	if data.tooltip then
		button.slider.Slider:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(data.label, 1, 1, 1);
			GameTooltip:AddLine(data.tooltip, nil, nil, nil, true);
			GameTooltip:Show();
		end)
		button.slider.Slider:SetScript("OnLeave", GameTooltip_Hide)
		button.sliderLabel:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(data.label, 1, 1, 1);
			GameTooltip:AddLine(data.tooltip, nil, nil, nil, true);
			GameTooltip:Show();
		end)
		button.sliderLabel:SetScript("OnLeave", GameTooltip_Hide)
	end
end

local function InitializeHeader(button, data)
	button:SetHeight(30)
	
	if not button.headerLabel then
		button.headerLabel = button:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
		button.headerLabel:SetPoint("LEFT", 10, -5)
		button.headerLabel:SetPoint("RIGHT", -10, -5)
		button.headerLabel:SetJustifyH("LEFT")
		button.headerLabel:SetTextColor(1, 0.82, 0) 
	end
	
	button.headerLabel:Show()
	button.headerLabel:SetText(data.label)
end


local function SettingsRowInitializer(button, data)
	if button.checkbox then button.checkbox:Hide(); button.label:Hide(); end
	if button.dropdown then button.dropdown:Hide(); button.dropdownLabel:Hide(); end
	if button.multicheckbox then button.multicheckbox:Hide(); button.multicheckboxLabel:Hide(); end
	if button.slider then button.slider:Hide(); button.sliderLabel:Hide(); end
	if button.headerLabel then button.headerLabel:Hide(); end

	if not button.NewIndicator then
		button.NewIndicator = button:CreateTexture(nil, "OVERLAY");
		button.NewIndicator:SetAtlas("plunderstorm-new-dot-lg");
		button.NewIndicator:SetSize(18, 18);
		button.NewIndicator:SetPoint("LEFT", button, "LEFT", -2, 0);
	end

	if data.isNew and not IsSettingSeen(data.key) then
		button.NewIndicator:Show();
	else
		button.NewIndicator:Hide();
	end

	if data.type == "checkbox" then
		InitializeCheckbox(button, data);
	elseif data.type == "dropdown" then
		InitializeDropdown(button, data);
	elseif data.type == "multicheckbox" then
		InitializeMultiCheckbox(button, data);
	elseif data.type == "slider" then
		InitializeSlider(button, data);
	elseif data.type == "header" then
		InitializeHeader(button, data);
	end
end

function Artificer:SaveFramePosition(frame, key)
	if not Artificer_DB then return end
	if not Artificer_DB.FramePositions then Artificer_DB.FramePositions = {} end
	
	local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()
	Artificer_DB.FramePositions[key] = {
		point = point,
		relativePoint = relativePoint,
		x = xOfs,
		y = yOfs
	}
end

function Artificer:RestoreFramePosition(frame, key)
	frame:ClearAllPoints()
	if Artificer_DB and Artificer_DB.FramePositions and Artificer_DB.FramePositions[key] then
		local pos = Artificer_DB.FramePositions[key];
		frame:SetPoint(pos.point, UIParent, pos.relativePoint, pos.x, pos.y);
	else
		frame:SetPoint("CENTER");
	end
end

function Artificer:SaveFrameSetting(key, setting, value)
	if not Artificer_DB then return end
	if not Artificer_DB.FrameSettings then Artificer_DB.FrameSettings = {} end
	if not Artificer_DB.FrameSettings[key] then Artificer_DB.FrameSettings[key] = {} end
	
	Artificer_DB.FrameSettings[key][setting] = value
end

function Artificer:RestoreFrameSettings(frame, key)
	Artificer:RestoreFramePosition(frame, key)
	
	if Artificer_DB and Artificer_DB.FrameSettings and Artificer_DB.FrameSettings[key] then
		local settings = Artificer_DB.FrameSettings[key]
		
		if settings.scale then
			frame:SetScale(settings.scale);
		end
		
		if settings.locked ~= nil then
			local isLocked = settings.locked;
			frame:SetMovable(not isLocked);
			if frame.TitleContainer then
				frame.TitleContainer:SetMovable(not isLocked);
			end
		end
	end
end

function Artificer:BuildSettingsData()
	allSettingsData = {}

	local function GetSearchText(label, tooltip)
		return (label .. " " .. (tooltip or "")):lower()
	end

	-- Header - Professions
	table.insert(allSettingsData, {
		type = "header",
		label = L["Header_Professions"],
	});

	-- Widgets - FishReelIn
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "FishReelIn",
		isNew = true,
		label = L["Widget_FishReelIn"],
		tooltip = L["Widget_FishReelInTT"],
		searchText = GetSearchText(L["Widget_FishReelIn"], L["Widget_FishReelInTT"]),
		callback = function(val)
			-- print("Fish Reel In: " .. tostring(val))
		end
	});

	-- Widgets - HideCraftingResults
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "HideCraftingResults",
		isNew = true,
		label = L["Widget_HideCraftingResults"],
		tooltip = L["Widget_HideCraftingResultsTT"],
		searchText = GetSearchText(L["Widget_HideCraftingResults"], L["Widget_HideCraftingResultsTT"]),
		callback = function(val)
			if Artificer.Widgets.HideCraftingResults then
				Artificer.Widgets.HideCraftingResults();
			end
		end
	});


	-- Header - Maps
	table.insert(allSettingsData, {
		type = "header",
		label = L["Header_Map"],
	});

	-- Widgets - ChromieTimeIcon
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "ChromieTimeIcon",
		isNew = true,
		label = L["Widget_ChromieTimeIcon"],
		tooltip = L["Widget_ChromieTimeIconTT"],
		searchText = GetSearchText(L["Widget_ChromieTimeIcon"], L["Widget_ChromieTimeIconTT"]),
		callback = function(val)
			if Artificer.Widgets.UpdateChromieTimeIcon then
				Artificer.Widgets.UpdateChromieTimeIcon();
			end
		end
	});

	-- Header - Action Bars
	table.insert(allSettingsData, {
		type = "header",
		label = L["Header_ActionBar"],
	});

	-- Widgets - HideMacroText
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "HideMacroText",
		isNew = true,
		label = L["Widget_HideMacroText"],
		tooltip = L["Widget_HideMacroTextTT"],
		searchText = GetSearchText(L["Widget_HideMacroText"], L["Widget_HideMacroTextTT"]),
		callback = function(val)
			if Artificer.DetermineMacroText then
				Artificer.DetermineMacroText();
			end
		end
	});

	-- Widgets - OutfitIcon
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "OutfitIcon",
		isNew = true,
		label = L["Widget_OutfitIcon"],
		tooltip = L["Widget_OutfitIconTT"],
		searchText = GetSearchText(L["Widget_OutfitIcon"], L["Widget_OutfitIconTT"]),
		callback = function(val)
			if Artificer.UpdateOutfitHighlighter then
				Artificer.UpdateOutfitHighlighter();
			end
		end
	});

	-- Header - Chat
	table.insert(allSettingsData, {
		type = "header",
		label = L["Header_Chat"],
	});

	-- Widgets - ArrowKeyEditbox
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "ArrowKeyEditbox",
		isNew = true,
		label = L["Widget_ArrowKeyEditbox"],
		tooltip = L["Widget_ArrowKeyEditboxTT"],
		searchText = GetSearchText(L["Widget_ArrowKeyEditbox"], L["Widget_ArrowKeyEditboxTT"]),
		callback = function(val)
			if Artificer.ArrowKeySetting then
				Artificer.ArrowKeySetting();
			end
		end
	});

	-- Widgets - ServerNotifications
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "ServerNotifications",
		isNew = true,
		label = L["Widget_ServerNotifications"],
		tooltip = L["Widget_ServerNotificationsTT"],
		searchText = GetSearchText(L["Widget_ServerNotifications"], L["Widget_ServerNotificationsTT"]),
		callback = function(val)
			-- print("Server Notifications: " .. tostring(val))
		end
	});

	-- Header - Misc.
	table.insert(allSettingsData, {
		type = "header",
		label = L["Header_Misc"],
	});

	-- Widgets - PartySync
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "PartySync",
		isNew = true,
		label = L["Widget_PartySync"],
		tooltip = L["Widget_PartySyncTT"],
		searchText = GetSearchText(L["Widget_PartySync"], L["Widget_PartySyncTT"]),
		callback = function(val)
			-- ...
		end
	});

	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "MovableCurrencyTransfer",
		isNew = true,
		label = L["Widget_MovableCurrencyTransfer"],
		tooltip = L["Widget_MovableCurrencyTransferTT"],
		searchText = GetSearchText(L["Widget_MovableCurrencyTransfer"], L["Widget_MovableCurrencyTransferTT"]),
		callback = function(val)
			if Artificer.Widgets.ApplyMovableCurrencyTransfer then
				Artificer.Widgets.ApplyMovableCurrencyTransfer();
			end
		end
	});

	-- Multi-checkbox dropdown - OutfitSwapSounds
	table.insert(allSettingsData, {
		type = "multicheckbox",
		key = "OutfitSwapSounds",
		isNew = true,
		label = L["Widget_OutfitSwapSounds"],
		tooltip = L["Widget_OutfitSwapSoundsTT"],
		options = {
			{ key = "impact", text = L["Widget_OSS_Impact"], default = true },
			{ key = "A", text = L["Widget_OSS_STA"], default = true },
			{ key = "B", text = L["Widget_OSS_STB"], default = true },
			{ key = "C", text = L["Widget_OSS_STC"], default = true },
			{ key = "D", text = L["Widget_OSS_STD"], default = true },
		},
		searchText = GetSearchText(L["Widget_OutfitSwapSounds"], L["Widget_OutfitSwapSoundsTT"]),
		callback = function(values)
			-- ...
		end
	});

	-- Header - Account Settings
	table.insert(allSettingsData, {
		type = "header",
		label = L["Header_AccountSettings"],
	});

	-- Widgets - AutoLoot
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "AutoLoot",
		isNew = true,
		label = L["Widget_AutoLoot"],
		tooltip = L["Widget_AutoLootTT"],
		searchText = GetSearchText(L["Widget_AutoLoot"], L["Widget_AutoLootTT"]),
		callback = function(val)
			if val and Artificer.Widgets.ApplyAutoLoot then
				Artificer.Widgets.ApplyAutoLoot();
			end
		end
	});

	-- Widgets - PetBattleMapFilter
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "PetBattleMapFilter",
		isNew = true,
		label = L["Widget_PetBattleMapFilter"],
		tooltip = L["Widget_PetBattleMapFilterTT"],
		searchText = GetSearchText(L["Widget_PetBattleMapFilter"], L["Widget_PetBattleMapFilterTT"]),
		callback = function(val)
			if val and Artificer.Widgets.ApplyPetBattleMapFilter then
				Artificer.Widgets.ApplyPetBattleMapFilter();
			end
		end
	});

	-- Widgets - CooldownManagerEnabled
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "CooldownManagerEnabled",
		isNew = true,
		label = L["Widget_cooldownViewerEnabled"],
		tooltip = L["Widget_cooldownViewerEnabledTT"],
		searchText = GetSearchText(L["Widget_cooldownViewerEnabled"], L["Widget_cooldownViewerEnabledTT"]),
		callback = function(val)
			if val and Artificer.Widgets.ApplyCooldownManagerEnabled then
				Artificer.Widgets.ApplyCooldownManagerEnabled();
			end
		end
	});

	-- Header - Console Variables (CVars)
	table.insert(allSettingsData, {
		type = "header",
		label = L["Header_CVars"],
	});

	if Artificer.CVars then
		for cvarName, data in pairs(Artificer.CVars) do
			local settingData = {
				type = data.settings,
				key = cvarName,
				isNew = true,
				label = data.label,
				tooltip = data.description,
				searchText = GetSearchText(data.label, data.description),
				callback = function(val)
					if data.settings == "checkbox" then
						local cvarVal = val and "1" or "0"
						C_CVar.SetCVar(cvarName, cvarVal);
					else
						C_CVar.SetCVar(cvarName, val);
					end
				end
			};
			
			if data.settings == "slider" then
				settingData.min = tonumber(data.min) or 0
				settingData.max = tonumber(data.max) or 1
				settingData.step = tonumber(data.step) or 1
				settingData.defaultValue = tonumber(data.default)
				settingData.formatter = function(value) return tostring(math.floor(value)) end
			end
			
			table.insert(allSettingsData, settingData);
		end
	end

	--[[ -- Test Settings
	table.insert(allSettingsData, {
		type = "checkbox",
		key = "ShowMinimapIcon",
		label = "Show Minimap Icon",
		tooltip = "Toggles the minimap icon on or off.",
		searchText = "show minimap icon",
		callback = function(val) print("Minimap Icon is now: " .. tostring(val)) end
	})

	table.insert(allSettingsData, {
		type = "dropdown",
		key = "logLevel",
		label = "Log Level",
		tooltip = "Set how much information is printed to chat.",
		defaultValue = 1,
		options = {
			{ text = "Information", value = 1 },
			{ text = "Warnings", value = 2 },
			{ text = "Errors Only", value = 3 },
		},
		searchText = "log level information warnings errors"
	})

	table.insert(allSettingsData, {
		type = "slider",
		key = "uiScale",
		label = "UI Scale",
		tooltip = "Adjust the size of the Artificer interface.",
		min = 0.5, max = 2.0, step = 0.1,
		defaultValue = 1.0,
		formatter = function(value) return math.floor((value * 100) + 0.5) .. "%" end,
		searchText = "ui scale size",
		callback = function(val)
			if Artificer.SettingsFrame then Artificer.SettingsFrame:SetScale(val) end
		end
	})
	--]]

	return allSettingsData
end


function Artificer:CreateSettingsUI()
	local frame = CreateFrame("Frame", "ArtificerSettingsFrame", UIParent, "PortraitFrameTemplateMinimizable")
	frame:SetSize(400, 500)
	frame:SetMovable(true)
	Artificer:RestoreFrameSettings(frame, "SettingsFrame")
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function(self)
		frame:StopMovingOrSizing();
		if frame:IsMovable() then
			frame:StartMoving();
		end
	end)
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing();
		Artificer:SaveFramePosition(self, "SettingsFrame");
	end)

	frame:SetScript("OnShow", function()
		PlaySound(279415);
	end)
	frame:SetScript("OnHide", function()
		PlaySound(248166);
	end)

	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
	frame:SetTitle(L["TOC_Title"])
	frame:SetPortraitTextureRaw("Interface\\AddOns\\Artificer\\Textures\\ArtificerIcon_BlackBG.png")
	local Portrait = frame.PortraitContainer.portrait
	Portrait:SetTexCoord(0.03, 1, 0.03, 1)

	tinsert(UISpecialFrames, "ArtificerSettingsFrame")
	
	--local savedScale = GetDBValue("uiScale")
	--if savedScale then
	--	frame:SetScale(savedScale);
	--end
	
	frame.TitleContainer:EnableMouse(true)
	frame.TitleContainer:RegisterForDrag("LeftButton")
	
	frame.TitleContainer:SetScript("OnDragStart", function(self)
		frame:StopMovingOrSizing();
		if frame:IsMovable() then
			frame:StartMoving();
		end
	end)
	
	frame.TitleContainer:SetScript("OnDragStop", function(self)
		frame:StopMovingOrSizing();
		Artificer:SaveFramePosition(frame, "SettingsFrame");
	end)

	frame.TitleContainer:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" then
			MenuUtil.CreateContextMenu(self, function(owner, rootDescription)
				rootDescription:CreateTitle(L["TOC_Title"])

				local function IsLocked() return not frame:IsMovable() end
				local function ToggleLock()
					local locked = not frame:IsMovable();
					frame:SetMovable(locked);
					if frame.TitleContainer then frame.TitleContainer:SetMovable(locked) end;
					Artificer:SaveFrameSetting("SettingsFrame", "locked", not locked);
				end
				rootDescription:CreateCheckbox(L["LockFrame"], IsLocked, ToggleLock)
				rootDescription:CreateButton(L["ResetPosition"], function()
					frame:ClearAllPoints();
					frame:SetPoint("CENTER");
					Artificer:SaveFramePosition(frame, "SettingsFrame");
				end)

				local submenu = rootDescription:CreateButton(L["UIScale"])
				local presets = {1.4, 1.2, 1.0, 0.8, 0.6};
				
				for _, scale in ipairs(presets) do
					local text = string.format("%d%%", scale * 100)
					submenu:CreateRadio(text, function() return math.abs(frame:GetScale() - scale) < 0.01 end, function()
						frame:SetScale(scale);
						Artificer:SaveFrameSetting("SettingsFrame", "scale", scale);
					end)
				end
			end)
		end
	end)

	frame.Bg = frame:CreateTexture(nil, "BACKGROUND", nil, 0)
	frame.Bg:SetPoint("TOPLEFT", 1, -24)
	frame.Bg:SetPoint("BOTTOMRIGHT", -2, 2)
	frame.Bg:SetColorTexture(0.1, 0.1, 0.1, 0.9)

	frame.BgIcon = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
	frame.BgIcon:SetPoint("CENTER", 0, 0)
	frame.BgIcon:SetSize(frame.Bg:GetWidth()*.75, frame.Bg:GetWidth()*.75)
	frame.BgIcon:SetTexture("Interface\\AddOns\\Artificer\\Textures\\ArtificerIcon_Small.blp")
	frame.BgIcon:SetDesaturated(true)
	frame.BgIcon:SetVertexColor(0.1, 0.1, 0.1, 0.2)

	local SearchBox = CreateFrame("EditBox", nil, frame, "SearchBoxTemplate")
	SearchBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 60, -35)
	SearchBox:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -25, -35)
	SearchBox:SetHeight(20)
	SearchBox:SetAutoFocus(false)

	local ScrollBox = CreateFrame("Frame", nil, frame, "WowScrollBoxList")
	ScrollBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 6, -65)
	ScrollBox:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -25, 6)

	local ScrollBar = CreateFrame("EventFrame", nil, frame, "MinimalScrollBar")
	ScrollBar:SetPoint("TOPLEFT", ScrollBox, "TOPRIGHT", 5, 0)
	ScrollBar:SetPoint("BOTTOMLEFT", ScrollBox, "BOTTOMRIGHT", 5, 0)

	ScrollView = CreateScrollBoxListLinearView()
	ScrollUtil.InitScrollBoxListWithScrollBar(ScrollBox, ScrollBar, ScrollView)
	
	ScrollView:SetElementInitializer("Button", SettingsRowInitializer)
	
	ScrollView:SetElementExtent(30)
	ScrollView:SetPadding(5, 5, 5, 5, 2)

	local function FilterSettings()
		local query = SearchBox:GetText():lower();
		local filtered = {};
		
		for _, data in ipairs(allSettingsData) do
			if query == "" or (data.searchText and data.searchText:find(query, 1, true)) then
				table.insert(filtered, data);
			end
		end
		
		local dataProvider = CreateDataProvider(filtered);
		ScrollView:SetDataProvider(dataProvider);
	end

	SearchBox:HookScript("OnTextChanged", function(self)
		self.t = 0
		self:SetScript("OnUpdate", function(self, elapsed)
			self.t = self.t + elapsed;
			if self.t >= 0.2 then
				self.t = 0;
				self:SetScript("OnUpdate", nil);
				FilterSettings();
			end
		end)
	end)

	Artificer:BuildSettingsData();
	FilterSettings();

	Artificer.SettingsFrame = frame;
	frame:Hide();
end

function Artificer:ToggleSettings()
	if not Artificer.SettingsFrame then
		Artificer:CreateSettingsUI();
	end
	
	local frame = Artificer.SettingsFrame
	if frame:IsShown() then
		frame:Hide();
	else
		frame:Show();
	end
end