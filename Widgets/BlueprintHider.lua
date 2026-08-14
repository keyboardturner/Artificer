local addonName, Artificer = ...;

local L = Artificer.L;

local function IsBlueprintHiderEnabled()
	return Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.BlueprintHider;
end

local MASK_CHAR_COUNT = 24;

--[[
something happens along the line for CopyToClipboard with setting the text somewhere
you can set the editbox to a password type, but it won't be reversible unless you SetText
and if you SetText, the clipboard function seems a bit wonky
so instead i just use a "big dumb black box" placed on top of the editbox contents
this also prevents it from being clickable on purpose, since copying asterisks is not normal
the import text is a bit weird ngl but it doesn't seem to break when i set its text so whatever
]]

local function CreateMaskOverlay(shareCodeBox)
	if shareCodeBox.MaskOverlay then
		return shareCodeBox.MaskOverlay;
	end

	local overlay = CreateFrame("Frame", nil, shareCodeBox);
	overlay:SetAllPoints(shareCodeBox);
	overlay:SetFrameLevel(shareCodeBox:GetFrameLevel() + 10);
	overlay:EnableMouse(true);

	local bg = overlay:CreateTexture(nil, "BACKGROUND");
	bg:SetAllPoints();
	bg:SetColorTexture(0, 0, 0, 1.0);

	local mask = overlay:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	mask:SetPoint("LEFT", 6, 0);
	mask:SetText(string.rep("*", MASK_CHAR_COUNT));
	overlay.maskText = mask;

	shareCodeBox.MaskOverlay = overlay;
	return overlay;
end

local function CreateImportToggle(shareCodeBox)
	if shareCodeBox.EyeToggle then return; end

	local editBox = shareCodeBox.EditBox;

	local toggle = CreateFrame("Button", nil, shareCodeBox);
	toggle:SetSize(25, 25);
	toggle:SetPoint("RIGHT", shareCodeBox, "RIGHT", 0, 0);
	toggle:SetFrameLevel(shareCodeBox:GetFrameLevel() + 10);

	local texture = toggle:CreateTexture(nil, "ARTWORK");
	texture:SetAllPoints();
	texture:SetAtlas("talents-heroclass-ring-minimize-hide");
	toggle.texture = texture;

	toggle:SetScript("OnClick", function(self)
		local isPassword = editBox:IsPassword();
		editBox:SetPassword(not isPassword);
		local currentText = editBox:GetText();
		editBox:SetText("");
		editBox:SetText(currentText);
		self.texture:SetAtlas(isPassword and "talents-heroclass-ring-minimize-show" or "talents-heroclass-ring-minimize-hide");
	end);

	shareCodeBox.EyeToggle = toggle;
end

local function AttachImportToggle(shareCodeBox)
	CreateImportToggle(shareCodeBox);

	local editBox = shareCodeBox.EditBox;
	editBox:SetPassword(true);

	local currentText = editBox:GetText();
	editBox:SetText("");
	editBox:SetText(currentText);

	shareCodeBox.EyeToggle.texture:SetAtlas("talents-heroclass-ring-minimize-hide");
end


local function CreateExportToggle(shareCodeBox)
	if shareCodeBox.EyeToggle then return; end

	local overlay = CreateMaskOverlay(shareCodeBox);

	local toggle = CreateFrame("Button", nil, shareCodeBox);
	toggle:SetSize(25, 25);
	toggle:SetPoint("RIGHT", shareCodeBox, "RIGHT", 0, 0);
	toggle:SetFrameLevel(overlay:GetFrameLevel() + 1);

	local texture = toggle:CreateTexture(nil, "ARTWORK");
	texture:SetAllPoints();
	texture:SetAtlas("talents-heroclass-ring-minimize-hide");
	toggle.texture = texture;

	toggle:SetScript("OnClick", function(self)
		local isMasked = overlay:IsShown();
		overlay:SetShown(not isMasked);
		self.texture:SetAtlas(isMasked and "talents-heroclass-ring-minimize-show" or "talents-heroclass-ring-minimize-hide");
	end);

	shareCodeBox.EyeToggle = toggle;
end

local function AttachExportToggle(shareCodeBox)
	CreateExportToggle(shareCodeBox);

	shareCodeBox.MaskOverlay:Show();
	shareCodeBox.EyeToggle.texture:SetAtlas("talents-heroclass-ring-minimize-hide");
end

local function ObscureEditBoxes()
	if not IsBlueprintHiderEnabled() then return; end

	if HousingBlueprintImportFrame and HousingBlueprintImportFrame.InputContent then
		AttachImportToggle(HousingBlueprintImportFrame.InputContent.ShareCodeBox);
	end

	if HousingBlueprintExportFrame and HousingBlueprintExportFrame.SuccessContent then
		AttachExportToggle(HousingBlueprintExportFrame.SuccessContent.ShareCodeBox);
	end
end

EventRegistry:RegisterCallback('HousingBlueprint.FrameShown', ObscureEditBoxes);

local eventHandler = CreateFrame("Frame");
eventHandler:RegisterEvent("HOUSING_BLUEPRINT_EXPORT_SUCCESS");
eventHandler:SetScript("OnEvent", function(_, event)
	if event == "HOUSING_BLUEPRINT_EXPORT_SUCCESS" then
		if not IsBlueprintHiderEnabled() then return; end
		
		if HousingBlueprintExportFrame and HousingBlueprintExportFrame.SuccessContent then
			AttachExportToggle(HousingBlueprintExportFrame.SuccessContent.ShareCodeBox);
		end
	end
end);

Artificer.Widgets.ApplyBlueprintHider = function()
	local enabled = IsBlueprintHiderEnabled();
	
	if HousingBlueprintImportFrame and HousingBlueprintImportFrame.InputContent then
		local shareCodeBox = HousingBlueprintImportFrame.InputContent.ShareCodeBox;
		if enabled then
			AttachImportToggle(shareCodeBox);
		elseif shareCodeBox.EyeToggle then
			shareCodeBox.EditBox:SetPassword(false);
			shareCodeBox.EyeToggle:Hide();
			shareCodeBox.EyeToggle = nil;
		end
	end

	if HousingBlueprintExportFrame and HousingBlueprintExportFrame.SuccessContent then
		local shareCodeBox = HousingBlueprintExportFrame.SuccessContent.ShareCodeBox;
		if enabled then
			AttachExportToggle(shareCodeBox);
		elseif shareCodeBox.MaskOverlay then
			shareCodeBox.MaskOverlay:Hide();
			if shareCodeBox.EyeToggle then
				shareCodeBox.EyeToggle:Hide();
				shareCodeBox.EyeToggle = nil;
			end
		end
	end
end
