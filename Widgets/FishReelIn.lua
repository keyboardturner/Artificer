local addonName, Artificer = ...;

local L = Artificer.L;

local fishreelin = CreateFrame("Frame")

fishreelin.EventsList = {
	"UNIT_SPELLCAST_CHANNEL_STOP",
};

for k, v in pairs(fishreelin.EventsList) do
	fishreelin:RegisterEvent(v);
end

local spellIDs = {
	[131476] = true, -- mainline

	[7620] = true, -- apprentice fishing
	[7731] = true, -- 50+
	[7732] = true, -- 125+
	[18248] = true, -- 200+
	[33095] = true, -- 275+
	[51294] = true, -- 350+
	[88868] = true, -- 425+
	[110410] = true, -- 500+
	[158743] = true, --575+
};

function fishreelin.event(self, event, ...)
	if Artificer_DB.Widgets.FishReelIn then
		if event == "UNIT_SPELLCAST_CHANNEL_STOP" then
			local unitTarget, castGUID, spellID = ...;
			if not issecretvalue(unitTarget) and unitTarget == "player" and not issecretvalue(spellID) and spellIDs[spellID] then
				PlaySoundFile(569808);
			end
		end
	end
end

fishreelin:SetScript("OnEvent", fishreelin.event);