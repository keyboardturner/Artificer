local addonName, Artificer = ...;

local L = Artificer.L;

function Artificer.Widgets.ApplyCooldownManagerEnabled()
	local val = Artificer_DB.Widgets.CooldownManagerEnabled;
	if val == 2 then
		if C_CVar.GetCVar("cooldownViewerEnabled") ~= "1" then
			C_CVar.SetCVar("cooldownViewerEnabled", "1");
		end
	elseif val == 3 then
		if C_CVar.GetCVar("cooldownViewerEnabled") ~= "0" then
			C_CVar.SetCVar("cooldownViewerEnabled", "0");
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