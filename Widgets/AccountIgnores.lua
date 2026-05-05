local addonName, Artificer = ...;
local L = Artificer.L;

Artificer.AccountIgnores = {};
Artificer.AccountFriends = {};
local AccountIgnores = Artificer.AccountIgnores;
local AccountFriends = Artificer.AccountFriends;

local function GetDB()
	if not Artificer_DB.AccountIgnores then Artificer_DB.AccountIgnores = {}; end
	return Artificer_DB.AccountIgnores;
end
local function GetFriendsDB()
	if not Artificer_DB.AccountFriends then Artificer_DB.AccountFriends = {}; end
	return Artificer_DB.AccountFriends;
end

local function GetCurrentCharKey()
	return UnitName("player") .. "-" .. GetRealmName();
end

local function FormatIgnoreName(ignoreName, ownerRealm)
	if string.find(ignoreName, "-") then
		return ignoreName;
	else
		return ignoreName .. "-" .. ownerRealm;
	end
end

function AccountIgnores:SyncCurrentCharacter()
	local numIgnores = C_FriendList.GetNumIgnores()
	if not numIgnores then return; end

	local charKey = GetCurrentCharKey()
	local db = GetDB()
	local currentIgnores = {};

	for i = 1, numIgnores do
		local name = C_FriendList.GetIgnoreName(i);
		if name then
			table.insert(currentIgnores, name);
		end
	end

	if #currentIgnores > 0 then
		db[charKey] = currentIgnores;
	else
		db[charKey] = nil;
	end
end

function AccountFriends:SyncCurrentCharacter()
	local numFriends = C_FriendList.GetNumFriends()
	if not numFriends then return; end

	local charKey = GetCurrentCharKey()
	local db = GetFriendsDB()
	local currentFriends = {};

	for i = 1, numFriends do
		local friendInfo = C_FriendList.GetFriendInfoByIndex(i);
		if friendInfo and friendInfo.name then
			table.insert(currentFriends, friendInfo.name);
		end
	end

	if #currentFriends > 0 then
		db[charKey] = currentFriends;
	else
		db[charKey] = nil;
	end
end

local container;
local scrollBox;
local scrollView;

local function InitializeRow(frame, data)
	if not frame.Text then
		frame.Text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		frame.Text:SetJustifyH("LEFT");
		frame.Text:SetPoint("LEFT", 5, 0);
		frame.Text:SetPoint("RIGHT", -5, 0);
	end

	if data.isHeader then
		frame.Text:SetFontObject("GameFontNormalLarge");
		frame.Text:SetTextColor(1, 0.82, 0);
		frame.Text:SetText(data.text);
	else
		frame.Text:SetFontObject("GameFontHighlight");
		frame.Text:SetTextColor(0.8, 0.8, 0.8);
		frame.Text:SetText(data.text);
	end
end

local function UpdateScrollList()
	if not scrollView then return; end

	local db = GetDB()
	local dataProvider = CreateDataProvider()
	local currentChar = GetCurrentCharKey()

	for charKey, ignoreList in pairs(db) do
		if charKey ~= currentChar then
			local _, _, charRealm = string.find(charKey, "-(.+)$");
			charRealm = charRealm or GetRealmName();

			dataProvider:Insert({ isHeader = true, text = charKey });

			for _, ignoredPlayer in ipairs(ignoreList) do
				local formattedName = FormatIgnoreName(ignoredPlayer, charRealm);
				dataProvider:Insert({ isHeader = false, text = "   " .. formattedName });
			end
		end
	end

	scrollView:SetDataProvider(dataProvider);
end

local function CreateUI()
	if container then return; end

	local parentFrame = FriendsFrame.IgnoreListWindow
	local targetPoint = FriendsFrame
	
	if C_AddOns.IsAddOnLoaded("BetterFriendlist") and BetterFriendsFrame then
		parentFrame = BetterFriendsFrame.IgnoreListWindow;
		targetPoint = BetterFriendsFrame;
	end

	container = CreateFrame("Frame", "ArtificerAccountIgnores", parentFrame, "BackdropTemplate")
	container:SetPoint("TOPLEFT", parentFrame, "TOPRIGHT", 5, 0)
	container:SetPoint("BOTTOMLEFT", parentFrame, "BOTTOMRIGHT", 5, 0)
	container:SetWidth(275)

	container:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	})
	container:SetBackdropColor(0, 0, 0, 0.8)

	container.Title = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	container.Title:SetPoint("TOP", 0, -10)
	container.Title:SetText(L["AccountIgnoreList"])

	local scrollBoxFrame = CreateFrame("Frame", nil, container, "WowScrollBoxList")
	scrollBoxFrame:SetPoint("TOPLEFT", container, "TOPLEFT", 10, -30)
	scrollBoxFrame:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", -26, 10)

	local scrollBar = CreateFrame("EventFrame", nil, container, "MinimalScrollBar")
	scrollBar:SetPoint("TOPLEFT", scrollBoxFrame, "TOPRIGHT", 4, 0)
	scrollBar:SetPoint("BOTTOMLEFT", scrollBoxFrame, "BOTTOMRIGHT", 4, 0)

	scrollView = CreateScrollBoxListLinearView()
	scrollView:SetElementInitializer("Frame", InitializeRow)
	scrollView:SetPadding(5, 5, 5, 5, 2)
	scrollView:SetElementExtent(20)

	ScrollUtil.InitScrollBoxListWithScrollBar(scrollBoxFrame, scrollBar, scrollView)
	
	scrollBox = scrollBoxFrame
end

local function OnIgnoreWindowShow()
	if not container then CreateUI(); end
	
	local showFrame = true
	if Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.AccountIgnoresWindow ~= nil then
		showFrame = Artificer_DB.Widgets.AccountIgnoresWindow;
	end

	if showFrame then
		container:Show();
	else
		container:Hide();
	end
	
	AccountIgnores:SyncCurrentCharacter()
	UpdateScrollList()

	if showFrame then
		local mainFrame = FriendsFrame;
		local ignoreWindow = FriendsFrame.IgnoreListWindow;

		if C_AddOns.IsAddOnLoaded("BetterFriendlist") and BetterFriendsFrame then
			mainFrame = BetterFriendsFrame;
			ignoreWindow = BetterFriendsFrame.IgnoreListWindow;
		end

		if ignoreWindow and mainFrame then
			local sizeX = mainFrame:GetWidth()*.75;
			local sizeY = mainFrame:GetHeight()*.85;
			
			ignoreWindow:SetSize(sizeX, sizeY);
		end
	end
end

function Artificer.AccountIgnores_ToggleVisibility(val)
	local isWindowVisible = (FriendsFrame and FriendsFrame.IgnoreListWindow and FriendsFrame.IgnoreListWindow:IsVisible()) or (BetterFriendsFrame and BetterFriendsFrame.IgnoreListWindow and BetterFriendsFrame.IgnoreListWindow:IsVisible())

	if isWindowVisible and container then
		if val then
			container:Show();
			local mainFrame = C_AddOns.IsAddOnLoaded("BetterFriendlist") and BetterFriendsFrame or FriendsFrame;
			local ignoreWindow = C_AddOns.IsAddOnLoaded("BetterFriendlist") and BetterFriendsFrame.IgnoreListWindow or FriendsFrame.IgnoreListWindow;
			if ignoreWindow and mainFrame then
				ignoreWindow:SetSize(mainFrame:GetWidth()*.75, mainFrame:GetHeight()*.85);
			end
		else
			container:Hide();
		end
	end
end

local function OnIgnoreWindowHide()
	if container then
		container:Hide();
	end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("IGNORELIST_UPDATE")
eventFrame:RegisterEvent("FRIENDLIST_UPDATE")

eventFrame:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == addonName then
		if FriendsFrame and FriendsFrame.IgnoreListWindow then
			FriendsFrame.IgnoreListWindow:HookScript("OnShow", OnIgnoreWindowShow);
			FriendsFrame.IgnoreListWindow:HookScript("OnHide", OnIgnoreWindowHide);
		end

	elseif event == "IGNORELIST_UPDATE" then
		AccountIgnores:SyncCurrentCharacter()
		if container and container:IsVisible() then
			UpdateScrollList();
		end

	elseif event == "FRIENDLIST_UPDATE" then
		Artificer.AccountFriends:SyncCurrentCharacter();
	end
end)

local function BFL_Loaded()
	if BetterFriendsFrame and BetterFriendsFrame.IgnoreListWindow then
		BetterFriendsFrame.IgnoreListWindow:HookScript("OnShow", OnIgnoreWindowShow);
		BetterFriendsFrame.IgnoreListWindow:HookScript("OnHide", OnIgnoreWindowHide);
	end
end


EventUtil.ContinueOnAddOnLoaded("BetterFriendlist", BFL_Loaded);