local addonName, Artificer = ...;

local L = Artificer.L;

function Artificer.Widgets.ApplyBnetToasts()
	local val = Artificer_DB.Widgets.BnetToasts;
	
	--[[
	so basically blizz broke bnet toasts (12.0.7?)
	and using the ingame settings option doesn't actually turn them off/on properly
	you have to set the CVar, and then use the enable/disable function
	why it works specifically like this ??????????????
	]]
	if val == 2 then
		C_CVar.SetCVar("showToastWindow", "1");
		
		if BNToastFrame and BNToastFrame.EnableToasts then
			BNToastFrame:EnableToasts();
		end
		
	elseif val == 3 then
		C_CVar.SetCVar("showToastWindow", "0");
		
		if BNToastFrame and BNToastFrame.DisableToasts then
			BNToastFrame:DisableToasts();
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		Artificer.Widgets.ApplyBnetToasts();
	end
end)