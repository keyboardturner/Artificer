local addonName, Artificer = ...;

local L = Artificer.L;

local ChromieTimeIcon = "Interface/AddOns/Artificer/Textures/ChromieTimeIcon";
local CHROMIE_TIME_NOT_ACTIVE = L["Widget_ChromieTimeIcon_NoCampaign"];

local iconFrame = CreateFrame("Frame", nil, WorldMapFrame.ScrollContainer)
iconFrame:SetSize(32, 32)
iconFrame:SetPoint("TOPRIGHT", WorldMapFrame.ScrollContainer, "TOPRIGHT", -4, -67)

iconFrame.background = iconFrame:CreateTexture(nil, "BACKGROUND", nil, -2)
iconFrame.background:SetTexture(136467)
iconFrame.background:SetPoint("TOPLEFT", iconFrame, "TOPLEFT", 4, -4)
iconFrame.background:SetSize(25, 25)

iconFrame.icon = iconFrame:CreateTexture(nil, "ARTWORK", nil)
iconFrame.icon:SetTexture(ChromieTimeIcon)
iconFrame.icon:SetDesaturated(true)
iconFrame.icon:SetPoint("TOPLEFT", iconFrame, "TOPLEFT", 5, -4)
iconFrame.icon:SetSize(25, 25)

iconFrame.border = iconFrame:CreateTexture(nil, "OVERLAY", nil, 1)
iconFrame.border:SetPoint("TOPLEFT", iconFrame, "TOPLEFT", 0, 0)
iconFrame.border:SetSize(54, 54)
iconFrame.border:SetTexture(136430)

iconFrame:Hide();

local function GetChromieTimeLocationString(unitToken)
	local expansionID = UnitChromieTimeID(unitToken);
	local option = C_ChromieTime.GetChromieTimeExpansionOption(expansionID);
	local expansion = option and option.name or "";
	if unitToken == "player" then
		return PARTY_PLAYER_CHROMIE_TIME_SELF_LOCATION:format(expansion);
	else
		return PARTY_PLAYER_CHROMIE_TIME_OTHER_LOCATION:format(expansion);
	end
end

local function UpdateChromieTimeIcon()
	if Artificer_DB and Artificer_DB.Widgets.ChromieTimeIcon then
		local InChromieTime, CanEnterChromieTime = C_PlayerInfo.IsPlayerInChromieTime(), C_PlayerInfo.CanPlayerEnterChromieTime()
		if InChromieTime then
			iconFrame.icon:SetDesaturated(false);
			iconFrame:Show();
		else
			iconFrame.icon:SetDesaturated(true);
			iconFrame:Hide();
		end
	else
		iconFrame:Hide();
	end
end

Artificer.Widgets.UpdateChromieTimeIcon = UpdateChromieTimeIcon();

iconFrame:SetScript("OnEnter", function(self)
	local InChromieTime, CanEnterChromieTime = C_PlayerInfo.IsPlayerInChromieTime(), C_PlayerInfo.CanPlayerEnterChromieTime()
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip_SetTitle(GameTooltip, CHROMIE_TIME_PREVIEW_CARD_DEFAULT_TITLE)
	if InChromieTime then
		GameTooltip_AddNormalLine(GameTooltip, GetChromieTimeLocationString("player"));
	else
		GameTooltip_AddNormalLine(GameTooltip, CHROMIE_TIME_NOT_ACTIVE);
	end
	GameTooltip:Show();
end)
iconFrame:SetScript("OnLeave", function()
	GameTooltip:Hide();
end)

iconFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
iconFrame:RegisterEvent("PLAYER_LEVEL_UP")
iconFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
iconFrame:RegisterEvent("QUESTLINE_UPDATE")
iconFrame:RegisterEvent("LORE_TEXT_UPDATED_CAMPAIGN")
iconFrame:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")

iconFrame:SetScript("OnEvent", UpdateChromieTimeIcon);
EventRegistry:RegisterCallback("WorldMapOnShow", UpdateChromieTimeIcon);
EventRegistry:RegisterCallback("MapCanvas.MapSet", UpdateChromieTimeIcon);

UpdateChromieTimeIcon();