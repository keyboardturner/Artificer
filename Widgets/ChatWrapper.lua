local addonName, Artificer = ...;
local L = Artificer.L;

local ChatTooltip = CreateFrame("GameTooltip", "ArtificerChatTooltip", UIParent, "GameTooltipTemplate")

local function UpdateEditBoxTooltip(editBox)
	local text = editBox:GetText()
	
	if text and text ~= "" then
		local cursorPos = editBox:GetCursorPosition()
		local textLen = string.len(text)
		
		local maxLetters = editBox:GetVisibleTextByteLimit()
		
		local counterDisplay
		if not maxLetters or maxLetters <= 0 or maxLetters > 100000 then
			counterDisplay = string.format("(%s)", textLen);
		else
			counterDisplay = string.format("(%s/%s)", textLen, maxLetters);
		end
		
		local leftSide = string.sub(text, 1, cursorPos)
		local rightSide = string.sub(text, cursorPos + 1)
		local visualText = string.format("%s%s%s", leftSide, "|cFF00FF00|||r", rightSide)

		ChatTooltip:SetOwner(editBox, "ANCHOR_TOPLEFT", 0, 5)
		
		local headerText = string.join(" ", L["CurrentMessage"], counterDisplay)
		ChatTooltip:SetText(headerText, 1, 0.82, 0)
		ChatTooltip:AddLine(visualText, 1, 1, 1, true)
		ChatTooltip:Show()
	else
		if ChatTooltip:GetOwner() == editBox then
			ChatTooltip:Hide();
		end
	end
end

local function EvaluateTooltipState(editBox)
	local visibility = (Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.ChatTooltipVisibility) or 3

	if visibility == 1 then
		if ChatTooltip:GetOwner() == editBox then
			ChatTooltip:Hide();
		end
		return;
	end

	local shouldShow = false
	
	if visibility == 2 then
		shouldShow = editBox:IsMouseOver();
	elseif visibility == 3 then
		shouldShow = editBox:IsMouseOver() or editBox:HasFocus();
	end

	if shouldShow then
		UpdateEditBoxTooltip(editBox);
	else
		if ChatTooltip:GetOwner() == editBox then
			ChatTooltip:Hide();
		end
	end
end

local function HookChatEditBox(editBox)
	if not editBox then return end
	
	editBox:HookScript("OnEnter", EvaluateTooltipState);
	editBox:HookScript("OnLeave", EvaluateTooltipState);
	editBox:HookScript("OnEditFocusGained", EvaluateTooltipState);
	editBox:HookScript("OnEditFocusLost", EvaluateTooltipState);
	editBox:HookScript("OnTextChanged", EvaluateTooltipState);
	editBox:HookScript("OnCursorChanged", EvaluateTooltipState);
end

if ChatFrameUtil and ChatFrameUtil.ForEachChatFrame then
	ChatFrameUtil.ForEachChatFrame(function(chatFrame)
		HookChatEditBox(chatFrame.editBox);
	end)
else
	for i = 1, NUM_CHAT_WINDOWS do
		local chatFrame = _G["ChatFrame"..i]
		if chatFrame and chatFrame.editBox then
			HookChatEditBox(chatFrame.editBox);
		end
	end
end