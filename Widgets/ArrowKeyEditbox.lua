local addonName, Artificer = ...;

local L = Artificer.L;

local function ArrowKeySetting()
	if Artificer_DB and Artificer_DB.Widgets.ArrowKeyEditbox then
		DEFAULT_CHAT_FRAME.editBox:SetAltArrowKeyMode(false); -- no alt needed
	else
		DEFAULT_CHAT_FRAME.editBox:SetAltArrowKeyMode(true); -- alt is needed
	end
end

Artificer.ArrowKeySetting = ArrowKeySetting;

local initialize = CreateFrame("Frame");
initialize:RegisterEvent("PLAYER_LOGIN");

function initialize:Go(event)
	if event == "PLAYER_LOGIN" then
		if Artificer_DB and Artificer_DB.Widgets.ArrowKeyEditbox then
			ArrowKeySetting();
		end
	end
end

initialize:SetScript("OnEvent", initialize.Go);