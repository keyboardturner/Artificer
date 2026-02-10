local addonName, Artificer = ...;

local L = Artificer.L;

function Artificer.Widgets.ApplyCooldownManagerEnabled()
    if Artificer_DB.Widgets.CooldownManagerEnabled then
        if C_CVar.GetCVar("cooldownViewerEnabled") ~= "1" then
            C_CVar.SetCVar("cooldownViewerEnabled", "1");
        end
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        Artificer.Widgets.ApplyCooldownManagerEnabled();
    end
end)