local addonName, Artificer = ...;

local L = Artificer.L;

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

blocky:SetScript("OnEvent", function(self, event, ...)
	if not self.hooked then
		TryHookTransmogFrame();
	end
end)