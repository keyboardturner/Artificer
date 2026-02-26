local addonName, Artificer = ...;

local L = Artificer.L;

local openedBySlash = false;

local function GetGroupSizeInfo()
	local numMembers = GetNumGroupMembers();

	if numMembers == 0 then
		return 1, 1;
	end

	local maxPlayers;
	local instMax = select(5, GetInstanceInfo())
	local instGroupSize = select(9, GetInstanceInfo())
	if instGroupSize and instGroupSize > 0 then
		maxPlayers = instGroupSize;
	end

	return numMembers, maxPlayers;
end

local function ShouldAutoHide()
	local setting = Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.LootHistoryVisibility;

	if type(setting) ~= "table" then
		return false;
	end

	if setting.always then
		return true;
	end

	if setting.solo and GetNumGroupMembers() == 0 then
		return true;
	end

	if setting.notFull then
		local current, max = GetGroupSizeInfo();
		if not max then
			max = 0;
		end
		if current < max then
			return true;
		end
	end

	return false;
end

local function EvaluateVisibility()
	if not GroupLootHistoryFrame then return end;

	if ShouldAutoHide() then
		if openedBySlash then
			return;
		end
		if GroupLootHistoryFrame:IsShown() then
			GroupLootHistoryFrame:Hide();
		end
	end
end

local function HookGroupLootHistoryFrame()
	if not GroupLootHistoryFrame then return end;

	GroupLootHistoryFrame:HookScript("OnShow", function(self)
		if ShouldAutoHide() and not openedBySlash then
			self:Hide();
		end
	end);

	GroupLootHistoryFrame:HookScript("OnHide", function()
		openedBySlash = false;
	end);
end

local eventFrame = CreateFrame("Frame");
eventFrame:RegisterEvent("ADDON_LOADED");
eventFrame:RegisterEvent("PLAYER_LOGIN");
eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE");
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");

EventRegistry:RegisterFrameEventAndCallback("GROUP_ROSTER_UPDATE", function() EvaluateVisibility(); end);
EventRegistry:RegisterFrameEventAndCallback("PLAYER_ENTERING_WORLD", function()  EvaluateVisibility(); end);
EventRegistry:RegisterFrameEventAndCallback("LOOT_HISTORY_CLEAR_HISTORY", function() EvaluateVisibility(); end);
EventRegistry:RegisterFrameEventAndCallback("LOOT_HISTORY_GO_TO_ENCOUNTER", function() EvaluateVisibility(); end);
EventRegistry:RegisterFrameEventAndCallback("LOOT_HISTORY_ONE_HUNDRED_ROLL", function() EvaluateVisibility(); end);
EventRegistry:RegisterFrameEventAndCallback("LOOT_HISTORY_UPDATE_DROP", function() EvaluateVisibility(); end);
EventRegistry:RegisterFrameEventAndCallback("LOOT_HISTORY_UPDATE_ENCOUNTER", function() EvaluateVisibility(); end);

eventFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		local loaded = ...;
		if loaded == addonName then
			if Artificer_DB and Artificer_DB.Widgets then
				if type(Artificer_DB.Widgets.LootHistoryVisibility) ~= "table" then
					Artificer_DB.Widgets.LootHistoryVisibility = {
						solo = false,
						notFull = false,
						always = false,
					};
				end
			end
		end

		if loaded == "Blizzard_LootHistory" then
			HookGroupLootHistoryFrame();
			EvaluateVisibility();
		end

	elseif event == "PLAYER_LOGIN" then
		SLASH_ARTIFICER_LOOTHISTORY1 = SLASH_OPEN_LOOT_HISTORY1;
		SLASH_ARTIFICER_LOOTHISTORY2 = SLASH_OPEN_LOOT_HISTORY2;
		SLASH_ARTIFICER_LOOTHISTORY3 = SLASH_OPEN_LOOT_HISTORY3;
		SLASH_ARTIFICER_LOOTHISTORY4 = SLASH_OPEN_LOOT_HISTORY4;
		SlashCmdList["ARTIFICER_LOOTHISTORY"] = function()
			if not GroupLootHistoryFrame then
				LoadAddOn("Blizzard_LootHistory");
			end
			openedBySlash = true;
			GroupLootHistoryFrame:Show();
		end;
		if Artificer.RegisterLootHistoryVisibilitySetting then
			Artificer.RegisterLootHistoryVisibilitySetting();
		end
	end
end);

Artificer.Widgets.ApplyLootHistoryVisibility = function()
	EvaluateVisibility();
end;