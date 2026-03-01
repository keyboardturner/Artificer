local addonName, Artificer = ...;

local L = Artificer.L;

local function Cowboy(self)
	if Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.PartySync then
		if self:IsShown() and self.ButtonContainer.Confirm:IsEnabled() then
			self:Confirm();
		end
	end
end

hooksecurefunc(QuestSessionManager.StartDialog, "CheckShow", Cowboy)