local addonName, Artificer = ...;

local L = Artificer.L;

function Artificer.Widgets.ApplyPetBattleMapFilter()
    if Artificer_DB.Widgets.PetBattleMapFilter then
        if C_CVar.GetCVar("showTamers") ~= "0" then
            C_CVar.SetCVar("showTamers", "0");
        end
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        Artificer.Widgets.ApplyPetBattleMapFilter();
    end
end)