local addonName, Artificer = ...;

local L = Artificer.L;

local f = CreateFrame("Frame");
f:RegisterEvent("ADDON_LOADED");
f:RegisterEvent("PLAYER_LOGIN");

function Artificer.Widgets.ApplyMovableCurrencyTransfer()
	local isEnabled = Artificer_DB.Widgets.MovableCurrencyTransfer

	if not C_AddOns.IsAddOnLoaded("Blizzard_TokenUI") then
		return;
	end

	local frame = CurrencyTransferMenu
	if not frame then return end

	if isEnabled then
		frame:SetMovable(true)
		frame:EnableMouse(true)
		frame:RegisterForDrag("LeftButton")
		frame:SetClampedToScreen(true)

		if not frame.ArtificerHooked then
			frame:HookScript("OnDragStart", function(self)
				if Artificer_DB.Widgets.MovableCurrencyTransfer then
					self:StartMoving();
				end
			end)
			
			frame:HookScript("OnDragStop", function(self)
				self:StopMovingOrSizing();
				Artificer:SaveFramePosition(self, "CurrencyTransferMenu");
			end)

			frame:HookScript("OnShow", function(self)
				if Artificer_DB.Widgets.MovableCurrencyTransfer then
					Artificer:RestoreFramePosition(self, "CurrencyTransferMenu");
				end
			end)
			
			frame.ArtificerHooked = true;
		end
		
		if frame:IsShown() then
			Artificer:RestoreFramePosition(frame, "CurrencyTransferMenu");
		end

	else
		frame:SetMovable(false);
	end
end

f:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "Blizzard_CurrencyTransfer" then
		Artificer.Widgets.ApplyMovableCurrencyTransfer();
	elseif event == "PLAYER_LOGIN" then
		Artificer.Widgets.ApplyMovableCurrencyTransfer();
	end
end)