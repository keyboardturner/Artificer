local addonName, Artificer = ...;

local L = Artificer.L;

local undoStack = {};
local redoStack = {};
local currentState = nil;
local isApplyingState = false;
local pendingCapture = false;
local UNDO_LIMIT = 100;

local undoBtn, redoBtn, restoreBtn
local mhSheatheBtn, ohSheatheBtn

local historyFrame = CreateFrame("Frame")

local SHEATHE_ICONS = {
	[Enum.TransmogOutfitSlotOptionSheatheCategory.Default] = "Interface\\AddOns\\Artificer\\Textures\\SheathDefault.png",
	[Enum.TransmogOutfitSlotOptionSheatheCategory.Back] = "Interface\\AddOns\\Artificer\\Textures\\SheathBack.png",
	[Enum.TransmogOutfitSlotOptionSheatheCategory.Side] = "Interface\\AddOns\\Artificer\\Textures\\SheathSide.png",
	[Enum.TransmogOutfitSlotOptionSheatheCategory.Hide] = "Interface\\AddOns\\Artificer\\Textures\\SheathHidden.png",
};

local function StatesAreDifferent(stateA, stateB)
	if not stateA or not stateB then
		return true;
	end
	
	if not stateA.secondaryStates or not stateB.secondaryStates then
		return true;
	end
	if not stateA.slots or not stateB.slots then
		return true;
	end
	
	for slotID, val in pairs(stateA.secondaryStates) do
		if stateB.secondaryStates[slotID] ~= val then
			return true;
		end
	end
	for slotID, val in pairs(stateB.secondaryStates) do
		if stateA.secondaryStates[slotID] ~= val then
			return true;
		end
	end
	
	for k, v in pairs(stateA.slots) do
		local b = stateB.slots[k]
		if not b or v.transmogID ~= b.transmogID or v.displayType ~= b.displayType then
			return true;
		end
	end
	for k, v in pairs(stateB.slots) do
		if not stateA.slots[k] then
			return true;
		end
	end
	
	return false;
end

local function UpdateButtonStates()
	if undoBtn and redoBtn and restoreBtn then
		local canUndo = #undoStack > 0;
		local canRedo = #redoStack > 0;
		
		undoBtn:SetEnabled(canUndo);
		undoBtn.Icon:SetDesaturated(not canUndo);
		undoBtn.Icon:SetAlpha(canUndo and 1 or 0.5);
		
		redoBtn:SetEnabled(canRedo);
		redoBtn.Icon:SetDesaturated(not canRedo);
		redoBtn.Icon:SetAlpha(canRedo and 1 or 0.5);

		local canRestore = Artificer_DB and Artificer_DB.LastTransmogState and StatesAreDifferent(currentState, Artificer_DB.LastTransmogState);
		restoreBtn:SetEnabled(canRestore);
		restoreBtn.Icon:SetDesaturated(not canRestore);
		restoreBtn.Icon:SetAlpha(canRestore and 1 or 0.5);
	end
end

local function CaptureUIState()
	if not TransmogFrame or not TransmogFrame:IsShown() or not TransmogFrame.CharacterPreview then
		return nil;
	end
	
	local state = {
		slots = {},
		secondaryStates = {}
	};
	
	local function AddSlotData(loc, opt, info)
		if loc and opt and info then
			local slotID = loc:GetSlot();
			
			if C_TransmogOutfitInfo.SlotHasSecondary(slotID) and state.secondaryStates[slotID] == nil then
				state.secondaryStates[slotID] = C_TransmogOutfitInfo.GetSecondarySlotState(slotID);
			end
			
			local key = slotID .. "_" .. loc:GetType() .. "_" .. opt.weaponOption;
			state.slots[key] = {
				slot = slotID,
				type = loc:GetType(),
				weaponOption = opt.weaponOption,
				transmogID = info.transmogID,
				displayType = info.displayType
			};
		end
	end

	for slotFrame in TransmogFrame.CharacterPreview.CharacterAppearanceSlotFramePool:EnumerateActive() do
		AddSlotData(slotFrame:GetTransmogLocation(), slotFrame:GetCurrentWeaponOptionInfo(), slotFrame:GetSlotInfo());
		local illusionFrame = slotFrame:GetIllusionSlotFrame();
		if illusionFrame then
			AddSlotData(illusionFrame:GetTransmogLocation(), illusionFrame:GetCurrentWeaponOptionInfo(), illusionFrame:GetSlotInfo());
		end
	end
	
	return state;
end

local function SaveCurrentStateToUndo()
	if currentState then
		table.insert(undoStack, currentState);
		if #undoStack > UNDO_LIMIT then
			table.remove(undoStack, 1);
		end
		redoStack = {};
		UpdateButtonStates();
	end
end

local function OnTransmogChanged()
	local newState = CaptureUIState()
	if StatesAreDifferent(currentState, newState) then
		SaveCurrentStateToUndo();
		currentState = newState;
	end
end

historyFrame:SetScript("OnUpdate", function()
	if pendingCapture then
		pendingCapture = false
		if not isApplyingState then
			OnTransmogChanged();
		end
	end
end)

local function TriggerCapture()
	if isApplyingState then return end
	pendingCapture = true;
end

local function ApplyState(state)
	if not state then return end
	isApplyingState = true;
	pendingCapture = false;
	
	if currentState then
		for slotID, val in pairs(state.secondaryStates) do
			if currentState.secondaryStates[slotID] ~= val then
				C_TransmogOutfitInfo.SetSecondarySlotState(slotID, val);
			end
		end
	end
	
	for key, data in pairs(state.slots) do
		local current = currentState and currentState.slots[key]
		if not current or current.transmogID ~= data.transmogID or current.displayType ~= data.displayType then
			C_TransmogOutfitInfo.SetPendingTransmog(data.slot, data.type, data.weaponOption, data.transmogID, data.displayType);
		end
	end
	
	isApplyingState = false;
	currentState = CaptureUIState();
	UpdateButtonStates();
end

local function PerformUndo()
	if #undoStack == 0 then return end
	if currentState then
		table.insert(redoStack, currentState);
	end
	local previousState = table.remove(undoStack);
	ApplyState(previousState);
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
end

local function PerformRedo()
	if #redoStack == 0 then return end
	if currentState then
		table.insert(undoStack, currentState);
	end
	local nextState = table.remove(redoStack);
	ApplyState(nextState);
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
end

local function PerformRestore()
	if Artificer_DB and Artificer_DB.LastTransmogState and StatesAreDifferent(currentState, Artificer_DB.LastTransmogState) then
		SaveCurrentStateToUndo();
		ApplyState(Artificer_DB.LastTransmogState);
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	end
end

local function CreateHistoryButton(name, iconAtlas, parent)
	local btn = CreateFrame("Button", name, parent)
	btn:SetSize(42, 42)
	btn:SetHitRectInsets(4, 4, 4, 4)
	
	btn:SetNormalAtlas("common-button-square-gray-up")
	btn:SetPushedAtlas("common-button-square-gray-down")
	local pushed = btn:GetPushedTexture()
	pushed:ClearAllPoints()
	pushed:SetPoint("TOPLEFT", btn, "TOPLEFT", 1, -1)
	pushed:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", 1, -1)
	
	local highlight = btn:CreateTexture(nil, "HIGHLIGHT")
	highlight:SetAtlas("common-button-square-gray-up")
	highlight:SetAlpha(0.4)
	highlight:SetAllPoints(btn)
	btn:SetHighlightTexture(highlight)
	
	btn.Icon = btn:CreateTexture(nil, "OVERLAY")
	btn.Icon:SetSize(16, 16)
	btn.Icon:SetPoint("CENTER")
	btn.Icon:SetAtlas(iconAtlas)
	
	btn:SetScript("OnMouseDown", function(self)
		if self:IsEnabled() then
			self.Icon:SetPoint("CENTER", 1, -1);
		end
	end)
	btn:SetScript("OnMouseUp", function(self)
		self.Icon:SetPoint("CENTER", 0, 0);
	end)
	
	return btn
end

local function CreateSheatheButton(name, parent, slotID)
	local btn = CreateFrame("Button", name, parent)
	btn:SetSize(30, 30)
	btn.slotID = slotID

	btn.Icon = btn:CreateTexture(nil, "BACKGROUND")
	btn.Icon:SetSize(22, 22)
	btn.Icon:SetPoint("CENTER")
	btn.Icon:SetTexture(SHEATHE_ICONS[Enum.TransmogOutfitSlotOptionSheatheCategory.Default])

	btn.Border = btn:CreateTexture(nil, "OVERLAY", nil, 1)
	btn.Border:SetAllPoints(btn)
	btn.Border:SetAtlas("transmog-gearslot-default-small", true)

	btn.DisabledIcon = btn:CreateTexture(nil, "OVERLAY", nil, 2)
	btn.DisabledIcon:SetPoint("TOPLEFT", btn, "TOPLEFT", 5, -5)
	btn.DisabledIcon:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -5, 5)
	btn.DisabledIcon:SetAtlas("transmog-icon-disabled", true)
	btn.DisabledIcon:Hide()

	local highlight = btn:CreateTexture(nil, "HIGHLIGHT")
	highlight:SetAllPoints(btn)
	highlight:SetAtlas("transmog-gearslot-default-small")
	highlight:SetBlendMode("ADD")

	btn:SetScript("OnClick", function(self)
		MenuUtil.CreateContextMenu(self, function(_owner, rootDescription)
			rootDescription:SetTag("MENU_ARTIFICER_SHEATHE_OPTIONS_" .. slotID)
			
			local slotFrame = TransmogFrame.CharacterPreview:GetSlotFrame(btn.slotID, Enum.TransmogType.Appearance)
			if not slotFrame then return end

			local weaponOptionInfo = slotFrame:GetCurrentWeaponOptionInfo()
			local weaponOption = weaponOptionInfo and weaponOptionInfo.weaponOption or Enum.TransmogOutfitSlotOption.None
			local outfitSlotInfo = C_TransmogOutfitInfo.GetViewedOutfitSlotInfo(btn.slotID, Enum.TransmogType.Appearance, weaponOption)

			if not outfitSlotInfo or outfitSlotInfo.transmogID == Constants.Transmog.NoTransmogID then return end

			local categories = C_TransmogOutfitInfo.GetAllTransmogOutfitOptionSheatheCategoryInfo(outfitSlotInfo.transmogID)
			if not categories then return end

			local currentCategory = outfitSlotInfo.sheatheCategory

			local function IsSelected(catID)
				return catID == currentCategory;
			end

			local function SetSelected(catID)
				C_TransmogOutfitInfo.SetPendingTransmogSheatheCategory(btn.slotID, weaponOption, catID);
				
				if TransmogFrame and TransmogFrame.CharacterPreview and TransmogFrame.CharacterPreview.ModelScene then
					local actor = TransmogFrame.CharacterPreview.ModelScene:GetPlayerActor();
					if actor and not actor:GetSheathed() then
						actor:SetSheathed(true);
						TransmogFrame.CharacterPreview:RefreshSheatheWeaponToggle();
					end
				end
			end

			for _, cat in ipairs(categories) do
				rootDescription:CreateRadio(cat.categoryName, IsSelected, SetSelected, cat.sheatheCategory);
			end
		end)
	end)

	btn:SetMotionScriptsWhileDisabled(true)

	btn:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		
		if self:IsEnabled() then
			GameTooltip_AddNormalLine(GameTooltip, L["SheathWeaponTT"]);
		else
			GameTooltip_AddNormalLine(GameTooltip, L["SheathWeaponTT"]);
			GameTooltip_AddErrorLine(GameTooltip, L["InvalidWeapoonSheathTT"]);
		end
		
		GameTooltip:Show();
	end)
	
	btn:SetScript("OnLeave", GameTooltip_Hide)

	return btn
end

local function UpdateSheatheButton(btn)
	if not btn then return end
	local slotFrame = TransmogFrame.CharacterPreview:GetSlotFrame(btn.slotID, Enum.TransmogType.Appearance)
	
	if not slotFrame or not slotFrame:IsShown() then
		btn:Hide();
		return;
	end

	local weaponOptionInfo = slotFrame:GetCurrentWeaponOptionInfo()
	local weaponOption = weaponOptionInfo and weaponOptionInfo.weaponOption or Enum.TransmogOutfitSlotOption.None
	local outfitSlotInfo = C_TransmogOutfitInfo.GetViewedOutfitSlotInfo(btn.slotID, Enum.TransmogType.Appearance, weaponOption)

	if not outfitSlotInfo then
		btn:Hide();
		return;
	end

	if not outfitSlotInfo.canTransmogrify then
		btn:Show();
		btn.Icon:SetTexture(SHEATHE_ICONS[Enum.TransmogOutfitSlotOptionSheatheCategory.Default]);
		btn.DisabledIcon:Show();
		btn:Disable();
		return;
	else
		btn.DisabledIcon:Hide();
		btn:Enable();
	end

	if outfitSlotInfo.transmogID == Constants.Transmog.NoTransmogID or outfitSlotInfo.displayType == Enum.TransmogOutfitDisplayType.Unassigned then
		btn:Hide();
		return;
	end

	local categories = C_TransmogOutfitInfo.GetAllTransmogOutfitOptionSheatheCategoryInfo(outfitSlotInfo.transmogID)
	if not categories or #categories <= 1 then
		btn:Hide();
		return;
	end

	btn:Show();
	btn.Icon:SetTexture(SHEATHE_ICONS[outfitSlotInfo.sheatheCategory] or SHEATHE_ICONS[Enum.TransmogOutfitSlotOptionSheatheCategory.Default]);
end

local function UpdateAllSheatheButtons()
	UpdateSheatheButton(mhSheatheBtn);
	UpdateSheatheButton(ohSheatheBtn);
end

local function ResetHistory()
	undoStack = {};
	redoStack = {};
	currentState = CaptureUIState();
	UpdateButtonStates();
end

local function BindKeys()
	if TransmogFrame and TransmogFrame:IsShown() then
		SetOverrideBindingClick(TransmogFrame, true, "ALT-Z", "ArtificerTransmogUndoButton");
		SetOverrideBindingClick(TransmogFrame, true, "SHIFT-Z", "ArtificerTransmogUndoButton");
		SetOverrideBindingClick(TransmogFrame, true, "ALT-Y", "ArtificerTransmogRedoButton");
		SetOverrideBindingClick(TransmogFrame, true, "SHIFT-Y", "ArtificerTransmogRedoButton");
	end
end

local function UnbindKeys()
	if TransmogFrame then
		ClearOverrideBindings(TransmogFrame);
	end
end

local function TryHookTransmog()
	if TransmogFrame and not historyFrame.hooked then
		
		undoBtn = CreateHistoryButton("ArtificerTransmogUndoButton", "common-icon-backarrow", TransmogFrame)
		undoBtn:SetScript("OnClick", PerformUndo)
		undoBtn:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip_AddNormalLine(GameTooltip, L["UndoTT"]);
			GameTooltip_AddHighlightLine(GameTooltip, L["UndoKeybindTT"]);
			GameTooltip:Show();
		end)
		undoBtn:SetScript("OnLeave", GameTooltip_Hide)
		undoBtn:SetFrameLevel(15)

		redoBtn = CreateHistoryButton("ArtificerTransmogRedoButton", "common-icon-forwardarrow", TransmogFrame)
		redoBtn:SetScript("OnClick", PerformRedo)
		redoBtn:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip_AddNormalLine(GameTooltip, L["RedoTT"]);
			GameTooltip_AddHighlightLine(GameTooltip, L["RedoKeybindTT"]);
			GameTooltip:Show();
		end)
		redoBtn:SetScript("OnLeave", GameTooltip_Hide)
		redoBtn:SetFrameLevel(15)

		restoreBtn = CreateHistoryButton("ArtificerTransmogRestoreButton", "common-icon-undo", TransmogFrame)
		restoreBtn:SetScript("OnClick", PerformRestore)
		restoreBtn:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(L["RestoreSessionTT"]);
			GameTooltip:Show();
		end)
		restoreBtn:SetScript("OnLeave", GameTooltip_Hide)
		restoreBtn:SetFrameLevel(15)

		if TransmogFrame.CharacterPreview then
			undoBtn:SetPoint("BOTTOMLEFT", TransmogFrame.CharacterPreview, "BOTTOMLEFT", 9, 40);
			redoBtn:SetPoint("LEFT", undoBtn, "RIGHT", 4, 0);
			restoreBtn:SetPoint("LEFT", redoBtn, "RIGHT", 4, 0);
			
			mhSheatheBtn = CreateSheatheButton("ArtificerMHSheatheButton", TransmogFrame.CharacterPreview, Enum.TransmogOutfitSlot.WeaponMainHand);
			mhSheatheBtn:SetPoint("RIGHT", TransmogFrame.CharacterPreview.BottomSlots, "LEFT", 10, 0);
			
			ohSheatheBtn = CreateSheatheButton("ArtificerOHSheatheButton", TransmogFrame.CharacterPreview, Enum.TransmogOutfitSlot.WeaponOffHand);
			ohSheatheBtn:SetPoint("LEFT", TransmogFrame.CharacterPreview.BottomSlots, "RIGHT", -10, 0);

			mhSheatheBtn:SetFrameLevel(15);
			ohSheatheBtn:SetFrameLevel(15);
		end

		UpdateButtonStates();
		UpdateAllSheatheButtons();

		TransmogFrame:HookScript("OnShow", function()
			ResetHistory();
			BindKeys();
			UpdateAllSheatheButtons();
		end)
		
		TransmogFrame:HookScript("OnHide", function()
			UnbindKeys();
			if Artificer_DB and currentState then
				if StatesAreDifferent(currentState, Artificer_DB.LastTransmogState) then
					Artificer_DB.LastTransmogState = currentState;
				end
			end
		end)
		
		EventRegistry:RegisterFrameEventAndCallback("VIEWED_TRANSMOG_OUTFIT_SLOT_REFRESH", function()
			TriggerCapture();
			UpdateAllSheatheButtons();
		end)
		EventRegistry:RegisterFrameEventAndCallback("TRANSMOG_DISPLAYED_OUTFIT_CHANGED", function()
			TriggerCapture();
			UpdateAllSheatheButtons();
		end)
		EventRegistry:RegisterFrameEventAndCallback("VIEWED_TRANSMOG_OUTFIT_CHANGED", function()
			TriggerCapture();
			UpdateAllSheatheButtons();
		end)

		EventRegistry:RegisterFrameEventAndCallback("VIEWED_TRANSMOG_OUTFIT_SLOT_WEAPON_OPTION_CHANGED", function()
			UpdateAllSheatheButtons();
		end)

		hooksecurefunc(TransmogFrame, "SelectSlot", function()
			UpdateAllSheatheButtons();
		end)

		if TransmogFrame:IsShown() then
			ResetHistory();
			BindKeys();
			UpdateAllSheatheButtons();
		end
		
		historyFrame.hooked = true;
	end
end

historyFrame:RegisterEvent("ADDON_LOADED");
historyFrame:RegisterEvent("PLAYER_LOGIN");
historyFrame:SetScript("OnEvent", function(self, event, ...)
	if not self.hooked then
		TryHookTransmog();
	end
end)