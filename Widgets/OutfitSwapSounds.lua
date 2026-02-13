local addonName, Artificer = ...;

local L = Artificer.L;

local SPELL_ID_Manual = 1247613;
local SPELL_ID_Auto = 1263886;
local SPELL_ID_Removal = 1247917;
local UNMUTE_DELAY = 1.5;

local TRANSMOG_SOUNDS = {
	impact = {
		4674437,4674439,4674441,4674443,4674445,
		4674447,4674449,4674451,4674453,4674455,
	},
	A = {
		4822566,4822568,4822570,4822572,4822574,
	},
	B = {
		5453506,5453508,5453510,5453512,5453514,
		5453516,5453518,5453520,5453522,5453524,
	},
	C = {
		2428618,2428619,2428620,2428621,2428622,
	},
	D = {
		612328,
	},
};

local muted = false
local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

local function GetOutfitSwapSounds()
	if not Artificer_DB then return {} end
	if not Artificer_DB.OutfitSwapSounds then
		Artificer_DB.OutfitSwapSounds = {
			impact = false,
			A = false,
			B = false,
			C = false,
			D = false,
		}
	end
	return Artificer_DB.OutfitSwapSounds
end

local function MuteTransmogSounds()
	if muted then return end
	muted = true

	local soundMutes = GetOutfitSwapSounds()
	local mutedSounds = {}

	for categoryName, soundIDs in pairs(TRANSMOG_SOUNDS) do
		if soundMutes[categoryName] then
			for _, soundID in ipairs(soundIDs) do
				MuteSoundFile(soundID);
				table.insert(mutedSounds, soundID);
			end
		end
	end

	C_Timer.After(UNMUTE_DELAY, function()
		for _, soundID in ipairs(mutedSounds) do
			UnmuteSoundFile(soundID);
		end
		muted = false
	end)
end

frame:SetScript("OnEvent", function(self, event, unit, castGUID, spellID)
	if unit ~= "player" then return end
	if spellID == SPELL_ID_Manual or spellID == SPELL_ID_Auto
	or spellID == SPELL_ID_Removal then
		MuteTransmogSounds();
	end
end)
