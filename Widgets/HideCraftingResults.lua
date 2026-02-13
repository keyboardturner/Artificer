local addonName, Artificer = ...;

local L = Artificer.L;

Artificer.Widgets.HideCraftingResults = function()
	if not C_AddOns.IsAddOnLoaded("Blizzard_Professions") then return end

	if not ProfessionsFrame 
	or not ProfessionsFrame.CraftingPage 
	or not ProfessionsFrame.CraftingPage.CraftingOutputLog then 
		return 
	end

	local craftingLog = ProfessionsFrame.CraftingPage.CraftingOutputLog
	
	local shouldHide = Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.HideCraftingResults

	if shouldHide then
		craftingLog:UnregisterEvent("TRADE_SKILL_ITEM_CRAFTED_RESULT");
		craftingLog:UnregisterEvent("TRADE_SKILL_CURRENCY_REWARD_RESULT");
	else
		craftingLog:RegisterEvent("TRADE_SKILL_ITEM_CRAFTED_RESULT");
		craftingLog:RegisterEvent("TRADE_SKILL_CURRENCY_REWARD_RESULT");
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")

f:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "Blizzard_Professions" then
		Artificer.Widgets.HideCraftingResults();
	
	elseif event == "PLAYER_LOGIN" then
		if C_AddOns.IsAddOnLoaded("Blizzard_Professions") then
			Artificer.Widgets.HideCraftingResults();
		end
	end
end)