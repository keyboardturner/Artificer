local addonName, Artificer = ...;

local L = Artificer.L;

Artificer.Widgets.ApplyHideTutorials = function()
	if not Artificer_DB or not Artificer_DB.Widgets.HideTutorials then return end

	C_CVar.SetCVar("showTutorials", 0)
	C_CVar.SetCVar("showNPETutorials", 0)

	local charDB = Artificer.GetCharDB()
	local tocVersion = select(4, GetBuildInfo())
	local lastInfoFrame = C_CVar.GetCVarBitfield("closedInfoFrames", NUM_LE_FRAME_TUTORIALS)

	if charDB.TutorialsHiddenTOC ~= tocVersion or not lastInfoFrame then
		if NUM_LE_FRAME_TUTORIALS then
			for i = 1, NUM_LE_FRAME_TUTORIALS do
				C_CVar.SetCVarBitfield("closedInfoFrames", i, true);
			end
		end
		if NUM_LE_FRAME_TUTORIAL_ACCCOUNTS then
			for i = 1, NUM_LE_FRAME_TUTORIAL_ACCCOUNTS do
				C_CVar.SetCVarBitfield("closedInfoFramesAccountWide", i, true);
			end
		end
		
		charDB.TutorialsHiddenTOC = tocVersion
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		Artificer.Widgets.ApplyHideTutorials();
	end
end)

hooksecurefunc("NPE_CheckTutorials", function()
	if Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.HideTutorials then
		if C_PlayerInfo.IsPlayerNPERestricted() and UnitLevel("player") == 1 then
			C_CVar.SetCVar("showTutorials", 0);
		end
	end
end)