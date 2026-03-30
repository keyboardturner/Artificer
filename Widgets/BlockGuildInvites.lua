local addonName, Artificer = ...;

local L = Artificer.L;

function Artificer.Widgets.ApplyBlockGuildInvites()
	local val = Artificer_DB.Widgets.BlockGuildInvites;
	if val == 2 then
		SetAutoDeclineGuildInvites(true);
	elseif val == 3 then
		SetAutoDeclineGuildInvites(false);
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		Artificer.Widgets.ApplyBlockGuildInvites();
	end
end)