local addonName, Artificer = ...;

local L = Artificer.L;

local function ArrowKeySetting()
	local useAltKey = not (Artificer_DB and Artificer_DB.Widgets.ArrowKeyEditbox);

	for i = 1, NUM_CHAT_WINDOWS do
		local editBox = _G["ChatFrame" .. i .. "EditBox"];
		if editBox then
			editBox:SetAltArrowKeyMode(useAltKey);
		end
	end
end

Artificer.ArrowKeySetting = ArrowKeySetting;

local initialize = CreateFrame("Frame");
initialize:RegisterEvent("PLAYER_LOGIN");

function initialize:Go(event)
	if event == "PLAYER_LOGIN" then
		ArrowKeySetting();
	end
end

initialize:SetScript("OnEvent", initialize.Go);