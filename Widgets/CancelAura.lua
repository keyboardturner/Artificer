local addonName, Artificer = ...;

local L = Artificer.L;

local HistoryList = {};
local sessionHistory = {};
local presets = {
	301893,		-- Paintbot Blue
	301894,		-- Paintbot Green
	301892,		-- Paintbot Orange
	44212,		-- Jack-o'-Lanterned!
	399502,		-- Atomically Recalibrated
	1215363,	-- Atomically Regoblinated
	279509,		-- A Witch!
	58493,		-- Mohawked!
	61781,		-- Turkey Feathers
};

local function InitializePresetHistory()
	for _, spellID in ipairs(presets) do
		if not HistoryList[spellID] then
			HistoryList[spellID] = true;
			table.insert(sessionHistory, spellID);
		end
	end
end

local function GetBlocklist()
	if not Artificer_DB.Widgets.CancelAura then
		Artificer_DB.Widgets.CancelAura = {};
	end
	return Artificer_DB.Widgets.CancelAura
end

local function AddToBlocklist(spellID)
	local db = GetBlocklist();
	db[spellID] = true;
	C_Spell.CancelSpellByID(spellID);
	Artificer:UpdateCancelAuraLists();
end

local function RemoveFromBlocklist(spellID)
	local db = GetBlocklist();
	db[spellID] = nil;
	Artificer:UpdateCancelAuraLists();
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_AURA")

frame:SetScript("OnEvent", function(self, event, unit, info)
	if InCombatLockdown() then return end
	if info.addedAuras and not issecretvalue(unit) and not issecretvalue(info) and unit == "player" then
		local db = GetBlocklist()
		for _, v in pairs(info.addedAuras) do
			local aura = v.spellId;
			if not HistoryList[aura] then
				HistoryList[aura] = true;
				table.insert(sessionHistory, 1, aura);
				if Artificer.CancelAuraFrame and Artificer.CancelAuraFrame:IsShown() then
					Artificer:UpdateCancelAuraLists();
				end
			end
			if db[aura] then
				C_Spell.CancelSpellByID(aura);
			end
		end
	end
end)

local caFrame;
local scrollBoxBlocklist, scrollBoxHistory;

local function CreateListRow(parent, data)
	local f = CreateFrame("Button", nil, parent)
	f:SetSize(parent:GetWidth(), 30)
	
	f.Icon = f:CreateTexture(nil, "ARTWORK")
	f.Icon:SetSize(24, 24)
	f.Icon:SetPoint("LEFT", 4, 0)
	
	f.Text = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	f.Text:SetPoint("LEFT", f.Icon, "RIGHT", 8, 0)
	f.Text:SetPoint("RIGHT", -50, 0)
	f.Text:SetJustifyH("LEFT")
	f.Text:SetWordWrap(false)
	
	f.SubText = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	f.SubText:SetPoint("BOTTOMLEFT", f.Text, "BOTTOMLEFT", 0, -8)
	f.SubText:SetText(data.spellID)
	f.SubText:SetTextColor(0.5, 0.5, 0.5)

	f.ActionBtn = CreateFrame("Button", nil, f)
	f.ActionBtn:SetSize(20, 20)
	f.ActionBtn:SetPoint("RIGHT", -4, 0)

	f.ActionBtn.Texture = f.ActionBtn:CreateTexture(nil, "ARTWORK")
	f.ActionBtn.Texture:SetAllPoints()

	local spell = Spell:CreateFromSpellID(data.spellID)
	f.Icon:SetTexture(134400)
	f.Text:SetText(L["Loading"])

	spell:ContinueOnSpellLoad(function()
		f.Text:SetText(spell:GetSpellName());
		f.SubText:SetText(data.spellID);
		f.Icon:SetTexture(spell:GetSpellTexture());
	end)

	if data.isBlocklist then
		f.ActionBtn.Texture:SetAtlas("Map-MarkedDefeated")
		
		f.ActionBtn:SetScript("OnClick", function()
			RemoveFromBlocklist(data.spellID);
		end)
		
		f.ActionBtn:SetScript("OnEnter", function(self)
			self.Texture:SetAlpha(0.7);
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(L["Remove"]);
			GameTooltip:Show();
		end)
	else
		f.ActionBtn.Texture:SetAtlas("GreenCross")
		
		local db = GetBlocklist()
		if db[data.spellID] then
			f.ActionBtn:Disable();
			f.ActionBtn:SetAlpha(0.3);
			f.ActionBtn.Texture:SetDesaturated(true);
		else
			f.ActionBtn:Enable();
			f.ActionBtn:SetAlpha(1);
			f.ActionBtn.Texture:SetDesaturated(false);
		end
		
		f.ActionBtn:SetScript("OnClick", function()
			AddToBlocklist(data.spellID);
		end)
		
		f.ActionBtn:SetScript("OnEnter", function(self)
			if self:IsEnabled() then self.Texture:SetAlpha(0.7); end
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(L["Add"]);
			GameTooltip:Show();
		end)
	end
	
	f.ActionBtn:SetScript("OnLeave", function(self)
		self.Texture:SetAlpha(1);
		GameTooltip_Hide();
	end)
	
	f:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetSpellByID(data.spellID);
		GameTooltip:Show();
	end)
	f:SetScript("OnLeave", GameTooltip_Hide)

	return f
end

function Artificer:UpdateCancelAuraLists()
	if not caFrame or not caFrame:IsShown() then return end

	local blockData = {}
	for spellID, enabled in pairs(GetBlocklist()) do
		if enabled then
			table.insert(blockData, { spellID = spellID, isBlocklist = true });
		end
	end
	table.sort(blockData, function(a,b) return a.spellID < b.spellID end)
	
	local dataProviderBlock = CreateDataProvider(blockData)
	scrollBoxBlocklist:SetDataProvider(dataProviderBlock)

	local historyData = {}
	for _, spellID in ipairs(sessionHistory) do
		table.insert(historyData, { spellID = spellID, isBlocklist = false });
	end
	
	local dataProviderHistory = CreateDataProvider(historyData)
	scrollBoxHistory:SetDataProvider(dataProviderHistory)
end

local function CreateScrollList(parent, titleText)
	local container = CreateFrame("Frame", nil, parent, "BackdropTemplate")
	container:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	})
	container:SetBackdropColor(0, 0, 0, 0.5)

	local title = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	title:SetPoint("BOTTOMLEFT", container, "TOPLEFT", 5, 1)
	title:SetText(titleText)

	local scrollBox = CreateFrame("Frame", nil, container, "WowScrollBoxList")
	scrollBox:SetPoint("TOPLEFT", 6, -6)
	scrollBox:SetPoint("BOTTOMRIGHT", -26, 6)

	local scrollBar = CreateFrame("EventFrame", nil, container, "MinimalScrollBar")
	scrollBar:SetPoint("TOPLEFT", scrollBox, "TOPRIGHT", 4, 0)
	scrollBar:SetPoint("BOTTOMLEFT", scrollBox, "BOTTOMRIGHT", 4, 0)

	local scrollView = CreateScrollBoxListLinearView()
	scrollView:SetElementInitializer("Frame", function(button, data)
		if button.content then button.content:Hide() end
		button.content = CreateListRow(button, data);
		button.content:SetAllPoints();
		button.content:Show();
	end)
	
	scrollView:SetElementExtent(35)
	scrollView:SetPadding(2, 2, 2, 2, 2)

	ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, scrollView)

	return container, scrollBox
end

local function CreateCancelAuraPanel()
	if caFrame then return caFrame end
	
	caFrame = CreateFrame("Frame", "ArtificerCancelAuraFrame", UIParent, "ButtonFrameTemplate")
	Artificer.CancelAuraFrame = caFrame
	caFrame:SetSize(600, 450)
	caFrame:SetPoint("CENTER")
	caFrame:SetToplevel(true)
	caFrame:EnableMouse(true)
	caFrame:SetMovable(true)
	caFrame:SetClampedToScreen(true)
	caFrame:RegisterForDrag("LeftButton")
	caFrame:SetScript("OnDragStart", caFrame.StartMoving)
	caFrame:SetScript("OnDragStop", caFrame.StopMovingOrSizing)

	caFrame.BgIcon = caFrame:CreateTexture(nil, "BACKGROUND", nil, 1)
	caFrame.BgIcon:SetPoint("CENTER", 0, 0)
	caFrame.BgIcon:SetSize(caFrame:GetHeight()*.75, caFrame:GetHeight()*.75)
	caFrame.BgIcon:SetTexture("Interface\\AddOns\\Artificer\\Textures\\ArtificerIcon_Small.blp")
	caFrame.BgIcon:SetDesaturated(true)
	caFrame.BgIcon:SetVertexColor(0.1, 0.1, 0.1, 0.2)

	caFrame:Hide()

	caFrame:SetScript("OnShow", function()
		if Artificer.SettingsFrame.CancelAuraTab then
			Artificer.SettingsFrame.CancelAuraTab.SelectedTexture:Show();
		end
	end)
	caFrame:SetScript("OnHide", function()
		if Artificer.SettingsFrame.CancelAuraTab then
			Artificer.SettingsFrame.CancelAuraTab.SelectedTexture:Hide();
		end
	end)
	
	ButtonFrameTemplate_HidePortrait(caFrame)
	ButtonFrameTemplate_HideButtonBar(caFrame)
	
	tinsert(UISpecialFrames, "ArtificerCancelAuraFrame")
	
	if caFrame.Inset then
		caFrame.Inset:Hide();
	end
	
	caFrame:SetTitle(string.join(" - ", L["TOC_Title"], L["CancelAuraManager"]))
	
	caFrame.Bg = caFrame:CreateTexture(nil, "BACKGROUND", nil, -7)
	caFrame.Bg:SetColorTexture(0.1, 0.1, 0.1, 0.95)
	caFrame.Bg:SetPoint("TOPLEFT", 2, -22)
	caFrame.Bg:SetPoint("BOTTOMRIGHT", -2, 2)

	local inputBox = CreateFrame("EditBox", nil, caFrame, "InputBoxTemplate")
	inputBox:SetSize(120, 30)
	inputBox:SetPoint("TOPLEFT", 25, -40)
	inputBox:SetAutoFocus(false)
	inputBox:SetNumeric(true)
	inputBox:SetTextInsets(5, 5, 0, 0)
	inputBox.Instructions = inputBox:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
	inputBox.Instructions:SetText(L["EnterSpellID"])
	inputBox.Instructions:SetPoint("LEFT", 5, 0)
	
	inputBox:SetScript("OnEditFocusGained", function(self) self.Instructions:Hide() end)
	inputBox:SetScript("OnEditFocusLost", function(self) if self:GetText() == "" then self.Instructions:Show() end end)

	local addBtn = CreateFrame("Button", nil, caFrame, "UIPanelButtonTemplate")
	addBtn:SetSize(80, 24)
	addBtn:SetPoint("LEFT", inputBox, "RIGHT", 10, 0)
	addBtn:SetText(L["Add"])
	addBtn:SetScript("OnClick", function()
		local id = tonumber(inputBox:GetText())
		if id and C_Spell.DoesSpellExist(id) then
			AddToBlocklist(id);
			inputBox:SetText("");
			inputBox.Instructions:Show();
			inputBox:ClearFocus();
		end
	end)

	local leftFrame, leftBox = CreateScrollList(caFrame, L["CanceledAuras"])
	leftFrame:SetPoint("TOPLEFT", 20, -80)
	leftFrame:SetPoint("BOTTOMLEFT", 20, 20)
	leftFrame:SetWidth(270)
	scrollBoxBlocklist = leftBox

	local rightFrame, rightBox = CreateScrollList(caFrame, L["AuraHistory"])
	rightFrame:SetPoint("TOPRIGHT", -20, -80)
	rightFrame:SetPoint("BOTTOMRIGHT", -20, 20)
	rightFrame:SetWidth(270)
	scrollBoxHistory = rightBox
	
	--[[
	local prevPresetBtn
	for _, spellID in ipairs(presets) do
		local btn = CreateFrame("Button", nil, caFrame)
		btn:SetSize(26, 26)
		
		if not prevPresetBtn then
			btn:SetPoint("BOTTOMLEFT", rightFrame, "TOPLEFT", 0, 15);
		else
			btn:SetPoint("LEFT", prevPresetBtn, "RIGHT", 4, 0);
		end
		
		btn.Icon = btn:CreateTexture(nil, "ARTWORK")
		btn.Icon:SetAllPoints()
		btn.Icon:SetTexture(134400)
		
		btn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
		
		local spell = Spell:CreateFromSpellID(spellID)
		spell:ContinueOnSpellLoad(function()
			btn.Icon:SetTexture(spell:GetSpellTexture());
		end)
		
		btn:SetScript("OnClick", function()
			AddToBlocklist(spellID)
		end)
		
		btn:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetSpellByID(spellID);
			GameTooltip:AddLine(" ");
			GameTooltip:AddLine(L["Add"], 0, 1, 0);
			GameTooltip:Show();
		end)
		btn:SetScript("OnLeave", GameTooltip_Hide)
		
		prevPresetBtn = btn
	end
	]]
	
	return caFrame
end

function Artificer:ShowCancelAuraUI()
	local frame = CreateCancelAuraPanel();
	frame:Show();
	Artificer:UpdateCancelAuraLists();
end

function Artificer:HideCancelAuraUI()
	if caFrame then
		caFrame:Hide();
	end
end

function Artificer:ToggleCancelAuraUI()
	if not caFrame or not caFrame:IsShown() then
		Artificer:ShowCancelAuraUI();
	else
		Artificer:HideCancelAuraUI();
	end
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("PLAYER_LOGIN")
loader:SetScript("OnEvent", function()
	InitializePresetHistory()

	if Artificer.CreateSettingsUI then
		hooksecurefunc(Artificer, "CreateSettingsUI", function()
			local parent = Artificer.SettingsFrame
			if not parent then return end
			
			if parent.CancelAuraTab then return end

			local tab = CreateFrame("CheckButton", nil, parent, "LargeSideTabButtonTemplate")
			tab:SetPoint("TOPLEFT", parent, "TOPRIGHT", 0, -30)

			tab.Icon:SetAtlas("icon_trackedbuffs")
			tab.Icon:SetSize(tab:GetWidth(),tab:GetWidth())

			tab:SetScript("OnClick", function(self)
				if caFrame and caFrame:IsVisible() then
					Artificer:HideCancelAuraUI();
				else
					Artificer:ShowCancelAuraUI();
				end
			end)

			tab:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				GameTooltip:SetText(L["CancelAuraManager"]);
				GameTooltip:AddLine(L["CancelAuraManagerTT"], 1, 1, 1, true);
				GameTooltip:Show();
			end)
			tab:SetScript("OnLeave", GameTooltip_Hide)

			tab.SelectedTexture:Hide()

			parent.CancelAuraTab = tab
		end)
	end
end)