local addonName, Artificer = ...;

local L = Artificer.L;

local actionBarMappings = {
	"Action",
	"MultiBarBottomLeft",
	"MultiBarBottomRight",
	"MultiBarRight",
	"MultiBarLeft",
	"MultiBar5",
	"MultiBar6",
	"MultiBar7",
};

local function setButtonNamesAlpha(alpha)
	for i = 1, #actionBarMappings do
		for btn = 1,12 do
			_G[actionBarMappings[i].."Button"..btn.."Name"]:SetAlpha(alpha);
		end
	end
end

local function DetermineMacroText()
	if Artificer_DB and Artificer_DB.Widgets.HideMacroText then
		setButtonNamesAlpha(0);
	else
		setButtonNamesAlpha(1);
	end
end

Artificer.DetermineMacroText = DetermineMacroText;

local initialize = CreateFrame("Frame");
initialize:RegisterEvent("PLAYER_LOGIN");

function initialize:Go(event)
	if event == "PLAYER_LOGIN" then
		if Artificer_DB and Artificer_DB.Widgets.HideMacroText then
			DetermineMacroText();
		end
	end
end

initialize:SetScript("OnEvent", initialize.Go);