local addonName, Artificer = ...

local L = {};
Artificer.L = L;

local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to—avoid writing the default localization out explicitly.
 return key;
end
setmetatable(L, {__index=defaultFunc});

local LOCALE = GetLocale()


if LOCALE == "enUS" then
	-- The EU English game client also
	-- uses the US English locale code.
	L["TOC_Title"] = "Artificer"
	L["TOC_Notes"] = "A personal workshop and collection of UI tweaks and adjustments"
	L["SLASH_ARTI1"] = "/artificer" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI2"] = "/arti" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI3"] = "/artificer" -- localized slash command
	L["SLASH_ARTI4"] = "/arti" -- localized slash command

	-- Frame
	L["UIScale"] = UI_SCALE
	L["LockFrame"] = LOCK_FRAME

	-- Headers
	L["Header_Professions"] = TRADE_SKILLS
	L["Header_Map"] = WORLD_MAP
	L["Header_ActionBar"] = BINDING_HEADER_ACTIONBAR
	L["Header_Chat"] = BINDING_HEADER_CHAT
	L["Header_Misc"] = BINDING_HEADER_MISC
	L["Header_AccountSettings"] = "Account Settings"
	L["Header_CVars"] = "Console Variables (CVars)"

	--Widgets
	L["Widget_FishReelIn"] = "Fish Reel In"
	L["Widget_FishReelInTT"] = "Plays a reel-in sound when your fishing cast finishes."
	L["Widget_ChromieTimeIcon"] = "Chromie Time Icon"
	L["Widget_ChromieTimeIconTT"] = "Displays an icon on the map indicating if you're in Chromie Time (Timewalking Campaigns)."
	L["Widget_ChromieTimeIcon_NoCampaign"] = "No current Timewalking Campaign is active."
	L["Widget_HideMacroText"] = "Hide Action Button Macro Text"
	L["Widget_HideMacroTextTT"] = "Hides the macro text on Action Bar buttons."
	L["Widget_ArrowKeyEditbox"] = "Allow Arrow Keys in Chat Editbox"
	L["Widget_ArrowKeyEditboxTT"] = "Allow using the arrow keys to move the cursor in the chat editbox without needing to press alt."
	L["Widget_OutfitIcon"] = "Transmog Outfit Borders"
	L["Widget_OutfitIconTT"] = "Display borders on transmog outfits that are placed on the action bar buttons."
	L["Widget_ServerNotifications"] = "Server Notification Raid Warnings"
	L["Widget_ServerNotificationsTT"] = "Display Server Notifications (such as realm restarts) displayed as a Raid Warning."

	--Widgets - Account-wide settings
	L["Widget_AutoLoot"] = "Account Auto Loot"
	L["Widget_AutoLootTT"] = "Enforces Auto Loot to be enabled on every character."
	L["Widget_PetBattleMapFilter"] = "Account Pet Battle Map Filter"
	L["Widget_PetBattleMapFilterTT"] = "Enforces Pet Battle Map Filter to be disabled on every character."
	L["Widget_cooldownViewerEnabled"] = "Account Cooldown Manager Enabled"
	L["Widget_cooldownViewerEnabledTT"] = "Enforces the Cooldown Manager to be enabled on every character."
	L["Widget_PartySync"] = "Automatically Accept Party Sync"
	L["Widget_PartySyncTT"] = "automatically accept the Party Sync confirm button when it is prompted."

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Show All Minimap Trackables"
	L["CVar_minimapTrackingShowAllTT"] = "Toggle additional minimap tracking options."
	L["CVar_weatherDensity"] = "Weather Density"
	L["CVar_weatherDensityTT"] = "Control the weather density / intensity."
	L["CVar_AutoPushSpellToActionBar"] = "Auto Push Spells to Action Bars"
	L["CVar_AutoPushSpellToActionBarTT"] = "Whether spells should automatically be placed on your action bars."


return end

if LOCALE == "esMX" then
	-- Spanish (Mexico) translations go here

return end

if LOCALE == "esES" then
	-- Spanish translations go here

return end

if LOCALE == "deDE" then
	-- German translations go here

return end

if LOCALE == "frFR" then
	-- French translations go here

return end

if LOCALE == "itIT" then
	-- Italian translations go here

return end

if LOCALE == "ptBR" then
	-- Brazilian Portuguese translations go here

-- Note that the EU Portuguese WoW client also
-- uses the Brazilian Portuguese locale code.
return end

if LOCALE == "ruRU" then
	-- Russian translations go here

return end

if LOCALE == "koKR" then
	-- Korean translations go here

return end

if LOCALE == "zhCN" then
	-- Simplified Chinese translations go here

return end

if LOCALE == "zhTW" then
	-- Traditional Chinese translations go here

return end
