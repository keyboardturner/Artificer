local addonName, Artificer = ...;

local f = CreateFrame("Frame")

local function ShouldCollapse()
	local settings = Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.AutoCollapseTracker;
	if type(settings) ~= "table" then
		return false;
	end

	local _, instanceType = IsInInstance()

	if settings.rested and IsResting() then
		return true;
	end
	if settings.combat and UnitAffectingCombat("player") then
		return true;
	end
	if settings.petbattle and C_PetBattles and C_PetBattles.IsInBattle() then
		return true;
	end
	if settings.bg and instanceType == "pvp" then
		return true;
	end
	if settings.arena and instanceType == "arena" then
		return true;
	end
	if settings.party and instanceType == "party" then
		return true;
	end
	if settings.mythicplus and C_ChallengeMode and C_ChallengeMode.IsChallengeModeActive() then
		return true;
	end
	if settings.raid and instanceType == "raid" then
		return true;
	end
	if settings.scenario and instanceType == "scenario" then
		return true;
	end
	if settings.housing and (instanceType == "neighborhood" or instanceType == "interior") then
	return true;
end

	return false
end

local wasCollapsedByAddon = false;

Artificer.Widgets.UpdateTrackerState = function()
	if not ObjectiveTrackerFrame or not ObjectiveTrackerFrame.SetCollapsed then return end

	local isCollapsed = ObjectiveTrackerFrame:IsCollapsed();
	local shouldCollapse = ShouldCollapse();

	if shouldCollapse and not isCollapsed then
		ObjectiveTrackerFrame:SetCollapsed(true);
		wasCollapsedByAddon = true;
	elseif not shouldCollapse and isCollapsed and wasCollapsedByAddon then
		ObjectiveTrackerFrame:SetCollapsed(false);
		wasCollapsedByAddon = false;
	end
end

local EventsTable = {
	"PLAYER_ENTERING_WORLD",
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_UPDATE_RESTING",
	"CHALLENGE_MODE_START",
	"CHALLENGE_MODE_COMPLETED",
	"PET_BATTLE_OPENING_START",
	"PET_BATTLE_CLOSE",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_REGEN_ENABLED",
};

for k, v in pairs(EventsTable) do
	f:RegisterEvent(v)
end

f:SetScript("OnEvent", function(self, event, ...)
	Artificer.Widgets.UpdateTrackerState();
end)