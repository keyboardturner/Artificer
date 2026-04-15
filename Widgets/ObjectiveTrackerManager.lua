local addonName, Artificer = ...;

local f = CreateFrame("Frame");

local FADE_DURATION = 0.5;
local FADE_OUT_ALPHA = 0.0;
local FADE_IN_ALPHA = 1.0;
local MOUSE_POLL_RATE = 0.1;

local fadeGroup = nil;
local fadeAnim = nil;
local animTarget = FADE_IN_ALPHA;
local animFromAlpha = FADE_IN_ALPHA;
local animStartTime = nil;

local function GetVisualAlpha()
	local OTF = ObjectiveTrackerFrame
	if not OTF then return FADE_IN_ALPHA end

	if fadeGroup and fadeGroup:IsPlaying() and animStartTime then
		local elapsed = GetTime() - animStartTime;
		local totalDur = fadeAnim:GetDuration();
		local progress = totalDur > 0 and math.min(elapsed / totalDur, 1) or 1;
		return animFromAlpha + (animTarget - animFromAlpha) * progress;
	end

	return OTF:GetAlpha();
end

local function FadeTo(toAlpha)
	local OTF = ObjectiveTrackerFrame
	if not OTF or not fadeGroup then return end

	local fromAlpha = GetVisualAlpha()

	if math.abs(fromAlpha - toAlpha) < 0.001 and not fadeGroup:IsPlaying() then
		return;
	end

	if fadeGroup:IsPlaying() then
		fadeGroup:Stop();
		OTF:SetAlpha(fromAlpha);
	end

	if math.abs(fromAlpha - toAlpha) < 0.001 then
		OTF:SetAlpha(toAlpha);
		animTarget = toAlpha;
		return;
	end

	local scaledDuration = FADE_DURATION * math.abs(toAlpha - fromAlpha);

	animFromAlpha = fromAlpha;
	animTarget = toAlpha;
	animStartTime = GetTime();

	fadeAnim:SetFromAlpha(fromAlpha);
	fadeAnim:SetToAlpha(toAlpha);
	fadeAnim:SetDuration(scaledDuration);
	fadeGroup:Play();
end

local function OnFadeFinished()
	local OTF = ObjectiveTrackerFrame;
	if OTF then
		OTF:SetAlpha(animTarget);
	end
	animStartTime = nil;
end

local function SetupAnimations()
	local OTF = ObjectiveTrackerFrame;
	if not OTF or fadeGroup then return end

	fadeGroup = OTF:CreateAnimationGroup();
	fadeGroup:SetLooping("NONE");
	fadeGroup:SetScript("OnFinished", OnFadeFinished);

	fadeAnim = fadeGroup:CreateAnimation("Alpha");
	fadeAnim:SetOrder(1);
	fadeAnim:SetDuration(FADE_DURATION);
end

local function ShouldFade()
	local settings = Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.AutoCollapseTracker
	if type(settings) ~= "table" then return false end

	local _, instanceType = IsInInstance()

	if settings.rested and IsResting() then return true end
	if settings.combat and UnitAffectingCombat("player") then return true end
	if settings.petbattle and C_PetBattles and C_PetBattles.IsInBattle() then return true end
	if settings.bg and instanceType == "pvp" then return true end
	if settings.arena and instanceType == "arena" then return true end
	if settings.party and instanceType == "party" then return true end
	if settings.mythicplus and C_ChallengeMode and C_ChallengeMode.IsChallengeModeActive() then return true end
	if settings.raid and instanceType == "raid" then return true end
	if settings.scenario and instanceType == "scenario" then return true end
	if settings.housing and (instanceType == "neighborhood" or instanceType == "interior") then return true end

	return false
end

local isFadedByAddon = false
local isMouseOver = false
local pollElapsed = 0

Artificer.Widgets.UpdateTrackerState = function()
	if not ObjectiveTrackerFrame then return end

	local settings = Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.AutoCollapseTracker
	if type(settings) ~= "table" then return end

	local shouldFade = ShouldFade();

	if shouldFade then
		isFadedByAddon = true
		if not isMouseOver then
			FadeTo(FADE_OUT_ALPHA);
		end
	else
		isFadedByAddon = false
		FadeTo(FADE_IN_ALPHA);
	end
end

f:SetScript("OnUpdate", function(self, elapsed)
	if not isFadedByAddon then return end
	if not ObjectiveTrackerFrame then return end

	pollElapsed = pollElapsed + elapsed;
	if pollElapsed < MOUSE_POLL_RATE then return end
	pollElapsed = 0;

	local mouseNow = ObjectiveTrackerFrame:IsMouseOver();
	if mouseNow == isMouseOver then return end

	isMouseOver = mouseNow;
	FadeTo(mouseNow and FADE_IN_ALPHA or FADE_OUT_ALPHA);
end)

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

for _, v in ipairs(EventsTable) do
	f:RegisterEvent(v);
end

f:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		SetupAnimations();
	end
	Artificer.Widgets.UpdateTrackerState();
end)