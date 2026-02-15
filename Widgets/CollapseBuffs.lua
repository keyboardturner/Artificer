local addonName, Artificer = ...;

local L = Artificer.L;

local function SetBuffsCollapsed(shouldCollapse)
	if not BuffFrame or not BuffFrame.CollapseAndExpandButton then 
		return;
	end

	local expandedState = not shouldCollapse;
	local currentChecked = BuffFrame.CollapseAndExpandButton:GetChecked();
	--[[
		this seems to be the only sane way of clicking this button
		so many other methods i tried would just cause a taint-fest upon opening edit mode
	--]]
	if currentChecked ~= expandedState then
		BuffFrame.CollapseAndExpandButton:SetChecked(expandedState);
		BuffFrame.CollapseAndExpandButton:UpdateOrientation();
		BuffFrame:SetBuffsExpandedState(); 
	end
end

function Artificer.Widgets.ApplyCollapsedBuffs()
	if UnitAffectingCombat("player") then return end;  -- immense errors if executed in combat
	
	local shouldCollapse = Artificer_DB.Widgets.CollapseBuffs;
	if shouldCollapse == nil then shouldCollapse = false; end

	SetBuffsCollapsed(shouldCollapse);
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		Artificer.Widgets.ApplyCollapsedBuffs();
	end
end)