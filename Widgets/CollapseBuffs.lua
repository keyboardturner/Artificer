local addonName, Artificer = ...;

local L = Artificer.L;

local function SetBuffsCollapsed(shouldCollapse)
	if not BuffFrame or not BuffFrame.CollapseAndExpandButton then 
		return;
	end
	BuffFrame:SetBuffsExpandedState(not shouldCollapse)
end

function Artificer.Widgets.ApplyCollapsedBuffs()
	local shouldCollapse = Artificer_DB.Widgets.CollapseBuffs or false;
	SetBuffsCollapsed(shouldCollapse);
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		Artificer.Widgets.ApplyCollapsedBuffs();
	end
end)