local addonName, Artificer = ...;

local L = Artificer.L;

local yeehaw = CreateFrame("Frame")

yeehaw:RegisterEvent("QUEST_SESSION_CREATED")

local function Cowboy()
    if Artificer_DB.Widgets.PartySync then
		QuestSessionManager.StartDialog:Confirm()
	end
end

yeehaw:SetScript("OnEvent", Cowboy)