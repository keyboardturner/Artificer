local addonName, Artificer = ...;

local L = Artificer.L;

function Artificer.Widgets.ApplyAutoLoot()
    if Artificer_DB.Widgets.AutoLoot then
        if C_CVar.GetCVar("autoLootDefault") ~= "1" then
            C_CVar.SetCVar("autoLootDefault", "1");
        end
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        Artificer.Widgets.ApplyAutoLoot();
    end
end)