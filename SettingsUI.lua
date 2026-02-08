local addonName, Artificer = ...;

local L = Artificer.L;
local allSettingsData = {};
local ScrollView;

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
	button:SetHeight(40)
	
	if not button.dropdown then
		button.dropdown = CreateFrame("DropdownButton", nil, button, "WowStyle1DropdownTemplate")
		button.dropdown:SetPoint("LEFT", 10, -5)
		button.dropdown:SetWidth(150)
		
		button.dropdownLabel = button:CreateFontString(nil, "OVERLAY", "GameTooltipText")
		button.dropdownLabel:SetPoint("BOTTOMLEFT", button.dropdown, "TOPLEFT", 0, 2)
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
	
	if data.tooltip then
		button.dropdown:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(data.label, 1, 1, 1);
			GameTooltip:AddLine(data.tooltip, nil, nil, nil, true);
			GameTooltip:Show();
		end)
		button.dropdown:SetScript("OnLeave", GameTooltip_Hide)
	end
end

local function InitializeSlider(button, data)
	button:SetHeight(50)
	
	if not button.slider then
		local options = Settings.CreateSliderOptions(data.min, data.max, data.step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, data.formatter)
		
		button.slider = CreateFrame("Frame", nil, button, "MinimalSliderWithSteppersTemplate")
		button.slider:SetPoint("LEFT", 10, -5)
		button.slider:SetWidth(250)
		button.slider:Init(GetDBValue(data.key) or data.defaultValue, options.minValue, options.maxValue, options.steps, options.formatters)
		
		button.sliderLabel = button:CreateFontString(nil, "OVERLAY", "GameTooltipText")
		button.sliderLabel:SetPoint("BOTTOMLEFT", button.slider, "TOPLEFT", 0, 2)
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
	button.slider:SetValue(GetDBValue(data.key) or data.defaultValue)
	button.slider.isInitializing = false
end


local function SettingsRowInitializer(button, data)
	if button.checkbox then button.checkbox:Hide(); button.label:Hide(); end
	if button.dropdown then button.dropdown:Hide(); button.dropdownLabel:Hide(); end
	if button.slider then button.slider:Hide(); button.sliderLabel:Hide(); end

	if data.type == "checkbox" then
		InitializeCheckbox(button, data);
	elseif data.type == "dropdown" then
		InitializeDropdown(button, data);
	elseif data.type == "slider" then
		InitializeSlider(button, data);
	end
end


function Artificer:BuildSettingsData()
	allSettingsData = {}

	-- Widgets - FishReelIn
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "FishReelIn",
		label = L["Widget_FishReelIn"],
		tooltip = L["Widget_FishReelInTT"],
		searchText = string.join(" ", L["Widget_FishReelIn"], L["Widget_FishReelInTT"] ),
		callback = function(val)
			-- print("Fish Reel In: " .. tostring(val))
		end
	});

	-- Widgets - ChromieTimeIcon
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "ChromieTimeIcon",
		label = L["Widget_ChromieTimeIcon"],
		tooltip = L["Widget_ChromieTimeIconTT"],
		searchText = string.join(" ", L["Widget_ChromieTimeIcon"], L["Widget_ChromieTimeIconTT"] ),
		callback = function(val)
			if Artificer.Widgets.UpdateChromieTimeIcon then
				Artificer.Widgets.UpdateChromieTimeIcon();
			end
		end
	});

	-- Widgets - HideMacroText
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "HideMacroText",
		label = L["Widget_HideMacroText"],
		tooltip = L["Widget_HideMacroTextTT"],
		searchText = string.join(" ", L["Widget_HideMacroText"], L["Widget_HideMacroTextTT"] ),
		callback = function(val)
			if Artificer.DetermineMacroText then
				Artificer.DetermineMacroText();
			end
		end
	});

	-- Widgets - ArrowKeyEditbox
	table.insert(allSettingsData, {
		type = "checkbox",
		isWidget = true,
		key = "ArrowKeyEditbox",
		label = L["Widget_ArrowKeyEditbox"],
		tooltip = L["Widget_ArrowKeyEditboxTT"],
		searchText = string.join(" ", L["Widget_ArrowKeyEditbox"], L["Widget_ArrowKeyEditbox"] ),
		callback = function(val)
			if Artificer.ArrowKeySetting then
				Artificer.ArrowKeySetting();
			end
		end
	});

	

	if Artificer.CVars then
		for cvarName, data in pairs(Artificer.CVars) do
			table.insert(allSettingsData, {
				type = data.settings,
				key = cvarName,
				label = data.label,
				tooltip = data.description,
				searchText = (data.label .. " " .. (data.description or "")):lower(),
				callback = function(val)
					if data.settings == "checkbox" then
						local cvarVal = val and "1" or "0"
						C_CVar.SetCVar(cvarName, cvarVal);
					else
						C_CVar.SetCVar(cvarName, val);
					end
				end
			});
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
	frame:SetPoint("CENTER")
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
	frame:SetTitle(L["TOC_Title"])
	frame:SetPortraitTextureRaw("Interface\\AddOns\\Artificer\\Textures\\ArtificerIcon_BlackBG.png")
	local Portrait = frame.PortraitContainer.portrait
	Portrait:SetTexCoord(0.03, 1, 0.03, 1)
	
	local savedScale = GetDBValue("uiScale")
	if savedScale then
		frame:SetScale(savedScale);
	end
	
	frame.TitleContainer:EnableMouse(true)
	frame.TitleContainer:RegisterForDrag("LeftButton")
	
	frame.TitleContainer:SetScript("OnDragStart", function(self)
		if frame:IsMovable() then
			frame:StartMoving();
		end
	end)
	
	frame.TitleContainer:SetScript("OnDragStop", function(self)
		frame:StopMovingOrSizing();
	end)

	frame.TitleContainer:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" then
			MenuUtil.CreateContextMenu(self, function(owner, rootDescription)
				rootDescription:CreateTitle(L["TOC_Title"])

				local function IsLocked() return not frame:IsMovable() end
				local function ToggleLock()
					frame:SetMovable(not frame:IsMovable())
				end
				rootDescription:CreateCheckbox(L["LockFrame"], IsLocked, ToggleLock)
				
				local submenu = rootDescription:CreateButton(L["UIScale"])
				local presets = {1.4, 1.2, 1.0, 0.8, 0.6};
				
				for _, scale in ipairs(presets) do
					local text = string.format("%d%%", scale * 100)
					submenu:CreateRadio(text, function() return math.abs(frame:GetScale() - scale) < 0.01 end, function()
						frame:SetScale(scale);
						SetDBValue("uiScale", scale);
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
	
	ScrollView:SetElementExtent(55)
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