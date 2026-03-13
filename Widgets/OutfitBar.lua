local addonName, Artificer = ...;

local L = Artificer.L;

local FOLEY_EVENT_ID = 8; -- apparently isn't used by anything atm so can probably safely nuke this for now
-- if this interferes with anything, blame Meo. he told me thjis event ID was safe
local FOLEY_TRIGGER_ID = 0;
local lastPlayedFileID = nil;
local outfitSpellID = 1247613;

--[[
Action Bar 1 (page 1)					ActionButton[1-12]					001 - 012
Action Bar 1 (page 2, unused?)			ActionButton[1-12]					013 - 024
Action Bar 4							MultiBarRightButton[1-12]			025 - 036
Action Bar 5							MultiBarLeftButton[1-12]			037 - 048
Action Bar 3							MultiBarBottomRightButton[1-12]		049 - 060
Action Bar 2							MultiBarBottomLeftButton[1-12]		061 - 072
Class specific																073 - 120

	73 - 84 - warrior battle stance
	85 - 96 - warrior battle stance
	97 - 108 - warrior battle stance

	73 - 84 - druid cat
	85 - 96 - druid prowl
	97 - 108 - druid bear
	109 - 120 - druid moonkin

	73 - 84 - rogue stealth
	85 - 96 - rogue shadow dance

	73 - 84 - priest shadowform

	121 - 132 - target possessed

Action Bar 1 (page 1, skyriding)		ActionButton[1-12]					121 - 132
Unknown (complains about totems?)											133 - 144

	133 - "fire totem slot"
	134 - "earth totem slot"
	135 - "water totem slot"
	136 - "air totem slot"
	137 - "fire totem slot"
	138 - "earth totem slot"
	139 - "water totem slot"
	140 - "air totem slot"
	141 - "fire totem slot"
	142 - "earth totem slot"
	143 - "water totem slot"
	144 - "air totem slot"

Action Bar 6							MultiBar5Button[1-12]				145 - 156
Action Bar 7							MultiBar6Button[1-12]				157 - 168
Action Bar 8							MultiBar7Button[1-12]				169 - 180
]]

local _, CLASS = UnitClass("player");
local OUTFIT_SLOT = (CLASS == "DRUID" and 130 or 118); -- use what OPie does for this so it doesn't just nuke their stuff

local function YeetCursorSounds()
	MuteSoundFile(567489)
	MuteSoundFile(567524)
	RunNextFrame(function()
		UnmuteSoundFile(567489);
		UnmuteSoundFile(567524);
	end)
end

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
	Metal_Chain_Maw = { -- PlaySound(267379)
		3745490, 3745492, 3745494, 3745496, 3745498,
		3745500, 3745502, 3745504, 3745506, 3745508,
		3745510, 3745512, 3745514, 3745516, 3745518,
		3745520,
	},
	Wildhammer = { -- PlaySound(259880)
		4611458, 4611460, 4611462, 4611464, 4611466,
		4611468, 4611470, 4611472, 4611474, 4611476,
		4611478,
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
	{
		key = "Metal_Chain_Maw",
		name = L["MetalChainMaw"],
		icon = "Interface\\Icons\\inv_mail_mawraid_d_01_chest",
		sounds = FoleySoundsLibrary.Metal_Chain_Maw,
		volume = .04,
	},
	{
		key = "Wildhammer",
		name = L["Wildhammer"],
		icon = "Interface\\Icons\\inv_misc_tabard_wildhammerclan",
		sounds = FoleySoundsLibrary.Wildhammer,
		volume = .08,
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

local ArtiOFFrame;
local soundPanel;
local selectedOutfitID = nil;

local UpdateSoundPanelSelection;
local RefreshOutfitListVisuals;
local UpdateOutfitCooldowns;


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
			
			--PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
			
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
	if not ArtiOFFrame or not ArtiOFFrame.buttons then return end
	
	local foleyDB = GetFoleyDB()
	local activeOutfitID = C_TransmogOutfitInfo.GetActiveOutfitID()
	
	for _, button in ipairs(ArtiOFFrame.buttons) do
		if button.outfitID == selectedOutfitID then
			button.selectionTexture:Show();
			button.border:Hide();
		else
			button.selectionTexture:Hide();
			button.border:Show();
		end

		if button.outfitID == activeOutfitID then
			button.activeHighlight:Show();
		else
			button.activeHighlight:Hide();
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

		if button.lockOverlay then
			local isLocked = C_TransmogOutfitInfo.IsLockedOutfit(button.outfitID)
			if isLocked then
				button.lockOverlay.Shine:Show();
				if not button.lockOverlay.Anim:IsPlaying() then
					button.lockOverlay.Anim:Play();
				end
				button.lockOverlay:Show();
			else
				button.lockOverlay.Anim:Stop();
				button.lockOverlay.Shine:Hide();
				button.lockOverlay:Hide();
			end
		end
	end
end

UpdateOutfitCooldowns = function()
	if InCombatLockdown() or not ArtiOFFrame or not ArtiOFFrame.buttons then return end

	local SCDI = C_Spell.GetSpellCooldown(outfitSpellID)
	if issecretvalue(SCDI) or issecretvalue(SCDI.startTime) or issecretvalue(SCDI.duration) then return end


	for _, button in ipairs(ArtiOFFrame.buttons) do
		if button.cooldown then
			if SCDI.startTime and SCDI.startTime > 0 and SCDI.duration and SCDI.duration > 0 then
				button.cooldown:SetCooldown(SCDI.startTime, SCDI.duration);
			else
				button.cooldown:Clear();
			end
		end
	end
end

local function CreateOutfitButton(parent, outfit, index)
	local button = CreateFrame("Button", nil, parent, "SecureActionButtonTemplate")
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

	button.activeHighlight = button:CreateTexture(nil, "OVERLAY", nil, 6)
	button.activeHighlight:SetAllPoints()
	button.activeHighlight:SetAtlas("transmog-gearSlot-transmogrified-HL")
	button.activeHighlight:SetAlpha(0.75)
	button.activeHighlight:SetTexCoord(.825,.175,.825,.175)
	button.activeHighlight:Hide()

	button.cooldown = CreateFrame("Cooldown", nil, button, "CooldownFrameTemplate")
	button.cooldown:SetAllPoints()
	button.cooldown:SetDrawEdge(true)
	button.cooldown:SetHideCountdownNumbers(true)
	button.cooldown:SetFrameLevel(button:GetFrameLevel() + 5)

	local lockOverlay = CreateFrame("Frame", nil, button)
	lockOverlay:SetAllPoints()
	lockOverlay:SetFrameLevel(button:GetFrameLevel() + 6)

	local shine = lockOverlay:CreateTexture(nil, "OVERLAY", nil, 0)
	shine:SetAtlas("UI-HUD-ActionBar-PetAutoCast-Ants", false)
	shine:SetBlendMode("BLEND")
	shine:SetPoint("TOPLEFT", lockOverlay, "TOPLEFT", -10, 10)
	shine:SetPoint("BOTTOMRIGHT", lockOverlay, "BOTTOMRIGHT", 10, -10)

	local mask = lockOverlay:CreateMaskTexture(nil, "OVERLAY")
	mask:SetAtlas("UI-HUD-ActionBar-PetAutoCast-Mask")
	mask:SetPoint("TOPLEFT", lockOverlay, "TOPLEFT", 4, -4)
	mask:SetPoint("BOTTOMRIGHT", lockOverlay, "BOTTOMRIGHT", -4, 4)
	shine:AddMaskTexture(mask)

	mask.t = lockOverlay:CreateMaskTexture(nil, "OVERLAY", nil, 0)
	mask.t:SetPoint("TOPLEFT", lockOverlay, "TOPLEFT", 4, -4)
	mask.t:SetPoint("BOTTOMRIGHT", lockOverlay, "BOTTOMRIGHT", -4, 4)
	mask.t:SetTexture(4733159, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	shine:AddMaskTexture(mask.t)

	local anim = shine:CreateAnimationGroup()
	anim:SetLooping("REPEAT")
	local rotation = anim:CreateAnimation("Rotation")
	rotation:SetDuration(4)
	rotation:SetOrder(1)
	rotation:SetDegrees(-360)
	rotation:SetOrigin("CENTER", 0, 0)

	local corners = lockOverlay:CreateTexture(nil, "OVERLAY", nil, 1)
	corners:SetAtlas("UI-HUD-ActionBar-PetAutoCast-Corners", false)
	corners:SetAllPoints()

	lockOverlay.Shine = shine
	lockOverlay.Anim = anim
	lockOverlay.Corners = corners
	lockOverlay:Hide()

	button.lockOverlay = lockOverlay

	
	RunNextFrame(function()
		if button and button:GetParent() then
			local base = button:GetFrameLevel();
			button.cooldown:SetFrameLevel(base + 5);
			button.lockOverlay:SetFrameLevel(base + 6);
		end
	end)

	button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

	button.outfitID  = outfit.outfitID
	button.outfitName = outfit.name

	button:SetAttribute("outfit-id", outfit.outfitID)
	button:SetAttribute("action", OUTFIT_SLOT)
	button:SetAttribute("useOnKeyDown", false)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	SecureHandlerWrapScript(button, "OnClick", button, 'return button')

	local bingus_

	button:SetScript("PreClick", function(self)
		local att_outfitID = self:GetAttribute("outfit-id")
		if InCombatLockdown() or not att_outfitID then return; end

		YeetCursorSounds()
		ClearCursor()
		C_TransmogOutfitInfo.PickupOutfit(att_outfitID)

		local cursorType, cursorID = GetCursorInfo()
		if cursorType == "outfit" and cursorID == att_outfitID then
			bingus_ = (GetActionInfo(OUTFIT_SLOT) == nil);
			PlaceAction(OUTFIT_SLOT);
			local actionType, actionID = GetActionInfo(OUTFIT_SLOT);
			if actionType == "outfit" and actionID == att_outfitID then
				self:SetAttribute("type", "action");
			end
		else
			ClearCursor();
		end
	end)

	button:SetScript("PostClick", function(self)
		self:SetAttribute("type", nil)
		if InCombatLockdown() or bingus_ == nil then return end

		if bingus_ == true then
			ClearCursor();
			PickupAction(OUTFIT_SLOT);
			ClearCursor();
		else
			PlaceAction(OUTFIT_SLOT);
			ClearCursor();
		end
		bingus_ = nil

		selectedOutfitID = self:GetAttribute("outfit-id")
		--PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		RefreshOutfitListVisuals()
		UpdateSoundPanelSelection()
	end)

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

		GameTooltip:AddLine(string.format(L["SoundS"], WrapTextInColorCode(displayName, "ffffffff")), 1, 0.82, 0)
		GameTooltip:AddLine(string.format(L["LeftClick"], L["EquipOutfit"]), 0, 1, 0)
		GameTooltip:AddLine(string.format(L["RightClick"], L["LockAppearance"]), 0, 1, 0)
		GameTooltip:AddLine(string.format(L["ClickDrag"], L["PickUpOutfit"]), 0, 1, 0)
		GameTooltip:Show()
	end)

	button:SetScript("OnLeave", GameTooltip_Hide)

	return button
end

local function RefreshOutfits()
	if not ArtiOFFrame then return end
	
	for _, button in ipairs(ArtiOFFrame.buttons) do button:Hide() end
	ArtiOFFrame.buttons = {}
	
	local outfits = C_TransmogOutfitInfo.GetOutfitsInfo()
	
	if not outfits then return end
	
	for i, outfit in ipairs(outfits) do
		local button = CreateOutfitButton(ArtiOFFrame.content, outfit, i);
		table.insert(ArtiOFFrame.buttons, button);
	end
	
	if not selectedOutfitID then
		selectedOutfitID = C_TransmogOutfitInfo.GetActiveOutfitID();
	end
	
	RefreshOutfitListVisuals()
	UpdateSoundPanelSelection()
end

local function CreateMainFrame()
	ArtiOFFrame = CreateFrame("Frame", "ArtificerOutfitPickerFrame", UIParent, "ButtonFrameTemplate")
	tinsert(UISpecialFrames, ArtiOFFrame:GetName())
	
	--local portrait = ArtiOFFrame.PortraitContainer.portrait
	--portrait:SetTexCoord(0.03, 1, 0.03, 1)
	--portrait:SetAtlas("transmog-icon-UI")

	ButtonFrameTemplate_HidePortrait(ArtiOFFrame)
	ButtonFrameTemplate_HideButtonBar(ArtiOFFrame)
	
	ArtiOFFrame:SetTitle(string.join(" - ", L["TOC_Title"], L["OutfitManager"]))
	ArtiOFFrame:SetSize(600, 500)
	ArtiOFFrame:SetMovable(true)
	if Artificer.RestoreFrameSettings then
		Artificer:RestoreFrameSettings(ArtiOFFrame, "ArtificerOutfitPickerFrame");
	else
		if Artificer.RestoreFramePosition then
			Artificer:RestoreFramePosition(ArtiOFFrame, "ArtificerOutfitPickerFrame");
		else
			ArtiOFFrame:SetPoint("CENTER");
		end
	end
	ArtiOFFrame:SetToplevel(true)
	ArtiOFFrame:EnableMouse(true)
	if ArtiOFFrame:IsMovable() == nil then ArtiOFFrame:SetMovable(true) end
	ArtiOFFrame:SetClampedToScreen(true)
	ArtiOFFrame:SetScript("OnMouseDown", function(self, button)
		self:StopMovingOrSizing();
		if button == "LeftButton" and self:IsMovable() then self:StartMoving() end
		
	end)
	ArtiOFFrame:SetScript("OnMouseUp", function(self, button)
		self:StopMovingOrSizing();
		if Artificer.SaveFramePosition then
			Artificer:SaveFramePosition(self, "ArtificerOutfitPickerFrame");
		end
	end)
	if ArtiOFFrame.TitleContainer then
		ArtiOFFrame.TitleContainer:SetHitRectInsets(0, 24, 0, 0)
		ArtiOFFrame.TitleContainer:EnableMouse(true)
		ArtiOFFrame.TitleContainer:SetMovable(ArtiOFFrame:IsMovable())
		ArtiOFFrame.TitleContainer:RegisterForDrag("LeftButton")
		ArtiOFFrame.TitleContainer:SetScript("OnMouseUp", function(self, button)
			if button == "RightButton" then
				MenuUtil.CreateContextMenu(self, function(owner, rootDescription)
					rootDescription:CreateTitle(L["OutfitSoundManager"])
					
					local function IsLocked() return not ArtiOFFrame:IsMovable() end
					local function ToggleLock()
						local locked = not ArtiOFFrame:IsMovable();
						ArtiOFFrame:SetMovable(locked);
						ArtiOFFrame.TitleContainer:SetMovable(locked);
						if Artificer.SaveFrameSetting then
							Artificer:SaveFrameSetting("ArtificerOutfitPickerFrame", "locked", not locked);
						end
					end
					rootDescription:CreateCheckbox(L["LockFrame"], IsLocked, ToggleLock)
					
					rootDescription:CreateButton(L["ResetPosition"], function()
						ArtiOFFrame:ClearAllPoints();
						ArtiOFFrame:SetPoint("CENTER");
						if Artificer.SaveFramePosition then
							Artificer:SaveFramePosition(ArtiOFFrame, "ArtificerOutfitPickerFrame");
						end
					end)
					
					local submenu = rootDescription:CreateButton(L["UIScale"])
					local presets = {1.4, 1.2, 1.0, 0.8, 0.6};
					
					for _, scale in ipairs(presets) do
						local text = string.format("%d%%", scale * 100);
						submenu:CreateRadio(text, function() return math.abs(ArtiOFFrame:GetScale() - scale) < 0.01 end, function()
							ArtiOFFrame:SetScale(scale);
							if Artificer.SaveFrameSetting then
								Artificer:SaveFrameSetting("ArtificerOutfitPickerFrame", "scale", scale);
							end
						end)
					end
				end)
			end
		end)
		ArtiOFFrame.TitleContainer:SetScript("OnDragStart", function(self)
			ArtiOFFrame:StopMovingOrSizing();
			if ArtiOFFrame:IsMovable() then
				ArtiOFFrame:StartMoving();
			end
		end)
		ArtiOFFrame.TitleContainer:SetScript("OnDragStop", function(self)
			ArtiOFFrame:StopMovingOrSizing();
			Artificer:SaveFramePosition(ArtiOFFrame, "ArtificerOutfitPickerFrame");
		end)
	end
	ArtiOFFrame:Hide()
	local inset = ArtiOFFrame.Inset
	inset:SetPoint("TOPLEFT", ArtiOFFrame, "TOPLEFT", 8, -28)
	inset:SetPoint("BOTTOMRIGHT", ArtiOFFrame, "BOTTOMRIGHT", -3, 3)

	ArtiOFFrame.BgIcon = ArtiOFFrame:CreateTexture(nil, "BACKGROUND", nil, 1)
	ArtiOFFrame.BgIcon:SetPoint("CENTER", 0, 0)
	ArtiOFFrame.BgIcon:SetSize(inset:GetHeight()*.75, inset:GetHeight()*.75)
	ArtiOFFrame.BgIcon:SetTexture("Interface\\AddOns\\Artificer\\Textures\\ArtificerIcon_Small.blp")
	ArtiOFFrame.BgIcon:SetDesaturated(true)
	ArtiOFFrame.BgIcon:SetVertexColor(.99, .71, .96, 0.2)
	
	ArtiOFFrame:SetScript("OnHide", function()
		if Artificer and Artificer.SettingsFrame and Artificer.SettingsFrame.OutfitBarTab then
			Artificer.SettingsFrame.OutfitBarTab.SelectedTexture:Hide();
		end
		PlaySound(62543);
	end)
	ArtiOFFrame:SetScript("OnShow", function()
		if Artificer and Artificer.SettingsFrame and Artificer.SettingsFrame.OutfitBarTab then
			Artificer.SettingsFrame.OutfitBarTab.SelectedTexture:Show();
		end
		RefreshOutfitListVisuals();
		PlaySound(25738);
	end)
	
	local scrollBorder = CreateFrame("Frame", nil, ArtiOFFrame, "InsetFrameTemplate3")
	scrollBorder:SetPoint("TOPLEFT", inset, "TOPLEFT", 0, 0)
	scrollBorder:SetPoint("BOTTOMLEFT", inset, "BOTTOMLEFT", 0, 0)
	scrollBorder:SetWidth(360)
	ArtiOFFrame.ScrollBorder = scrollBorder
	
	local scrollFrame = CreateFrame("ScrollFrame", nil, ArtiOFFrame, "ScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", scrollBorder, "TOPLEFT", 6, -8)
	scrollFrame:SetPoint("BOTTOMRIGHT", scrollBorder, "BOTTOMRIGHT", -28, 3)
	
	local content = CreateFrame("Frame", nil, scrollFrame)
	content:SetSize(330, 1)
	scrollFrame:SetScrollChild(content)
	
	ArtiOFFrame.scrollFrame = scrollFrame
	ArtiOFFrame.content = content
	ArtiOFFrame.buttons = {}
	
	soundPanel = CreateSoundPanel(ArtiOFFrame)
	
	ArtiOFFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	ArtiOFFrame:RegisterEvent("TRANSMOG_DISPLAYED_OUTFIT_CHANGED")
	ArtiOFFrame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
	ArtiOFFrame:SetScript("OnEvent", function()
		if ArtiOFFrame:IsVisible() then
			local activeID = C_TransmogOutfitInfo.GetActiveOutfitID();
			if activeID then
				selectedOutfitID = activeID;
				RefreshOutfitListVisuals();
				UpdateSoundPanelSelection();
			end
		end
	end)
	
	return ArtiOFFrame
end
--[[
	-- this event can be so unbelievably taxing and quite frankly isn't necessary to show the CDs properly. leaving a note here because Mistakes Were Made(tm)
EventRegistry:RegisterFrameEventAndCallback("UNIT_SPELLCAST_SUCCEEDED", function(event, unitTarget, _, spellID)
	if ArtiOFFrame and ArtiOFFrame:IsVisible() and not issecretvalue(unitTarget) and unitTarget == "player" and not issecretvalue(spellID) and spellID == outfitSpellID then
		UpdateOutfitCooldowns();
		return;
	end
end)
--]]

EventRegistry:RegisterFrameEventAndCallback("SPELL_UPDATE_COOLDOWN", function(event, spellID)
	if ArtiOFFrame and ArtiOFFrame:IsVisible() and not issecretvalue(spellID) and spellID == outfitSpellID then
		UpdateOutfitCooldowns();
		return;
	end
end)


function Artificer:ToggleOutfitSoundUI()
	if not ArtiOFFrame then ArtiOFFrame = CreateMainFrame() end
	if ArtiOFFrame:IsVisible() then
		ArtiOFFrame:Hide();
	else
		if InCombatLockdown() then return end
		RefreshOutfits();
		ArtiOFFrame:Show();
	end
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
	local formID = GetShapeshiftFormID()
	local isShapeshifted = formID and formID ~= 28 -- 28 shadowform

	if not isFalling and not currentMoving and not isMounted and not isSwimming and not isSubmerged and not isShapeshifted then
		SoundSelector();
	end
end

-- play a sound when leaping
hooksecurefunc("JumpOrAscendStart", function()
	local isMounted = IsMounted()
	local isSwimming = IsSwimming()
	local isSubmerged = IsSubmerged()
	local formID = GetShapeshiftFormID()
	local isShapeshifted = formID and formID ~= 28 -- 28 is shadowform

	-- checking `not IsFalling()` prevents the sound from triggering when hitting the jump key mid-air
	if not isMounted and not isSwimming and not isSubmerged and not isShapeshifted and not IsFalling() then
		SoundSelector();
	end
end)

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
	local formID = GetShapeshiftFormID()
	local isShapeshifted = formID and formID ~= 28 -- 28 shadowform
	
	if isFalling then
		C_Timer.After(.35, FallingChecker);
	end
	
	if currentMoving and not isFalling and not isMounted and not isSwimming and not isSubmerged and not isShapeshifted then
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
				if not ArtiOFFrame then ArtiOFFrame = CreateMainFrame() end
				if ArtiOFFrame and ArtiOFFrame:IsVisible() then
					ArtiOFFrame:Hide();
				else
					if InCombatLockdown() then
						return;
					else
						RefreshOutfits();
						ArtiOFFrame:Show();
					end
				end
			end)

			tab:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				GameTooltip:SetText(L["OutfitManager"]);
				GameTooltip:AddLine(L["OutfitManagerTT"], 1, 1, 1, true);
				GameTooltip:Show();
			end)
			tab:SetScript("OnLeave", GameTooltip_Hide)

			tab.SelectedTexture:Hide()

			parent.OutfitBarTab = tab
		end)
	end
end)

EventRegistry:RegisterFrameEventAndCallback("PLAYER_REGEN_DISABLED", function()
	if ArtiOFFrame and ArtiOFFrame:IsVisible() then
		ArtiOFFrame:Hide();
	end
end)