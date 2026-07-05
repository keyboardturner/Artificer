local addonName, Artificer = ...;

local L = Artificer.L;

function Artificer.Widgets.ApplySelectionCircle()
	local filters = Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.ObjectSelectionCircleFilters;
	if not filters then return; end

	local showCircle = false;

	if UnitExists("target") then
		local isPlayer = UnitIsPlayer("target");
		local isFriend = UnitIsFriend("player", "target");
		local isEnemy = UnitIsEnemy("player", "target");
		local isSelf = UnitIsUnit("target", "player");

		if filters.self and isSelf then
			showCircle = true;
		elseif filters.pet and UnitExists("pet") and UnitIsUnit("target", "pet") then
			showCircle = true;
		elseif filters.friendlyPlayer and isFriend and isPlayer and not isSelf then
			showCircle = true;
		elseif filters.friendlyNPC and isFriend and not isPlayer then
			showCircle = true;
		elseif filters.enemyPlayer and isEnemy and isPlayer then
			showCircle = true;
		elseif filters.enemyNPC and isEnemy and not isPlayer then
			showCircle = true;
		elseif filters.interactable and UnitIsInteractable("target") and not isSelf then
			showCircle = true;
		elseif filters.attackable and UnitCanAttack("player", "target") then
			showCircle = true;
		end
	end

	if filters.hideWithUI and not UIParent:IsVisible() then
		showCircle = false;
	end

	local targetCVarState = showCircle and "1" or "0"
	if C_CVar.GetCVar("ObjectSelectionCircle") ~= targetCVarState then
		C_CVar.SetCVar("ObjectSelectionCircle", targetCVarState);
	end
end

local f = CreateFrame("Frame");
f:RegisterEvent("PLAYER_LOGIN");
f:RegisterEvent("PLAYER_TARGET_CHANGED");

f:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" or event == "PLAYER_TARGET_CHANGED" then
		Artificer.Widgets.ApplySelectionCircle();
	end
end)

UIParent:HookScript("OnShow", function()
	Artificer.Widgets.ApplySelectionCircle();
end)

UIParent:HookScript("OnHide", function()
	Artificer.Widgets.ApplySelectionCircle();
end)

function Artificer.Widgets.ApplyFindYourself()
	local settings = Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.FindYourself;
	
	if type(settings) ~= "table" then return; end

	local _, instanceType, difficultyID = GetInstanceInfo();
	local isMPlus = (difficultyID == 8) or (C_ChallengeMode and C_ChallengeMode.IsChallengeModeActive());
	
	local shouldEnable = false;

	if instanceType == "none" then
		shouldEnable = settings.openworld;
	elseif instanceType == "pvp" then
		shouldEnable = settings.bg;
	elseif instanceType == "arena" then
		shouldEnable = settings.arena;
	elseif instanceType == "party" then
		shouldEnable = isMPlus and settings.mythicplus or settings.party;
	elseif instanceType == "raid" then
		shouldEnable = settings.raid;
	elseif instanceType == "scenario" then
		shouldEnable = settings.scenario;
	elseif instanceType == "housing" then
		shouldEnable = settings.housing;
	else
		shouldEnable = settings.openworld;
	end

	if shouldEnable then
		C_CVar.SetCVar("findYourselfAnywhere", "1");
		C_CVar.SetCVar("findYourselfAnywhereOnlyInCombat", settings.combat and "1" or "0");
	else
		C_CVar.SetCVar("findYourselfAnywhere", "0");
		C_CVar.SetCVar("findYourselfAnywhereOnlyInCombat", "0");
	end
end

f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:RegisterEvent("CHALLENGE_MODE_START");

f:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		Artificer.Widgets.ApplySelectionCircle();
		Artificer.Widgets.ApplyFindYourself() ;
	elseif event == "PLAYER_TARGET_CHANGED" then
		Artificer.Widgets.ApplySelectionCircle();
	elseif event == "PLAYER_ENTERING_WORLD" or event == "CHALLENGE_MODE_START" then
		Artificer.Widgets.ApplyFindYourself();
	end
end);
