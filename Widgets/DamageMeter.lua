local addonName, Artificer = ...;

local L = Artificer.L;

function Artificer.Widgets.ApplyDamageMeterSettings()
	local valDamageMeter = Artificer_DB.Widgets.DamageMeter;
	local valDamageWipe = Artificer_DB.Widgets.DamageWipe;
	
	if valDamageMeter == 2 then
		if C_CVar.GetCVar("damageMeterEnabled") ~= "1" then
			C_CVar.SetCVar("damageMeterEnabled", "1");
		end
	elseif valDamageMeter == 3 then
		if C_CVar.GetCVar("damageMeterEnabled") ~= "0" then
			C_CVar.SetCVar("damageMeterEnabled", "0");
		end
	end
	
	if valDamageWipe == 2 then
		if C_CVar.GetCVar("damageMeterResetOnNewInstance") ~= "1" then
			C_CVar.SetCVar("damageMeterResetOnNewInstance", "1");
		end
	elseif valDamageWipe == 3 then
		if C_CVar.GetCVar("damageMeterResetOnNewInstance") ~= "0" then
			C_CVar.SetCVar("damageMeterResetOnNewInstance", "0");
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		Artificer.Widgets.ApplyDamageMeterSettings();
	end
end)