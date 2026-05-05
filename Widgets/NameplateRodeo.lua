local addonName, Artificer = ...;


local MAX_NAMEPLATES = 50;
local NAMEPLATE_TOKEN = "nameplate%d";

-- the goal here is to have certain things be more "reactive" than others in an attempt to make status checking ease up on resources
-- somebody targeting you will be a lot more reactive than querying a guild member is still a guild member
-- this is still pretty resource-intensive, so i'm probably going to change this up later to check far less often and trigger only on ingame events
local FAST_INTERVAL = 1.0 / MAX_NAMEPLATES;
local SLOW_INTERVAL = 5.0 / MAX_NAMEPLATES;

local fastProcessors = {};
local slowProcessors = {};
local socialProcessors = {};

local rodeoFrame = CreateFrame("Frame");
local fastIndex, fastTimer = 1, 0;
local slowIndex, slowTimer = 1, 0;

-- iterating over all nameplate tokens gathered, but staggering each nameplate out over their interval time instead of all in 1 frame
-- the average CPU will stay the same but it shouldn't be as spiky, hopefully?
local function RodeoOnUpdate(self, elapsed)
	fastTimer = fastTimer + elapsed;
	slowTimer = slowTimer + elapsed;

	while fastTimer >= FAST_INTERVAL do
		fastTimer = fastTimer - FAST_INTERVAL;
		local unitToken = format(NAMEPLATE_TOKEN, fastIndex);
		for _, fn in ipairs(fastProcessors) do
			fn(unitToken);
		end;
		fastIndex = fastIndex + 1;
		if fastIndex > MAX_NAMEPLATES then fastIndex = 1 end;
	end

	while slowTimer >= SLOW_INTERVAL do
		slowTimer = slowTimer - SLOW_INTERVAL;
		local unitToken = format(NAMEPLATE_TOKEN, slowIndex);
		for _, fn in ipairs(slowProcessors) do
			fn(unitToken);
		end;
		slowIndex = slowIndex + 1;
		if slowIndex > MAX_NAMEPLATES then slowIndex = 1 end;
	end
end

local socialFrame = CreateFrame("Frame");
socialFrame:RegisterEvent("FRIENDLIST_UPDATE");
socialFrame:RegisterEvent("IGNORELIST_UPDATE");
socialFrame:SetScript("OnEvent", function(self, event)
	for _, fn in ipairs(socialProcessors) do fn(event) end;
end);

local Rodeo = {};
Artificer.NameplateRodeo = Rodeo;

-- the "API" for status / target to register from so it's 1 core function
function Rodeo:RegisterFast(fn)
	table.insert(fastProcessors, fn);
end

function Rodeo:RegisterSlow(fn)
	table.insert(slowProcessors, fn);
end

function Rodeo:RegisterSocial(fn)
	table.insert(socialProcessors, fn);
end

function Rodeo:Refresh()
	local db = Artificer_DB and Artificer_DB.Widgets;
	local anyActive = db and (db.NameplateTargetIndicator or db.NameplateStatusIndicator);

	if anyActive then
		rodeoFrame:SetScript("OnUpdate", RodeoOnUpdate);
	else
		rodeoFrame:SetScript("OnUpdate", nil);
		fastIndex, fastTimer = 1, 0;
		slowIndex, slowTimer = 1, 0;
	end
end
