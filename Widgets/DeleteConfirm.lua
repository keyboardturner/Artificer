local addonName, Artificer = ...;
local L = Artificer.L;

local origOnShow = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnShow
local origOnHide = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHide

StaticPopupDialogs["DELETE_GOOD_ITEM"].OnShow = function(dialog, data)
	if origOnShow then
		origOnShow(dialog, data);
	end

	if Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.DeleteConfirm then
		if not dialog.autoDeleteButton then
			local btn = CreateFrame("Button", nil, dialog)
			btn:SetSize(24, 24)
			
			local editBox = dialog:GetEditBox()
			
			btn:SetPoint("RIGHT", editBox, "LEFT", -5, 0)
			
			btn:SetNormalAtlas("common-icon-delete")
			btn:SetHighlightAtlas("common-icon-delete", "ADD")
			
			btn:SetScript("OnClick", function(self)
				editBox:SetText(DELETE_ITEM_CONFIRM_STRING);
				dialog:GetButton1():Click();
			end)
			btn:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOM");
				GameTooltip:AddLine(L["Widget_DeleteConfirm_ButtonTT"], 1, 1, 1, 1, true);
				GameTooltip:Show();
			end)
			btn:SetScript("OnLeave", GameTooltip_Hide);
			
			dialog.autoDeleteButton = btn
		end

		dialog.autoDeleteButton:Show()
	else
		if dialog.autoDeleteButton then
			dialog.autoDeleteButton:Hide()
		end
	end
end

StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHide = function(dialog, data)
	if origOnHide then
		origOnHide(dialog, data);
	end
	
	if dialog.autoDeleteButton then
		dialog.autoDeleteButton:Hide();
	end
end