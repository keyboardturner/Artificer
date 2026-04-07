local addonName, Artificer = ...;
local L = Artificer.L;

ChromieTimeMapButtonMixin = {};

function ChromieTimeMapButtonMixin:OnLoad()
	self:SetSize(32, 32);

	self.background = self:CreateTexture(nil, "BACKGROUND", nil, -2);
	self.background:SetTexture(136467);
	self.background:SetSize(25, 25);
	self.background:SetPoint("TOPLEFT", self, "TOPLEFT", 4, -4);

	self.icon = self:CreateTexture(nil, "ARTWORK", nil);
	self.icon:SetTexture("Interface/AddOns/Artificer/Textures/ChromieTimeIcon");
	self.icon:SetSize(25, 25);
	self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -4);

	self.border = self:CreateTexture(nil, "OVERLAY", nil, 1);
	self.border:SetTexture(136430);
	self.border:SetSize(54, 54);
	self.border:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0);

	self:SetHighlightTexture("Interface/Minimap/UI-Minimap-ZoomButton-Highlight", "ADD");

	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("PLAYER_LEVEL_UP");
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	self:RegisterEvent("QUESTLINE_UPDATE");
	self:RegisterEvent("LORE_TEXT_UPDATED_CAMPAIGN");
	self:RegisterEvent("PLAYER_DIFFICULTY_CHANGED");

	self:SetScript("OnEvent", self.OnEvent);
	self:SetScript("OnEnter", self.OnEnter);
	self:SetScript("OnLeave", self.OnLeave);
end

function ChromieTimeMapButtonMixin:GetChromieTimeLocationString(unitToken)
	local expansionID = UnitChromieTimeID(unitToken);
	local option = C_ChromieTime.GetChromieTimeExpansionOption(expansionID);
	local expansion = option and option.name or "";
	if unitToken == "player" then
		return PARTY_PLAYER_CHROMIE_TIME_SELF_LOCATION:format(expansion);
	else
		return PARTY_PLAYER_CHROMIE_TIME_OTHER_LOCATION:format(expansion);
	end
end

function ChromieTimeMapButtonMixin:Refresh()
	if Artificer_DB and Artificer_DB.Widgets.ChromieTimeIcon then
		local InChromieTime = C_PlayerInfo.IsPlayerInChromieTime();
		if InChromieTime then
			self.icon:SetDesaturated(false);
			self:Show();
		else
			self.icon:SetDesaturated(true);
			self:Hide();
		end
	else
		self:Hide();
	end
end

function ChromieTimeMapButtonMixin:OnEvent(event, ...)
	self:Refresh();
end

function ChromieTimeMapButtonMixin:OnEnter()
	local InChromieTime = C_PlayerInfo.IsPlayerInChromieTime();
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip_SetTitle(GameTooltip, CHROMIE_TIME_PREVIEW_CARD_DEFAULT_TITLE);
	
	if InChromieTime then
		GameTooltip_AddNormalLine(GameTooltip, self:GetChromieTimeLocationString("player"));
	else
		GameTooltip_AddNormalLine(GameTooltip, L["Widget_ChromieTimeIcon_NoCampaign"]);
	end
	
	GameTooltip:Show();
end

function ChromieTimeMapButtonMixin:OnLeave()
	GameTooltip:Hide();
end

local chromieMapButton = CreateFrame("Button", "ArtificerChromieTimeMapButton", WorldMapFrame.ScrollContainer);
chromieMapButton:SetPoint("TOPRIGHT", WorldMapFrame.ScrollContainer, "TOPRIGHT", -4, -67);

Mixin(chromieMapButton, ChromieTimeMapButtonMixin);

chromieMapButton:OnLoad();

Artificer.Widgets.UpdateChromieTimeIcon = function() 
	chromieMapButton:Refresh(); 
end;

EventRegistry:RegisterCallback("WorldMapOnShow", function() chromieMapButton:Refresh() end);
EventRegistry:RegisterCallback("MapCanvas.MapSet", function() chromieMapButton:Refresh() end);

chromieMapButton:Refresh();