local addonName, Artificer = ...;

local L = Artificer.L;

local function IsModuleEnabled()
	return Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.ProfessionsBook;
end

local function GetProfDB()
	local db = Artificer_DB and Artificer_DB.ProfessionsBook or (Artificer.Defaults and Artificer.Defaults.ProfessionsBook);
	if db then
		if db.iconStyle == nil then db.iconStyle = "icon"; end
		if db.hideCustomIcons == nil then db.hideCustomIcons = false; end
		if db.hideDefaultIcons == nil then db.hideDefaultIcons = true; end
		if db.Colors == nil then
			db.Colors = CopyTable(Artificer.Defaults.ProfessionsBook.Colors);
		end
		return db;
	end
	return CopyTable(Artificer.Defaults.ProfessionsBook);
end

local frameMaxSlots = {
	["PrimaryProfession1"] = 3,
	["PrimaryProfession2"] = 3,
	["SecondaryProfession1"] = 2,
	["SecondaryProfession2"] = 1,
};

local slotIDToName = {
	[20] = "Prof0ToolSlot", [21] = "Prof0Gear0Slot", [22] = "Prof0Gear1Slot",
	[23] = "Prof1ToolSlot", [24] = "Prof1Gear0Slot", [25] = "Prof1Gear1Slot",
	[26] = "CookingToolSlot", [27] = "CookingGear0Slot",
	[28] = "FishingToolSlot",
};


-- the knowledge points are mostly "borrowed" from Plumber functionality, since i kind of obscure its point badge with my rework
-- if an API from Plumber gets added or something i'll use that instead, but until then RIP
local primaryFrameToProfessionIndex = {
	["PrimaryProfession1"] = 1,
	["PrimaryProfession2"] = 2,
};

local GetSpecTabIDsForSkillLine = C_ProfSpecs and C_ProfSpecs.GetSpecTabIDsForSkillLine;
local GetConfigIDForSkillLine = C_ProfSpecs and C_ProfSpecs.GetConfigIDForSkillLine;
local GetTabInfo = C_ProfSpecs and C_ProfSpecs.GetTabInfo;
local GetSpendCurrencyForPath = C_ProfSpecs and C_ProfSpecs.GetSpendCurrencyForPath;
local GetTreeCurrencyInfo = C_Traits and C_Traits.GetTreeCurrencyInfo;
local GetNodeInfo = C_Traits and C_Traits.GetNodeInfo;
local GetTreeNodes = C_Traits and C_Traits.GetTreeNodes;
local CanPurchaseRank = C_Traits and C_Traits.CanPurchaseRank;

local function GetPrimaryProfessionSkillLine(index)
	local prof = select(index, GetProfessions());
	if prof then
		local subcategoryName = select(11, GetProfessionInfo(prof));
		if not subcategoryName or subcategoryName == "" then return; end

		if C_TradeSkillUI and C_TradeSkillUI.GetAllProfessionTradeSkillLines and C_TradeSkillUI.GetProfessionInfoBySkillLineID then
			local skillLines = C_TradeSkillUI.GetAllProfessionTradeSkillLines();
			for _, skillLine in ipairs(skillLines) do
				local info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLine);
				if info and info.professionName == subcategoryName then
					return skillLine;
				end
			end
		end
	end
end

local function GetProfessionUnspentPoints(index)
	if not (GetConfigIDForSkillLine and GetSpecTabIDsForSkillLine and GetTabInfo and GetSpendCurrencyForPath and GetTreeCurrencyInfo and GetNodeInfo and GetTreeNodes and CanPurchaseRank) then
		return;
	end

	local skillLine = GetPrimaryProfessionSkillLine(index);
	if not skillLine then return; end

	local configID = GetConfigIDForSkillLine(skillLine);
	if not configID then return; end

	local tabTreeIDs = GetSpecTabIDsForSkillLine(skillLine);
	if not tabTreeIDs then return; end

	local total = 0;
	local anyPurchasableNode = false;
	local tabCurrencyCount = {};

	for _, treeID in ipairs(tabTreeIDs) do
		local tabInfo = GetTabInfo(treeID);
		if tabInfo then
			local tabSpendCurrency = GetSpendCurrencyForPath(tabInfo.rootNodeID);
			if tabSpendCurrency and tabCurrencyCount[tabSpendCurrency] == nil then
				local treeCurrencyInfo = GetTreeCurrencyInfo(configID, treeID, false) or {};
				local currencyCount = 0;
				for _, treeCurrency in ipairs(treeCurrencyInfo) do
					if treeCurrency.traitCurrencyID == tabSpendCurrency then
						currencyCount = treeCurrency.quantity or 0;
						break;
					end
				end
				tabCurrencyCount[tabSpendCurrency] = currencyCount;
				total = total + currencyCount;
			end
		end

		local nodeIDs = GetTreeNodes(treeID) or {};
		for _, nodeID in ipairs(nodeIDs) do
			local nodeInfo = GetNodeInfo(configID, nodeID);
			if nodeInfo and nodeInfo.isVisible then
				local activeEntryID = nodeInfo.activeEntry and nodeInfo.activeEntry.entryID or nil;
				if CanPurchaseRank(configID, nodeID, activeEntryID) then
					anyPurchasableNode = true;
				end
			end
		end
	end

	if anyPurchasableNode then
		return total;
	end
end

local UnspentPointsBadgeMixin = {};
do
	function UnspentPointsBadgeMixin:SetPoints(points)
		if points and points > 0 then
			self.points = points;
			local displayText = points;
			if points > 99 then
				displayText = "99+";
			end
			self.Text:SetText(displayText);
			self:Show();
		else
			self.points = 0;
			self:Hide();
		end
	end

	function UnspentPointsBadgeMixin:OnEnter()
		if not (self.points and self.points > 0) then return; end
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetText(PROFESSIONS_SPECIALIZATION_UNSPENT_POINTS, 1, 1, 1, 1, true);
		local format = L["ProfBook_UnspentKnowledgeTooltipFormat"];
		if format then
			GameTooltip:AddLine(format:format(self.points), 1, 0.82, 0, true);
		else
			GameTooltip:AddLine(self.points, 1, 0.82, 0);
		end
		GameTooltip:Show();
	end

	function UnspentPointsBadgeMixin:OnLeave()
		GameTooltip:Hide();
	end
end

local function CreateUnspentPointsBadge(parent)
	local badge = CreateFrame("Frame", nil, parent);
	Mixin(badge, UnspentPointsBadgeMixin);
	badge:SetSize(22, 22);
	badge:SetPoint("CENTER", parent, "BOTTOM", 0, 0);
	badge:SetFrameLevel(parent:GetFrameLevel() + 5);

	badge.Background = badge:CreateTexture(nil, "ARTWORK");
	badge.Background:SetAllPoints();
	badge.Background:SetAtlas("transmog-gearSlot-disabled-small");

	badge.Text = badge:CreateFontString(nil, "OVERLAY", "TextStatusBarText");
	badge.Text:SetJustifyH("CENTER");
	badge.Text:SetPoint("CENTER", badge, "CENTER", 0, 0);

	badge:SetScript("OnEnter", badge.OnEnter);
	badge:SetScript("OnLeave", badge.OnLeave);
	badge:Hide();

	return badge;
end

local function UpdateUnspentPointsBadge(frame, professionIndex, hasProfession)
	if not (frame.iconButton and professionIndex) then return; end

	if not frame.unspentPointsBadge then
		frame.unspentPointsBadge = CreateUnspentPointsBadge(frame.iconButton);
	end

	local points;
	if hasProfession then
		points = GetProfessionUnspentPoints(professionIndex);
	end
	frame.unspentPointsBadge:SetPoints(points);
end
-- end of peter's plumber points(tm) feature

local professionJournalSpells = {
	--primary (crafting)
	[171] = { -- Alchemy
		journal = 2259,
		icon = 4620669,
		secondaryicon = "Mobile-Alchemy",
		oldicon = 136240,
		professionbookicon = 3615513,
		spells = {},
	},
	[164] = { -- Blacksmithing
		journal = 2018,
		icon = 4620670,
		secondaryicon = "Mobile-Blacksmithing",
		oldicon = 136241,
		professionbookicon = 3618821,
		spells = {},
	},
	[333] = { -- Enchanting
		journal = 7411,
		icon = 4620672,
		secondaryicon = "Mobile-Enchanting",
		oldicon = 136244,
		spells = {13262},
		professionbookicon = 3615911,
	},
	[202] = { -- Engineering
		journal = 4036,
		icon = 4620673,
		secondaryicon = "Mobile-Enginnering",
		oldicon = 136243,
		professionbookicon = 3615515,
		spells = {},
	},
	[773] = { -- Inscription
		journal = 45357,
		icon = 4620676,
		secondaryicon = "Mobile-Inscription",
		oldicon = 237171,
		professionbookicon = 3615518,
		spells = {},
	},
	[755] = { -- Jewelcrafting
		journal = 25229,
		icon = 4620677,
		secondaryicon = "Mobile-Jewelcrafting",
		oldicon = 134072,
		professionbookicon = 3615519,
		spells = {},
	},
	[165] = { -- Leatherworking
		journal = 2108,
		icon = 4620678,
		secondaryicon = "Mobile-Leatherworking",
		oldicon = 136247,
		professionbookicon = 3615520,
		spells = {},
	},
	[197] = { -- Tailoring
		journal = 3908,
		icon = 4620681,
		secondaryicon = "Mobile-Tailoring",
		oldicon = 136249,
		professionbookicon = 3615523,
		spells = {},
	},

	--primary (gathering)

	[182] = { -- Herbalism
		journal = 193290,
		icon = 4620675,
		secondaryicon = "Mobile-Herbalism",
		oldicon = 136246,
		professionbookicon = 3615517,
		spells = {2366, 390392, 423395, 439871, 1221172, 1223014},
	},
	[186] = { -- Mining
		journal = 2656,
		icon = 4620679,
		secondaryicon = "Mobile-Mining",
		oldicon = 136248,
		professionbookicon = 3615521,
		spells = {2575, 288213, 423394, 1225392},
	},
	[393] = { -- Skinning
		journal = 194174,
		icon = 4620680,
		secondaryicon = "Mobile-Skinning",
		oldicon = 134366,
		professionbookicon = 3615522,
		spells = {8613, 442615, 440977, 1223388, 1226037, 1250491},
	},

	--secondary
	[356] = { -- Fishing
		journal = 271990,
		icon = 4620674,
		secondaryicon = "Mobile-Fishing",
		oldicon = 136245,
		professionbookicon = 3615516,
		spells = {131474},
	},
	[185] = { -- Cooking
		journal = 2550,
		icon = 4620671,
		secondaryicon = "Mobile-Cooking",
		oldicon = 133971,
		professionbookicon = 3615514,
		spells = {818},
	},
	[794] = { -- Archaeology
		journalIDs = {
			78670,	-- 75
			88961,	-- 150
			89718,	-- 225
			89719,	-- 300
			89720,	-- 375
			89721,	-- 450
			89722,	-- 525
			110393,	-- 600
			158762,	-- 700
			195127,	-- 800
			278910,	-- 950
		},
		icon = 441139,
		secondaryicon = "Mobile-Archeology",
		oldicon = 441139,
		professionbookicon = 441139,
		spells = {80451},
	},
	--[[
	[129] = { -- First Aid (Removed)
		journal = , -- probably was the same as archaeology
		icon = 135966,
		secondaryicon = "Mobile-FirstAid",
		oldicon = 135966,
		professionbookicon = 135966,
		spells = {},
	},
	]]
};

local function GetLearnedSpells(spellList)
	local learned = {};
	if not spellList then return learned; end
	
	for _, spellID in ipairs(spellList) do
		local isKnown = false;
		
		isKnown = C_SpellBook.IsSpellKnown(spellID);
		
		if isKnown then
			table.insert(learned, spellID);
		end
	end
	
	return learned;
end

local function UpgradeProfessionFrame(frame)
	if not frame or frame.isUpgraded then return; end
	local isSecondary = string.find(frame:GetName(), "Secondary");
	
	if isSecondary then
		frame:SetHeight(70);
	else
		frame:SetHeight(81);
	end
	if not frame.specialization then
		frame.specialization = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		frame.specialization:Hide();
	end
	frame.spellOffset = frame.spellOffset or 0;
	
	if frame.icon then
		frame.icon:SetAlpha(0);
	end
	
	local originalBorder = _G[frame:GetName().."IconBorder"];
	if originalBorder then
		originalBorder:SetAlpha(0);
	end
	
	frame.iconButton = CreateFrame("Button", nil, frame);
	
	if isSecondary then
		frame.iconButton:SetSize(56, 56);
	else
		frame.iconButton:SetSize(72, 72);
	end

	frame.iconButton:SetPoint("TOPLEFT", frame, "TOPLEFT", -23, -7);
	
	frame.iconButton:RegisterForClicks("LeftButtonUp");
	frame.iconButton:SetHighlightAtlas("common-roundhighlight", "ADD");
	
	local newBorder = frame.iconButton:CreateTexture(nil, "OVERLAY");
	newBorder:SetAllPoints();
	newBorder:SetTexture("Interface\\Spellbook\\ProfessionsBook");
	newBorder:SetTexCoord(0.43359375, 0.72265625, 0.14843750, 0.72656250);
	frame.customIconBorder = newBorder;
	
	frame.customIcon = frame.iconButton:CreateTexture(nil, "BORDER");
	frame.customIcon:SetPoint("TOPLEFT", newBorder, "TOPLEFT", 1, -1);
	frame.customIcon:SetPoint("BOTTOMRIGHT", newBorder, "BOTTOMRIGHT", -1, 1);
	
	frame.customIconOverlay = frame.iconButton:CreateTexture(nil, "ARTWORK");
	frame.customIconOverlay:SetAllPoints(frame.customIcon);
	frame.customIconOverlay:SetDesaturated(true);
	frame.customIconOverlay:SetBlendMode("ADD");
	frame.customIconOverlay:SetAlpha(0.3);
	frame.customIconOverlay:SetVertexColor(1.0,0.4,0.0);
	
	local circleMask = frame.iconButton:CreateMaskTexture();
	circleMask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE");
	circleMask:SetAllPoints(frame.customIcon);
	frame.customIcon:AddMaskTexture(circleMask);
	frame.customIconOverlay:AddMaskTexture(circleMask);

	if frame.professionName then
		frame.professionName:SetTextColor(0.25098*1.7, 0.129411*1.7, 0.0, 0.8);
		
		if not frame.professionBackplate then
			frame.professionBackplate = frame:CreateTexture(nil, "BACKGROUND");
			frame.professionBackplate:SetAtlas("spellbook-list-backplate");
			frame.professionBackplate:SetSize(240, 50);
			frame.professionBackplate:SetPoint("LEFT", frame.professionName, "LEFT", -60, 0);
			
			frame.professionBackplate:SetVertexColor(0.3, 0.15, 0.05, 0.3);
		end
	end
	if frame.rank then
		frame.rank:SetTextColor(0.25098*1.7, 0.129411*1.7, 0.0, 0.8);
	end
	if frame.missingHeader then
		frame.missingHeader:SetTextColor(0.25098*1.7, 0.129411*1.7, 0.0, 0.8);
	end

	if isSecondary then
		if frame.statusBar then
			frame.statusBar:ClearAllPoints();
			frame.statusBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 94, 0);
		end
		if frame.professionName then
			frame.professionName:ClearAllPoints();
			frame.professionName:SetPoint("TOPLEFT", frame, "TOPLEFT", 80, 0);
		end
		if frame.rank then
			frame.rank:ClearAllPoints();
			frame.rank:SetPoint("BOTTOMLEFT", frame.statusBar, "TOPLEFT", -15, 3);
		end
		if frame.missingHeader then
			frame.missingHeader:ClearAllPoints();
			frame.missingHeader:SetPoint("TOPLEFT", frame, "TOPLEFT", 50, -10);
		end
		if frame.missingText then
			frame.missingText:ClearAllPoints();
			frame.missingText:SetPoint("TOPLEFT", frame.missingHeader, "BOTTOMLEFT", 0, -1);
		end
	else
		if frame.professionName then
			frame.professionName:ClearAllPoints();
			frame.professionName:SetPoint("TOPLEFT", frame, "TOPLEFT", 80, -5);
		end
		if frame.rank then
			frame.rank:ClearAllPoints();
			frame.rank:SetPoint("BOTTOMLEFT", frame.professionName, "BOTTOMLEFT", 0, -43);
		end
		if frame.statusBar then
			frame.statusBar:ClearAllPoints();
			frame.statusBar:SetPoint("TOPLEFT", frame.rank, "BOTTOMLEFT", 14, -5);
		end
		if frame.missingHeader then
			frame.missingHeader:ClearAllPoints();
			frame.missingHeader:SetPoint("TOPLEFT", frame, "TOPLEFT", 65, -13);
		end
		if frame.missingText then
			frame.missingText:ClearAllPoints();
			frame.missingText:SetPoint("TOPLEFT", frame.missingHeader, "BOTTOMLEFT", 0, -1);
		end
	end

	frame.iconButton:RegisterForDrag("LeftButton");
	
	frame.iconButton:SetScript("OnDragStart", function(self)
		if InCombatLockdown() then return; end
		if self.journalSpellID then
			C_Spell.PickupSpell(self.journalSpellID);
		end
	end)

	frame.iconButton:SetScript("OnClick", function(self)
		if self.journalSpellID then
			CastSpellByID(self.journalSpellID);
		end
	end)
	
	frame.iconButton:SetScript("OnEnter", function(self)
		if self.journalSpellID then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetSpellByID(self.journalSpellID);
			GameTooltip:Show();
		end
	end)
	frame.iconButton:SetScript("OnLeave", function() GameTooltip_Hide(); end);

	frame.spellFlyoutTrigger = CreateFrame("Button", nil, frame);
	frame.spellFlyoutTrigger:SetSize(35, 35);
	frame.spellFlyoutTrigger:SetPoint("LEFT", frame.iconButton, "RIGHT", 4, 0);
	
	local bgOffset = 7;
	local bg = frame.spellFlyoutTrigger:CreateTexture(nil, "BACKGROUND");
	bg:SetPoint("TOPLEFT", bgOffset, -bgOffset);
	bg:SetPoint("BOTTOMRIGHT", -bgOffset, bgOffset);
	bg:SetAtlas("talents-node-choiceflyout-circle-locked");
	local bgBorder = frame.spellFlyoutTrigger:CreateTexture(nil, "BACKGROUND");
	bgBorder:SetAllPoints();
	bgBorder:SetAtlas("talents-node-apex-small-gray");

	local arrow = frame.spellFlyoutTrigger:CreateTexture(nil, "OVERLAY");
	arrow:SetSize(15, 5);
	arrow:SetPoint("CENTER", 1, 0);
	arrow:SetAtlas("UI-HUD-ActionBar-Flyout");
	arrow:SetRotation(math.rad(-90)); -- i'm too lazy to texcoord it
	frame.spellFlyoutTrigger.arrow = arrow;

	frame.spellFlyoutContainer = CreateFrame("Frame", nil, frame, "BackdropTemplate");
	frame.spellFlyoutContainer:SetFrameStrata("HIGH");
	frame.spellFlyoutContainer:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	});
	frame.spellFlyoutContainer:SetBackdropColor(0, 0, 0, 0.9);
	frame.spellFlyoutContainer:SetPoint("TOPLEFT", frame.spellFlyoutTrigger, "TOPRIGHT", 2, 0);
	frame.spellFlyoutContainer:Hide();

	frame.spellFlyoutButtons = {};

	local function UpdateArrowTexture(self)
		if frame.spellFlyoutContainer:IsShown() then
			self.arrow:SetAtlas("UI-HUD-ActionBar-Flyout-Down");
		elseif self:IsMouseOver() then
			self.arrow:SetAtlas("UI-HUD-ActionBar-Flyout-Mouseover");
		else
			self.arrow:SetAtlas("UI-HUD-ActionBar-Flyout");
		end
	end

	frame.spellFlyoutTrigger:SetScript("OnEnter", function(self)
		UpdateArrowTexture(self);
	end)

	frame.spellFlyoutTrigger:SetScript("OnLeave", function(self)
		UpdateArrowTexture(self);
	end)

	frame.spellFlyoutTrigger:SetScript("OnClick", function(self)
		if InCombatLockdown() then return; end
		local isOpening = not frame.spellFlyoutContainer:IsShown();
		frame.spellFlyoutContainer:SetShown(isOpening);
		UpdateArrowTexture(self);
	end)
	
	frame.spellFlyoutContainer:SetScript("OnHide", function()
		UpdateArrowTexture(frame.spellFlyoutTrigger);
	end)
	frame.spellFlyoutContainer:SetScript("OnShow", function()
		UpdateArrowTexture(frame.spellFlyoutTrigger);
	end)

	if frame.UnlearnButton and frame.UnlearnButton.Icon then
		frame.UnlearnButton.Icon:SetTexture(nil);
		frame.UnlearnButton.Icon:SetAtlas("transmog-icon-remove");
	end

	frame.isUpgraded = true;
end

local function InitializeGearSlots(frame)
	if frame.gearSlots then return; end
	frame.gearSlots = {};

	local frameName = frame:GetName();
	local maxSlots = frameMaxSlots[frameName];
	
	if not maxSlots then return; end

	if not frame.flyoutSettings then
		frame.flyoutSettings = {
			onClickFunc = PaperDollFrameItemFlyoutButton_OnClick,
			getItemsFunc = PaperDollFrameItemFlyout_GetItems,
			postGetItemsFunc = PaperDollFrameItemFlyout_PostGetItems,
			hasPopouts = true,
			parent = frame,
			anchorX = -30,
			anchorY = -35,
		};
	end

	for i = 1, maxSlots do
		local btn = CreateFrame("ItemButton", nil, frame);
		btn:SetSize(36, 36);

		if i == 1 then
			btn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -23, -8);
		elseif i == 2 then
			local divider = CreateFrame("Frame", nil, frame);
			divider:SetSize(5, 37);
			divider:SetPoint("RIGHT", frame.gearSlots[1], "LEFT", -6, 0);
			
			local tex = divider:CreateTexture(nil, "ARTWORK");
			tex:SetAtlas("Professions-Equipment-Divider", true);
			tex:SetPoint("CENTER");
			
			frame.gearSlotDivider = divider;
			
			btn:SetPoint("RIGHT", divider, "LEFT", -6, 0);
		else
			btn:SetPoint("RIGHT", frame.gearSlots[i-1], "LEFT", -4, 0);
		end

		btn:RegisterForDrag("LeftButton");
		btn:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		
		btn:SetScript("OnEvent", PaperDollItemSlotButton_OnEvent);
		btn:SetScript("OnShow", PaperDollItemSlotButton_OnShow);
		btn:SetScript("OnHide", PaperDollItemSlotButton_OnHide);
		
		btn:SetScript("OnClick", function(self, button)
			if IsModifiedClick() then
				PaperDollItemSlotButton_OnModifiedClick(self, button);
			else
				PaperDollItemSlotButton_OnClick(self, button);
			end
		end)
		
		btn:SetScript("OnDragStart", function(self)
			PaperDollItemSlotButton_OnClick(self, "LeftButton");
		end);
		btn:SetScript("OnReceiveDrag", function(self)
			PaperDollItemSlotButton_OnClick(self, "LeftButton");
		end);
		btn:SetScript("OnEnter", PaperDollItemSlotButton_OnEnter);
		btn:SetScript("OnLeave", PaperDollItemSlotButton_OnLeave);

		table.insert(frame.gearSlots, btn);
	end
end

local function ApplyProfessionHook()
	hooksecurefunc("FormatProfession", function(frame, index)
		
		if not InCombatLockdown() then
			if frame.SpellButton1 then frame.SpellButton1:Hide(); end
			if frame.SpellButton2 then frame.SpellButton2:Hide(); end
			
			if frame.SpellButtonBottom then frame.SpellButtonBottom:Hide(); end
		end

		if frameMaxSlots[frame:GetName()] then
			if GetProfDB().showGearSlots then
				InitializeGearSlots(frame);

				local hasProfession = (index ~= nil);
				local skillLine = nil;

				if hasProfession then
					local _, _, _, _, _, _, skillLineID = GetProfessionInfo(index);
					skillLine = skillLineID;
				end

				local activeSlots = {};
				if skillLine and C_TradeSkillUI and C_TradeSkillUI.GetProfessionSlots then
					local professionEnum = nil;

					if C_TradeSkillUI.GetProfessionInfoBySkillLineID then
						local profInfo = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLine);
						if profInfo and profInfo.profession then
							professionEnum = profInfo.profession;
						end
					end

					-- API uses Enum.Profession
					if not professionEnum then
						local skillLineToEnum = {
							[129] = 0,	-- First Aid
							[164] = 1,	-- Blacksmithing
							[165] = 2,	-- Leatherworking
							[171] = 3,	-- Alchemy
							[182] = 4,	-- Herbalism
							[185] = 5,	-- Cooking
							[186] = 6,	-- Mining
							[197] = 7,	-- Tailoring
							[202] = 8,	-- Engineering
							[333] = 9,	-- Enchanting
							[356] = 10,	-- Fishing
							[393] = 11,	-- Skinning
							[755] = 12,	-- Jewelcrafting
							[773] = 13,	-- Inscription
							[794] = 14,	-- Archaeology
						};
						professionEnum = skillLineToEnum[skillLine];
					end

					if professionEnum then
						activeSlots = C_TradeSkillUI.GetProfessionSlots(professionEnum) or {};
					end
				end

				for i, btn in ipairs(frame.gearSlots) do
					local slotID = activeSlots[i];

					if slotID and hasProfession and not InCombatLockdown() then
						btn.slotName = slotIDToName[slotID];
						PaperDollItemSlotButton_OnLoad(btn);
						btn:Show();
						PaperDollItemSlotButton_Update(btn);
					else
						btn:Hide();
						btn:SetID(0);
						btn.slotName = nil;
					end
				end
				
				if frame.gearSlotDivider then
					frame.gearSlotDivider:SetShown(hasProfession and #activeSlots > 1 and not InCombatLockdown());
				end

			else
				if frame.gearSlots then
					for _, btn in ipairs(frame.gearSlots) do
						btn:Hide();
					end
				end
				if frame.gearSlotDivider then
					frame.gearSlotDivider:Hide();
				end
			end
		end

		if frame.isUpgraded then
			local skillData = nil;

			local primaryIndex = primaryFrameToProfessionIndex[frame:GetName()];
			if primaryIndex then
				UpdateUnspentPointsBadge(frame, primaryIndex, index ~= nil);
			end

			if index then
				local name, texture, rank, maxRank, numSpells, spellOffset, skillLine = GetProfessionInfo(index);
				skillData = professionJournalSpells[skillLine];
				
				local chosenTexture = texture;
				local style = GetProfDB().iconStyle or "icon";

				if skillData then
					if style == "icon" and skillData.icon then
						chosenTexture = skillData.icon;
					elseif style == "secondaryicon" and skillData.secondaryicon then
						chosenTexture = skillData.secondaryicon;
					elseif style == "oldicon" and skillData.oldicon then
						chosenTexture = skillData.oldicon;
					elseif style == "professionbook" and skillData.professionbookicon then
						chosenTexture = skillData.professionbookicon;
					elseif style == "journal" and skillData.journal then
						local spellInfo = C_Spell.GetSpellInfo(skillData.journal);
						if spellInfo then
							chosenTexture = spellInfo.iconID;
						else
							chosenTexture = GetSpellTexture(skillData.journal);
						end
					end
				end

				if not chosenTexture and frame.icon then
					chosenTexture = frame.icon:GetTexture();
				end

				local function SetIconTex(texObj, texVal)
					if not texObj or not texVal then return; end
					if type(texVal) == "string" and not string.match(texVal, "\\") and C_Texture.GetAtlasInfo(texVal) then
						texObj:SetAtlas(texVal);
					else
						texObj:SetTexture(texVal);
					end
				end

				SetIconTex(frame.customIcon, chosenTexture);
				SetIconTex(frame.customIconOverlay, chosenTexture);
				
				frame.iconButton:Enable();
				frame.customIcon:SetAlpha(0.8);
				frame.customIcon:SetDesaturated(false);
				frame.customIcon:SetBlendMode("BLEND");
				
				if frame.customIconOverlay then
					frame.customIconOverlay:Show();
					frame.customIconOverlay:SetVertexColor(1,.4,0);
				end

				if frame.professionBackplate then
					frame.professionBackplate:Show();
				end
			else
				frame.iconButton:Disable();

				frame.customIcon:SetTexture("Interface\\Icons\\INV_Scroll_04");
				frame.customIcon:SetAlpha(0.8);
				frame.customIcon:SetDesaturated(true);
				frame.customIcon:SetBlendMode("BLEND");

				if frame.customIconOverlay then
					frame.customIconOverlay:SetTexture("Interface\\Icons\\INV_Scroll_04");
					frame.customIconOverlay:Show();
				end

				if frame.professionBackplate then
					frame.professionBackplate:Hide();
				end
			end

			local db = GetProfDB();
			if frame.icon then
				frame.icon:SetAlpha(db.hideDefaultIcons and 0 or 1);
			end
			
			if frame.iconButton then
				frame.iconButton:SetShown(not db.hideCustomIcons);
			end
			if frame.customIconBorder then
				frame.customIconBorder:SetShown(not db.hideCustomIcons);
			end

			if frame.professionBackplate then
				local c = db.Colors.Bg;
				frame.professionBackplate:SetVertexColor(c.r, c.g, c.b, c.a);
				frame.professionBackplate:SetDesaturated(c.desat);
			end
			if frame.professionName then
				local c = db.Colors.Name;
				frame.professionName:SetTextColor(c.r, c.g, c.b, c.a);
			end
			if frame.rank then
				local c = db.Colors.Rank;
				frame.rank:SetTextColor(c.r, c.g, c.b, c.a);
			end
			if frame.statusBar then
				local c = db.Colors.Bar;
				frame.statusBar:SetStatusBarColor(c.r, c.g, c.b, c.a);
				if frame.statusBar.rankText then
					local tc = db.Colors.BarText;
					frame.statusBar.rankText:SetTextColor(tc.r, tc.g, tc.b, tc.a);
				end
			end

			local resolvedJournalID = nil;
			if skillData then
				if skillData.journalIDs then
					for _, spellID in ipairs(skillData.journalIDs) do
						local isKnown = false;
						isKnown = C_SpellBook.IsSpellKnown(spellID);

						if isKnown then
							resolvedJournalID = spellID;
							break;
						end
					end
				else
					resolvedJournalID = skillData.journal;
				end
			end

			frame.iconButton.journalSpellID = resolvedJournalID;

			local activeSpells = skillData and GetLearnedSpells(skillData.spells) or {};

			if #activeSpells > 0 then
				frame.spellFlyoutTrigger:Show();
				
				local numFlyoutSpells = #activeSpells;
				local container = frame.spellFlyoutContainer;
				
				local maxPerRow = 5;
				local btnSize = 32;
				local padding = 4;
				local inset = 4;
				
				local numCols = math.min(numFlyoutSpells, maxPerRow);
				local numRows = math.ceil(numFlyoutSpells / maxPerRow);
				
				local containerWidth = (numCols * btnSize) + ((numCols - 1) * padding) + (inset * 2);
				local containerHeight = (numRows * btnSize) + ((numRows - 1) * padding) + (inset * 2);
				
				container:SetSize(containerWidth, containerHeight);
				
				for i = 1, numFlyoutSpells do
					local spellID = activeSpells[i];
					local spellBtn = frame.spellFlyoutButtons[i];
					
					if not spellBtn then
						spellBtn = CreateFrame("Button", nil, container);
						spellBtn:SetSize(btnSize, btnSize);
						spellBtn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD");
						spellBtn:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress");
						
						local iconTex = spellBtn:CreateTexture(nil, "ARTWORK");
						iconTex:SetAllPoints();
						spellBtn.icon = iconTex;
						
						spellBtn:RegisterForDrag("LeftButton");
						
						spellBtn:SetScript("OnEnter", function(self)
							GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
							GameTooltip:SetSpellByID(self.spellID);
						end)
						spellBtn:SetScript("OnLeave", function() GameTooltip_Hide(); end);
						
						spellBtn:SetScript("OnDragStart", function(self)
							if InCombatLockdown() then return; end
							C_Spell.PickupSpell(self.spellID);
							container:Hide();
						end)
						
						frame.spellFlyoutButtons[i] = spellBtn;
					end
					
					spellBtn.spellID = spellID;
					
					local spellInfo = C_Spell.GetSpellInfo(spellID);
					if spellInfo then
						spellBtn.icon:SetTexture(spellInfo.iconID);
					else
						spellBtn.icon:SetTexture(GetSpellTexture(spellID));
					end
					
					local colIndex = (i - 1) % maxPerRow;
					local rowIndex = math.floor((i - 1) / maxPerRow);
					
					local xOffset = inset + (colIndex * (btnSize + padding));
					local yOffset = -(inset + (rowIndex * (btnSize + padding)));
					
					spellBtn:ClearAllPoints();
					spellBtn:SetPoint("TOPLEFT", container, "TOPLEFT", xOffset, yOffset);
					spellBtn:Show();
				end
				
				for i = numFlyoutSpells + 1, #frame.spellFlyoutButtons do
					if frame.spellFlyoutButtons[i] then
						frame.spellFlyoutButtons[i]:Hide();
					end
				end
			else
				frame.spellFlyoutTrigger:Hide();
				frame.spellFlyoutContainer:Hide();
			end
		end
	end)
end

EventUtil.ContinueOnAddOnLoaded("Blizzard_ProfessionsBook", function()
	if not IsModuleEnabled() then return; end
	
	ProfessionsBookPage1:Hide();
	ProfessionsBookPage2:Hide();

	local newPageLeft = ProfessionsBookFrame:CreateTexture(nil, "BACKGROUND");
	newPageLeft:SetPoint("TOPLEFT", ProfessionsBookFrame, "TOPLEFT", 0, -25);
	newPageLeft:SetPoint("BOTTOMRIGHT", ProfessionsBookFrame, "BOTTOMRIGHT", 0, 0);
	newPageLeft:SetTexture("Interface\\AddOns\\Artificer\\Textures\\ProfessionsBookBackground2.png");
	ProfessionsBookFrame.ArtificerPageLeft = newPageLeft;
	
	local ribbon = ProfessionsBookFrame:CreateTexture(nil, "BORDER");
	ribbon:SetTexture("Interface\\AddOns\\Artificer\\Textures\\ProfessionsBookRibbon.png");
	ribbon:SetPoint("TOPLEFT", ProfessionsBookFrame, "TOPLEFT", -10, -15);
	ribbon:SetSize(102*.6, 557*.6);
	--ribbon:SetVertexColor(.4741, .7498, .2502);
	ribbon:SetTexCoord(1, 0, 0, 1);
	ProfessionsBookFrame.ArtificerRibbon = ribbon;

	SecondaryProfession1:SetPoint("TOPLEFT", PrimaryProfession2, "BOTTOMLEFT", 0, -20);
	SecondaryProfession2:SetPoint("TOPLEFT", SecondaryProfession1, "BOTTOMLEFT", 0, -5);
	SecondaryProfession3:SetPoint("TOPLEFT", SecondaryProfession2, "BOTTOMLEFT", 0, -5);

	local framesToUpgrade = {
		"PrimaryProfession1", "PrimaryProfession2",
		"SecondaryProfession1", "SecondaryProfession2", "SecondaryProfession3"
	};
	
	for _, name in ipairs(framesToUpgrade) do
		local frame = _G[name];
		if frame then
			UpgradeProfessionFrame(frame);
		end
	end

	ApplyProfessionHook();
	
	if Artificer.UpdateProfessionGlobalColors then
		Artificer.UpdateProfessionGlobalColors();
	end
end)

-- open the frame thingy when selecting an enchant
local baitListenerFrame = CreateFrame("Frame");
baitListenerFrame:RegisterEvent("ENCHANT_SPELL_SELECTED");
baitListenerFrame:RegisterEvent("ENCHANT_SPELL_COMPLETED");
baitListenerFrame:SetScript("OnEvent", function(self, event, ...)
	if not IsModuleEnabled() or not GetProfDB().autoOpenBook then return; end

	if event == "ENCHANT_SPELL_SELECTED" then
		local matchedSlots = {};

		for slotID = 20, 28 do
			local itemLocation = ItemLocation:CreateFromEquipmentSlot(slotID);
			
			if itemLocation:IsValid() then
				if C_Item.DoesItemMatchTargetEnchantingSpell(itemLocation) then
					table.insert(matchedSlots, slotID);
				end
			end
		end

		--[[
		DevTools_Dump({
				EventFired = event,
				MatchedProfessionSlots = matchedSlots,
				TotalMatches = #matchedSlots
			}, "Profession Gear Enchant Check");
		]]

		if #matchedSlots > 0 then
			if not ProfessionsBookFrame or not ProfessionsBookFrame:IsShown() then
				ToggleProfessionsBook();
			end
		end
		
	elseif event == "ENCHANT_SPELL_COMPLETED" then
		if ProfessionsBookFrame and ProfessionsBookFrame:IsShown() then
			HideUIPanel(ProfessionsBookFrame);
		end
	end
end)



local TimerContainer = CreateFrame("Frame", "ArtificerProfessionTimerContainer", UIParent);
TimerContainer:SetSize(224, 20);
TimerContainer:SetPoint("CENTER", 0, -150);
TimerContainer:SetMovable(true);
TimerContainer:RegisterForDrag("LeftButton");

TimerContainer.Overlay = TimerContainer:CreateTexture(nil, "BACKGROUND");
TimerContainer.Overlay:SetAllPoints();
TimerContainer.Overlay:SetColorTexture(0, 1, 0, 0.2);
TimerContainer.Overlay:Hide();

TimerContainer.DragText = TimerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
TimerContainer.DragText:SetPoint("CENTER");
TimerContainer.DragText:SetText(DRAG_MODEL);
TimerContainer.DragText:SetTextColor(0, 1, 0);
TimerContainer.DragText:Hide();

TimerContainer:SetScript("OnDragStart", function(self)
	self.isDragging = true;
	self:StartMoving();
end);
TimerContainer:SetScript("OnDragStop", function(self)
	self.isDragging = false;
	self:StopMovingOrSizing();
	if Artificer and Artificer.SaveFramePosition then
		Artificer:SaveFramePosition(self, "ProfessionTimerContainer");
	end
end);

local activeTimers = {};
local timerPool = {};

local function LayoutTimers()
	local sortedSlots = {};
	for slotID in pairs(activeTimers) do
		table.insert(sortedSlots, slotID);
	end
	table.sort(sortedSlots);

	local height = math.max(20, #sortedSlots * 40);
	TimerContainer:SetSize(224, height);

	for i, slotID in ipairs(sortedSlots) do
		local bar = activeTimers[slotID];
		bar:ClearAllPoints();
		if i == 1 then
			bar:SetPoint("TOPLEFT", TimerContainer, "TOPLEFT", 24, -15);
		else
			local prevBar = activeTimers[sortedSlots[i-1]];
			bar:SetPoint("TOPLEFT", prevBar, "BOTTOMLEFT", 0, -20);
		end
		bar:Show();
	end
end

local function ReleaseTimerBar(slotID)
	local bar = activeTimers[slotID];
	if bar then
		bar:Hide();
		activeTimers[slotID] = nil;
		table.insert(timerPool, bar);
		LayoutTimers();
	end
end

local function GetOrCreateTimerBar(slotID)
	if activeTimers[slotID] then return activeTimers[slotID]; end

	local bar
	if #timerPool > 0 then
		bar = table.remove(timerPool);
	else
		bar = CreateFrame("StatusBar", nil, TimerContainer);
		bar:SetSize(200, 20);
		bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar"); -- i'll probably change or add options for this later
		bar:SetStatusBarColor(0.2, 0.8, 0.2);

		local bg = bar:CreateTexture(nil, "BACKGROUND");
		bg:SetAllPoints();
		bg:SetColorTexture(0, 0, 0, 0.6);

		local border = CreateFrame("Frame", nil, bar, "BackdropTemplate");
		border:SetPoint("TOPLEFT", -2, 2);
		border:SetPoint("BOTTOMRIGHT", 2, -2);
		border:SetBackdrop({
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			edgeSize = 12,
		});

		local icon = bar:CreateTexture(nil, "ARTWORK");
		icon:SetSize(20, 20);
		icon:SetPoint("RIGHT", bar, "LEFT", -4, 0);
		icon:SetTexCoord(0.08, 0.92, 0.08, 0.92);
		bar.Icon = icon;

		local iconBorder = CreateFrame("Frame", nil, bar, "BackdropTemplate");
		iconBorder:SetPoint("TOPLEFT", icon, "TOPLEFT", -2, 2);
		iconBorder:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2);
		iconBorder:SetBackdrop({
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			edgeSize = 12,
		});

		local nameText = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
		nameText:SetPoint("BOTTOMLEFT", bar, "TOPLEFT", 0, 2);
		nameText:SetJustifyH("LEFT");
		bar.NameText = nameText;
		
		local timeText = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
		timeText:SetPoint("RIGHT", bar, "RIGHT", -5, 0);
		timeText:SetJustifyH("RIGHT");
		bar.TimeText = timeText;
	end
	
	bar.slotID = slotID;
	activeTimers[slotID] = bar;
	return bar;
end

TimerContainer:SetScript("OnUpdate", function(self, elapsed)
	local advancedOpen = Artificer.ProfBookAdvancedFrame and Artificer.ProfBookAdvancedFrame:IsVisible();
	local shiftDown = IsShiftKeyDown();
	local shouldEnableMouse = advancedOpen or shiftDown or self.isDragging;
	
	if self:IsMouseEnabled() ~= shouldEnableMouse then
		self:EnableMouse(shouldEnableMouse);
	end
	
	if advancedOpen then
		self.Overlay:Show();
		if next(activeTimers) == nil then
			self.DragText:Show();
		else
			self.DragText:Hide();
		end
	else
		self.Overlay:Hide();
		self.DragText:Hide();
	end

	local currentTime = GetTime()
	for slotID, bar in pairs(activeTimers) do
		local remaining = bar.endTime - currentTime;
		if remaining <= 0 then
			local currentGUID = bar.itemGUID;
			ReleaseTimerBar(slotID);
			
			if Artificer_DB and Artificer_DB.EnchantTimers and currentGUID then
				Artificer_DB.EnchantTimers[currentGUID] = nil;
			end
		else
			bar:SetValue(remaining);
			
			local hours = math.floor(remaining / 3600);
			local mins = math.floor((remaining % 3600) / 60);
			local secs = math.floor(remaining % 60);
			
			if hours > 0 then
				bar.TimeText:SetText(string.format("%d:%02d:%02d", hours, mins, secs));
			else
				bar.TimeText:SetText(string.format("%02d:%02d", mins, secs));
			end
		end
	end
end)

local enchantPatterns = {};
local patternsLoaded = false;

local function LoadEnchantPatterns()
	if patternsLoaded then return; end
	
	local function AddPattern(globalStr, mult)
		if type(globalStr) ~= "string" then return; end
		
		for _, num in ipairs({1, 8}) do
			local markerString = "\001";
			local success, formatted = pcall(string.format, globalStr, markerString, num);
			if not success then return; end
			
			local strPos = string.find(formatted, markerString);
			local numPos = string.find(formatted, tostring(num));
			
			if strPos and numPos then
				local nameFirst = strPos < numPos;
				
				local pattern = string.gsub(formatted, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1");
				
				pattern = string.gsub(pattern, markerString, "(.+)");
				pattern = string.gsub(pattern, tostring(num), "(%%d+)");
				
				table.insert(enchantPatterns, {
					pattern = "^" .. pattern .. "$",
					mult = mult,
					nameFirst = nameFirst
				});
			end
		end
	end

	AddPattern(ITEM_ENCHANT_TIME_LEFT_DAYS, 86400);
	AddPattern(ITEM_ENCHANT_TIME_LEFT_HOURS, 3600);
	AddPattern(ITEM_ENCHANT_TIME_LEFT_MIN, 60);
	AddPattern(ITEM_ENCHANT_TIME_LEFT_SEC, 1);
	
	patternsLoaded = true;
end

local function GetTempEnchantInfoFromSlot(slotID)
	LoadEnchantPatterns();
	
	local tooltipData = C_TooltipInfo.GetInventoryItem("player", slotID);
	if not tooltipData or not tooltipData.lines then return nil, nil; end

	for _, line in ipairs(tooltipData.lines) do
		if line.leftText then
			local cleanText = string.gsub(line.leftText, "|c%x%x%x%x%x%x%x%x", "");
			cleanText = string.gsub(cleanText, "|r", "");
			cleanText = strtrim(cleanText);
			
			for _, data in ipairs(enchantPatterns) do
				local match1, match2 = string.match(cleanText, data.pattern);
				
				if match1 and match2 then
					local name, durationStr;
					
					if data.nameFirst then
						name = match1;
						durationStr = match2;
					else
						name = match2;
						durationStr = match1;
					end
					
					local duration = tonumber(durationStr) * data.mult;
					return duration, strtrim(name);
				end
			end
		end
	end
	return nil, nil;
end

local timerListener = CreateFrame("Frame");
timerListener:RegisterEvent("ENCHANT_SPELL_COMPLETED");
timerListener:RegisterEvent("PLAYER_ENTERING_WORLD");
timerListener:RegisterEvent("BAG_UPDATE_DELAYED");
timerListener:RegisterEvent("BAG_UPDATE_COOLDOWN");
timerListener:RegisterEvent("ADDON_LOADED");

local function UpdateTimerBar(slotID, isNewEnchant)
	local itemLocation = ItemLocation:CreateFromEquipmentSlot(slotID);
	if not itemLocation:IsValid() then
		ReleaseTimerBar(slotID);
		return false;
	end
	
	local itemGUID = C_Item.GetItemGUID(itemLocation);
	if not itemGUID then
		ReleaseTimerBar(slotID);
		return false;
	end

	local remainingTime, name = GetTempEnchantInfoFromSlot(slotID);
	local currentOSTime = time();
	
	local db = Artificer_DB and Artificer_DB.EnchantTimers;
	
	if db and db[slotID] ~= nil then
		db[slotID] = nil;
	end

	if db and db[itemGUID] and db[itemGUID].expiration and db[itemGUID].expiration <= currentOSTime then
		db[itemGUID] = nil;
	end

	if not remainingTime and db and db[itemGUID] then
		local expectedRemaining = db[itemGUID].expiration - currentOSTime;
		if expectedRemaining > 0 then
			remainingTime = expectedRemaining;
			name = db[itemGUID].name;
		end
	end

	if remainingTime and name then
		local maxDuration = remainingTime;

		if db then
			if isNewEnchant or not db[itemGUID] or db[itemGUID].name ~= name then
				db[itemGUID] = {
					maxDuration = remainingTime,
					name = name,
					expiration = currentOSTime + remainingTime
				};
			else
				maxDuration = db[itemGUID].maxDuration;
				
				local savedExpiration = db[itemGUID].expiration;
				if savedExpiration then
					local expectedRemaining = savedExpiration - currentOSTime;
					if math.abs(expectedRemaining - remainingTime) > 60 then
						db[itemGUID].expiration = currentOSTime + remainingTime;
						
						if remainingTime > db[itemGUID].maxDuration then
							db[itemGUID].maxDuration = remainingTime;
							maxDuration = remainingTime;
						end
					else
						remainingTime = expectedRemaining;
					end
				else
					db[itemGUID].expiration = currentOSTime + remainingTime;
				end
			end
		end

		local bar = GetOrCreateTimerBar(slotID);
		bar.itemGUID = itemGUID;
		local exactTime = GetTime();
		if bar.endTime and bar.enchantName == name then
			local drift = math.abs((bar.endTime - exactTime) - remainingTime);
			if drift > 2 then
				bar.endTime = exactTime + remainingTime;
			end
		else
			bar.endTime = exactTime + remainingTime;
		end

		bar.enchantName = name;
		bar.NameText:SetText(name);
		bar.Icon:SetTexture(GetInventoryItemTexture("player", slotID));
		bar:SetMinMaxValues(0, maxDuration);
		return true;
	else
		if db and db[itemGUID] then
			db[itemGUID] = nil;
		end
		ReleaseTimerBar(slotID);
		return false;
	end
end

timerListener:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		local loadedAddon = ...;
		if loadedAddon == addonName then
			if not Artificer_DB then return; end
			Artificer_DB.EnchantTimers = Artificer_DB.EnchantTimers or {};
			
			local currentOSTime = time();
			for key, data in pairs(Artificer_DB.EnchantTimers) do
				if type(data) == "table" and data.expiration and data.expiration <= currentOSTime then
					Artificer_DB.EnchantTimers[key] = nil;
				end
			end
			
			if Artificer_DB.FramePositions and Artificer_DB.FramePositions["ProfessionTimerContainer"] then
				local pos = Artificer_DB.FramePositions["ProfessionTimerContainer"];
				TimerContainer:ClearAllPoints();
				TimerContainer:SetPoint(pos.point, UIParent, pos.relativePoint, pos.x, pos.y);
			end
		end
		return;
	end

	if not IsModuleEnabled() or not GetProfDB().showTimer then
		for slotID in pairs(activeTimers) do
			ReleaseTimerBar(slotID);
		end
		return;
	end
	
	if event == "ENCHANT_SPELL_COMPLETED" then
		local successful, enchantedItem = ...;
		if successful and enchantedItem and enchantedItem:IsEquipmentSlot() then
			local slotID = enchantedItem:GetEquipmentSlot();
			if slotID >= 20 and slotID <= 28 then
				if UpdateTimerBar(slotID, true) then
					LayoutTimers();
				end
			end
		end
	elseif event == "BAG_UPDATE_DELAYED" or event == "BAG_UPDATE_COOLDOWN" then
		for slotID = 20, 28 do
			UpdateTimerBar(slotID, false);
		end
		LayoutTimers();
	elseif event == "PLAYER_ENTERING_WORLD" then
		for slotID = 20, 28 do
			UpdateTimerBar(slotID, false);
		end
		LayoutTimers();
	end
end)

local combatStateListener = CreateFrame("Frame");
combatStateListener:RegisterEvent("PLAYER_REGEN_DISABLED");
combatStateListener:RegisterEvent("PLAYER_REGEN_ENABLED");

combatStateListener:SetScript("OnEvent", function(self, event)
	if ProfessionsBookFrame and ProfessionsBookFrame:IsShown() then
		for i = 1, 2 do
			local primary = _G["PrimaryProfession"..i];
			local secondary = _G["SecondaryProfession"..i];
			if primary and primary.spellFlyoutContainer then primary.spellFlyoutContainer:Hide(); end
			if secondary and secondary.spellFlyoutContainer then secondary.spellFlyoutContainer:Hide(); end
		end
		
		ProfessionsBookFrame_Update();
	end
end)

local unspentPointsListener = CreateFrame("Frame");
unspentPointsListener:RegisterEvent("TRAIT_TREE_CURRENCY_INFO_UPDATED");
unspentPointsListener:RegisterEvent("TRAIT_CONFIG_UPDATED");
unspentPointsListener:SetScript("OnEvent", function(self, event, ...)
	if ProfessionsBookFrame and ProfessionsBookFrame:IsShown() and IsModuleEnabled() then
		ProfessionsBookFrame_Update();
	end
end)

function Artificer.UpdateProfessionStatusBarColors()
	local db = GetProfDB()
	local barColor = db.Colors.Bar
	
	if not barColor then return end

	local r, g, b, a, desat = barColor.r, barColor.g, barColor.b, barColor.a, barColor.desat

	local function ColorBar(barName)
		local bar = _G[barName]
		if bar then
			bar:SetStatusBarColor(r, g, b, a)
			local bg = bar:GetStatusBarTexture()
			if bg then bg:SetDesaturated(desat) end
			
			local left = _G[barName .. "Left"]
			if left then
				left:SetVertexColor(r, g, b, a)
				left:SetDesaturated(desat)
			end
			
			local right = _G[barName .. "Right"]
			if right then
				right:SetVertexColor(r, g, b, a)
				right:SetDesaturated(desat)
			end
		end
	end

	for i = 1, 2 do ColorBar("PrimaryProfession" .. i .. "StatusBar") end
	for i = 1, 4 do ColorBar("SecondaryProfession" .. i .. "StatusBar") end
end

function Artificer.UpdateProfessionGlobalColors()
	local db = GetProfDB()
	if ProfessionsBookFrame then
		if ProfessionsBookFrame.ArtificerPageLeft then
			local c = db.Colors.BookLeft or { r = 1, g = 1, b = 1, a = 1, desat = false }
			ProfessionsBookFrame.ArtificerPageLeft:SetVertexColor(c.r, c.g, c.b, c.a)
			ProfessionsBookFrame.ArtificerPageLeft:SetDesaturated(c.desat)
		end
		if ProfessionsBookFrame.ArtificerRibbon then
			local c = db.Colors.Ribbon or { r = 1, g = 1, b = 1, a = 1, desat = false }
			ProfessionsBookFrame.ArtificerRibbon:SetVertexColor(c.r, c.g, c.b, c.a)
			ProfessionsBookFrame.ArtificerRibbon:SetDesaturated(c.desat)
		end
	end
end

function Artificer:OpenProfessionsBookAdvancedSettings()
	if not self.ProfBookAdvancedFrame then
		local f = CreateFrame("Frame", "ArtificerProfBookAdvancedFrame", Artificer.SettingsFrame, "DialogBorderTranslucentTemplate");
		f:ClearAllPoints();
		f:SetSize(350, 520);
		f:SetPoint("LEFT", Artificer.SettingsFrame, "RIGHT", 45, 0);
		f:EnableMouse(true);
		f:Hide();

		tinsert(UISpecialFrames, "ArtificerProfBookAdvancedFrame");

		f:SetScript("OnHide", function() PlaySound(840); end)
		f:SetScript("OnShow", function() PlaySound(839); end)

		local closeButton = CreateFrame("Button", nil, f, "UIPanelCloseButtonNoScripts");
		closeButton:SetPoint("TOPRIGHT", 0, 0);
		closeButton:SetScript("OnClick", function() f:Hide() end);

		local titleBG = CreateFrame("Frame", nil, f, "DialogBorderTranslucentTemplate");
		titleBG:ClearAllPoints();
		titleBG:SetSize(160, 40);
		titleBG:SetPoint("BOTTOM", f, "TOP", 0, -15);

		local titleText = titleBG:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		titleText:SetPoint("CENTER");
		titleText:SetText(L["Widget_ProfessionsBook"]);
		titleBG:SetWidth(titleText:GetWidth() * 1.2);

		local gearCheck = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate");
		gearCheck:SetPoint("TOPLEFT", f, "TOPLEFT", 20, -35);
		gearCheck:SetSize(24, 24);
		local gearLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		gearLabel:SetPoint("LEFT", gearCheck, "RIGHT", 4, 0);
		gearLabel:SetText(L["ProfBook_ShowGear"]);
		gearCheck:SetScript("OnClick", function(self)
			if not Artificer_DB.ProfessionsBook then Artificer_DB.ProfessionsBook = {}; end
			Artificer_DB.ProfessionsBook.showGearSlots = self:GetChecked();
			if ProfessionsBookFrame and ProfessionsBookFrame:IsShown() then ProfessionsBookFrame_Update(); end
		end)

		local autoCheck = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate");
		autoCheck:SetPoint("TOPLEFT", gearCheck, "BOTTOMLEFT", 0, -10);
		autoCheck:SetSize(24, 24);
		local autoLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		autoLabel:SetPoint("LEFT", autoCheck, "RIGHT", 4, 0);
		autoLabel:SetText(L["ProfBook_AutoOpen"]);
		autoCheck:SetScript("OnClick", function(self)
			if not Artificer_DB.ProfessionsBook then Artificer_DB.ProfessionsBook = {}; end
			Artificer_DB.ProfessionsBook.autoOpenBook = self:GetChecked();
		end)

		local timerCheck = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate");
		timerCheck:SetPoint("TOPLEFT", autoCheck, "BOTTOMLEFT", 0, -10);
		timerCheck:SetSize(24, 24);
		local timerLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		timerLabel:SetPoint("LEFT", timerCheck, "RIGHT", 4, 0);
		timerLabel:SetText(L["ProfBook_ShowTimer"]);
		timerCheck:SetScript("OnClick", function(self)
			if not Artificer_DB.ProfessionsBook then Artificer_DB.ProfessionsBook = {}; end
			Artificer_DB.ProfessionsBook.showTimer = self:GetChecked();
			if not self:GetChecked() and ProfessionEnchantTimer then ProfessionEnchantTimer:Hide(); end
		end)

		local dropButton = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate");
		dropButton:SetPoint("TOPLEFT", timerCheck, "BOTTOMLEFT", 6, -30);
		dropButton:SetWidth(160);

		local styleLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		styleLabel:SetPoint("BOTTOMLEFT", dropButton, "TOPLEFT", 0, 10);
		styleLabel:SetText(L["FNP_IconStyle"]);

		local STYLE_OPTIONS = {
			{ text = L["ProfBook_StyleModern"], value = "icon" },
			{ text = L["ProfBook_StyleAtlas"], value = "secondaryicon" },
			{ text = L["ProfBook_StyleClassic"], value = "oldicon" },
			{ text = L["ProfBook_StyleProfBook"], value = "professionbook" },
			{ text = L["ProfBook_StyleSpell"], value = "journal" },
		};

		local function GetStyleText(val)
			for _, opt in ipairs(STYLE_OPTIONS) do
				if opt.value == val then
					return opt.text;
				end
			end
			return STYLE_OPTIONS[1].text;
		end

		local function UpdateDropButtonText()
			local currentStyle = GetProfDB().iconStyle or "icon";
			dropButton.Text:SetText(GetStyleText(currentStyle));
		end

		dropButton:SetupMenu(function(dropdown, rootDescription)
			rootDescription:SetTag("ARTIFICER_PROFBOOK_ICONSTYLE");

			for _, opt in ipairs(STYLE_OPTIONS) do
				rootDescription:CreateRadio(opt.text,
					function()
						return GetProfDB().iconStyle == opt.value;
					end,
					function()
						if not Artificer_DB.ProfessionsBook then Artificer_DB.ProfessionsBook = {}; end
						Artificer_DB.ProfessionsBook.iconStyle = opt.value;
						UpdateDropButtonText();
						if ProfessionsBookFrame and ProfessionsBookFrame:IsShown() then
							ProfessionsBookFrame_Update();
						end
					end
				)
			end
		end)

		UpdateDropButtonText();

		local customIconCheck = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate");
		customIconCheck:SetPoint("TOPLEFT", dropButton, "BOTTOMLEFT", -6, -20);
		customIconCheck:SetSize(24, 24);
		local customIconLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		customIconLabel:SetPoint("LEFT", customIconCheck, "RIGHT", 4, 0);
		customIconLabel:SetText(L["ProfBook_HideCustomIcons"]);
		customIconCheck:SetScript("OnClick", function(self)
			if not Artificer_DB.ProfessionsBook then Artificer_DB.ProfessionsBook = {}; end
			Artificer_DB.ProfessionsBook.hideCustomIcons = self:GetChecked();
			if ProfessionsBookFrame and ProfessionsBookFrame:IsShown() then ProfessionsBookFrame_Update(); end
		end)

		local defaultIconCheck = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate");
		defaultIconCheck:SetPoint("TOPLEFT", customIconCheck, "BOTTOMLEFT", 0, -10);
		defaultIconCheck:SetSize(24, 24);
		local defaultIconLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		defaultIconLabel:SetPoint("LEFT", defaultIconCheck, "RIGHT", 4, 0);
		defaultIconLabel:SetText(L["ProfBook_HideDefaultIcons"]);
		defaultIconCheck:SetScript("OnClick", function(self)
			if not Artificer_DB.ProfessionsBook then Artificer_DB.ProfessionsBook = {}; end
			Artificer_DB.ProfessionsBook.hideDefaultIcons = self:GetChecked();
			if ProfessionsBookFrame and ProfessionsBookFrame:IsShown() then ProfessionsBookFrame_Update(); end
		end)

		local scrollBox = CreateFrame("Frame", nil, f, "WowScrollBoxList");
		scrollBox:SetPoint("TOPLEFT", defaultIconCheck, "BOTTOMLEFT", -5, -10);
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
				rowFrame.desatCheck.Text:SetText(L["Desaturate"]);

				rowFrame.isInitialized = true;
			end

			rowFrame.cLabel:SetText(s.name);
			
			if s.isText then
				rowFrame.desatCheck:Hide();
			else
				rowFrame.desatCheck:Show();
			end

			local function GetCurrentColor()
				local db = GetProfDB();
				return db.Colors[s.key] or { r=1, g=1, b=1, a=1, desat=false };
			end

			local function ApplyColor(t)
				if not t then return; end
				rowFrame.swatch.Color:SetVertexColor(t.r, t.g, t.b, t.a);
				if not Artificer_DB.ProfessionsBook then Artificer_DB.ProfessionsBook = {}; end
				if not Artificer_DB.ProfessionsBook.Colors then Artificer_DB.ProfessionsBook.Colors = CopyTable(Artificer.Defaults.ProfessionsBook.Colors); end
				
				Artificer_DB.ProfessionsBook.Colors[s.key] = t;
				if ProfessionsBookFrame and ProfessionsBookFrame:IsShown() then
					ProfessionsBookFrame_Update();
					Artificer.UpdateProfessionStatusBarColors();
					Artificer.UpdateProfessionGlobalColors();
				end
			end

			local initColor = GetCurrentColor();
			rowFrame.swatch.Color:SetVertexColor(initColor.r, initColor.g, initColor.b, initColor.a);
			rowFrame.desatCheck:SetChecked(initColor.desat);

			rowFrame.desatCheck:SetScript("OnClick", function(self)
				local current = GetCurrentColor();
				current.desat = self:GetChecked();
				ApplyColor(current);
			end);

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
							ApplyColor(CopyTable(Artificer.Defaults.ProfessionsBook.Colors[s.key]));
						end);
					end);
					return;
				end

				local current = GetCurrentColor();
				local info = { r = current.r, g = current.g, b = current.b, opacity = current.a, hasOpacity = true };

				info.swatchFunc = function()
					local r, g, b = ColorPickerFrame:GetColorRGB();
					local a = ColorPickerFrame:GetColorAlpha();
					ApplyColor({ r = r, g = g, b = b, a = a, desat = rowFrame.desatCheck:GetChecked() });
				end;
				info.cancelFunc = function()
					local r, g, b, a = ColorPickerFrame:GetPreviousValues();
					ApplyColor({ r = r, g = g, b = b, a = a, desat = rowFrame.desatCheck:GetChecked() });
				end;
				ColorPickerFrame:SetupColorPickerAndShow(info);
			end);
		end);

		local colorElements = {
			{ key = "Bg", name = L["ProfBook_ColorBg"], isText = false },
			{ key = "BookLeft", name = L["ProfBook_ColorBookLeft"], isText = false },
			{ key = "Ribbon", name = L["ProfBook_ColorRibbon"], isText = false },
			{ key = "Name", name = L["ProfBook_ColorName"], isText = true },
			{ key = "Rank", name = L["ProfBook_ColorRank"], isText = true },
			{ key = "Bar", name = L["ProfBook_ColorBar"], isText = false },
			{ key = "BarText", name = L["ProfBook_ColorBarText"], isText = true },
		}
		
		local dataProvider = CreateDataProvider(colorElements);
		scrollView:SetDataProvider(dataProvider);

		f:HookScript("OnShow", function()
			local db = GetProfDB();
			gearCheck:SetChecked(db.showGearSlots);
			autoCheck:SetChecked(db.autoOpenBook);
			timerCheck:SetChecked(db.showTimer);
			customIconCheck:SetChecked(db.hideCustomIcons);
			defaultIconCheck:SetChecked(db.hideDefaultIcons);
			UpdateDropButtonText();
			Artificer.UpdateProfessionStatusBarColors();
			Artificer.UpdateProfessionGlobalColors();
		end)

		self.ProfBookAdvancedFrame = f;
	end

	if self.ProfBookAdvancedFrame:IsVisible() then
		self.ProfBookAdvancedFrame:Hide();
	else
		Artificer:CloseAllAdvancedFrames();
		self.ProfBookAdvancedFrame:Show();
	end
end