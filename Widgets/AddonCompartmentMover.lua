local addonName, Artificer = ...;

local L = Artificer.L;

if not Artificer.Widgets then Artificer.Widgets = {}; end

Artificer.Widgets.ApplyAddonCompartmentMover = function()
	if not AddonCompartmentFrame then return end
	
	AddonCompartmentFrame:ClearAllPoints();
	
	if Artificer_DB.Widgets.AddonCompartmentMover then
		AddonCompartmentFrame:SetPoint("BOTTOMLEFT", GameTimeFrame, "TOPLEFT", 0, 0);
	else
		AddonCompartmentFrame:SetPoint("TOPLEFT", GameTimeFrame, "BOTTOMLEFT", 0, 0);
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event, ...)
	Artificer.Widgets.ApplyAddonCompartmentMover();
end)