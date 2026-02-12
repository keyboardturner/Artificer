local addonName, Artificer = ...;

local L = Artificer.L;

local HistoryList = {};
local sessionHistory = {};
local presets = {
	42220,		-- Shipwrecked Sailors (Alliance)
	42268,		-- Shipwrecked Sailors (Horde)
};

local function InitializePresetHistory()
	for _, questID in ipairs(presets) do
		if not HistoryList[questID] then
			HistoryList[questID] = true;
			table.insert(sessionHistory, questID);
		end
	end
end

local function GetBlocklist()
	if not Artificer_DB.Widgets.AbandonQuest then
		Artificer_DB.Widgets.AbandonQuest = {};
	end
	return Artificer_DB.Widgets.AbandonQuest
end

local function AbandonQuestByID(questID)
	C_QuestLog.SetSelectedQuest(questID);
	C_QuestLog.SetAbandonQuest();
	C_QuestLog.AbandonQuest();
end

local function AddToBlocklist(questID)
	local db = GetBlocklist();
	db[questID] = true;
	if C_QuestLog.IsOnQuest(questID) then
		AbandonQuestByID(questID);
	end
	Artificer:UpdateAbandonQuestLists();
end

local function RemoveFromBlocklist(questID)
	local db = GetBlocklist();
	db[questID] = nil;
	Artificer:UpdateAbandonQuestLists();
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("QUEST_ACCEPTED")
frame:RegisterEvent("QUEST_REMOVED")

frame:SetScript("OnEvent", function(self, event, questID, wasReplayQuest)
	if InCombatLockdown() then return end
	
	if event == "QUEST_ACCEPTED" then
		local db = GetBlocklist()
		
		if not HistoryList[questID] then
			HistoryList[questID] = true;
			table.insert(sessionHistory, 1, questID);
			if Artificer.AbandonQuestFrame and Artificer.AbandonQuestFrame:IsShown() then
				Artificer:UpdateAbandonQuestLists();
			end
		end
		
		if db[questID] then
			AbandonQuestByID(questID);
		end
	end
end)

local aqFrame;
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
	f.SubText:SetText(data.questID)
	f.SubText:SetTextColor(0.5, 0.5, 0.5)

	f.ActionBtn = CreateFrame("Button", nil, f)
	f.ActionBtn:SetSize(20, 20)
	f.ActionBtn:SetPoint("RIGHT", -4, 0)

	f.ActionBtn.Texture = f.ActionBtn:CreateTexture(nil, "ARTWORK")
	f.ActionBtn.Texture:SetAllPoints()

	local questTitle = C_QuestLog.GetTitleForQuestID(data.questID)
	if questTitle and questTitle ~= "" then
		f.Text:SetText(questTitle)
		f.SubText:SetText(data.questID)
	else
		f.Text:SetText(string.format(L["QuestID"],data.questID))
		f.SubText:SetText(data.questID)
	end
	
	f.Icon:SetAtlas("QuestLog-tab-icon-quest")

	if data.isBlocklist then
		f.ActionBtn.Texture:SetAtlas("Map-MarkedDefeated")
		
		f.ActionBtn:SetScript("OnClick", function()
			RemoveFromBlocklist(data.questID);
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
		if db[data.questID] then
			f.ActionBtn:Disable();
			f.ActionBtn:SetAlpha(0.3);
			f.ActionBtn.Texture:SetDesaturated(true);
		else
			f.ActionBtn:Enable();
			f.ActionBtn:SetAlpha(1);
			f.ActionBtn.Texture:SetDesaturated(false);
		end
		
		f.ActionBtn:SetScript("OnClick", function()
			AddToBlocklist(data.questID);
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
		local questTitle = C_QuestLog.GetTitleForQuestID(data.questID)
		if questTitle and questTitle ~= "" then
			GameTooltip:SetText(questTitle, 1, 1, 1)
			GameTooltip:AddLine(string.format(L["QuestID"],data.questID), 0.5, 0.5, 0.5)
			local questTagInfo = C_QuestLog.GetQuestTagInfo(data.questID)
			if questTagInfo and questTagInfo.tagName then
				GameTooltip:AddLine(questTagInfo.tagName, 1, 0.82, 0)
			end
		else
			GameTooltip:SetText(string.format(L["QuestID"],data.questID), 1, 1, 1)
		end
		GameTooltip:Show();
	end)
	f:SetScript("OnLeave", GameTooltip_Hide)

	return f
end

function Artificer:UpdateAbandonQuestLists()
	if not aqFrame or not aqFrame:IsShown() then return end

	local blockData = {}
	for questID, enabled in pairs(GetBlocklist()) do
		if enabled then
			table.insert(blockData, { questID = questID, isBlocklist = true });
		end
	end
	table.sort(blockData, function(a,b) return a.questID < b.questID end)
	
	local dataProviderBlock = CreateDataProvider(blockData)
	scrollBoxBlocklist:SetDataProvider(dataProviderBlock)

	local historyData = {}
	for _, questID in ipairs(sessionHistory) do
		table.insert(historyData, { questID = questID, isBlocklist = false });
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

local function CreateAbandonQuestPanel()
	if aqFrame then return aqFrame end
	
	aqFrame = CreateFrame("Frame", "ArtificerAbandonQuestFrame", UIParent, "ButtonFrameTemplate")
	Artificer.AbandonQuestFrame = aqFrame
	aqFrame:SetSize(600, 450)
	aqFrame:SetPoint("CENTER")
	aqFrame:SetToplevel(true)
	aqFrame:EnableMouse(true)
	aqFrame:SetMovable(true)
	aqFrame:SetClampedToScreen(true)
	aqFrame:RegisterForDrag("LeftButton")
	aqFrame:SetScript("OnDragStart", aqFrame.StartMoving)
	aqFrame:SetScript("OnDragStop", aqFrame.StopMovingOrSizing)

	aqFrame.BgIcon = aqFrame:CreateTexture(nil, "BACKGROUND", nil, 1)
	aqFrame.BgIcon:SetPoint("CENTER", 0, 0)
	aqFrame.BgIcon:SetSize(aqFrame:GetHeight()*.75, aqFrame:GetHeight()*.75)
	aqFrame.BgIcon:SetTexture("Interface\\AddOns\\Artificer\\Textures\\ArtificerIcon_Small.blp")
	aqFrame.BgIcon:SetDesaturated(true)
	aqFrame.BgIcon:SetVertexColor(0.1, 0.1, 0.1, 0.2)

	aqFrame:Hide()

	aqFrame:SetScript("OnShow", function()
		if Artificer.SettingsFrame.AbandonQuestTab then
			Artificer.SettingsFrame.AbandonQuestTab.SelectedTexture:Show();
		end
	end)
	aqFrame:SetScript("OnHide", function()
		if Artificer.SettingsFrame.AbandonQuestTab then
			Artificer.SettingsFrame.AbandonQuestTab.SelectedTexture:Hide();
		end
	end)
	
	ButtonFrameTemplate_HidePortrait(aqFrame)
	ButtonFrameTemplate_HideButtonBar(aqFrame)
	
	tinsert(UISpecialFrames, "ArtificerAbandonQuestFrame")
	
	if aqFrame.Inset then
		aqFrame.Inset:Hide();
	end
	
	aqFrame:SetTitle(string.join(" - ", L["TOC_Title"], L["AbandonQuestManager"]))
	
	aqFrame.Bg = aqFrame:CreateTexture(nil, "BACKGROUND", nil, -7)
	aqFrame.Bg:SetColorTexture(0.1, 0.1, 0.1, 0.95)
	aqFrame.Bg:SetPoint("TOPLEFT", 2, -22)
	aqFrame.Bg:SetPoint("BOTTOMRIGHT", -2, 2)

	local inputBox = CreateFrame("EditBox", nil, aqFrame, "InputBoxTemplate")
	inputBox:SetSize(120, 30)
	inputBox:SetPoint("TOPLEFT", 25, -40)
	inputBox:SetAutoFocus(false)
	inputBox:SetNumeric(true)
	inputBox:SetTextInsets(5, 5, 0, 0)
	inputBox.Instructions = inputBox:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
	inputBox.Instructions:SetText(L["EnterQuestID"])
	inputBox.Instructions:SetPoint("LEFT", 5, 0)
	
	inputBox:SetScript("OnEditFocusGained", function(self) self.Instructions:Hide() end)
	inputBox:SetScript("OnEditFocusLost", function(self) if self:GetText() == "" then self.Instructions:Show() end end)

	local addBtn = CreateFrame("Button", nil, aqFrame, "UIPanelButtonTemplate")
	addBtn:SetSize(80, 24)
	addBtn:SetPoint("LEFT", inputBox, "RIGHT", 10, 0)
	addBtn:SetText(L["Add"])
	addBtn:SetScript("OnClick", function()
		local id = tonumber(inputBox:GetText())
		if id then
			AddToBlocklist(id);
			inputBox:SetText("");
			inputBox.Instructions:Show();
			inputBox:ClearFocus();
		end
	end)

	local leftFrame, leftBox = CreateScrollList(aqFrame, L["AbandonedQuests"])
	leftFrame:SetPoint("TOPLEFT", 20, -80)
	leftFrame:SetPoint("BOTTOMLEFT", 20, 20)
	leftFrame:SetWidth(270)
	scrollBoxBlocklist = leftBox

	local rightFrame, rightBox = CreateScrollList(aqFrame, L["QuestHistory"])
	rightFrame:SetPoint("TOPRIGHT", -20, -80)
	rightFrame:SetPoint("BOTTOMRIGHT", -20, 20)
	rightFrame:SetWidth(270)
	scrollBoxHistory = rightBox
	
	return aqFrame
end

function Artificer:ShowAbandonQuestUI()
	local frame = CreateAbandonQuestPanel();
	frame:Show();
	Artificer:UpdateAbandonQuestLists();
end

function Artificer:HideAbandonQuestUI()
	if aqFrame then
		aqFrame:Hide();
	end
end

function Artificer:ToggleAbandonQuestUI()
	if not aqFrame or not aqFrame:IsShown() then
		Artificer:ShowAbandonQuestUI();
	else
		Artificer:HideAbandonQuestUI();
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
			
			if parent.AbandonQuestTab then return end

			local tab = CreateFrame("CheckButton", nil, parent, "LargeSideTabButtonTemplate")
			tab:SetPoint("TOPLEFT", parent, "TOPRIGHT", 0, -90)

			tab.Icon:SetAtlas("QuestLog-tab-icon-quest")
			--tab.Icon:SetDesaturated(true)
			--tab.Icon:SetVertexColor(.83, .62, 0.10, 1)
			tab.Icon:SetSize(tab:GetWidth(),tab:GetWidth())

			tab:SetScript("OnClick", function(self)
				if aqFrame and aqFrame:IsVisible() then
					Artificer:HideAbandonQuestUI();
				else
					Artificer:ShowAbandonQuestUI();
				end
			end)

			tab:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				GameTooltip:SetText(L["AbandonQuestManager"]);
				GameTooltip:AddLine(L["AbandonQuestManagerTT"], 1, 1, 1, true);
				GameTooltip:Show();
			end)
			tab:SetScript("OnLeave", GameTooltip_Hide)

			tab.SelectedTexture:Hide()

			parent.AbandonQuestTab = tab
		end)
	end
end)