local addonName, Artificer = ...;

local L = Artificer.L;

local function IsEnabled()
	return Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.LFDBackground;
end

local backgrounds = {
	--timewalking
	[2634] = "UI-EJ-Classic", -- Classic TWing
	[744] = "UI-EJ-BurningCrusade", -- TBC TWing
	[995] = "UI-EJ-WrathoftheLichKing", -- Wrath TWing
	[1146] = "UI-EJ-Cataclysm", -- Cata TWing
	[1453] = "UI-EJ-MistsofPandaria", -- MoP TWing
	[1971] = "UI-EJ-WarlordsofDraenor", -- WoD TWing
	[2274] = "UI-EJ-Legion", -- Legion TWing
	[2874] = "UI-EJ-BattleforAzeroth", -- BFA TWing
	[3076] = "UI-EJ-Shadowlands", -- SLs TWing
	[3143] = "UI-EJ-Dragonflight", -- DF TWing
	--[PLACEHOLDER] = "UI-EJ-TheWarWithin", -- TWW TWing
	--[PLACEHOLDER] = "ui-ej-midnight", -- Midnight TWing
	--[PLACEHOLDER] = "", -- Last Titan

	-- levelling queues
	[258] = "UI-EJ-Classic", -- Classic
	[259] = "UI-EJ-BurningCrusade", -- TBC
	[260] = "UI-EJ-BurningCrusade", -- TBC Heroic
	[261] = "UI-EJ-WrathoftheLichKing", -- Wrath
	[262] = "UI-EJ-WrathoftheLichKing", -- Wrath Heroic
	[300] = "UI-EJ-Cataclysm", -- Cata
	[301] = "UI-EJ-Cataclysm", -- Cata Heroic
	[463] = "UI-EJ-MistsofPandaria", -- MoP
	[462] = "UI-EJ-MistsofPandaria", -- MoP Heroic
	[2537] = "UI-EJ-MistsofPandaria", -- MoP Heroic 2
	[2538] = "UI-EJ-MistsofPandaria", -- MoP Timerunning
	[2539] = "UI-EJ-MistsofPandaria", -- MoP Heroic Timerunning
	--[493] = "UI-EJ-MistsofPandaria", -- MoP Scenario
	--[641] = "UI-EJ-MistsofPandaria", -- MoP Heroic Scenario
	--[2558] = "UI-EJ-MistsofPandaria", -- MoP Timerunning Scenario
	--[2559] = "UI-EJ-MistsofPandaria", -- MoP Timerunning Heroic Scenario
	[788] = "UI-EJ-WarlordsofDraenor", -- WoD
	[789] = "UI-EJ-WarlordsofDraenor", -- WoD Heroic
	[1045] = "UI-EJ-Legion", -- Legion
	[1046] = "UI-EJ-Legion", -- Legion Heroic
	--[2817] = "UI-EJ-Legion", -- Legion Timerunning Heroic
	--[2820] = "UI-EJ-Legion", -- Legion Timerunning
	[1670] = "UI-EJ-BattleforAzeroth", -- BFA
	[1671] = "UI-EJ-BattleforAzeroth", -- BFA Heroic
	[2086] = "UI-EJ-Shadowlands", -- SLs
	[2087] = "UI-EJ-Shadowlands", -- SLs Heroic
	[2350] = "UI-EJ-Dragonflight", -- DF
	[2351] = "UI-EJ-Dragonflight", -- DF Heroic
	[2516] = "UI-EJ-TheWarWithin", -- TWW
	[2517] = "UI-EJ-TheWarWithin", -- TWW Heroic
	[2723] = "UI-EJ-TheWarWithin", -- TWW Heroic S1
	[2807] = "UI-EJ-TheWarWithin", -- TWW Heroic S2
	[2993] = "UI-EJ-TheWarWithin", -- TWW Heroic S3

};

local frame = CreateFrame("Frame");
--local maskTexture = frame:CreateMaskTexture();
frame.inset = frame:CreateTexture(nil, "BORDER", nil, 5)
frame.inset:SetAtlas("AdventureMap-InsetMapBorder")

local function SetMaskTexture()
	--maskTexture:SetAllPoints(LFDQueueFrameBackground);
	--maskTexture:SetTexture(340816, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE");
	--LFDQueueFrameBackground:AddMaskTexture(maskTexture);
	LFDQueueFrameBackground:SetAllPoints(LFDParentFrameInset);
	LFDQueueFrameBackground:SetTexCoord(0.05,0.95,0.05,0.95);
	frame.inset:SetParent(LFDQueueFrame);
	frame.inset:SetPoint("TOPLEFT", LFDQueueFrameBackground, "TOPLEFT", -3, 3);
	frame.inset:SetPoint("BOTTOMRIGHT", LFDQueueFrameBackground, "BOTTOMRIGHT", 0, -3);
	frame.inset:SetTexCoord(0.025,0.975,0.0325,0.965);
	--LFDQueueFrameBackground:SetDrawLayer("BACKGROUND", -6); -- this stuff does not want to just behave
end

local function RevertTexCoords()
	LFDQueueFrameBackground:SetTexCoord(0,256/400,0,1);
	LFDQueueFrameBackground:SetAllPoints(LFDParentFrameInset);
end

local function SetBingusTexture(texture)
	if not texture then return; end

	LFDQueueFrameBackground:SetAtlas(texture);
	SetMaskTexture();
end

frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("LFG_LOCK_INFO_RECEIVED");
frame:RegisterEvent("LFG_UPDATE_RANDOM_INFO");
frame:RegisterEvent("LFG_UPDATE");
frame:RegisterEvent("LFG_QUEUE_STATUS_UPDATE");
frame:SetScript("OnEvent", function(self, event, addonName)
	if event == "ADDON_LOADED" then
		if addonName == "Blizzard_GroupFinder" or C_AddOns.IsAddOnLoaded("Blizzard_GroupFinder") then

			hooksecurefunc("LFDQueueFrame_SetTypeRandomDungeon", function()
				if not LFDQueueFrameBackground then return; end		
				if not IsEnabled() then return; end

				local dungeonID = LFDQueueFrame.type;

				if type(dungeonID) == "number" and backgrounds[dungeonID] then
					RunNextFrame(function() SetBingusTexture(backgrounds[dungeonID]) end);
				else
					RevertTexCoords();
				end
			end);

			hooksecurefunc("LFDQueueFrame_SetTypeSpecificDungeon", function()
				if not LFDQueueFrameBackground then return; end
				if not IsEnabled() then return; end

				local dungeonID = LFDQueueFrame.type;

				if type(dungeonID) == "number" and backgrounds[dungeonID] then
					SetBingusTexture(backgrounds[dungeonID]);
				else
					RevertTexCoords();
				end
			end)

			hooksecurefunc("LFDQueueFrame_SetTypeFollowerDungeon", function()
				if not LFDQueueFrameBackground then return; end
				if not IsEnabled() then return; end

				local dungeonID = LFDQueueFrame.type;

				if type(dungeonID) == "number" and backgrounds[dungeonID] then
					SetBingusTexture(backgrounds[dungeonID]);
				else
					RevertTexCoords();
				end
			end)

			PVEFrame:HookScript("OnShow", function()
				if not LFDQueueFrameBackground then return; end
				if not IsEnabled() then return; end

				local dungeonID = LFDQueueFrame.type;

				if type(dungeonID) == "number" and backgrounds[dungeonID] then
					SetBingusTexture(backgrounds[dungeonID]);
				else
					RevertTexCoords();
				end
			end)

			hooksecurefunc("GroupFinderFrame_ShowGroupFrame", function()
				if not LFDQueueFrameBackground then return; end
				if not IsEnabled() then return; end

				local dungeonID = LFDQueueFrame.type;

				if type(dungeonID) == "number" and backgrounds[dungeonID] then
					RunNextFrame(function() SetBingusTexture(backgrounds[dungeonID]); end);
				else
					RevertTexCoords();
				end
			end);

			hooksecurefunc("LFDQueueFrameRandom_UpdateFrame", function()
				if not LFDQueueFrameBackground then return; end		
				if not IsEnabled() then return; end

				local dungeonID = LFDQueueFrame.type;

				if type(dungeonID) == "number" and backgrounds[dungeonID] then
					SetBingusTexture(backgrounds[dungeonID]);
				else
					RevertTexCoords();
				end
			end);

			self:UnregisterEvent("ADDON_LOADED");
		end
	else
		if not LFDQueueFrameBackground then return; end
		if not IsEnabled() then return; end

		local dungeonID = LFDQueueFrame.type;

		if type(dungeonID) == "number" and backgrounds[dungeonID] then
			SetBingusTexture(backgrounds[dungeonID]);
		else
			RevertTexCoords();
		end
	end
end);

local function CleanupCustomEntryText(entry)
	if entry.LFDBackground_InstanceName then
		entry.LFDBackground_InstanceName:Hide();
		entry.LFDBackground_InstanceName:SetText("");
	end
end

hooksecurefunc("QueueStatusEntry_SetMinimalDisplay", CleanupCustomEntryText);
hooksecurefunc("QueueStatusEntry_SetFullDisplay", CleanupCustomEntryText);

hooksecurefunc("QueueStatusEntry_SetUpLFG", function(entry, category)
	if not IsEnabled() then return; end
	
	local mode = GetLFGMode(category);
	if mode ~= "queued" then return; end

	local activeID = select(18, GetLFGQueueStats(category));
	if not activeID then return; end

	local hasData, _, _, _, _, _, _, _, _, _, instanceName = GetLFGQueueStats(category, activeID);
	if not hasData or not instanceName or instanceName == "" then return; end

	if not entry.LFDBackground_InstanceName then
		entry.LFDBackground_InstanceName = entry:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	end

	entry.LFDBackground_InstanceName:SetText(instanceName);
	entry.LFDBackground_InstanceName:Show();

	entry.LFDBackground_InstanceName:ClearAllPoints();
	entry.LFDBackground_InstanceName:SetPoint("TOPLEFT", entry.Title, "BOTTOMLEFT", 0, -5);

	local textHeight = entry.LFDBackground_InstanceName:GetStringHeight();
	if textHeight == 0 then textHeight = 12 end
	local shiftHeight = textHeight + 5; 

	if entry.SubTitle and entry.SubTitle:IsShown() then
		entry.SubTitle:ClearAllPoints();
		entry.SubTitle:SetPoint("TOPLEFT", entry.LFDBackground_InstanceName, "BOTTOMLEFT", 0, -5);
	end

	local elementsToShift = {
		entry.HealersFound,
		entry.AverageWait,
		entry.TimeInQueue,
		entry.ExtraText
	};

	for _, el in ipairs(elementsToShift) do
		if el and el:IsShown() then
			local point, relativeTo, relativePoint, x, y = el:GetPoint(1);
			if relativeTo == entry and type(y) == "number" then
				el:SetPoint(point, relativeTo, relativePoint, x, y - shiftHeight);
			end
		end
	end

	entry:SetHeight(entry:GetHeight() + shiftHeight);
end)

local function GetQueuedLFDInstanceName()
	local mode = GetLFGMode(LE_LFG_CATEGORY_LFD);
	if mode ~= "queued" then return nil; end

	local activeID = select(18, GetLFGQueueStats(LE_LFG_CATEGORY_LFD));
	if not activeID then return nil; end

	local hasData, _, _, _, _, _, _, _, _, _, instanceName = GetLFGQueueStats(LE_LFG_CATEGORY_LFD, activeID);
	if not hasData or not instanceName or instanceName == "" then return nil; end

	return instanceName;
end

local function AppendQueueStatusToTooltip(self)
	if not IsEnabled() then return; end

	local instanceName = GetQueuedLFDInstanceName();
	if instanceName then
		if not GameTooltip:IsVisible() then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(self.GetText and self:GetText() or LEAVE_QUEUE); 
		end
		
		GameTooltip:AddLine(string.join(" ", QUEUED_FOR_SHORT, instanceName), 0.1, 1, 0.1, true); 
		GameTooltip:Show();
	end
end

if LFDQueueFrameFindGroupButton then
	LFDQueueFrameFindGroupButton:HookScript("OnEnter", AppendQueueStatusToTooltip);
end

if LFDQueueFrame and LFDQueueFrame.TypeDropdown then
	LFDQueueFrame.TypeDropdown:HookScript("OnEnter", AppendQueueStatusToTooltip);
end