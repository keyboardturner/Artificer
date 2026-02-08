local addonName, Artificer = ...;

local L = Artificer.L;

local SERVER_MESSAGES = {
	"[SERVER]", -- enUS, deDE, itIT
	"[SERVIDOR]", -- esES, esMX, ptBR
	"[SERVEUR]", -- frFR
	"[서버]", -- koKR
	"[СЕРВЕР]", -- ruRU
	"[服务器]", -- zhCN
	"[伺服器]", -- zhTW
};

local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_SYSTEM")

f:SetScript("OnEvent", function(self, event, text)
	if Artificer_DB.Widgets.ServerNotifications then
		if issecretvalue(text) or not text then return end

		for k, v in pairs(SERVER_MESSAGES) do


			if text:find(v, 1, true) then -- can't use SERVER_MESSAGE_PREFIX atm
				RaidNotice_AddMessage(
					RaidWarningFrame,
					text,
					ChatTypeInfo["RAID_WARNING"]
				);
				PlaySound(SOUNDKIT.RAID_WARNING, "Master");
			end
		end
	end
end)