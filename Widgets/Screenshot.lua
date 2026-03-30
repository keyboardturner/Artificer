local addonName, Artificer = ...;

local L = Artificer.L;

Artificer.Widgets.ApplyScreenshotSizeMultiplier = function(val)
	if not val then return end
	Artificer.StoreCVar("screenshotSizeOverride");

	if val == 1 then
		C_CVar.SetCVar("screenshotSizeOverride", "0x0");
	else
		local w, h = 1920, 1080
		if C_VideoOptions and C_VideoOptions.GetCurrentGameWindowSize then
			local size = C_VideoOptions.GetCurrentGameWindowSize();
			w, h = size.x, size.y;
		else
			local res = C_CVar.GetCVar("gxWindowedResolution")
			if res then 
				local parsedW, parsedH = res:match("(%d+)x(%d+)")
				if parsedW and parsedH then
					w, h = tonumber(parsedW), tonumber(parsedH);
				end
			end
		end
		
		C_CVar.SetCVar("screenshotSizeOverride", tostring(w * val) .. "x" .. tostring(h * val))
	end
end

Artificer.Widgets.ApplyHideScreenshotText = function()
	if not ActionStatus then return end

	if Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.HideScreenshotText then
		ActionStatus:UnregisterEvent("SCREENSHOT_STARTED");
		ActionStatus:UnregisterEvent("SCREENSHOT_SUCCEEDED");
		ActionStatus:UnregisterEvent("SCREENSHOT_FAILED");
	else
		ActionStatus:RegisterEvent("SCREENSHOT_STARTED");
		ActionStatus:RegisterEvent("SCREENSHOT_SUCCEEDED");
		ActionStatus:RegisterEvent("SCREENSHOT_FAILED");
	end
end

Artificer.Widgets.ApplyScreenshotSettings = function()
	if not Artificer_DB then return end

	if Artificer_DB.ScreenshotFormat then
		Artificer.StoreCVar("screenshotFormat");
		C_CVar.SetCVar("screenshotFormat", Artificer_DB.ScreenshotFormat);
	end
	
	if Artificer_DB.ScreenshotQuality then
		Artificer.StoreCVar("screenshotQuality");
		C_CVar.SetCVar("screenshotQuality", Artificer_DB.ScreenshotQuality);
	end
	
	if Artificer_DB.ScreenshotSizeMultiplier then
		Artificer.Widgets.ApplyScreenshotSizeMultiplier(Artificer_DB.ScreenshotSizeMultiplier);
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		Artificer.Widgets.ApplyHideScreenshotText();
		Artificer.Widgets.ApplyScreenshotSettings();
	end
end)