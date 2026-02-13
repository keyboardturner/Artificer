local addonName, Artificer = ...;

local L = Artificer.L;

local FOLEY_EVENT_ID = 8; -- apparently isn't used by anything atm so can probably safely nuke this for now
-- if this interferes with anything, blame Meo. he told me thjis event ID was safe
local FOLEY_TRIGGER_ID = 0;
local lastPlayedFileID = nil;

local function GetFoleyDB()
	if not Artificer.GetCharDB then return nil end

	local charDB = Artificer.GetCharDB()
	if not charDB then return nil end

	if not charDB.FoleySounds then
		charDB.FoleySounds = {};
	end
	
	return charDB.FoleySounds;
end

local function GetVolumeDB()
	if not Artificer.GetCharDB then return nil end

	local charDB = Artificer.GetCharDB()
	if not charDB then return nil end

	if not charDB.FoleyVolume then
		charDB.FoleyVolume = {};
	end
	
	return charDB.FoleyVolume;
end

local FoleySoundsLibrary = {
	Leather = {	-- SoundKit ID 1003 (Leather)
		567580, 567586, 567591, 567598, 567599,
		567601, 567602, 567604, 567606, 567607,
	},
	Chain = {	-- SoundKit ID 1005 (Chain/Mail)
		567585, 567587, 567590, 567592, 567593,
		567594, 567597, 567600, 567603, 567605,
	},
	Plate = {	-- SoundKit ID 1004 (Plate)
		567578, 567579, 567581, 567582, 567583,
		567584, 567588, 567589, 567595, 567596,
	},
	RidingDragonTurtle_Run = { -- PlaySound(29484)
		633539, 633541, 633543, 633545, 633547,
		633549, 633551, 633553, 633555, 633557,
	},
	RidingDragonTurtle_Walk = { -- PlaySound(29483)
		633559, 633561, 633563, 633565, 633567,
		633569, 633571, 633573, 633575, 633577,
	},
	YakMount_Run = { -- soundkit may have issues with infinite loop
		633579, 633581, 633583, 633585, 633587,
		633589, 633591, 633593, 633595, 633597,
	},
	YakMount_Walk = { --soundkit may have issues with infinite loop
		633599, 633601, 633603, 633605, 633607,
		633609, 633611, 633613, 633615, 633617,
	},
	Grummle_Run = { -- soundkit may have infinite loop issues
		642967, 642969, 642971, 642973, 642975,
		642977, 642979, 642981, 642983, 642985,
	},
	Grummle_Walk = { -- soundkit may have infinite loop issues
		642987, 642989, 642991, 642993, 642995,
		642997, 642999, 643001, 643003, 643005,
	},
	TreasureGoblinPet_Bag = { -- soundkit allows overlap (PlaySound(211065))
		943380, 943382, 943384, 943386, 943388,
		943390, 943392, 943394, 943396, 943398,
	},
	Metal_ArmorBuckles_Long = { -- LOUD, allows overlap (PlaySound(217605))
		4577783, 4577785, 4577787, 4577789, 4577791,
		4577793, 4577796, 4577798, 4577800, 4577802,
	},
	Metal_ArmorBuckles_Short = { -- loud, allows overlap (PlaySound(228470))
		4577804, 4577806, 4577808, 4577810, 4577813,
		4577815, 4577817, 4577819, 4577821, 4577823,
		4577825, 4577827, 4577829, 4577831,
	},
};

local SoundDefinitions = {
	{
		key = "None",
		name = L["None"],
		icon = "Interface\\Icons\\INV_Misc_QuestionMark",
		sounds = nil,
	},
	{
		key = "Leather",
		name = L["Leather"],
		icon = "Interface\\Icons\\inv_chest_leather_09",
		sounds = FoleySoundsLibrary.Leather,
		volume = 1,
	},
	{
		key = "Chain",
		name = L["Chain"],
		icon = "Interface\\Icons\\inv_chest_chain_12",
		sounds = FoleySoundsLibrary.Chain,
		volume = 1,
	},
	{
		key = "Plate",
		name = L["Plate"],
		icon = "Interface\\Icons\\inv_chest_plate04",
		sounds = FoleySoundsLibrary.Plate,
		volume = 1,
	},
	{
		key = "GearLight",
		name = L["GearLight"],
		icon = "Interface\\Icons\\inv_cape_armor_explorer_d_01_backpack",
		sounds = FoleySoundsLibrary.RidingDragonTurtle_Run,
		volume = .15,
	},
	{
		key = "GearHeavy",
		name = L["GearHeavy"],
		icon = "Interface\\Icons\\inv_backpack_wrathion_c_01",
		sounds = FoleySoundsLibrary.RidingDragonTurtle_Walk,
		volume = .15,
	},
	{
		key = "ArmorBucklesLight",
		name = L["BucklesLight"],
		icon = "Interface\\Icons\\inv_belt_47c",
		sounds = FoleySoundsLibrary.Metal_ArmorBuckles_Long,
		volume = .1,
	},
	{
		key = "ArmorBucklesHeavy",
		name = L["BucklesHeavy"],
		icon = "Interface\\Icons\\inv_belt_44",
		sounds = FoleySoundsLibrary.Metal_ArmorBuckles_Short,
		volume = .1,
	},
	{
		key = "YakRun",
		name = L["YakRun"],
		icon = "Interface\\Icons\\inv_belt_42b",
		sounds = FoleySoundsLibrary.YakMount_Run,
		volume = .1,
	},
	{
		key = "YakWalk",
		name = L["YakWalk"],
		icon = "Interface\\Icons\\inv_belt_robe_panprog_b_01",
		sounds = FoleySoundsLibrary.YakMount_Walk,
		volume = .1,
	},
	{
		key = "GrummleRun",
		name = L["GrummleRun"],
		icon = "Interface\\Icons\\inv_misc_bag_13",
		sounds = FoleySoundsLibrary.Grummle_Run,
		volume = .1,
	},
	{
		key = "GrummleWalk",
		name = L["GrummleWalk"],
		icon = "Interface\\Icons\\inv_misc_5potionbag_special",
		sounds = FoleySoundsLibrary.Grummle_Walk,
		volume = .1,
	},
	{
		key = "TreasureGoblin",
		name = L["TreasureGoblin"],
		icon = "Interface\\Icons\\inv_misc_coinbag_special",
		sounds = FoleySoundsLibrary.TreasureGoblinPet_Bag,
		volume = .1,
	},
};

local SoundDataLookup = {};
local SoundIconLookup = {};
local SoundVolumeLookup = {};

for _, def in ipairs(SoundDefinitions) do
	SoundDataLookup[def.key] = def.sounds;
	SoundIconLookup[def.key] = def.icon;
	SoundVolumeLookup[def.key] = def.volume or 1.0;
end

local frame;
local soundPanel;
local selectedOutfitID = nil;

local UpdateSoundPanelSelection;
local RefreshOutfitListVisuals;


local function CreateSoundOptionButton(parent, data)
	local btn = CreateFrame("Button", nil, parent)
	btn:SetSize(parent:GetWidth() - 12, 40)

	if not btn.normalTex then
		btn.normalTex = btn:CreateTexture(nil, "BACKGROUND");
		btn.normalTex:SetAllPoints();
		btn.normalTex:SetAtlas("glues-characterSelect-card-drag");
		btn.normalTex:SetAlpha(0.8);
	end

	if not btn.selectedTex then
		btn.selectedTex = btn:CreateTexture(nil, "BACKGROUND", nil, 1);
		btn.selectedTex:SetAllPoints();
		btn.selectedTex:SetAtlas("transmog-outfit-card-selected");
	end
	btn.selectedTex:SetAlpha(0)

	if not btn.icon then
		btn.icon = btn:CreateTexture(nil, "ARTWORK");
		btn.icon:SetSize(24, 24);
		btn.icon:SetPoint("LEFT", 12, 0);
		btn.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92);
	end
	btn.icon:SetTexture(data.icon)
	
	if not btn.crosshair then
		btn.crosshair = btn:CreateTexture(nil, "OVERLAY");
		btn.crosshair:SetSize(btn:GetHeight()*1.4, btn:GetHeight()*1.4);
		btn.crosshair:SetPoint("LEFT", btn, "LEFT", -8, 0);
		btn.crosshair:SetAtlas("Soulbinds_Tree_ActivateFX_DiamondArrows");
		btn.crosshair:SetTexCoord(1,0, 0,0, 1,1, 0,1);
	end
	btn.crosshair:Hide()

	if not btn.text then
		btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
		btn.text:SetPoint("LEFT", btn.icon, "RIGHT", 10, 0);
	end
	btn.text:SetText(data.name)

	btn:SetHighlightTexture("Interface\\Buttons\\UI-Listbox-Highlight", "ADD")
	
	btn.key = data.key

	btn:SetScript("OnClick", function(self)
		if not selectedOutfitID then return end
		
		local foleyDB = GetFoleyDB()
		local volumeDB = GetVolumeDB()
		
		if foleyDB and volumeDB then
			foleyDB[selectedOutfitID] = self.key;

			local defaultVol = SoundVolumeLookup[self.key] or 1.0;
			volumeDB[selectedOutfitID] = defaultVol;
			
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
			
			UpdateSoundPanelSelection();
			RefreshOutfitListVisuals();
		end
	end)

	return btn;
end

UpdateSoundPanelSelection = function()
	if not soundPanel or not selectedOutfitID then return end
	
	local outfits = C_TransmogOutfitInfo.GetOutfitsInfo()
	local outfitName = L["Outfit"]
	if outfits then
		for _, o in ipairs(outfits) do
			if o.outfitID == selectedOutfitID then
				outfitName = o.name;
				break;
			end
		end
	end
	soundPanel.header:SetText(outfitName)

	local volumeDB = GetVolumeDB()
	local currentVolume = (volumeDB and volumeDB[selectedOutfitID]) or 1.0
	if soundPanel.volumeSlider then
		soundPanel.volumeSlider.isInitializing = true;
		soundPanel.volumeSlider:SetValue(currentVolume);
		soundPanel.volumeSlider.isInitializing = false;
	end

	local soundData = {}
	local foleyDB = GetFoleyDB()
	local currentSound = (foleyDB and foleyDB[selectedOutfitID]) or "None"
	
	for _, def in ipairs(SoundDefinitions) do
		table.insert(soundData, {
			key = def.key,
			name = def.name,
			icon = def.icon,
			sounds = def.sounds,
			isSelected = (def.key == currentSound)
		})
	end
	
	if soundPanel.scrollBox then
		local dataProvider = CreateDataProvider(soundData);
		soundPanel.scrollBox:SetDataProvider(dataProvider);
	end
end

local function CreateSoundPanel(parent)
	local p = CreateFrame("Frame", nil, parent, "InsetFrameTemplate3")
	p:SetPoint("TOPRIGHT", parent.Inset, "TOPRIGHT", 0, 0)
	p:SetPoint("BOTTOMRIGHT", parent.Inset, "BOTTOMRIGHT", 0, 0)
	p:SetWidth(220)
	
	p.header = p:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	p.header:SetPoint("TOP", 0, -15)
	p.header:SetText("Select Outfit")
	
	local div = p:CreateTexture(nil, "ARTWORK")
	div:SetAtlas("transmog-setCard-transmogrified-pending-FX2")
	div:SetSize(180, 15)
	div:SetPoint("TOP", 0, -35)

	local volumeLabel = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	volumeLabel:SetPoint("TOP", div, "BOTTOM", 0, -8)
	volumeLabel:SetText("Volume")
	
	local options = Settings.CreateSliderOptions(0, 1, 0.01)
	options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value)
		return string.format("%d%%", value * 100);
	end)
	
	local volumeSlider = CreateFrame("Frame", nil, p, "MinimalSliderWithSteppersTemplate")
	volumeSlider:SetPoint("TOP", volumeLabel, "BOTTOM", 0, 0)
	volumeSlider:SetWidth(180)
	volumeSlider:Init(1.0, options.minValue, options.maxValue, options.steps, options.formatters)
	p.volumeSlider = volumeSlider
	local rightText = volumeSlider.RightText
	rightText:SetPoint("LEFT", volumeSlider, "RIGHT", -25, 25)
	
	volumeSlider:RegisterCallback("OnValueChanged", function(_, value)
		if not selectedOutfitID then return end
		if volumeSlider.isInitializing then return end
		
		local volumeDB = GetVolumeDB()
		if volumeDB then
			volumeDB[selectedOutfitID] = value;
		end
	end, volumeSlider)

	local scrollBox = CreateFrame("Frame", nil, p, "WowScrollBoxList")
	scrollBox:SetPoint("TOPLEFT", 6, -110)
	scrollBox:SetPoint("BOTTOMRIGHT", -26, 6)
	p.scrollBox = scrollBox

	local scrollBar = CreateFrame("EventFrame", nil, p, "MinimalScrollBar")
	scrollBar:SetPoint("TOPLEFT", scrollBox, "TOPRIGHT", 4, 0)
	scrollBar:SetPoint("BOTTOMLEFT", scrollBox, "BOTTOMRIGHT", 4, 0)

	local scrollView = CreateScrollBoxListLinearView()
	scrollView:SetElementInitializer("Frame", function(button, data)
		if button.content then
			button.content:Hide();
		end
		
		button.content = CreateSoundOptionButton(button, data)
		button.content:SetAllPoints()
		
		if data.isSelected then
			button.content.selectedTex:SetAlpha(1);
			button.content.crosshair:Show();
			button.content.text:SetTextColor(1, 1, 1);
		else
			button.content.selectedTex:SetAlpha(0);
			button.content.crosshair:Hide();
			button.content.text:SetTextColor(0.6, 0.6, 0.6);
		end
		
		button.content:Show();
	end)
	
	scrollView:SetElementExtent(44)
	scrollView:SetPadding(2, 2, 2, 2, 2)

	ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, scrollView)

	local dataProvider = CreateDataProvider({})
	scrollBox:SetDataProvider(dataProvider)
	
	return p
end

RefreshOutfitListVisuals = function()
	if not frame or not frame.buttons then return end
	
	local foleyDB = GetFoleyDB()
	
	for _, button in ipairs(frame.buttons) do
		if button.outfitID == selectedOutfitID then
			button.selectionTexture:Show();
			button.border:Hide();
		else
			button.selectionTexture:Hide();
			button.border:Show();
		end

		if foleyDB then
			local assignedKey = foleyDB[button.outfitID] or "None"
			local iconPath = SoundIconLookup[assignedKey] or SoundIconLookup["None"]
			
			if assignedKey == "None" or not iconPath then
				button.soundStatusIcon:Hide();
			else
				button.soundStatusIcon:SetTexture(iconPath);
				button.soundStatusIcon:Show();
			end
		end
	end
end


local function OnOutfitClick(self)
	selectedOutfitID = self.outfitID;
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	RefreshOutfitListVisuals();
	UpdateSoundPanelSelection();
end

local function CreateOutfitButton(parent, outfit, index)
	local button = CreateFrame("Button", nil, parent)
	local buttonSize = 55
	local spacing = buttonSize + 10
	button:SetSize(buttonSize, buttonSize)
	
	local col = (index - 1) % 5
	local row = math.floor((index - 1) / 5)
	button:SetPoint("TOPLEFT", 7 + (col * spacing), -7 - (row * spacing))
	
	button.icon = button:CreateTexture(nil, "BACKGROUND")
	button.icon:SetAllPoints()
	button.icon:SetTexture(outfit.icon)
	
	button.selectionTexture = button:CreateTexture(nil, "OVERLAY", nil, 2)
	button.selectionTexture:SetAllPoints()
	button.selectionTexture:SetAtlas("UI-HUD-RotationHelper-SpellbookGlow")
	button.selectionTexture:Hide()

	button.border = button:CreateTexture(nil, "OVERLAY")
	button.border:SetAtlas("transmog-outfit-card-lineGlw-purple")
	button.border:SetBlendMode("ADD")
	button.border:SetAllPoints()
	button.border:SetAlpha(0.5)

	button.soundStatusIcon = button:CreateTexture(nil, "OVERLAY", nil, 7)
	button.soundStatusIcon:SetSize(20, 20)
	button.soundStatusIcon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
	button.soundStatusIcon:Hide()
	
	button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
	
	button.outfitID = outfit.outfitID
	button.outfitName = outfit.name
	
	button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	button:SetScript("OnClick", OnOutfitClick)

	button:RegisterForDrag("LeftButton")
	button:SetScript("OnDragStart", function(self)
		C_TransmogOutfitInfo.PickupOutfit(self.outfitID);
	end)
	
	button:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(self.outfitName, 1, 1, 1)
		
		local foleyDB = GetFoleyDB()
		local currentKey = (foleyDB and foleyDB[self.outfitID]) or "None"
		
		local displayName = currentKey
		for _, def in ipairs(SoundDefinitions) do
			if def.key == currentKey then
				displayName = def.name;
				break;
			end
		end
		
		GameTooltip:AddLine(string.format(L["SoundS"],WrapTextInColorCode(displayName, "ffffffff")), 1, 0.82, 0)
		GameTooltip:AddLine(string.format(L["Click"], L["ConfigureSounds"]), 0.5, 0.5, 0.5)
		GameTooltip:AddLine(string.format(L["ClickDrag"], L["PickUpOutfit"]), 0.5, 0.5, 0.5)
		GameTooltip:Show()
	end)
	
	button:SetScript("OnLeave", GameTooltip_Hide)
	
	return button
end

local function RefreshOutfits()
	if not frame then return end
	
	for _, button in ipairs(frame.buttons) do button:Hide() end
	frame.buttons = {}
	
	local outfits = C_TransmogOutfitInfo.GetOutfitsInfo()
	
	if not outfits then return end
	
	for i, outfit in ipairs(outfits) do
		local button = CreateOutfitButton(frame.content, outfit, i);
		table.insert(frame.buttons, button);
	end
	
	if not selectedOutfitID then
		selectedOutfitID = C_TransmogOutfitInfo.GetActiveOutfitID();
	end
	
	RefreshOutfitListVisuals()
	UpdateSoundPanelSelection()
end

local function CreateMainFrame()
	frame = CreateFrame("Frame", "ArtificerOutfitPickerFrame", UIParent, "ButtonFrameTemplate")
	tinsert(UISpecialFrames, frame:GetName())
	
	--local portrait = frame.PortraitContainer.portrait
	--portrait:SetTexCoord(0.03, 1, 0.03, 1)
	--portrait:SetAtlas("transmog-icon-UI")

	ButtonFrameTemplate_HidePortrait(frame)
	ButtonFrameTemplate_HideButtonBar(frame)
	
	frame:SetTitle(string.join(" - ", L["TOC_Title"], L["OutfitSoundManager"]))
	frame:SetSize(600, 500)
	if Artificer.RestoreFramePosition then
		Artificer:RestoreFramePosition(frame, "ArtificerOutfitPickerFrame");
	else
		frame:SetPoint("CENTER");
	end
	frame:SetToplevel(true)
	frame:EnableMouse(true)
	frame:SetMovable(true)
	frame:SetClampedToScreen(true)
	frame:SetScript("OnMouseDown", function(self, button)
		self:StopMovingOrSizing();
		if button == "LeftButton" then self:StartMoving() end
		
	end)
	frame:SetScript("OnMouseUp", function(self, button)
		self:StopMovingOrSizing();
		if Artificer.SaveFramePosition then
			Artificer:SaveFramePosition(self, "ArtificerOutfitPickerFrame");
		end
	end)
	if frame.TitleContainer then
		frame.TitleContainer:SetHitRectInsets(0, 24, 0, 0)
		frame.TitleContainer:EnableMouse(true)
		frame.TitleContainer:SetMovable(true)
		frame.TitleContainer:RegisterForDrag("LeftButton")
		frame.TitleContainer:SetScript("OnMouseUp", function(self, button)
			if button == "RightButton" then
				MenuUtil.CreateContextMenu(self, function(owner, rootDescription)
					rootDescription:CreateTitle(L["OutfitSoundManager"])
					
					local function IsLocked() return not frame:IsMovable() end
					local function ToggleLock()
						frame:SetMovable(not frame:IsMovable())
					end
					rootDescription:CreateCheckbox(L["LockFrame"], IsLocked, ToggleLock)
					
					rootDescription:CreateButton(L["ResetPosition"], function()
						frame:ClearAllPoints();
						frame:SetPoint("CENTER");
						if Artificer.SaveFramePosition then
							Artificer:SaveFramePosition(frame, "ArtificerOutfitPickerFrame");
						end
					end)
					
					local submenu = rootDescription:CreateButton(L["UIScale"])
					local presets = {1.4, 1.2, 1.0, 0.8, 0.6};
					
					for _, scale in ipairs(presets) do
						local text = string.format("%d%%", scale * 100);
						submenu:CreateRadio(text, function() return math.abs(frame:GetScale() - scale) < 0.01 end, function()
							frame:SetScale(scale);
						end)
					end
				end)
			end
		end)
		frame.TitleContainer:SetScript("OnDragStart", function(self)
			frame:StopMovingOrSizing();
			if frame:IsMovable() then
				frame:StartMoving();
			end
		end)
		frame.TitleContainer:SetScript("OnDragStop", function(self)
			frame:StopMovingOrSizing();
			Artificer:SaveFramePosition(frame, "ArtificerOutfitPickerFrame");
		end)
	end
	frame:Hide()
	local inset = frame.Inset
	inset:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -28)
	inset:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, 3)
	
	frame:SetScript("OnHide", function()
		if Artificer and Artificer.SettingsFrame.OutfitBarTab then
			Artificer.SettingsFrame.OutfitBarTab.SelectedTexture:Hide();
		end
		PlaySound(74423)
	end)
	frame:SetScript("OnShow", function()
		if Artificer and Artificer.SettingsFrame.OutfitBarTab then
			Artificer.SettingsFrame.OutfitBarTab.SelectedTexture:Show();
		end
		PlaySound(74421)
	end)
	
	local scrollBorder = CreateFrame("Frame", nil, frame, "InsetFrameTemplate3")
	scrollBorder:SetPoint("TOPLEFT", inset, "TOPLEFT", 0, 0)
	scrollBorder:SetPoint("BOTTOMLEFT", inset, "BOTTOMLEFT", 0, 0)
	scrollBorder:SetWidth(360)
	frame.ScrollBorder = scrollBorder
	
	local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "ScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", scrollBorder, "TOPLEFT", 6, -8)
	scrollFrame:SetPoint("BOTTOMRIGHT", scrollBorder, "BOTTOMRIGHT", -28, 3)
	
	local content = CreateFrame("Frame", nil, scrollFrame)
	content:SetSize(330, 1)
	scrollFrame:SetScrollChild(content)
	
	frame.scrollFrame = scrollFrame
	frame.content = content
	frame.buttons = {}
	
	soundPanel = CreateSoundPanel(frame)
	
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("TRANSMOG_DISPLAYED_OUTFIT_CHANGED")
	frame:SetScript("OnEvent", function()
		local activeID = C_TransmogOutfitInfo.GetActiveOutfitID()
		if activeID then
			selectedOutfitID = activeID;
			RefreshOutfitListVisuals();
			UpdateSoundPanelSelection();
		end
	end)
	
	return frame
end

local function SoundSelector()
	local foleyDB = GetFoleyDB()
	local volumeDB = GetVolumeDB()

	local activeOutfitID = C_TransmogOutfitInfo.GetActiveOutfitID()
	if not foleyDB or not activeOutfitID then return end

	local soundKey = foleyDB[activeOutfitID]
	if not soundKey then return end

	local soundData = SoundDataLookup[soundKey]
	if not soundData then return end

	local volume = (volumeDB and volumeDB[activeOutfitID]) or 1.0
	
	if type(soundData) == "table" then
		local fileID
		
		-- don't play the same file twice in a row it hurts my brain
		if #soundData > 1 then
			fileID = lastPlayedFileID
	
			while fileID == lastPlayedFileID do
				fileID = soundData[math.random(1, #soundData)]
			end
		else
			fileID = soundData[1]
		end
		
		lastPlayedFileID = fileID
		
		C_EncounterEvents.SetEventSound(FOLEY_EVENT_ID, FOLEY_TRIGGER_ID, { file = fileID, volume = volume })
		C_EncounterEvents.PlayEventSound(FOLEY_EVENT_ID, FOLEY_TRIGGER_ID)
		C_EncounterEvents.SetEventSound(FOLEY_EVENT_ID, FOLEY_TRIGGER_ID, nil)
	end
end

local function FallingChecker()
	local currentMoving = IsPlayerMoving()
	local isFalling = IsFalling()
	local isMounted = IsMounted()
	local isSwimming = IsSwimming()
	local isSubmerged = IsSubmerged()
	if not isFalling and not currentMoving and not isMounted and not isSwimming and not isSubmerged then
		SoundSelector();
	end
end

--[[
	the vanilla foley sound frequency was less frequent, i think this is approximately every .4 sec avg
	i wanted to try to sync this up to a "foot step" sound, approximately when the body would move
	i liked how this sounded and kind of stuck with it. i might add options later to tune these knobs
	but that would be a lot more work for what i've already put here (and i'd have to find ui space)
	for now, this seems to work. it also has the benefit of speeding up with movement speed
	that means if you do sprint, it should be more frequent. if you walk, it should be less, and so forth
	it caps off so that it can't just, you know, produce insane sounds happening if you dismount and retain speed
	it's purposefully not meant to play while mounted, falling, swimming, etc. because you're largely not moving
	or these just otherwise wouldn't be "hearable" in those environments
--]]
local function CheckPlayerMovement()
	local unitSpeed = select(1, GetUnitSpeed("player"))
	local speedMult = 1
	local speedFrequency = 7
	local scalingFactor = .3
	local offset = 0.7
	local multMin = .85
	local multMax = 1.54
	local basicMult = .37

	if unitSpeed and unitSpeed ~= 0 then
		speedMult = (speedFrequency / unitSpeed) * scalingFactor + offset;
		if speedMult < multMin then speedMult = multMin end;
		if speedMult > multMax then speedMult = multMax end;
	end

	local currentMoving = IsPlayerMoving()
	local isFalling = IsFalling()
	local isMounted = IsMounted()
	local isSwimming = IsSwimming()
	local isSubmerged = IsSubmerged()
	
	if isFalling then
		C_Timer.After(.35, FallingChecker);
	end
	
	if currentMoving and not isFalling and not isMounted and not isSwimming and not isSubmerged then
		SoundSelector();
	end
	
	C_Timer.After(basicMult*speedMult, CheckPlayerMovement)
end

CheckPlayerMovement()

local loader = CreateFrame("Frame")
loader:RegisterEvent("PLAYER_LOGIN")
loader:SetScript("OnEvent", function()
	if Artificer.CreateSettingsUI then
		hooksecurefunc(Artificer, "CreateSettingsUI", function()
			local parent = Artificer.SettingsFrame
			if not parent then return end
			
			if parent.OutfitBarTab then return end

			local tab = CreateFrame("CheckButton", nil, parent, "LargeSideTabButtonTemplate")
			tab:SetPoint("TOPLEFT", parent, "TOPRIGHT", 0, -150)

			tab.Icon:SetAtlas("Crosshair_Transmogrify_128") -- i could probably make a "gold" version to fit artificer color theme later
			tab.Icon:SetSize(tab:GetWidth()-10, tab:GetWidth()-10)

			tab:SetScript("OnClick", function(self)
				if not frame then frame = CreateMainFrame() end
				if frame and frame:IsVisible() then
					frame:Hide();
				else
					RefreshOutfits();
					frame:Show();
				end
			end)

			tab:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				GameTooltip:SetText(L["OutfitSoundManager"]);
				GameTooltip:AddLine(L["OutfitSoundManagerTT"], 1, 1, 1, true);
				GameTooltip:Show();
			end)
			tab:SetScript("OnLeave", GameTooltip_Hide)

			tab.SelectedTexture:Hide()

			parent.OutfitBarTab = tab
		end)
	end
end)