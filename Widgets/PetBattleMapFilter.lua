local addonName, Artificer = ...;

local L = Artificer.L;

function Artificer.Widgets.ApplyPetBattleMapFilter()
	local val = Artificer_DB.Widgets.PetBattleMapFilter;
	if val == 2 then
		if C_CVar.GetCVar("showTamers") ~= "0" then
			C_CVar.SetCVar("showTamers", "0");
		end
	elseif val == 3 then
		if C_CVar.GetCVar("showTamers") ~= "1" then
			C_CVar.SetCVar("showTamers", "1");
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