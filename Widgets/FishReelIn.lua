local addonName, Artificer = ...;

local L = Artificer.L;

local fishreelin = CreateFrame("Frame")

fishreelin.EventsList = {
	"UNIT_SPELLCAST_CHANNEL_STOP",
};

for k, v in pairs(fishreelin.EventsList) do
	fishreelin:RegisterEvent(v);
end

function fishreelin.event(self, event, ...)
	if Artificer_DB.Widgets.FishReelIn then
		if event == "UNIT_SPELLCAST_CHANNEL_STOP" then
			local unitTarget, castGUID, spellID = ...
			if not issecretvalue(unitTarget) and unitTarget == "player" and not issecretvalue(spellID) and spellID == 131476 then
				PlaySoundFile(569808);
			end
		end
	end
end

fishreelin:SetScript("OnEvent", fishreelin.event);