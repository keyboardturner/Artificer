local addonName, Artificer = ...;

local L = Artificer.L;

local Print = Artificer.Print;

local blocky = CreateFrame("Frame");
local originalBlockTradesState;

local function OnTransmogShow()
	if Artificer_DB.Widgets.BlockTrades then
		originalBlockTradesState = C_CVar.GetCVar("blockTrades");
		C_CVar.SetCVar("blockTrades", "1");
	end
end

local function OnTransmogHide()
	if Artificer_DB.Widgets.BlockTrades and originalBlockTradesState then
		C_CVar.SetCVar("blockTrades", originalBlockTradesState);
		originalBlockTradesState = nil;
	end

	-- the original purpose was to kind of prevent the transmog window from being nuked by unexpected closes, so i think posting the outfit link is a better option
	if Artificer_DB.Widgets.OutfitLinkOnClose then
		if TransmogFrame and TransmogFrame.CharacterPreview then
			local itemTransmogInfoList = TransmogFrame.CharacterPreview:GetItemTransmogInfoList();
			
			if itemTransmogInfoList then
				local link = C_TransmogCollection.GetCustomSetHyperlinkFromItemTransmogInfoList(itemTransmogInfoList);
				
				if link then
					if not ChatEdit_InsertLink(link) then
						Print(string.format(L["Widget_OutfitLinkOnClose_LastViewedOutfit"], link));
					end
				end
			end
		end
	end
end

local function TryHookTransmogFrame()
	if TransmogFrame and not blocky.hooked then
		TransmogFrame:HookScript("OnShow", OnTransmogShow);
		TransmogFrame:HookScript("OnHide", OnTransmogHide);
		blocky.hooked = true;
	end
end

blocky:RegisterEvent("PLAYER_LOGIN")
blocky:RegisterEvent("ADDON_LOADED")
blocky:RegisterEvent("PLAYER_LOGOUT")

blocky:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGOUT" then
		if Artificer_DB.Widgets.BlockTrades and originalBlockTradesState then
			C_CVar.SetCVar("blockTrades", originalBlockTradesState);
			originalBlockTradesState = nil;
		end
	elseif not self.hooked then
		TryHookTransmogFrame();
	end
end)