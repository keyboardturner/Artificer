local addonName, Artificer = ...;

local L = Artificer.L;

if not Artificer.IsForever then return; end

local AdditionalItems = {
	[171] = { -- Alchemy
		items = {
			[1] = 279956,
			[2] = 279970,
			[3] = 279990,
		},
	},
	[164] = { -- Blacksmithing
		items = {
			[1] = 279944,
			[2] = 279988,
			[3] = 279955,
		},
	},
	[333] = { -- Enchanting
		items = {
			[1] = 279976,
			[2] = 279985,
			[3] = 279987,
		},
	},
	[202] = { -- Engineering
		items = {
			[1] = 279950,
			[2] = 279949,
			[3] = 279989,
		},
	},
	[182] = { -- Herbalism
		items = {
			[1] = 279962,
			[2] = 279964,
			[3] = 279947,
		},
	},
	[165] = { -- Leatherworking
		items = {
			[1] = 279978,
			[2] = 279941,
			[3] = 279945,
		},
	},
	[186] = { -- Mining
		items = {
			[1] = 279960,
			[2] = 279948,
			[3] = 279952,
		},
	},
	[393] = { -- Skinning
		items = {
			[1] = 279979,
			[2] = 279969,
			[3] = 279938,
		},
	},
	[197] = { -- Tailoring
		items = {
			[1] = 279972,
			[2] = 279943,
			[3] = 279959,
		},
	},
	[129] = { -- First Aid
		items = {
			[1] = 279968,
			[2] = 279940,
			[3] = 279951,
		},
	},
	[356] = { -- Fishing
		items = {
			[1] = 279967,
			[2] = 279965,
			[3] = 279966,
		},
	},
	--[[ -- this is just the campfire item itself
	[185] = { -- Cooking
		items = {
			[1] = 279981,
			[2] = 279961,
			[3] = 279974,
		},
	},
	]]
};

local ICON_INSET = 4;
local ICON_PRESSED_INSET = 5;

local CampingButton = CreateFrame("Button", "ArtificerCampingButton", UIParent);
CampingButton:SetSize(64, 64);
CampingButton:SetPoint("CENTER", 0, -50);
CampingButton:SetAlpha(0);
CampingButton:Hide();

CampingButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(EMOTE87_CMD1);
	GameTooltip:Show();
end);

CampingButton:SetScript("OnLeave", function(self)
	if GameTooltip:GetOwner() == self then
		GameTooltip:Hide();
	end
end);

local bg = CampingButton:CreateTexture(nil, "BACKGROUND");
bg:SetAllPoints();
bg:SetAtlas("warband-bank-slot");
CampingButton.Bg = bg;

local icon = CampingButton:CreateTexture(nil, "ARTWORK");
icon:SetPoint("CENTER");
icon:SetPoint("TOPLEFT", 5, -5);
icon:SetPoint("BOTTOMRIGHT", -5, 5);
icon:SetAtlas("warbands-icon");
CampingButton.Icon = icon;

local fadeIn = CampingButton:CreateAnimationGroup();
local alphaIn = fadeIn:CreateAnimation("Alpha");
alphaIn:SetFromAlpha(0);
alphaIn:SetToAlpha(1);
alphaIn:SetDuration(0.2);
alphaIn:SetSmoothing("OUT");
fadeIn:SetScript("OnPlay", function()
	CampingButton:Show();
end);
fadeIn:SetScript("OnFinished", function()
	CampingButton:SetAlpha(1);
end);

local fadeOut = CampingButton:CreateAnimationGroup();
local alphaOut = fadeOut:CreateAnimation("Alpha");
alphaOut:SetFromAlpha(1);
alphaOut:SetToAlpha(0);
alphaOut:SetDuration(0.2);
alphaOut:SetSmoothing("OUT");
fadeOut:SetScript("OnFinished", function()
	CampingButton:SetAlpha(0);
	CampingButton:Hide();
end);

CampingButton:SetScript("OnMouseDown", function()
	icon:SetAlpha(0.6);
	icon:SetTexCoord(-0.1, 1.1, -0.1, 1.1);
end);

CampingButton:SetScript("OnMouseUp", function()
	icon:SetAlpha(1.0);
	icon:SetTexCoord(0, 1, 0, 1);
end);

local function IsNearCookingFire()
	local requirements = C_TradeSkillUI.GetRecipeRequirements(2538);
	if requirements and requirements[1] then
		return requirements[1].met;
	end
	return false;
end

local function HasCampingAura()
	return C_UnitAuras.GetPlayerAuraBySpellID(1283391) ~= nil;
end

local function IsGainingCampfire()
	return C_UnitAuras.GetPlayerAuraBySpellID(1229739) ~= nil;
end

local function HasGainedCampfire()
	return C_UnitAuras.GetPlayerAuraBySpellID(1229741) ~= nil;
end

local function BoostedRest()
	return C_UnitAuras.GetPlayerAuraBySpellID(1229451) ~= nil;
end

local radialButtons = {};
local RADIUS = 65;

local SkillOrder = { 171, 164, 333, 202, 182, 165, 186, 393, 197, 129, 356, 185, };

local function GetOwnedAdditionalItems()
	local owned = {};
	for _, skillID in ipairs(SkillOrder) do
		local data = AdditionalItems[skillID];
		if data then
			for rank = 3, 1, -1 do
				local itemID = data.items[rank];
				if itemID and C_Item.GetItemCount(itemID) > 0 then
					table.insert(owned, {itemID = itemID, rank = rank, skillID = skillID});
					break;
				end
			end
		end
	end
	return owned;
end

local SetButtonVisibility;

local function SetRadialIconInset(btn, inset)
	btn.icon:ClearAllPoints();
	btn.icon:SetPoint("TOPLEFT", inset, -inset);
	btn.icon:SetPoint("BOTTOMRIGHT", -inset, inset);
end

local function SetRadialButtonState(btn, state)
	btn.Bg:SetAtlas("gamepad-actionbar-xbox-" .. state);
end

local function RefreshRadialButtonState(btn)
	if btn.isPressed then
		SetRadialButtonState(btn, "pressed");
	elseif btn:IsMouseOver() then
		SetRadialButtonState(btn, "selected");
	else
		SetRadialButtonState(btn, "normal");
	end
end

local function UpdateRadialButtonCooldown(btn)
	if not btn.itemID then
		btn.Cooldown:Clear();
		return;
	end
	local start, duration, enable = C_Container.GetItemCooldown(btn.itemID);
	if start and duration and duration > 0 and enable ~= 0 then
		btn.Cooldown:SetCooldown(start, duration);
	else
		btn.Cooldown:Clear();
	end
end

local function UpdateRadialCooldowns()
	for _, btn in ipairs(radialButtons) do
		if btn:IsShown() then
			UpdateRadialButtonCooldown(btn);
		end
	end
end

local function UpdateRadialMenu()
	if InCombatLockdown() then return; end
	local items = GetOwnedAdditionalItems();
	local numItems = #items;
	local startingAngle = math.pi / 2;

	for _, btn in ipairs(radialButtons) do
		btn:Hide();
	end

	for i, data in ipairs(items) do
		local btn = radialButtons[i];
		if not btn then
			btn = CreateFrame("Button", "ArtificerRadialButton"..i, CampingButton, "SecureActionButtonTemplate");
			btn:SetSize(36, 36);
			btn:RegisterForClicks("AnyUp", "AnyDown");
			btn:SetAttribute("type", "item");

			local btnBg = btn:CreateTexture(nil, "BACKGROUND");
			btnBg:SetPoint("TOPLEFT", -4, 4);
			btnBg:SetPoint("BOTTOMRIGHT", 4, -4);
			btn.Bg = btnBg;

			local itemIcon = btn:CreateTexture(nil, "ARTWORK");
			itemIcon:SetTexCoord(0.2, 0.8, 0.2, 0.8)
			btn.icon = itemIcon;
			SetRadialIconInset(btn, ICON_INSET);

			local mask = btn:CreateMaskTexture();
			mask:SetAllPoints(itemIcon);
			mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE");
			itemIcon:AddMaskTexture(mask);
			btn.mask = mask;

			local cooldown = CreateFrame("Cooldown", nil, btn, "CooldownFrameTemplate");
			cooldown:SetPoint("TOPLEFT", 4, -4);
			cooldown:SetPoint("BOTTOMRIGHT", -4, 4);
			cooldown:SetUseCircularEdge(true);
			cooldown:SetDrawEdge(false);
			cooldown:SetHideCountdownNumbers(true);
			cooldown:SetSwipeTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask")
			btn.Cooldown = cooldown;

			btn:HookScript("OnEnter", function(self)
				RefreshRadialButtonState(self);
				if self.itemID then
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
					GameTooltip:SetItemByID(self.itemID);
					GameTooltip:Show();
				end
			end);

			btn:HookScript("OnLeave", function(self)
				RefreshRadialButtonState(self);
				if GameTooltip:GetOwner() == self then
					GameTooltip:Hide();
				end
			end);

			btn:HookScript("OnMouseDown", function(self)
				self.isPressed = true;
				SetRadialIconInset(self, ICON_PRESSED_INSET);
				RefreshRadialButtonState(self);
			end);

			btn:HookScript("OnMouseUp", function(self)
				self.isPressed = false;
				SetRadialIconInset(self, ICON_INSET);
				RefreshRadialButtonState(self);
			end);

			btn:HookScript("OnHide", function(self)
				self.isPressed = false;
				SetRadialIconInset(self, ICON_INSET);
				RefreshRadialButtonState(self);
				if GameTooltip:GetOwner() == self then
					GameTooltip:Hide();
				end
			end);

			SetRadialButtonState(btn, "normal");
			table.insert(radialButtons, btn);
		end

		btn.itemID = data.itemID;
		btn:SetAttribute("item", "item:"..data.itemID);
		btn.icon:SetTexture(C_Item.GetItemIconByID(data.itemID));

		UpdateRadialButtonCooldown(btn);

		local angle = startingAngle;
		if numItems > 1 then
			angle = startingAngle - ((i - 1) * (2 * math.pi / numItems));
		end

		local x = math.cos(angle) * RADIUS;
		local y = math.sin(angle) * RADIUS;

		btn:ClearAllPoints();
		btn:SetPoint("CENTER", CampingButton, "CENTER", x, y);
		btn:Show();
	end
end

SetButtonVisibility = function(shouldShow)
	if shouldShow then
		if not CampingButton:IsShown() or fadeOut:IsPlaying() then
			UpdateRadialMenu();
			fadeOut:Stop();
			fadeIn:Play();
		end
	else
		if CampingButton:IsShown() and not fadeOut:IsPlaying() then
			fadeIn:Stop();
			fadeOut:Play();
		end
	end
end

local function UpdateButtonVisibility()
	local shouldShow = false;
	if Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.CampfireNearby then
		if HasCampingAura() and IsNearCookingFire() and not IsFalling() then
			shouldShow = true;
		end
	end
	SetButtonVisibility(shouldShow);
end

CampingButton:SetScript("OnClick", function()
	if HasCampingAura() and IsNearCookingFire() then
		C_ChatInfo.PerformEmote("SIT");
		SetButtonVisibility(false);
	end
end);

local campy = CreateFrame("Frame");
campy:RegisterEvent("PLAYER_STOPPED_MOVING");
campy:RegisterEvent("PLAYER_STARTED_MOVING");
campy:RegisterEvent("PLAYER_ENTERING_WORLD");
campy:RegisterEvent("BAG_UPDATE_COOLDOWN");
campy:RegisterEvent("SPELL_UPDATE_COOLDOWN");
campy:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_STARTED_MOVING" then
		SetButtonVisibility(false);
	elseif event == "BAG_UPDATE_COOLDOWN" or event == "SPELL_UPDATE_COOLDOWN" then
		if CampingButton:IsShown() then
			UpdateRadialCooldowns();
		end
	else
		UpdateButtonVisibility();
	end
end);

Artificer.Widgets.ApplyCampfireNearby = function()
	UpdateButtonVisibility();
end