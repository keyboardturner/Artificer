local addonName, Artificer = ...

local L = {};
Artificer.L = L;

local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to—avoid writing the default localization out explicitly.
 return key;
end
setmetatable(L, {__index=defaultFunc});

local LOCALE = GetLocale()


if LOCALE == "enUS" then
	-- The EU English game client also
	-- uses the US English locale code.
	L["TOC_Title"] = "Artificer"
	L["TOC_Notes"] = "A personal workshop and collection of UI tweaks and adjustments"
	L["SLASH_ARTI1"] = "/artificer" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI2"] = "/arti" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI3"] = "/artificer" -- localized slash command
	L["SLASH_ARTI4"] = "/arti" -- localized slash command
	L["OpenSettings"] = "Open Settings"

	-- Headers
	L["Header_AccountSettings"] = "Account Settings"
	L["Header_CVars"] = "Console Variables (CVars)"

	--Widgets
	L["Widget_FishReelIn"] = "Fish Reel In"
	L["Widget_FishReelInTT"] = "Plays a reel-in sound when your fishing cast finishes."
	L["Widget_ChromieTimeIcon"] = "Chromie Time Icon"
	L["Widget_ChromieTimeIconTT"] = "Displays an icon on the map indicating if you're in Chromie Time (Timewalking Campaigns)."
	L["Widget_ChromieTimeIcon_NoCampaign"] = "No current Timewalking Campaign is active."
	L["Widget_HideMacroText"] = "Hide Action Button Macro Text"
	L["Widget_HideMacroTextTT"] = "Hides the macro text on Action Bar buttons."
	L["Widget_ArrowKeyEditbox"] = "Allow Arrow Keys in Chat Editbox"
	L["Widget_ArrowKeyEditboxTT"] = "Allow using the arrow keys to move the cursor in the chat editbox without needing to press alt."
	L["Widget_OutfitIcon"] = "Transmog Outfit Borders"
	L["Widget_OutfitIconTT"] = "Display borders on transmog outfits that are placed on the action bar buttons."
	L["Widget_ServerNotifications"] = "Server Notification Raid Warnings"
	L["Widget_ServerNotificationsTT"] = "Display Server Notifications (such as realm restarts) displayed as a Raid Warning."
	L["Widget_OutfitSwapSounds"] = "Outfit Swap Sounds"
	L["Widget_OutfitSwapSoundsTT"] = "Select which sounds to mute during outfit changes."
	L["Widget_OSS_Impact"] = "Impact"
	L["Widget_OSS_STA"] = "Sound Type A"
	L["Widget_OSS_STB"] = "Sound Type B"
	L["Widget_OSS_STC"] = "Sound Type C"
	L["Widget_OSS_STD"] = "Sound Type D"
	L["Widget_HideCraftingResults"] = "Hide Crafting Results"
	L["Widget_HideCraftingResultsTT"] = "Hide the Crafting Results frame when opening a profession tradeskill frame and crafting an item."
	L["Widget_MovableCurrencyTransfer"] = "Movable Currency Transfer"
	L["Widget_MovableCurrencyTransferTT"] = "Allows the Currency Transfer window to be moved."
	L["Widget_AddonCompartmentMover"] = "Move Addon Compartment Frame"
	L["Widget_AddonCompartmentMoverTT"] = "Moves the Addon Compartment Frame to the top of the calendar button instead of the bottom."
	L["Widget_MinimapIcon"] = "Minimap Icon"
	L["Widget_MinimapIconTT"] = "Displays clickable icon button on Minimap to open settings."
	L["Widget_CollapseBuffs"] = "Auto Collapse Buff Frame"
	L["Widget_CollapseBuffsTT"] = "Automatically collapses the default Buff Frame."
	L["Widget_PartySync"] = "Automatically Accept Party Sync"
	L["Widget_PartySyncTT"] = "Automatically accept the Party Sync confirm button when it is prompted."
	L["Widget_ChatTooltipVisibility"] = "Chat Message Preview"
	L["Widget_ChatTooltipVisibilityTT"] = "Display a tooltip on the edit box to preview the chat message you're currently editing."
	L["CurrentMessage"] = "Current Message"
	L["Mouseover"] = "Mouseover"
	L["Widget_HideScreenshotText"] = "Hide Screenshot Text"
	L["Widget_HideScreenshotTextTT"] = "Hides the screenshot taken text."
	L["Widget_ScreenshotFormat"] = "Screenshot Format"
	L["Widget_ScreenshotFormatTT"] = "Adjust the screenshot format (PNG may turn certain skyboxes transparent in the file)."
	L["Widget_ScreenshotQuality"] = "Screenshot Quality"
	L["Widget_ScreenshotQualityTT"] = "Adjust the screenshot quality."
	L["Widget_ScreenshotSizeMultiplier"] = "Screenshot Resolution"
	L["Widget_ScreenshotSizeMultiplierTT"] = "Adjust the screenshot resolution based on a multiplier of your window."
	L["Warning_FileSize"] = "Caution: This may cause a large screenshot file size."

	--Widgets - Account-wide settings
	L["Widget_AutoLoot"] = "Account Auto Loot Toggle"
	L["Widget_AutoLootTT"] = "Enforces account-wide settings for Auto Loot on every character."
	L["Widget_PetBattleMapFilter"] = "Account Pet Battle Map Filter Toggle"
	L["Widget_PetBattleMapFilterTT"] = "Enforces account-wide settings for Pet Battle Map Filter on every character."
	L["Widget_cooldownViewerEnabled"] = "Account Cooldown Manager Toggle"
	L["Widget_cooldownViewerEnabledTT"] = "Enforces account-wide settings for the Cooldown Manager on every character."
	L["Account_On"] = "Account-Wide Enabled"
	L["Account_Off"] = "Account-Wide Disabled"
	L["Widget_BlockGuildInvites"] = "Account Block Guild Invites"
	L["Widget_BlockGuildInvitesTT"] = "Account-wide setting to automatically decline guild invites on all characters."

	--Widgets - CancelAura
	L["CancelAuraManager"] = "Cancel Aura Manager"
	L["CancelAuraManagerTT"] = "Automatically remove specific buffs out of combat."
	L["InvalidSpell"] = "Invalid Spell ID"
	L["EnterSpellID"] = "Enter Spell ID"
	L["CanceledAuras"] = "Canceled Auras"
	L["AuraHistory"] = "Aura History"
	L["SpellID"] = "Spell ID"

	--Widgets - AbandonQuestManager
	L["AbandonQuestManager"] = "Abandon Quest Manager"
	L["AbandonQuestManagerTT"] = "Automatically remove specific quests you don't want to accept."
	L["InvalidQuest"] = "Invalid Quest ID"
	L["EnterQuestID"] = "Enter Quest ID"
	L["AbandonedQuests"] = "Auto Abandoned Quests"
	L["QuestHistory"] = "Quest History"
	L["QuestID"] = "Quest ID: %s"

	--Widgets - OutfitBar
	L["OutfitSoundManager"] = "Outfit Sound Manager"
	L["OutfitSoundManagerTT"] = "Configure gear movement sounds that can play for each outfit."
	L["Leather"] = "Leather"
	L["Chain"] = "Chain"
	L["Plate"] = "Plate"
	L["GearLight"] = "Gear Light"
	L["GearHeavy"] = "Gear Heavy"
	L["BucklesLight"] = "Buckles Light"
	L["BucklesHeavy"] = "Buckles Heavy"
	L["YakRun"] = "Yak Run"
	L["YakWalk"] = "Yak Walk"
	L["GrummleRun"] = "Grummle Run"
	L["GrummleWalk"] = "Grummle Walk"
	L["TreasureGoblin"] = "Treasure Goblin"
	L["SoundS"] = "Sound: %s"
	L["Click"] = "Click: %s"
	L["LeftClick"] = "Left-Click: %s"
	L["RightClick"] = "Right-Click: %s"
	L["ClickDrag"] = "Click-Drag: %s"
	L["ConfigureSounds"] = "Configure Sounds"
	L["PickUpOutfit"] = "Pick Up Outfit"
	L["OutfitManager"] = "Outfit Manager"
	L["OutfitManagerTT"] = "Choose an outfit to wear and configure gear movement sounds that can play for each outfit."
	L["EquipOutfit"] = "Equip Outfit"
	L["Widget_MinimapRightClick"] = "Minimap Right-Click"
	L["Widget_MinimapRightClickTT"] = "Set the Minimap right-click functionality"
	L["LockAppearance"] = "Lock Appearance"

	--Widgets - TransmogHistory
	L["UndoTT"] = "Undo"
	L["RedoTT"] = "Redo"
	L["UndoKeybindTT"] = "(Alt-Z / Shift-Z)"
	L["RedoKeybindTT"] = "(Alt-Y / Shift-Y)"
	L["RestoreSessionTT"] = "Restore Previous Session"
	L["SheathWeaponTT"] = TRANSMOG_SHEATHE_WEAPON
	L["InvalidWeapoonSheathTT"] = TRANSMOG_SLOT_WARNING_NOTHING_EQUIPPED

	--Widgets - Loot History Visibility
	L["Widget_LootHistoryVisibility"] = "Loot History Visibility"
	L["Widget_LootHistoryVisibilityTT"] = "Automatically hide the loot history based on the selected option."
	L["Widget_LHV_None"] = NONE
	L["Widget_LHV_Solo"] = SOLO
	L["Widget_LHV_NotFull"] = "Non-Full Group"
	L["Widget_LHV_Always"] = ALWAYS

	--Widgets - Hide Tutorials
	L["Widget_HideTutorials"] = "Hide Tutorials"
	L["Widget_HideTutorialsTT"] = "Enforces hiding tutorials for the entire account."

	--Widgets - NameplateTargetIndicator
	L["FNP_TargetIndicator"] = "Friendly Nameplate Target Indicator"
	L["FNP_TargetIndicatorTT"] = "Displays an icon on the nameplate of a friendly player targeting you."
	L["FNP_HeroTalentRing"] = "Hero Talent Ring"
	L["FNP_ArtificerEye"] = "Artificer Eye"
	L["FNP_LFGEye"] = "LFG Eye"
	L["FNP_DragIcon"] = "Drag Icon Relative to Nameplate"
	L["FNP_IconStyle"] = "Icon Style"
	L["FNP_IconSize"] = "Icon Size"
	L["FNP_IconColor"] = "Icon Color"
	L["LC_OpenColorPicker"] = "Left-Click: Open Color Picker"
	L["RC_OpenDropdown"] = "Right-Click: Additional Settings"
	L["ColorOptions"] = "Color Options"
	L["CopyColor"] = "Copy Color"
	L["PasteColor"] = "Paste Color"

	--Widgets - NameplateStatus
	L["FNP_StatusIndicator"] = "Friendly Nameplate Status Indicator"
	L["FNP_StatusIndicatorTT"] = "Displays an icon on the nameplate of a friendly player status."
	L["FNP_StatusOptions"] = PLAYER_STATUS
	L["FNP_StatusConnection"] = "Connection (AFK/DND/DC)"
	L["FNP_StatusChromie"] = "Chromie Time"
	L["FNP_StatusGroup"] = PARTY_MEMBERS
	L["FNP_StatusGuild"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriend"] = FRIENDS
	L["FNP_StatusIgnored"] = IGNORED
	L["FNP_StatusConnectionDCd"] = "Disconnected"
	L["FNP_StatusConnectionAway"] = CHAT_MSG_AFK
	L["FNP_StatusConnectionDND"] = DND
	L["FNP_StatusGroupMember"] = GROUP
	L["FNP_StatusGroupAssist"] = RAID_ASSISTANT
	L["FNP_StatusGroupLeader"] = LEADER
	L["FNP_StatusGuildMember"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriendChar"] = FRIENDS .. " - " .. CHARACTER
	L["FNP_StatusFriendAcc"] = FRIENDS .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT
	L["FNP_StatusFriendBNet"] = FRIENDS .. " - " .. BATTLETAG
	L["FNP_StatusIgnoredChar"] = IGNORED .. " - " .. CHARACTER
	L["FNP_StatusIgnoredAcc"] = IGNORED .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT

	--Widgets - Account Ignore List
	L["Widget_AccountIgnoreList"] = "Account Ignore List Window"
	L["Widget_AccountIgnoreListTT"] = "Display a window containing all recorded ignores on the account."
	L["AccountIgnoreList"] = "Account Ignore List"

	--Widgets - PreyBar
	L["Widget_PreyBar"] = "Prey Progress Indicators"
	L["Widget_PreyBarTT"] = "Displays alternate Prey Progress alongside the Prey Hunt widget."
	L["PreyBar_Style_Row"] = "Row"
	L["PreyBar_Style_Statusbar"] = "Status Bar"
	L["PreyBar_Position"] = "Position"
	L["PreyBar_PositionTT"] = "Which side of the widget to attach to."
	L["PreyBar_Style"] = UNIT_NAMEPLATES_STYLE
	L["PreyBar_Style_Corner"] = RAID_TARGET_4
	L["PreyBar_Position_Top"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_TOP
	L["PreyBar_Position_Bottom"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_BOTTOM
	L["PreyBar_Position_Left"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_LEFT
	L["PreyBar_Position_Right"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_RIGHT
	L["PreyBar_HideBlizzWidget"] = "Hide Blizzard Prey Widget"
	L["PreyBar_HideInCombat"] = "Hide in Combat"

	L["EncounterBar"] = HUD_EDIT_MODE_ENCOUNTER_BAR_LABEL

	L["Header_Combat"] = COMBAT_LABEL
	L["Widget_SpellAlerts"] = COMBAT_TEXT_SHOW_REACTIVES_TEXT
	L["Widget_SpellAlertsTT"] = "Filter specific spell alerts which appear on screen.\n\nRequires Spell Alerts to be enabled."

	--Widgets - BlockTrades
	L["Widget_BlockTrades"] = "Block Trading While Transmogging"
	L["Widget_BlockTradesTT"] = "Blocks all trading while the transmog frame is open"
	L["Widget_OutfitLinkOnClose"] = "Outfit Link on Transmog Close"
	L["Widget_OutfitLinkOnCloseTT"] = "Automatically link your currently viewed outfit into the chat when closing the Transmog window."
	L["Widget_OutfitLinkOnClose_LastViewedOutfit"] = "Last Viewed Outfit: %s"

	--Widgets - MapAmbience
	L["Widget_MapAmbience_QD"] = "Reduce Quel'danas Ambience Volume"
	L["Widget_MapAmbience_QDTT"] = "Reduces the ambience volume in Quel'danas by roughly 25% of your existing ambience volume."

	--Widgets - DamageMeter
	L["Widget_DamageMeter"] = DAMAGE_METER_LABEL
	L["Widget_DamageMeterTT"] = "Enforces account-wide settings for the damage meter visibility on every character"
	L["Widget_DamageWipe"] = AUTO_RESET_DAMAGE_METER
	L["Widget_DamageWipeTT"] = "Enforces account-wide settings for the resetting the damage meter on every character"

	--Widgets - Account-wide settings
	L["Header_ObjectiveTracker"] = HUD_EDIT_MODE_OBJECTIVE_TRACKER_LABEL
	L["Widget_AutoCollapseTracker"] = "Auto Collapse Objective Tracker"
	L["Widget_AutoCollapseTrackerTT"] = "Automatically minimizes the Objective Tracker under certain conditions."
	L["Widget_AutoFadeObjectiveTracker"] = "Auto Fade Objective Tracker"
	L["Widget_AutoFadeObjectiveTrackerTT"] = "Automatically fades the Objective Tracker under certain conditions."
	L["Widget_ACT_RestedArea"] = "Rested Area"
	L["Widget_ACT_Combat"] = COMBAT
	L["Widget_ACT_PetBattles"] = SHOW_PET_BATTLES_ON_MAP_TEXT
	L["Widget_ACT_Battlegrounds"] = BATTLEFIELDS
	L["Widget_ACT_Arena"] = ARENA
	L["Widget_ACT_Dungeon"] = LFG_TYPE_DUNGEON
	L["Widget_ACT_MPlus"] = PLAYER_DIFFICULTY_MYTHIC_PLUS
	L["Widget_ACT_Raids"] = RAID
	L["Widget_ACT_ScenariosDelves"] = SCENARIOS_PVEFRAME .. "/" .. DELVES_LABEL
	L["Widget_ACT_Housing"] = BINDING_HEADER_HOUSING_SYSTEM

	--Widgets - Delete Confirm
	L["Widget_DeleteConfirm"] = "Delete Item Text Filler"
	L["Widget_DeleteConfirmTT"] = string.format("Button to fill the '%s' text, with subsequent function to delete the item on the second press.", DELETE_ITEM_CONFIRM_STRING)
	L["Widget_DeleteConfirm_ButtonTT"] = string.format("Click 1: Fill '%s' text.\n\nClick 2: Delete Item.", DELETE_ITEM_CONFIRM_STRING)

	--Widgets - ProfessionToasts
	L["Widget_ProfessionToasts"] = "Profession Toasts"
	L["Widget_ProfessionToastsTT"] = "Displays a fade-in notification upon levelling a profession skill."
	L["FrameWidth"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_WIDTH
	L["FrameHeight"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_HEIGHT
	L["FontSize"] = FONT_SIZE
	L["FontColor"] = "Font Color"
	L["BorderColor"] = EMBLEM_BORDER_COLOR
	L["BackgroundColor"] = "Background Color"
	L["BorderStyle"] = "Border Style"
	L["BackgroundStyle"] = "Background Style"
	L["SingleLine"] = "Single Line Profession Level"
	L["PlaySound"] = COOLDOWN_VIEWER_SETTINGS_ALERT_MENU_BUTTON_TOOLTIP_PREVIEW
	L["Desaturate"] = "Desaturate"

	L["BorderStyle_housingcontainer"] = "Housing Container"
	L["BorderStyle_shopheader"] = "Shop Header"
	L["BorderStyle_questtracker"] = "Quest Tracker"
	L["BorderStyle_achievementalert"] = "Achievement Alert"
	L["BorderStyle_shipmisson"] = "Ship Mission"
	L["BorderStyle_housingitem"] = "Housing Item"
	L["BorderStyle_artifactlevel"] = "Artifact Level"
	L["BorderStyle_shoptoast"] = "Shop Toast"
	L["BorderStyle_legioninvasion"] = "Legion Invasion Title"
	L["BorderStyle_lootroll"] = "Loot Roll"
	L["BorderStyle_activities"] = "Activities"
	L["BorderStyle_midnightscenariotitle"] = "Midnight Scenario Title"
	L["BorderStyle_thewarwithinscenariotitle"] = "War Within Scenario Title"
	L["BorderStyle_dragonflightscenariotitle"] = "Dragonflight Scenario Title"
	L["BorderStyle_dragonflightscenarioframe"] = "Dragonflight Scenario Frame"
	L["BorderStyle_evergreenscenariotitle"] = "Evergreen Scenario Title"

	-- Professions - official translations
	L["ALCHEMY"] = "Alchemy" --CHARACTER_PROFESSION_ALCHEMY
	L["ARCHAEOLOGY"] = "Archaeology"--PROFESSIONS_ARCHAEOLOGY
	L["BLACKSMITHING"] = "Blacksmithing" --CHARACTER_PROFESSION_BLACKSMITHING
	L["COOKING"] = "Cooking" --PROFESSIONS_COOKING
	L["ENCHANTING"] = "Enchanting" --CHARACTER_PROFESSION_ENCHANTING
	L["ENGINEERING"] = "Engineering" --CHARACTER_PROFESSION_ENGINEERING
	L["FIRST_AID"] = "First Aid" --PROFESSIONS_FIRST_AID
	L["FISHING"] = "Fishing" --PROFESSIONS_FISHING
	L["HERBALISM"] = "Herbalism" --CHARACTER_PROFESSION_HERBALISM
	L["INSCRIPTION"] = "Inscription" --CHARACTER_PROFESSION_INSCRIPTION
	L["JEWELCRAFTING"] = "Jewelcrafting" --CHARACTER_PROFESSION_JEWELCRAFTING
	L["LEATHERWORKING"] = "Leatherworking" --CHARACTER_PROFESSION_LEATHERWORKING
	L["MINING"] = "Mining" --CHARACTER_PROFESSION_MINING
	L["SKINNING"] = "Skinning" --CHARACTER_PROFESSION_SKINNING
	L["TAILORING"] = "Tailoring" --CHARACTER_PROFESSION_TAILORING

	L["SpecializationArt"] = "Specialization Art"
	L["MobileIcons"] = "Mobile Icon"

	L["MetalChainMaw"] = "Metal Chain - Maw"
	L["Wildhammer"] = "Wildhammer"

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Show All Minimap Trackables"
	L["CVar_minimapTrackingShowAllTT"] = "Toggle additional minimap tracking options."
	L["CVar_weatherDensity"] = "Weather Density"
	L["CVar_weatherDensityTT"] = "Control the weather density / intensity."
	L["CVar_AutoPushSpellToActionBar"] = "Auto Push Spells to Action Bars"
	L["CVar_AutoPushSpellToActionBarTT"] = "Whether spells should automatically be placed on your action bars."
	L["CVar_minimapTrackingClosestOnly"] = "Minimap Tracking Closest Only"
	L["CVar_minimapTrackingClosestOnlyTT"] = "Show only the closest tracked icon for certain minimap icon types."
	L["CVar_autoDismount"] = "Auto Dismount (Ground)"
	L["CVar_autoDismountTT"] = "Automatically dismount from your ground mount when interacting with certain things."

	-- Global Strings
	L["UIScale"] = UI_SCALE
	L["LockFrame"] = LOCK_FRAME
	L["ResetPosition"] = RESET_POSITION
	L["Header_Professions"] = TRADE_SKILLS
	L["Header_Map"] = WORLD_MAP
	L["Header_ActionBar"] = BINDING_HEADER_ACTIONBAR
	L["Header_Chat"] = BINDING_HEADER_CHAT
	L["Header_Misc"] = BINDING_HEADER_MISC
	L["Loading"] = LFG_LIST_LOADING
	L["Remove"] = REMOVE
	L["Add"] = ADD
	L["None"] = NONE
	L["All"] = ALL
	L["Outfit"] = TRANSMOG_OUTFIT_NAME_DEFAULT
	L["AdvancedOptions"] = ADVANCED_OPTIONS
	L["Header_Nameplates"] = NAMEPLATES_LABEL
	L["Header_Screenshot"] = BINDING_NAME_SCREENSHOT



return end

if LOCALE == "esMX" then
	-- Spanish (Mexico) translations go here

	L["TOC_Title"] = "Artificer"
	L["TOC_Notes"] = "Un taller personal y colección de ajustes y mejoras de la interfaz"
	L["SLASH_ARTI1"] = "/artificer" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI2"] = "/arti" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI3"] = "/artificer" -- localized slash command
	L["SLASH_ARTI4"] = "/arti" -- localized slash command
	L["OpenSettings"] = "Abrir configuración"

	-- Headers
	L["Header_AccountSettings"] = "Configuración de la cuenta"
	L["Header_CVars"] = "Variables de consola (CVars)"

	--Widgets
	L["Widget_FishReelIn"] = "Recoger la línea de pesca"
	L["Widget_FishReelInTT"] = "Reproduce un sonido al terminar tu lanzamiento de pesca."
	L["Widget_ChromieTimeIcon"] = "Icono de Tiempo de Cromi"
	L["Widget_ChromieTimeIconTT"] = "Muestra un icono en el mapa si estás en Tiempo de Cromi (Campañas de Paseo en el Tiempo)."
	L["Widget_ChromieTimeIcon_NoCampaign"] = "No hay ninguna campaña de Paseo en el Tiempo activa."
	L["Widget_HideMacroText"] = "Ocultar texto de macro"
	L["Widget_HideMacroTextTT"] = "Oculta el texto de macros en los botones de acción."
	L["Widget_ArrowKeyEditbox"] = "Permitir flechas en el chat"
	L["Widget_ArrowKeyEditboxTT"] = "Permite mover el cursor con las flechas sin presionar Alt."
	L["Widget_OutfitIcon"] = "Bordes de atuendos de transfiguración"
	L["Widget_OutfitIconTT"] = "Muestra bordes en atuendos de transfiguración en la barra de acción."
	L["Widget_ServerNotifications"] = "Avisos del servidor como advertencia de banda"
	L["Widget_ServerNotificationsTT"] = "Muestra avisos del servidor como Advertencia de banda."
	L["Widget_OutfitSwapSounds"] = "Sonidos al cambiar atuendo"
	L["Widget_OutfitSwapSoundsTT"] = "Selecciona qué sonidos silenciar al cambiar atuendos."
	L["Widget_OSS_Impact"] = "Impacto"
	L["Widget_OSS_STA"] = "Tipo de sonido A"
	L["Widget_OSS_STB"] = "Tipo de sonido B"
	L["Widget_OSS_STC"] = "Tipo de sonido C"
	L["Widget_OSS_STD"] = "Tipo de sonido D"
	L["Widget_HideCraftingResults"] = "Ocultar resultados de fabricación"
	L["Widget_HideCraftingResultsTT"] = "Oculta la ventana de resultados al fabricar."
	L["Widget_MovableCurrencyTransfer"] = "Mover transferencia de moneda"
	L["Widget_MovableCurrencyTransferTT"] = "Permite mover la ventana de transferencia de moneda."
	L["Widget_AddonCompartmentMover"] = "Mover marco de addons"
	L["Widget_AddonCompartmentMoverTT"] = "Mueve el compartimento de addons encima del calendario."
	L["Widget_MinimapIcon"] = "Icono del minimapa"
	L["Widget_MinimapIconTT"] = "Muestra un icono clicable en el minimapa."
	L["Widget_CollapseBuffs"] = "Contraer automáticamente el marco de beneficios"
	L["Widget_CollapseBuffsTT"] = "Contrae automáticamente el marco de beneficios predeterminado."
	L["Widget_PartySync"] = "Aceptar Sincronización de grupo automáticamente"
	L["Widget_PartySyncTT"] = "Acepta automáticamente la sincronización de grupo."
	L["Widget_ChatTooltipVisibility"] = "Vista previa del mensaje"
	L["Widget_ChatTooltipVisibilityTT"] = "Muestra un tooltip en el cuadro de texto para previsualizar el mensaje que estás editando."
	L["CurrentMessage"] = "Mensaje actual"
	L["Mouseover"] = "Al pasar el ratón"
	L["Widget_HideScreenshotText"] = "Ocultar texto de captura"
	L["Widget_HideScreenshotTextTT"] = "Oculta el texto que indica que se ha tomado una captura."
	L["Widget_ScreenshotFormat"] = "Formato de captura"
	L["Widget_ScreenshotFormatTT"] = "Ajusta el formato de captura (PNG puede hacer algunos cielos transparentes)."
	L["Widget_ScreenshotQuality"] = "Calidad de captura"
	L["Widget_ScreenshotQualityTT"] = "Ajusta la calidad de la captura."
	L["Widget_ScreenshotSizeMultiplier"] = "Resolución de captura"
	L["Widget_ScreenshotSizeMultiplierTT"] = "Ajusta la resolución según un multiplicador de la ventana."
	L["Warning_FileSize"] = "Advertencia: puede generar archivos grandes."
	L["Widget_BlockGuildInvites"] = "Bloquear invitaciones de hermandad (cuenta)"
	L["Widget_BlockGuildInvitesTT"] = "Configuración global para rechazar automáticamente invitaciones de hermandad en todos los personajes."

	--Widgets - Account-wide settings
	L["Widget_AutoLoot"] = "Alternar botín automático de la cuenta"
	L["Widget_AutoLootTT"] = "Aplica la configuración de botín automático a toda la cuenta en todos los personajes."
	L["Widget_PetBattleMapFilter"] = "Alternar filtro del mapa de duelos de mascotas de la cuenta"
	L["Widget_PetBattleMapFilterTT"] = "Aplica la configuración del filtro del mapa de duelos de mascotas a toda la cuenta."
	L["Widget_cooldownViewerEnabled"] = "Alternar administrador de reutilización de la cuenta"
	L["Widget_cooldownViewerEnabledTT"] = "Aplica la configuración del administrador de reutilización a toda la cuenta."
	L["Account_On"] = "Activado en toda la cuenta"
	L["Account_Off"] = "Desactivado en toda la cuenta"

	--Widgets - CancelAura
	L["CancelAuraManager"] = "Gestor de cancelación de auras"
	L["CancelAuraManagerTT"] = "Elimina automáticamente beneficios fuera de combate."
	L["InvalidSpell"] = "ID de hechizo no válido"
	L["EnterSpellID"] = "Introduce ID de hechizo"
	L["CanceledAuras"] = "Auras canceladas"
	L["AuraHistory"] = "Historial de auras"
	L["SpellID"] = "ID de hechizo"

	--Widgets - AbandonQuestManager
	L["AbandonQuestManager"] = "Gestor de abandono de misiones"
	L["AbandonQuestManagerTT"] = "Abandona automáticamente misiones no deseadas."
	L["InvalidQuest"] = "ID de misión no válido"
	L["EnterQuestID"] = "Introduce ID de misión"
	L["AbandonedQuests"] = "Misiones abandonadas automáticamente"
	L["QuestHistory"] = "Historial de misiones"
	L["QuestID"] = "ID de misión: %s"

	--Widgets - OutfitBar
	L["OutfitSoundManager"] = "Gestor de sonidos de atuendo"
	L["OutfitSoundManagerTT"] = "Configura sonidos de movimiento del equipo por atuendo."
	L["Leather"] = "Cuero"
	L["Chain"] = "Malla"
	L["Plate"] = "Placas"
	L["GearLight"] = "Equipo ligero"
	L["GearHeavy"] = "Equipo pesado"
	L["BucklesLight"] = "Hebillas ligeras"
	L["BucklesHeavy"] = "Hebillas pesadas"
	L["YakRun"] = "Yak corriendo"
	L["YakWalk"] = "Yak caminando"
	L["GrummleRun"] = "Grummel corriendo"
	L["GrummleWalk"] = "Grummel caminando"
	L["TreasureGoblin"] = "Duende del tesoro"
	L["SoundS"] = "Sonido: %s"
	L["Click"] = "Clic: %s"
	L["LeftClick"] = "Clic izquierdo: %s"
	L["RightClick"] = "Clic derecho: %s"
	L["ClickDrag"] = "Clic-arrastrar: %s"
	L["ConfigureSounds"] = "Configurar sonidos"
	L["PickUpOutfit"] = "Recoger atuendo"
	L["OutfitManager"] = "Administrador de atuendos"
	L["OutfitManagerTT"] = "Elige un atuendo para equipar y configura los sonidos de movimiento del equipo que pueden reproducirse para cada atuendo."
	L["EquipOutfit"] = "Equipar atuendo"
	L["Widget_MinimapRightClick"] = "Clic derecho en el minimapa"
	L["Widget_MinimapRightClickTT"] = "Configurar la función del clic derecho en el minimapa"
	L["LockAppearance"] = "Bloquear apariencia"

	--Widgets - TransmogHistory
	L["UndoTT"] = "Deshacer"
	L["RedoTT"] = "Rehacer"
	L["UndoKeybindTT"] = "(Alt-Z / Mayús-Z)"
	L["RedoKeybindTT"] = "(Alt-Y / Mayús-Y)"
	L["RestoreSessionTT"] = "Restaurar sesión anterior"
	L["SheathWeaponTT"] = TRANSMOG_SHEATHE_WEAPON
	L["InvalidWeapoonSheathTT"] = TRANSMOG_SLOT_WARNING_NOTHING_EQUIPPED

	--Widgets - Loot History Visibility
	L["Widget_LootHistoryVisibility"] = "Visibilidad del historial de botín"
	L["Widget_LootHistoryVisibilityTT"] = "Oculta automáticamente el historial de botín según la opción seleccionada."
	L["Widget_LHV_None"] = NONE
	L["Widget_LHV_Solo"] = SOLO
	L["Widget_LHV_NotFull"] = "Grupo no completo"
	L["Widget_LHV_Always"] = ALWAYS

	--Widgets - Hide Tutorials
	L["Widget_HideTutorials"] = "Ocultar tutoriales"
	L["Widget_HideTutorialsTT"] = "Fuerza la ocultación de los tutoriales en toda la cuenta."

	--Widgets - NameplateTargetIndicator
	L["FNP_TargetIndicator"] = "Indicador de objetivo en placas de nombre amistosas"
	L["FNP_TargetIndicatorTT"] = "Muestra un ícono en la placa de nombre de un jugador amistoso que te está seleccionando."
	L["FNP_HeroTalentRing"] = "Anillo de talento heroico"
	L["FNP_ArtificerEye"] = "Ojo del Artífice"
	L["FNP_LFGEye"] = "Ojo del Buscador de Grupo"
	L["FNP_DragIcon"] = "Arrastrar ícono relativo a la placa de nombre"
	L["FNP_IconStyle"] = "Estilo del ícono"
	L["FNP_IconSize"] = "Tamaño del ícono"
	L["FNP_IconColor"] = "Color del ícono"
	L["LC_OpenColorPicker"] = "Clic izquierdo: Abrir selector de color"
	L["RC_OpenDropdown"] = "Clic derecho: Configuración adicional"
	L["ColorOptions"] = "Opciones de color"
	L["CopyColor"] = "Copiar color"
	L["PasteColor"] = "Pegar color"

	--Widgets - NameplateStatus
	L["FNP_StatusIndicator"] = "Indicador de estado en placas de nombre amistosas"
	L["FNP_StatusIndicatorTT"] = "Muestra un icono en la placa de nombre del estado de un jugador amistoso."
	L["FNP_StatusOptions"] = PLAYER_STATUS
	L["FNP_StatusConnection"] = "Conexión (AFK/DND/DC)"
	L["FNP_StatusChromie"] = "Tiempo de Cromi"
	L["FNP_StatusGroup"] = PARTY_MEMBERS
	L["FNP_StatusGuild"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriend"] = FRIENDS
	L["FNP_StatusIgnored"] = IGNORED
	L["FNP_StatusConnectionDCd"] = "Desconectado"
	L["FNP_StatusConnectionAway"] = CHAT_MSG_AFK
	L["FNP_StatusConnectionDND"] = DND
	L["FNP_StatusGroupMember"] = GROUP
	L["FNP_StatusGroupAssist"] = RAID_ASSISTANT
	L["FNP_StatusGroupLeader"] = LEADER
	L["FNP_StatusGuildMember"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriendChar"] = FRIENDS .. " - " .. CHARACTER
	L["FNP_StatusFriendAcc"] = FRIENDS .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT
	L["FNP_StatusFriendBNet"] = FRIENDS .. " - " .. BATTLETAG
	L["FNP_StatusIgnoredChar"] = IGNORED .. " - " .. CHARACTER
	L["FNP_StatusIgnoredAcc"] = IGNORED .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT

	--Widgets - Account Ignore List
	L["Widget_AccountIgnoreList"] = "Ventana de lista de ignorados de la cuenta"
	L["Widget_AccountIgnoreListTT"] = "Muestra una ventana que contiene todos los ignorados registrados en la cuenta."
	L["AccountIgnoreList"] = "Lista de ignorados de la cuenta"

	--Widgets - PreyBar
	L["Widget_PreyBar"] = "Indicadores de progreso de presa"
	L["Widget_PreyBarTT"] = "Muestra progreso alternativo de presa junto al widget Cacería de Presa."
	L["PreyBar_Style_Row"] = "Fila"
	L["PreyBar_Style_Statusbar"] = "Barra de estado"
	L["PreyBar_Position"] = "Posición"
	L["PreyBar_PositionTT"] = "A qué lado del widget adjuntarlo."
	L["PreyBar_Style"] = UNIT_NAMEPLATES_STYLE
	L["PreyBar_Style_Corner"] = RAID_TARGET_4
	L["PreyBar_Position_Top"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_TOP
	L["PreyBar_Position_Bottom"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_BOTTOM
	L["PreyBar_Position_Left"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_LEFT
	L["PreyBar_Position_Right"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_RIGHT
	L["PreyBar_HideBlizzWidget"] = "Ocultar widget de presa de Blizzard"
	L["PreyBar_HideInCombat"] = "Ocultar en combate"

	L["EncounterBar"] = HUD_EDIT_MODE_ENCOUNTER_BAR_LABEL

	L["Header_Combat"] = COMBAT_LABEL
	L["Widget_SpellAlerts"] = COMBAT_TEXT_SHOW_REACTIVES_TEXT
	L["Widget_SpellAlertsTT"] = "Filtra alertas de hechizos específicas que aparecen en pantalla.\n\nRequiere que las alertas de hechizos estén activadas."

	--Widgets - BlockTrades
	L["Widget_BlockTrades"] = "Bloquear intercambios durante la transfiguración"
	L["Widget_BlockTradesTT"] = "Bloquea todos los intercambios mientras la ventana de transfiguración esté abierta."
	L["Widget_OutfitLinkOnClose"] = "Vincular atuendo al cerrar la transfiguración"
	L["Widget_OutfitLinkOnCloseTT"] = "Vincula automáticamente en el chat el atuendo actualmente visualizado al cerrar la ventana de transfiguración."
	L["Widget_OutfitLinkOnClose_LastViewedOutfit"] = "Último atuendo visto: %s"

	--Widgets - MapAmbience
	L["Widget_MapAmbience_QD"] = "Reducir volumen ambiental en Quel'danas"
	L["Widget_MapAmbience_QDTT"] = "Reduce el volumen ambiental en Quel'danas aproximadamente un 25% de tu volumen ambiental actual."

	--Widgets - DamageMeter
	L["Widget_DamageMeter"] = DAMAGE_METER_LABEL
	L["Widget_DamageMeterTT"] = "Aplica configuraciones a nivel de cuenta para la visibilidad del medidor de daño en cada personaje."
	L["Widget_DamageWipe"] = AUTO_RESET_DAMAGE_METER
	L["Widget_DamageWipeTT"] = "Aplica configuraciones a nivel de cuenta para reiniciar el medidor de daño en cada personaje."

	--Widgets - Account-wide settings
	L["Header_ObjectiveTracker"] = HUD_EDIT_MODE_OBJECTIVE_TRACKER_LABEL
	L["Widget_AutoCollapseTracker"] = "Contraer automáticamente el rastreador de objetivos"
	L["Widget_AutoCollapseTrackerTT"] = "Minimiza automáticamente el rastreador de objetivos bajo ciertas condiciones."
	L["Widget_AutoFadeObjectiveTracker"] = "Desvanecer automáticamente el rastreador de objetivos"
	L["Widget_AutoFadeObjectiveTrackerTT"] = "Desvanece automáticamente el rastreador de objetivos bajo ciertas condiciones."
	L["Widget_ACT_RestedArea"] = "Área de descanso"
	L["Widget_ACT_Combat"] = COMBAT
	L["Widget_ACT_PetBattles"] = SHOW_PET_BATTLES_ON_MAP_TEXT
	L["Widget_ACT_Battlegrounds"] = BATTLEFIELDS
	L["Widget_ACT_Arena"] = ARENA
	L["Widget_ACT_Dungeon"] = LFG_TYPE_DUNGEON
	L["Widget_ACT_MPlus"] = PLAYER_DIFFICULTY_MYTHIC_PLUS
	L["Widget_ACT_Raids"] = RAID
	L["Widget_ACT_ScenariosDelves"] = SCENARIOS_PVEFRAME .. "/" .. DELVES_LABEL
	L["Widget_ACT_Housing"] = BINDING_HEADER_HOUSING_SYSTEM

	--Widgets - Delete Confirm
	L["Widget_DeleteConfirm"] = "Rellenar texto de eliminación de objeto"
	L["Widget_DeleteConfirmTT"] = string.format("Botón para rellenar el texto '%s', con una función posterior para eliminar el objeto en la segunda pulsación.", DELETE_ITEM_CONFIRM_STRING)
	L["Widget_DeleteConfirm_ButtonTT"] = string.format("Clic 1: Rellenar el texto '%s'.\n\nClic 2: Eliminar objeto.", DELETE_ITEM_CONFIRM_STRING)

	--Widgets - ProfessionToasts
	L["Widget_ProfessionToasts"] = "Avisos de profesión"
	L["Widget_ProfessionToastsTT"] = "Muestra una notificación con aparición gradual al subir el nivel de una habilidad de profesión."
	L["FrameWidth"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_WIDTH
	L["FrameHeight"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_HEIGHT
	L["FontSize"] = FONT_SIZE
	L["FontColor"] = "Color de fuente"
	L["BorderColor"] = EMBLEM_BORDER_COLOR
	L["BackgroundColor"] = "Color de fondo"
	L["BorderStyle"] = "Estilo de borde"
	L["BackgroundStyle"] = "Estilo de fondo"
	L["SingleLine"] = "Nivel de profesión en una sola línea"
	L["PlaySound"] = COOLDOWN_VIEWER_SETTINGS_ALERT_MENU_BUTTON_TOOLTIP_PREVIEW
	L["Desaturate"] = "Desaturado"

	L["BorderStyle_housingcontainer"] = "Contenedor de vivienda"
	L["BorderStyle_shopheader"] = "Encabezado de tienda"
	L["BorderStyle_questtracker"] = "Seguimiento de misiones"
	L["BorderStyle_achievementalert"] = "Alerta de logro"
	L["BorderStyle_shipmisson"] = "Misión de nave"
	L["BorderStyle_housingitem"] = "Objeto de vivienda"
	L["BorderStyle_artifactlevel"] = "Nivel de artefacto"
	L["BorderStyle_shoptoast"] = "Notificación de tienda"
	L["BorderStyle_legioninvasion"] = "Título de invasión de la Legión"
	L["BorderStyle_lootroll"] = "Tirada de botín"
	L["BorderStyle_activities"] = "Actividades"
	L["BorderStyle_midnightscenariotitle"] = "Título de escenario Midnight"
	L["BorderStyle_thewarwithinscenariotitle"] = "Título de escenario The War Within"
	L["BorderStyle_dragonflightscenariotitle"] = "Título de escenario Dragonflight"
	L["BorderStyle_dragonflightscenarioframe"] = "Marco de escenario Dragonflight"
	L["BorderStyle_evergreenscenariotitle"] = "Título de escenario Evergreen"

	-- Professions - official translations
	L["ALCHEMY"] = "Alquimia"
	L["ARCHAEOLOGY"] = "Arqueología"
	L["BLACKSMITHING"] = "Herrería"
	L["COOKING"] = "Cocina"
	L["ENCHANTING"] = "Encantamiento"
	L["ENGINEERING"] = "Ingeniería"
	L["FIRST_AID"] = "Primeros auxilios"
	L["FISHING"] = "Pesca"
	L["HERBALISM"] = "Herboristería"
	L["INSCRIPTION"] = "Inscripción"
	L["JEWELCRAFTING"] = "Joyería"
	L["LEATHERWORKING"] = "Peletería"
	L["MINING"] = "Minería"
	L["SKINNING"] = "Desuello"
	L["TAILORING"] = "Sastrería"

	L["SpecializationArt"] = "Arte de especialización"
	L["MobileIcons"] = "Icono móvil"

	L["MetalChainMaw"] = "Cadena metálica - Las Fauces"
	L["Wildhammer"] = "Martillo Salvaje"

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Mostrar todo en el minimapa"
	L["CVar_minimapTrackingShowAllTT"] = "Activa opciones adicionales del minimapa."
	L["CVar_weatherDensity"] = "Densidad del clima"
	L["CVar_weatherDensityTT"] = "Controla la intensidad del clima."
	L["CVar_AutoPushSpellToActionBar"] = "Añadir hechizos automáticamente"
	L["CVar_AutoPushSpellToActionBarTT"] = "Coloca hechizos automáticamente en las barras."
	L["CVar_minimapTrackingClosestOnly"] = "Seguimiento del minimapa: solo el más cercano"
	L["CVar_minimapTrackingClosestOnlyTT"] = "Muestra solo el icono rastreado más cercano para ciertos tipos de iconos del minimapa."
	L["CVar_autoDismount"] = "Desmontar automáticamente (tierra)"
	L["CVar_autoDismountTT"] = "Te desmonta automáticamente de tu montura terrestre al interactuar con ciertos objetos."

	-- Global Strings
	L["UIScale"] = UI_SCALE
	L["LockFrame"] = LOCK_FRAME
	L["ResetPosition"] = RESET_POSITION
	L["Header_Professions"] = TRADE_SKILLS
	L["Header_Map"] = WORLD_MAP
	L["Header_ActionBar"] = BINDING_HEADER_ACTIONBAR
	L["Header_Chat"] = BINDING_HEADER_CHAT
	L["Header_Misc"] = BINDING_HEADER_MISC
	L["Loading"] = LFG_LIST_LOADING
	L["Remove"] = REMOVE
	L["Add"] = ADD
	L["None"] = NONE
	L["All"] = ALL
	L["Outfit"] = TRANSMOG_OUTFIT_NAME_DEFAULT
	L["AdvancedOptions"] = ADVANCED_OPTIONS
	L["Header_Nameplates"] = NAMEPLATES_LABEL
	L["Header_Screenshot"] = BINDING_NAME_SCREENSHOT


return end

if LOCALE == "esES" then
	-- Spanish translations go here

	L["TOC_Title"] = "Artificer"
	L["TOC_Notes"] = "Un taller personal y colección de ajustes de la interfaz"
	L["SLASH_ARTI1"] = "/artificer" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI2"] = "/arti" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI3"] = "/artificer" -- localized slash command
	L["SLASH_ARTI4"] = "/arti" -- localized slash command
	L["OpenSettings"] = "Abrir ajustes"

	-- Headers
	L["Header_AccountSettings"] = "Configuración de la cuenta"
	L["Header_CVars"] = "Variables de consola (CVars)"

	--Widgets
	L["Widget_FishReelIn"] = "Recoger la línea de pesca"
	L["Widget_FishReelInTT"] = "Reproduce un sonido al terminar tu lanzamiento de pesca."
	L["Widget_ChromieTimeIcon"] = "Icono de Tiempo de Cromi"
	L["Widget_ChromieTimeIconTT"] = "Muestra un icono en el mapa si estás en Tiempo de Cromi (Campañas de Paseo en el Tiempo)."
	L["Widget_ChromieTimeIcon_NoCampaign"] = "No hay ninguna campaña de Paseo en el Tiempo activa."
	L["Widget_HideMacroText"] = "Ocultar texto de macro"
	L["Widget_HideMacroTextTT"] = "Oculta el texto de macros en los botones de acción."
	L["Widget_ArrowKeyEditbox"] = "Permitir flechas en el chat"
	L["Widget_ArrowKeyEditboxTT"] = "Permite mover el cursor con las flechas sin presionar Alt."
	L["Widget_OutfitIcon"] = "Bordes de atuendos de transfiguración"
	L["Widget_OutfitIconTT"] = "Muestra bordes en atuendos de transfiguración en la barra de acción."
	L["Widget_ServerNotifications"] = "Avisos del servidor como aviso de banda"
	L["Widget_ServerNotificationsTT"] = "Muestra avisos del servidor como Advertencia de banda."
	L["Widget_OutfitSwapSounds"] = "Sonidos al cambiar atuendo"
	L["Widget_OutfitSwapSoundsTT"] = "Selecciona qué sonidos silenciar al cambiar atuendos."
	L["Widget_OSS_Impact"] = "Impacto"
	L["Widget_OSS_STA"] = "Tipo de sonido A"
	L["Widget_OSS_STB"] = "Tipo de sonido B"
	L["Widget_OSS_STC"] = "Tipo de sonido C"
	L["Widget_OSS_STD"] = "Tipo de sonido D"
	L["Widget_HideCraftingResults"] = "Ocultar resultados de fabricación"
	L["Widget_HideCraftingResultsTT"] = "Oculta la ventana de resultados al fabricar."
	L["Widget_MovableCurrencyTransfer"] = "Mover transferencia de moneda"
	L["Widget_MovableCurrencyTransferTT"] = "Permite mover la ventana de transferencia de moneda."
	L["Widget_AddonCompartmentMover"] = "Mover marco de addons"
	L["Widget_AddonCompartmentMoverTT"] = "Mueve el compartimento de addons encima del calendario."
	L["Widget_MinimapIcon"] = "Icono del minimapa"
	L["Widget_MinimapIconTT"] = "Muestra un icono clicable en el minimapa."
	L["Widget_CollapseBuffs"] = "Contraer automáticamente el marco de beneficios"
	L["Widget_CollapseBuffsTT"] = "Contrae automáticamente el marco de beneficios predeterminado."
	L["Widget_PartySync"] = "Aceptar Sincronización de grupo automáticamente"
	L["Widget_PartySyncTT"] = "Acepta automáticamente la sincronización de grupo."
	L["Widget_ChatTooltipVisibility"] = "Vista previa del mensaje"
	L["Widget_ChatTooltipVisibilityTT"] = "Muestra un tooltip en el cuadro de texto para previsualizar el mensaje que estás editando."
	L["CurrentMessage"] = "Mensaje actual"
	L["Mouseover"] = "Al pasar el ratón"
	L["Widget_HideScreenshotText"] = "Ocultar texto de captura"
	L["Widget_HideScreenshotTextTT"] = "Oculta el texto que indica que se ha tomado una captura."
	L["Widget_ScreenshotFormat"] = "Formato de captura"
	L["Widget_ScreenshotFormatTT"] = "Ajusta el formato de captura (PNG puede hacer algunos cielos transparentes)."
	L["Widget_ScreenshotQuality"] = "Calidad de captura"
	L["Widget_ScreenshotQualityTT"] = "Ajusta la calidad de la captura."
	L["Widget_ScreenshotSizeMultiplier"] = "Resolución de captura"
	L["Widget_ScreenshotSizeMultiplierTT"] = "Ajusta la resolución según un multiplicador de la ventana."
	L["Warning_FileSize"] = "Advertencia: puede generar archivos grandes."
	L["Widget_BlockGuildInvites"] = "Bloquear invitaciones de hermandad (cuenta)"
	L["Widget_BlockGuildInvitesTT"] = "Configuración global para rechazar automáticamente invitaciones de hermandad en todos los personajes."

	--Widgets - Account-wide settings
	L["Widget_AutoLoot"] = "Alternar saqueo automático de la cuenta"
	L["Widget_AutoLootTT"] = "Aplica la configuración de saqueo automático a toda la cuenta en todos los personajes."
	L["Widget_PetBattleMapFilter"] = "Alternar filtro del mapa de duelos de mascotas de la cuenta"
	L["Widget_PetBattleMapFilterTT"] = "Aplica la configuración del filtro del mapa de duelos de mascotas a toda la cuenta."
	L["Widget_cooldownViewerEnabled"] = "Alternar gestor de reutilización de la cuenta"
	L["Widget_cooldownViewerEnabledTT"] = "Aplica la configuración del gestor de reutilización a toda la cuenta."
	L["Account_On"] = "Activado en toda la cuenta"
	L["Account_Off"] = "Desactivado en toda la cuenta"

	--Widgets - CancelAura
	L["CancelAuraManager"] = "Gestor de cancelación de auras"
	L["CancelAuraManagerTT"] = "Elimina automáticamente beneficios fuera de combate."
	L["InvalidSpell"] = "ID de hechizo no válido"
	L["EnterSpellID"] = "Introduce ID de hechizo"
	L["CanceledAuras"] = "Auras canceladas"
	L["AuraHistory"] = "Historial de auras"
	L["SpellID"] = "ID de hechizo"

	--Widgets - AbandonQuestManager
	L["AbandonQuestManager"] = "Gestor de abandono de misiones"
	L["AbandonQuestManagerTT"] = "Abandona automáticamente misiones no deseadas."
	L["InvalidQuest"] = "ID de misión no válido"
	L["EnterQuestID"] = "Introduce ID de misión"
	L["AbandonedQuests"] = "Misiones abandonadas automáticamente"
	L["QuestHistory"] = "Historial de misiones"
	L["QuestID"] = "ID de misión: %s"

	--Widgets - OutfitBar
	L["OutfitSoundManager"] = "Gestor de sonidos de atuendo"
	L["OutfitSoundManagerTT"] = "Configura sonidos de movimiento del equipo por atuendo."
	L["Leather"] = "Cuero"
	L["Chain"] = "Malla"
	L["Plate"] = "Placas"
	L["GearLight"] = "Equipo ligero"
	L["GearHeavy"] = "Equipo pesado"
	L["BucklesLight"] = "Hebillas ligeras"
	L["BucklesHeavy"] = "Hebillas pesadas"
	L["YakRun"] = "Yak corriendo"
	L["YakWalk"] = "Yak caminando"
	L["GrummleRun"] = "Grummel corriendo"
	L["GrummleWalk"] = "Grummel caminando"
	L["TreasureGoblin"] = "Duende del tesoro"
	L["SoundS"] = "Sonido: %s"
	L["Click"] = "Clic: %s"
	L["LeftClick"] = "Clic izquierdo: %s"
	L["RightClick"] = "Clic derecho: %s"
	L["ClickDrag"] = "Clic-arrastrar: %s"
	L["ConfigureSounds"] = "Configurar sonidos"
	L["PickUpOutfit"] = "Recoger atuendo"
	L["OutfitManager"] = "Gestor de atuendos"
	L["OutfitManagerTT"] = "Elige un atuendo para equipar y configura los sonidos de movimiento del equipo que pueden reproducirse para cada atuendo."
	L["EquipOutfit"] = "Equipar atuendo"
	L["Widget_MinimapRightClick"] = "Clic derecho en el minimapa"
	L["Widget_MinimapRightClickTT"] = "Configurar la función del clic derecho en el minimapa"
	L["LockAppearance"] = "Mantener apariencia"

	--Widgets - TransmogHistory
	L["UndoTT"] = "Deshacer"
	L["RedoTT"] = "Rehacer"
	L["UndoKeybindTT"] = "(Alt-Z / Mayús-Z)"
	L["RedoKeybindTT"] = "(Alt-Y / Mayús-Y)"
	L["RestoreSessionTT"] = "Restaurar sesión anterior"
	L["SheathWeaponTT"] = TRANSMOG_SHEATHE_WEAPON
	L["InvalidWeapoonSheathTT"] = TRANSMOG_SLOT_WARNING_NOTHING_EQUIPPED

	--Widgets - Loot History Visibility
	L["Widget_LootHistoryVisibility"] = "Visibilidad del historial de botín"
	L["Widget_LootHistoryVisibilityTT"] = "Oculta automáticamente el historial de botín según la opción seleccionada."
	L["Widget_LHV_None"] = NONE
	L["Widget_LHV_Solo"] = SOLO
	L["Widget_LHV_NotFull"] = "Grupo no completo"
	L["Widget_LHV_Always"] = ALWAYS

	--Widgets - Hide Tutorials
	L["Widget_HideTutorials"] = "Ocultar tutoriales"
	L["Widget_HideTutorialsTT"] = "Fuerza la ocultación de los tutoriales en toda la cuenta."

	--Widgets - NameplateTargetIndicator
	L["FNP_TargetIndicator"] = "Indicador de objetivo en placas de nombre amistosas"
	L["FNP_TargetIndicatorTT"] = "Muestra un icono en la placa de nombre de un jugador amistoso que te está seleccionando."
	L["FNP_HeroTalentRing"] = "Anillo de talento heroico"
	L["FNP_ArtificerEye"] = "Ojo del Artífice"
	L["FNP_LFGEye"] = "Ojo del Buscador de Grupo"
	L["FNP_DragIcon"] = "Arrastrar icono relativo a la placa de nombre"
	L["FNP_IconStyle"] = "Estilo del icono"
	L["FNP_IconSize"] = "Tamaño del icono"
	L["FNP_IconColor"] = "Color del icono"
	L["LC_OpenColorPicker"] = "Clic izquierdo: Abrir selector de color"
	L["RC_OpenDropdown"] = "Clic derecho: Configuración adicional"
	L["ColorOptions"] = "Opciones de color"
	L["CopyColor"] = "Copiar color"
	L["PasteColor"] = "Pegar color"

	--Widgets - NameplateStatus
	L["FNP_StatusIndicator"] = "Indicador de estado en placas de nombre amistosas"
	L["FNP_StatusIndicatorTT"] = "Muestra un icono en la placa de nombre del estado de un jugador amistoso."
	L["FNP_StatusOptions"] = PLAYER_STATUS
	L["FNP_StatusConnection"] = "Conexión (AFK/DND/DC)"
	L["FNP_StatusChromie"] = "Tiempo de Cromi"
	L["FNP_StatusGroup"] = PARTY_MEMBERS
	L["FNP_StatusGuild"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriend"] = FRIENDS
	L["FNP_StatusIgnored"] = IGNORED
	L["FNP_StatusConnectionDCd"] = "Desconectado"
	L["FNP_StatusConnectionAway"] = CHAT_MSG_AFK
	L["FNP_StatusConnectionDND"] = DND
	L["FNP_StatusGroupMember"] = GROUP
	L["FNP_StatusGroupAssist"] = RAID_ASSISTANT
	L["FNP_StatusGroupLeader"] = LEADER
	L["FNP_StatusGuildMember"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriendChar"] = FRIENDS .. " - " .. CHARACTER
	L["FNP_StatusFriendAcc"] = FRIENDS .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT
	L["FNP_StatusFriendBNet"] = FRIENDS .. " - " .. BATTLETAG
	L["FNP_StatusIgnoredChar"] = IGNORED .. " - " .. CHARACTER
	L["FNP_StatusIgnoredAcc"] = IGNORED .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT

	--Widgets - Account Ignore List
	L["Widget_AccountIgnoreList"] = "Ventana de lista de ignorados de la cuenta"
	L["Widget_AccountIgnoreListTT"] = "Muestra una ventana que contiene todos los ignorados registrados en la cuenta."
	L["AccountIgnoreList"] = "Lista de ignorados de la cuenta"

	--Widgets - PreyBar
	L["Widget_PreyBar"] = "Indicadores de progreso de presa"
	L["Widget_PreyBarTT"] = "Muestra un progreso alternativo de presa junto al widget Caza de Presa."
	L["PreyBar_Style_Row"] = "Fila"
	L["PreyBar_Style_Statusbar"] = "Barra de estado"
	L["PreyBar_Position"] = "Posición"
	L["PreyBar_PositionTT"] = "A qué lado del widget adjuntarlo."
	L["PreyBar_Style"] = UNIT_NAMEPLATES_STYLE
	L["PreyBar_Style_Corner"] = RAID_TARGET_4
	L["PreyBar_Position_Top"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_TOP
	L["PreyBar_Position_Bottom"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_BOTTOM
	L["PreyBar_Position_Left"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_LEFT
	L["PreyBar_Position_Right"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_RIGHT
	L["PreyBar_HideBlizzWidget"] = "Ocultar widget de presa de Blizzard"
	L["PreyBar_HideInCombat"] = "Ocultar en combate"

	L["EncounterBar"] = HUD_EDIT_MODE_ENCOUNTER_BAR_LABEL

	L["Header_Combat"] = COMBAT_LABEL
	L["Widget_SpellAlerts"] = COMBAT_TEXT_SHOW_REACTIVES_TEXT
	L["Widget_SpellAlertsTT"] = "Filtra alertas de hechizos específicas que aparecen en pantalla.\n\nRequiere que las alertas de hechizos estén activadas."

	--Widgets - BlockTrades
	L["Widget_BlockTrades"] = "Bloquear intercambios durante la transfiguración"
	L["Widget_BlockTradesTT"] = "Bloquea todos los intercambios mientras la ventana de transfiguración esté abierta."
	L["Widget_OutfitLinkOnClose"] = "Vincular atuendo al cerrar la transfiguración"
	L["Widget_OutfitLinkOnCloseTT"] = "Vincula automáticamente en el chat el atuendo actualmente visualizado al cerrar la ventana de transfiguración."
	L["Widget_OutfitLinkOnClose_LastViewedOutfit"] = "Último atuendo visto: %s"

	--Widgets - MapAmbience
	L["Widget_MapAmbience_QD"] = "Reducir volumen ambiental en Quel'danas"
	L["Widget_MapAmbience_QDTT"] = "Reduce el volumen ambiental en Quel'danas aproximadamente un 25% de tu volumen ambiental actual."

	--Widgets - DamageMeter
	L["Widget_DamageMeter"] = DAMAGE_METER_LABEL
	L["Widget_DamageMeterTT"] = "Aplica configuraciones a nivel de cuenta para la visibilidad del medidor de daño en cada personaje."
	L["Widget_DamageWipe"] = AUTO_RESET_DAMAGE_METER
	L["Widget_DamageWipeTT"] = "Aplica configuraciones a nivel de cuenta para reiniciar el medidor de daño en cada personaje."

	--Widgets - Account-wide settings
	L["Header_ObjectiveTracker"] = HUD_EDIT_MODE_OBJECTIVE_TRACKER_LABEL
	L["Widget_AutoCollapseTracker"] = "Contraer automáticamente el rastreador de objetivos"
	L["Widget_AutoCollapseTrackerTT"] = "Minimiza automáticamente el rastreador de objetivos bajo ciertas condiciones."
	L["Widget_AutoFadeObjectiveTracker"] = "Desvanecer automáticamente el rastreador de objetivos"
	L["Widget_AutoFadeObjectiveTrackerTT"] = "Desvanece automáticamente el rastreador de objetivos bajo ciertas condiciones."
	L["Widget_ACT_RestedArea"] = "Área de descanso"
	L["Widget_ACT_Combat"] = COMBAT
	L["Widget_ACT_PetBattles"] = SHOW_PET_BATTLES_ON_MAP_TEXT
	L["Widget_ACT_Battlegrounds"] = BATTLEFIELDS
	L["Widget_ACT_Arena"] = ARENA
	L["Widget_ACT_Dungeon"] = LFG_TYPE_DUNGEON
	L["Widget_ACT_MPlus"] = PLAYER_DIFFICULTY_MYTHIC_PLUS
	L["Widget_ACT_Raids"] = RAID
	L["Widget_ACT_ScenariosDelves"] = SCENARIOS_PVEFRAME .. "/" .. DELVES_LABEL
	L["Widget_ACT_Housing"] = BINDING_HEADER_HOUSING_SYSTEM

	--Widgets - Delete Confirm
	L["Widget_DeleteConfirm"] = "Rellenar texto de eliminación de objeto"
	L["Widget_DeleteConfirmTT"] = string.format("Botón para rellenar el texto '%s', con una función posterior para eliminar el objeto en la segunda pulsación.", DELETE_ITEM_CONFIRM_STRING)
	L["Widget_DeleteConfirm_ButtonTT"] = string.format("Clic 1: Rellenar el texto '%s'.\n\nClic 2: Eliminar objeto.", DELETE_ITEM_CONFIRM_STRING)

	--Widgets - ProfessionToasts
	L["Widget_ProfessionToasts"] = "Avisos de profesión"
	L["Widget_ProfessionToastsTT"] = "Muestra una notificación con aparición gradual al subir el nivel de una habilidad de profesión."
	L["FrameWidth"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_WIDTH
	L["FrameHeight"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_HEIGHT
	L["FontSize"] = FONT_SIZE
	L["FontColor"] = "Color de fuente"
	L["BorderColor"] = EMBLEM_BORDER_COLOR
	L["BackgroundColor"] = "Color de fondo"
	L["BorderStyle"] = "Estilo de borde"
	L["BackgroundStyle"] = "Estilo de fondo"
	L["SingleLine"] = "Nivel de profesión en una sola línea"
	L["PlaySound"] = COOLDOWN_VIEWER_SETTINGS_ALERT_MENU_BUTTON_TOOLTIP_PREVIEW
	L["Desaturate"] = "Desaturado"

	L["BorderStyle_housingcontainer"] = "Contenedor de vivienda"
	L["BorderStyle_shopheader"] = "Encabezado de tienda"
	L["BorderStyle_questtracker"] = "Seguimiento de misiones"
	L["BorderStyle_achievementalert"] = "Alerta de logro"
	L["BorderStyle_shipmisson"] = "Misión de nave"
	L["BorderStyle_housingitem"] = "Objeto de vivienda"
	L["BorderStyle_artifactlevel"] = "Nivel de artefacto"
	L["BorderStyle_shoptoast"] = "Notificación de tienda"
	L["BorderStyle_legioninvasion"] = "Título de invasión de la Legión"
	L["BorderStyle_lootroll"] = "Tirada de botín"
	L["BorderStyle_activities"] = "Actividades"
	L["BorderStyle_midnightscenariotitle"] = "Título de escenario Midnight"
	L["BorderStyle_thewarwithinscenariotitle"] = "Título de escenario The War Within"
	L["BorderStyle_dragonflightscenariotitle"] = "Título de escenario Dragonflight"
	L["BorderStyle_dragonflightscenarioframe"] = "Marco de escenario Dragonflight"
	L["BorderStyle_evergreenscenariotitle"] = "Título de escenario Evergreen"

	-- Professions - official translations
	L["ALCHEMY"] = "Alquimia"
	L["ARCHAEOLOGY"] = "Arqueología"
	L["BLACKSMITHING"] = "Herrería"
	L["COOKING"] = "Cocina"
	L["ENCHANTING"] = "Encantamiento"
	L["ENGINEERING"] = "Ingeniería"
	L["FIRST_AID"] = "Primeros auxilios"
	L["FISHING"] = "Pesca"
	L["HERBALISM"] = "Herboristería"
	L["INSCRIPTION"] = "Inscripción"
	L["JEWELCRAFTING"] = "Joyería"
	L["LEATHERWORKING"] = "Peletería"
	L["MINING"] = "Minería"
	L["SKINNING"] = "Desuello"
	L["TAILORING"] = "Sastrería"

	L["SpecializationArt"] = "Arte de especialización"
	L["MobileIcons"] = "Icono móvil"

	L["MetalChainMaw"] = "Cadena metálica - Las Fauces"
	L["Wildhammer"] = "Martillo Salvaje"

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Mostrar todo en el minimapa"
	L["CVar_minimapTrackingShowAllTT"] = "Activa opciones adicionales del minimapa."
	L["CVar_weatherDensity"] = "Densidad del clima"
	L["CVar_weatherDensityTT"] = "Controla la intensidad del clima."
	L["CVar_AutoPushSpellToActionBar"] = "Añadir hechizos automáticamente"
	L["CVar_AutoPushSpellToActionBarTT"] = "Coloca hechizos automáticamente en las barras."
	L["CVar_minimapTrackingClosestOnly"] = "Seguimiento del minimapa: solo el más cercano"
	L["CVar_minimapTrackingClosestOnlyTT"] = "Muestra solo el icono rastreado más cercano para ciertos tipos de iconos del minimapa."
	L["CVar_autoDismount"] = "Desmontar automáticamente (tierra)"
	L["CVar_autoDismountTT"] = "Te desmonta automáticamente de tu montura terrestre al interactuar con ciertos objetos."

	-- Global Strings
	L["UIScale"] = UI_SCALE
	L["LockFrame"] = LOCK_FRAME
	L["ResetPosition"] = RESET_POSITION
	L["Header_Professions"] = TRADE_SKILLS
	L["Header_Map"] = WORLD_MAP
	L["Header_ActionBar"] = BINDING_HEADER_ACTIONBAR
	L["Header_Chat"] = BINDING_HEADER_CHAT
	L["Header_Misc"] = BINDING_HEADER_MISC
	L["Loading"] = LFG_LIST_LOADING
	L["Remove"] = REMOVE
	L["Add"] = ADD
	L["None"] = NONE
	L["All"] = ALL
	L["Outfit"] = TRANSMOG_OUTFIT_NAME_DEFAULT
	L["AdvancedOptions"] = ADVANCED_OPTIONS
	L["Header_Nameplates"] = NAMEPLATES_LABEL
	L["Header_Screenshot"] = BINDING_NAME_SCREENSHOT

return end

if LOCALE == "deDE" then
	-- German translations go here
	L["TOC_Title"] = "Artificer"
	L["TOC_Notes"] = "Eine persönliche Werkstatt und Sammlung von UI-Anpassungen"
	L["SLASH_ARTI1"] = "/artificer" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI2"] = "/arti" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI3"] = "/artificer" -- localized slash command
	L["SLASH_ARTI4"] = "/arti" -- localized slash command
	L["OpenSettings"] = "Einstellungen öffnen"

	-- Headers
	L["Header_AccountSettings"] = "Kontoeinstellungen"
	L["Header_CVars"] = "Konsolenvariablen (CVars)"

	--Widgets
	L["Widget_FishReelIn"] = "Angel einholen"
	L["Widget_FishReelInTT"] = "Spielt ein Geräusch ab, wenn dein Angelauswurf endet."
	L["Widget_ChromieTimeIcon"] = "Chromie-Zeit-Symbol"
	L["Widget_ChromieTimeIconTT"] = "Zeigt ein Symbol auf der Karte an, wenn du dich in der Chromie-Zeit (Zeitwanderungs-Kampagnen) befindest."
	L["Widget_ChromieTimeIcon_NoCampaign"] = "Derzeit ist keine Zeitwanderungs-Kampagne aktiv."
	L["Widget_HideMacroText"] = "Makrotext auf Aktionsleisten ausblenden"
	L["Widget_HideMacroTextTT"] = "Blendet den Makrotext auf Aktionsleisten-Buttons aus."
	L["Widget_ArrowKeyEditbox"] = "Pfeiltasten im Chat erlauben"
	L["Widget_ArrowKeyEditboxTT"] = "Erlaubt das Bewegen des Cursors im Chat mit den Pfeiltasten ohne Alt."
	L["Widget_OutfitIcon"] = "Transmog-Outfit-Rahmen"
	L["Widget_OutfitIconTT"] = "Zeigt Rahmen für Transmog-Outfits auf Aktionsleisten-Buttons."
	L["Widget_ServerNotifications"] = "Servermeldungen als Schlachtzugswarnung"
	L["Widget_ServerNotificationsTT"] = "Zeigt Servermeldungen (z. B. Neustarts) als Schlachtzugswarnung an."
	L["Widget_OutfitSwapSounds"] = "Outfitwechsel-Sounds"
	L["Widget_OutfitSwapSoundsTT"] = "Wähle, welche Sounds beim Outfitwechsel stummgeschaltet werden."
	L["Widget_OSS_Impact"] = "Aufprall"
	L["Widget_OSS_STA"] = "Soundtyp A"
	L["Widget_OSS_STB"] = "Soundtyp B"
	L["Widget_OSS_STC"] = "Soundtyp C"
	L["Widget_OSS_STD"] = "Soundtyp D"
	L["Widget_HideCraftingResults"] = "Herstellungsergebnisse ausblenden"
	L["Widget_HideCraftingResultsTT"] = "Blendet das Fenster mit Herstellungsergebnissen beim Herstellen aus."
	L["Widget_MovableCurrencyTransfer"] = "Währungstransfer beweglich machen"
	L["Widget_MovableCurrencyTransferTT"] = "Erlaubt das Verschieben des Währungstransfer-Fensters."
	L["Widget_AddonCompartmentMover"] = "Addon-Fach verschieben"
	L["Widget_AddonCompartmentMoverTT"] = "Verschiebt das Addon-Fach über den Kalender-Button statt darunter."
	L["Widget_MinimapIcon"] = "Minikarten-Symbol"
	L["Widget_MinimapIconTT"] = "Zeigt ein klickbares Symbol auf der Minikarte zum Öffnen der Einstellungen."
	L["Widget_CollapseBuffs"] = "Buff-Leiste automatisch einklappen"
	L["Widget_CollapseBuffsTT"] = "Klappt die Standard-Buff-Leiste automatisch ein."
	L["Widget_PartySync"] = "Gruppensynchronisierung automatisch akzeptieren"
	L["Widget_PartySyncTT"] = "Akzeptiert automatisch die Bestätigung der Gruppensynchronisierung."
	L["Widget_ChatTooltipVisibility"] = "Chatnachrichten-Vorschau"
	L["Widget_ChatTooltipVisibilityTT"] = "Zeigt einen Tooltip im Eingabefeld an, um die aktuell bearbeitete Chatnachricht vorzusehen."
	L["CurrentMessage"] = "Aktuelle Nachricht"
	L["Mouseover"] = "Mouseover"
	L["Widget_HideScreenshotText"] = "Screenshot-Text ausblenden"
	L["Widget_HideScreenshotTextTT"] = "Blendet den Text „Screenshot aufgenommen“ aus."
	L["Widget_ScreenshotFormat"] = "Screenshot-Format"
	L["Widget_ScreenshotFormatTT"] = "Passt das Screenshot-Format an (PNG kann bestimmte Himmel transparent darstellen)."
	L["Widget_ScreenshotQuality"] = "Screenshot-Qualität"
	L["Widget_ScreenshotQualityTT"] = "Passt die Screenshot-Qualität an."
	L["Widget_ScreenshotSizeMultiplier"] = "Screenshot-Auflösung"
	L["Widget_ScreenshotSizeMultiplierTT"] = "Passt die Screenshot-Auflösung basierend auf einem Multiplikator des Fensters an."
	L["Warning_FileSize"] = "Achtung: Dies kann zu einer großen Dateigröße führen."
	L["Widget_BlockGuildInvites"] = "Gildeneinladungen blockieren (Accountweit)"
	L["Widget_BlockGuildInvitesTT"] = "Accountweite Einstellung zum automatischen Ablehnen von Gildeneinladungen für alle Charaktere."

	--Widgets - Account-wide settings
	L["Widget_AutoLoot"] = "Account-Autoplünderung umschalten"
	L["Widget_AutoLootTT"] = "Erzwingt kontoweite Einstellungen für Autoplünderung auf allen Charakteren."
	L["Widget_PetBattleMapFilter"] = "Account-Haustierkampf-Kartenfilter umschalten"
	L["Widget_PetBattleMapFilterTT"] = "Erzwingt kontoweite Einstellungen für den Haustierkampf-Kartenfilter auf allen Charakteren."
	L["Widget_cooldownViewerEnabled"] = "Account-Abklingzeit-Manager umschalten"
	L["Widget_cooldownViewerEnabledTT"] = "Erzwingt kontoweite Einstellungen für den Abklingzeit-Manager auf allen Charakteren."
	L["Account_On"] = "Accountweit aktiviert"
	L["Account_Off"] = "Accountweit deaktiviert"

	--Widgets - CancelAura
	L["CancelAuraManager"] = "Aura-Abbruch-Manager"
	L["CancelAuraManagerTT"] = "Entfernt automatisch bestimmte Stärkungszauber außerhalb des Kampfes."
	L["InvalidSpell"] = "Ungültige Zauber-ID"
	L["EnterSpellID"] = "Zauber-ID eingeben"
	L["CanceledAuras"] = "Abgebrochene Auren"
	L["AuraHistory"] = "Aura-Verlauf"
	L["SpellID"] = "Zauber-ID"

	--Widgets - AbandonQuestManager
	L["AbandonQuestManager"] = "Questabbruch-Manager"
	L["AbandonQuestManagerTT"] = "Lehnt automatisch bestimmte unerwünschte Quests ab."
	L["InvalidQuest"] = "Ungültige Quest-ID"
	L["EnterQuestID"] = "Quest-ID eingeben"
	L["AbandonedQuests"] = "Automatisch abgebrochene Quests"
	L["QuestHistory"] = "Questverlauf"
	L["QuestID"] = "Quest-ID: %s"

	--Widgets - OutfitBar
	L["OutfitSoundManager"] = "Outfit-Sound-Manager"
	L["OutfitSoundManagerTT"] = "Konfiguriert Geräusche von Ausrüstungsbewegungen pro Outfit."
	L["Leather"] = "Leder"
	L["Chain"] = "Kette"
	L["Plate"] = "Platte"
	L["GearLight"] = "Leichte Ausrüstung"
	L["GearHeavy"] = "Schwere Ausrüstung"
	L["BucklesLight"] = "Leichte Schnallen"
	L["BucklesHeavy"] = "Schwere Schnallen"
	L["YakRun"] = "Yak laufen"
	L["YakWalk"] = "Yak gehen"
	L["GrummleRun"] = "Grummel laufen"
	L["GrummleWalk"] = "Grummel gehen"
	L["TreasureGoblin"] = "Schatzgoblin"
	L["SoundS"] = "Sound: %s"
	L["Click"] = "Klick: %s"
	L["LeftClick"] = "Linksklick: %s"
	L["RightClick"] = "Rechtsklick: %s"
	L["ClickDrag"] = "Klicken & Ziehen: %s"
	L["ConfigureSounds"] = "Sounds konfigurieren"
	L["PickUpOutfit"] = "Outfit aufnehmen"
	L["OutfitManager"] = "Outfit-Manager"
	L["OutfitManagerTT"] = "Wähle ein Outfit zum Anlegen und konfiguriere Ausrüstungsbewegungsgeräusche, die für jedes Outfit abgespielt werden können."
	L["EquipOutfit"] = "Outfit anlegen"
	L["Widget_MinimapRightClick"] = "Minikarten-Rechtsklick"
	L["Widget_MinimapRightClickTT"] = "Lege die Funktion des Rechtsklicks auf die Minikarte fest"
	L["LockAppearance"] = "Aussehen fixieren"

	--Widgets - TransmogHistory
	L["UndoTT"] = "Rückgängig"
	L["RedoTT"] = "Wiederholen"
	L["UndoKeybindTT"] = "(Alt-Z / Umschalt-Z)"
	L["RedoKeybindTT"] = "(Alt-Y / Umschalt-Y)"
	L["RestoreSessionTT"] = "Vorherige Sitzung wiederherstellen"
	L["SheathWeaponTT"] = TRANSMOG_SHEATHE_WEAPON
	L["InvalidWeapoonSheathTT"] = TRANSMOG_SLOT_WARNING_NOTHING_EQUIPPED

	--Widgets - Loot History Visibility
	L["Widget_LootHistoryVisibility"] = "Sichtbarkeit des Beuteverlaufs"
	L["Widget_LootHistoryVisibilityTT"] = "Blendet den Beuteverlauf automatisch basierend auf der ausgewählten Option aus."
	L["Widget_LHV_None"] = NONE
	L["Widget_LHV_Solo"] = SOLO
	L["Widget_LHV_NotFull"] = "Keine volle Gruppe"
	L["Widget_LHV_Always"] = ALWAYS

	--Widgets - Hide Tutorials
	L["Widget_HideTutorials"] = "Tutorials ausblenden"
	L["Widget_HideTutorialsTT"] = "Blendet Tutorials für den gesamten Account dauerhaft aus."

	--Widgets - NameplateTargetIndicator
	L["FNP_TargetIndicator"] = "Freundlicher Namensplaketten-Zielindikator"
	L["FNP_TargetIndicatorTT"] = "Zeigt ein Symbol auf der Namensplakette eines freundlichen Spielers an, der dich anvisiert."
	L["FNP_HeroTalentRing"] = "Helden-Talent-Ring"
	L["FNP_ArtificerEye"] = "Artificer-Auge"
	L["FNP_LFGEye"] = "LFG-Auge"
	L["FNP_DragIcon"] = "Symbol relativ zur Namensplakette verschieben"
	L["FNP_IconStyle"] = "Symbolstil"
	L["FNP_IconSize"] = "Symbolgröße"
	L["FNP_IconColor"] = "Symbolfarbe"
	L["LC_OpenColorPicker"] = "Links-Klick: Farbwähler öffnen"
	L["RC_OpenDropdown"] = "Rechts-Klick: Zusätzliche Einstellungen"
	L["ColorOptions"] = "Farboptionen"
	L["CopyColor"] = "Farbe kopieren"
	L["PasteColor"] = "Farbe einfügen"

	--Widgets - NameplateStatus
	L["FNP_StatusIndicator"] = "Freundliche Namensplaketten-Statusanzeige"
	L["FNP_StatusIndicatorTT"] = "Zeigt ein Symbol auf der Namensplakette eines freundlichen Spielerstatus an."
	L["FNP_StatusOptions"] = PLAYER_STATUS
	L["FNP_StatusConnection"] = "Verbindung (AFK/DND/DC)"
	L["FNP_StatusChromie"] = "Chromie-Zeit"
	L["FNP_StatusGroup"] = PARTY_MEMBERS
	L["FNP_StatusGuild"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriend"] = FRIENDS
	L["FNP_StatusIgnored"] = IGNORED
	L["FNP_StatusConnectionDCd"] = "Getrennt"
	L["FNP_StatusConnectionAway"] = CHAT_MSG_AFK
	L["FNP_StatusConnectionDND"] = DND
	L["FNP_StatusGroupMember"] = GROUP
	L["FNP_StatusGroupAssist"] = RAID_ASSISTANT
	L["FNP_StatusGroupLeader"] = LEADER
	L["FNP_StatusGuildMember"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriendChar"] = FRIENDS .. " - " .. CHARACTER
	L["FNP_StatusFriendAcc"] = FRIENDS .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT
	L["FNP_StatusFriendBNet"] = FRIENDS .. " - " .. BATTLETAG
	L["FNP_StatusIgnoredChar"] = IGNORED .. " - " .. CHARACTER
	L["FNP_StatusIgnoredAcc"] = IGNORED .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT

	--Widgets - Account Ignore List
	L["Widget_AccountIgnoreList"] = "Fenster für kontoweite Ignorierliste"
	L["Widget_AccountIgnoreListTT"] = "Zeigt ein Fenster mit allen auf dem Konto gespeicherten Ignorierten an."
	L["AccountIgnoreList"] = "Kontoweite Ignorierliste"

	--Widgets - PreyBar
	L["Widget_PreyBar"] = "Beute-Fortschrittsanzeigen"
	L["Widget_PreyBarTT"] = "Zeigt alternativen Beute-Fortschritt neben dem Beutejagd-Widget an."
	L["PreyBar_Style_Row"] = "Reihe"
	L["PreyBar_Style_Statusbar"] = "Statusleiste"
	L["PreyBar_Position"] = "Position"
	L["PreyBar_PositionTT"] = "An welcher Seite des Widgets es befestigt werden soll."
	L["PreyBar_Style"] = UNIT_NAMEPLATES_STYLE
	L["PreyBar_Style_Corner"] = RAID_TARGET_4
	L["PreyBar_Position_Top"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_TOP
	L["PreyBar_Position_Bottom"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_BOTTOM
	L["PreyBar_Position_Left"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_LEFT
	L["PreyBar_Position_Right"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_RIGHT
	L["PreyBar_HideBlizzWidget"] = "Blizzard-Beute-Widget ausblenden"
	L["PreyBar_HideInCombat"] = "Im Kampf ausblenden"

	L["EncounterBar"] = HUD_EDIT_MODE_ENCOUNTER_BAR_LABEL

	L["Header_Combat"] = COMBAT_LABEL
	L["Widget_SpellAlerts"] = COMBAT_TEXT_SHOW_REACTIVES_TEXT
	L["Widget_SpellAlertsTT"] = "Filtert bestimmte Zauberwarnungen, die auf dem Bildschirm erscheinen.\n\nErfordert, dass Zauberwarnungen aktiviert sind."

	--Widgets - BlockTrades
	L["Widget_BlockTrades"] = "Handel während der Transmogrifikation blockieren"
	L["Widget_BlockTradesTT"] = "Blockiert jeglichen Handel, solange das Transmogrifikationsfenster geöffnet ist."
	L["Widget_OutfitLinkOnClose"] = "Outfit beim Schließen der Transmogrifikation verlinken"
	L["Widget_OutfitLinkOnCloseTT"] = "Verlinkt beim Schließen des Transmogrifikationsfensters automatisch das aktuell betrachtete Outfit im Chat."
	L["Widget_OutfitLinkOnClose_LastViewedOutfit"] = "Zuletzt angesehenes Outfit: %s"

	--Widgets - MapAmbience
	L["Widget_MapAmbience_QD"] = "Umgebungslautstärke in Quel'danas reduzieren"
	L["Widget_MapAmbience_QDTT"] = "Reduziert die Umgebungslautstärke in Quel'danas um etwa 25 % deiner aktuellen Umgebungslautstärke."

	--Widgets - DamageMeter
	L["Widget_DamageMeter"] = DAMAGE_METER_LABEL
	L["Widget_DamageMeterTT"] = "Erzwingt kontoweite Einstellungen für die Sichtbarkeit des Schadensmeters auf jedem Charakter."
	L["Widget_DamageWipe"] = AUTO_RESET_DAMAGE_METER
	L["Widget_DamageWipeTT"] = "Erzwingt kontoweite Einstellungen zum Zurücksetzen des Schadensmeters auf jedem Charakter."

	--Widgets - Account-wide settings
	L["Header_ObjectiveTracker"] = HUD_EDIT_MODE_OBJECTIVE_TRACKER_LABEL
	L["Widget_AutoCollapseTracker"] = "Zielverfolgung automatisch einklappen"
	L["Widget_AutoCollapseTrackerTT"] = "Minimiert die Zielverfolgung unter bestimmten Bedingungen automatisch."
	L["Widget_AutoFadeObjectiveTracker"] = "Zielverfolgung automatisch ausblenden"
	L["Widget_AutoFadeObjectiveTrackerTT"] = "Blendet die Zielverfolgung unter bestimmten Bedingungen automatisch aus."
	L["Widget_ACT_RestedArea"] = "Erholungsgebiet"
	L["Widget_ACT_Combat"] = COMBAT
	L["Widget_ACT_PetBattles"] = SHOW_PET_BATTLES_ON_MAP_TEXT
	L["Widget_ACT_Battlegrounds"] = BATTLEFIELDS
	L["Widget_ACT_Arena"] = ARENA
	L["Widget_ACT_Dungeon"] = LFG_TYPE_DUNGEON
	L["Widget_ACT_MPlus"] = PLAYER_DIFFICULTY_MYTHIC_PLUS
	L["Widget_ACT_Raids"] = RAID
	L["Widget_ACT_ScenariosDelves"] = SCENARIOS_PVEFRAME .. "/" .. DELVES_LABEL
	L["Widget_ACT_Housing"] = BINDING_HEADER_HOUSING_SYSTEM

	--Widgets - Delete Confirm
	L["Widget_DeleteConfirm"] = "Text zum Löschen von Gegenständen ausfüllen"
	L["Widget_DeleteConfirmTT"] = string.format("Schaltfläche zum Ausfüllen des Textes '%s', mit anschließender Funktion zum Löschen des Gegenstands beim zweiten Klick.", DELETE_ITEM_CONFIRM_STRING)
	L["Widget_DeleteConfirm_ButtonTT"] = string.format("Klick 1: Text '%s' ausfüllen.\n\nKlick 2: Gegenstand löschen.", DELETE_ITEM_CONFIRM_STRING)

	--Widgets - ProfessionToasts
	L["Widget_ProfessionToasts"] = "Berufsmeldungen"
	L["Widget_ProfessionToastsTT"] = "Zeigt eine Einblendbenachrichtigung an, wenn eine Berufsfertigkeit erhöht wird."
	L["FrameWidth"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_WIDTH
	L["FrameHeight"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_HEIGHT
	L["FontSize"] = FONT_SIZE
	L["FontColor"] = "Schriftfarbe"
	L["BorderColor"] = EMBLEM_BORDER_COLOR
	L["BackgroundColor"] = "Hintergrundfarbe"
	L["BorderStyle"] = "Rahmenstil"
	L["BackgroundStyle"] = "Hintergrundstil"
	L["SingleLine"] = "Einzeilige Berufslevel-Anzeige"
	L["PlaySound"] = COOLDOWN_VIEWER_SETTINGS_ALERT_MENU_BUTTON_TOOLTIP_PREVIEW
	L["Desaturate"] = "Entsättigt"

	L["BorderStyle_housingcontainer"] = "Wohnungscontainer"
	L["BorderStyle_shopheader"] = "Shop-Kopfzeile"
	L["BorderStyle_questtracker"] = "Questverfolgung"
	L["BorderStyle_achievementalert"] = "Erfolgsbenachrichtigung"
	L["BorderStyle_shipmisson"] = "Schiffsmission"
	L["BorderStyle_housingitem"] = "Wohnungsgegenstand"
	L["BorderStyle_artifactlevel"] = "Artefaktstufe"
	L["BorderStyle_shoptoast"] = "Shop-Benachrichtigung"
	L["BorderStyle_legioninvasion"] = "Legionsinvasionstitel"
	L["BorderStyle_lootroll"] = "Beutewurf"
	L["BorderStyle_activities"] = "Aktivitäten"
	L["BorderStyle_midnightscenariotitle"] = "Midnight-Szenariotitel"
	L["BorderStyle_thewarwithinscenariotitle"] = "The War Within-Szenariotitel"
	L["BorderStyle_dragonflightscenariotitle"] = "Dragonflight-Szenariotitel"
	L["BorderStyle_dragonflightscenarioframe"] = "Dragonflight-Szenariofenster"
	L["BorderStyle_evergreenscenariotitle"] = "Evergreen-Szenariotitel"

	-- Professions - official translations
	L["ALCHEMY"] = "Alchemie"
	L["ARCHAEOLOGY"] = "Archäologie"
	L["BLACKSMITHING"] = "Schmiedekunst"
	L["COOKING"] = "Kochkunst"
	L["ENCHANTING"] = "Verzauberkunst"
	L["ENGINEERING"] = "Ingenieurskunst"
	L["FIRST_AID"] = "Erste Hilfe"
	L["FISHING"] = "Angeln"
	L["HERBALISM"] = "Kräuterkunde"
	L["INSCRIPTION"] = "Inschriftenkunde"
	L["JEWELCRAFTING"] = "Juwelierskunst"
	L["LEATHERWORKING"] = "Lederverarbeitung"
	L["MINING"] = "Bergbau"
	L["SKINNING"] = "Kürschnerei"
	L["TAILORING"] = "Schneiderei"

	L["SpecializationArt"] = "Spezialisierungsgrafik"
	L["MobileIcons"] = "Mobiles Symbol"

	L["MetalChainMaw"] = "Metallkette – Schlund"
	L["Wildhammer"] = "Wildhammer"

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Alle Minikarten-Verfolgungen anzeigen"
	L["CVar_minimapTrackingShowAllTT"] = "Aktiviert zusätzliche Minikarten-Verfolgungsoptionen."
	L["CVar_weatherDensity"] = "Wetterdichte"
	L["CVar_weatherDensityTT"] = "Steuert die Intensität des Wetters."
	L["CVar_AutoPushSpellToActionBar"] = "Zauber automatisch auf Aktionsleisten platzieren"
	L["CVar_AutoPushSpellToActionBarTT"] = "Legt fest, ob Zauber automatisch auf Aktionsleisten platziert werden."
	L["CVar_minimapTrackingClosestOnly"] = "Minimap-Verfolgung nur nächstgelegen"
	L["CVar_minimapTrackingClosestOnlyTT"] = "Zeigt nur das nächstgelegene verfolgte Symbol für bestimmte Minimap-Symboltypen an."
	L["CVar_autoDismount"] = "Automatisches Absitzen (Boden)"
	L["CVar_autoDismountTT"] = "Steigt automatisch von deinem Bodenreittier ab, wenn du mit bestimmten Objekten interagierst."

	-- Global Strings
	L["UIScale"] = UI_SCALE
	L["LockFrame"] = LOCK_FRAME
	L["ResetPosition"] = RESET_POSITION
	L["Header_Professions"] = TRADE_SKILLS
	L["Header_Map"] = WORLD_MAP
	L["Header_ActionBar"] = BINDING_HEADER_ACTIONBAR
	L["Header_Chat"] = BINDING_HEADER_CHAT
	L["Header_Misc"] = BINDING_HEADER_MISC
	L["Loading"] = LFG_LIST_LOADING
	L["Remove"] = REMOVE
	L["Add"] = ADD
	L["None"] = NONE
	L["All"] = ALL
	L["Outfit"] = TRANSMOG_OUTFIT_NAME_DEFAULT
	L["AdvancedOptions"] = ADVANCED_OPTIONS
	L["Header_Nameplates"] = NAMEPLATES_LABEL
	L["Header_Screenshot"] = BINDING_NAME_SCREENSHOT

return end

if LOCALE == "frFR" then
	-- French translations go here

	L["TOC_Title"] = "Artificer"
	L["TOC_Notes"] = "Un atelier personnel et une collection d’ajustements de l’interface"
	L["SLASH_ARTI1"] = "/artificer" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI2"] = "/arti" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI3"] = "/artificer" -- localized slash command
	L["SLASH_ARTI4"] = "/arti" -- localized slash command
	L["OpenSettings"] = "Ouvrir les options"

	-- Headers
	L["Header_AccountSettings"] = "Paramètres du compte"
	L["Header_CVars"] = "Variables de console (CVars)"

	--Widgets
	L["Widget_FishReelIn"] = "Remonter la ligne"
	L["Widget_FishReelInTT"] = "Joue un son lorsque votre lancer de pêche se termine."
	L["Widget_ChromieTimeIcon"] = "Icône Temps de Chromie"
	L["Widget_ChromieTimeIconTT"] = "Affiche une icône sur la carte si vous êtes en Temps de Chromie (campagnes Marcheurs du temps)."
	L["Widget_ChromieTimeIcon_NoCampaign"] = "Aucune campagne Marcheurs du temps n’est active."
	L["Widget_HideMacroText"] = "Masquer le texte des macros des barres d’action"
	L["Widget_HideMacroTextTT"] = "Masque le texte des macros sur les boutons des barres d’action."
	L["Widget_ArrowKeyEditbox"] = "Autoriser les flèches dans la zone de chat"
	L["Widget_ArrowKeyEditboxTT"] = "Permet d’utiliser les flèches pour déplacer le curseur sans maintenir Alt."
	L["Widget_OutfitIcon"] = "Bordures des tenues de transmogrification"
	L["Widget_OutfitIconTT"] = "Affiche des bordures sur les tenues placées sur les barres d’action."
	L["Widget_ServerNotifications"] = "Notifications serveur en alerte de raid"
	L["Widget_ServerNotificationsTT"] = "Affiche les notifications serveur (ex : redémarrages) comme alerte de raid."
	L["Widget_OutfitSwapSounds"] = "Sons de changement de tenue"
	L["Widget_OutfitSwapSoundsTT"] = "Choisissez quels sons couper lors du changement de tenue."
	L["Widget_OSS_Impact"] = "Impact"
	L["Widget_OSS_STA"] = "Type de son A"
	L["Widget_OSS_STB"] = "Type de son B"
	L["Widget_OSS_STC"] = "Type de son C"
	L["Widget_OSS_STD"] = "Type de son D"
	L["Widget_HideCraftingResults"] = "Masquer les résultats d’artisanat"
	L["Widget_HideCraftingResultsTT"] = "Masque la fenêtre de résultats lors de la fabrication."
	L["Widget_MovableCurrencyTransfer"] = "Fenêtre de transfert de monnaie déplaçable"
	L["Widget_MovableCurrencyTransferTT"] = "Permet de déplacer la fenêtre de transfert de monnaie."
	L["Widget_AddonCompartmentMover"] = "Déplacer le compartiment des addons"
	L["Widget_AddonCompartmentMoverTT"] = "Déplace le compartiment des addons au-dessus du bouton calendrier."
	L["Widget_MinimapIcon"] = "Icône de la minicarte"
	L["Widget_MinimapIconTT"] = "Affiche une icône cliquable sur la minicarte pour ouvrir les options."
	L["Widget_CollapseBuffs"] = "Réduire automatiquement la fenêtre des améliorations"
	L["Widget_CollapseBuffsTT"] = "Réduit automatiquement la fenêtre des améliorations par défaut."
	L["Widget_PartySync"] = "Accepter automatiquement la synchronisation de groupe"
	L["Widget_PartySyncTT"] = "Accepte automatiquement la confirmation de synchronisation de groupe."
	L["Widget_ChatTooltipVisibility"] = "Aperçu du message de chat"
	L["Widget_ChatTooltipVisibilityTT"] = "Affiche une info-bulle dans la zone de saisie pour prévisualiser le message en cours d’édition."
	L["CurrentMessage"] = "Message actuel"
	L["Mouseover"] = "Survol"
	L["Widget_HideScreenshotText"] = "Masquer le texte de capture"
	L["Widget_HideScreenshotTextTT"] = "Masque le texte indiquant qu’une capture d’écran a été prise."
	L["Widget_ScreenshotFormat"] = "Format de capture d’écran"
	L["Widget_ScreenshotFormatTT"] = "Ajuste le format de capture (le PNG peut rendre certains ciels transparents)."
	L["Widget_ScreenshotQuality"] = "Qualité de capture"
	L["Widget_ScreenshotQualityTT"] = "Ajuste la qualité de la capture d’écran."
	L["Widget_ScreenshotSizeMultiplier"] = "Résolution de capture"
	L["Widget_ScreenshotSizeMultiplierTT"] = "Ajuste la résolution selon un multiplicateur de la fenêtre."
	L["Warning_FileSize"] = "Attention : cela peut générer un fichier volumineux."
	L["Widget_BlockGuildInvites"] = "Bloquer les invitations de guilde (compte)"
	L["Widget_BlockGuildInvitesTT"] = "Paramètre global pour refuser automatiquement les invitations de guilde sur tous les personnages."

	--Widgets - Account-wide settings
	L["Widget_AutoLoot"] = "Basculer le butin automatique du compte"
	L["Widget_AutoLootTT"] = "Applique les paramètres de butin automatique à tout le compte sur chaque personnage."
	L["Widget_PetBattleMapFilter"] = "Basculer le filtre de carte de combats de mascottes du compte"
	L["Widget_PetBattleMapFilterTT"] = "Applique les paramètres du filtre de carte de combats de mascottes à tout le compte."
	L["Widget_cooldownViewerEnabled"] = "Basculer le gestionnaire de temps de recharge du compte"
	L["Widget_cooldownViewerEnabledTT"] = "Applique les paramètres du gestionnaire de temps de recharge à tout le compte."
	L["Account_On"] = "Activé pour tout le compte"
	L["Account_Off"] = "Désactivé pour tout le compte"

	--Widgets - CancelAura
	L["CancelAuraManager"] = "Gestionnaire d’annulation d’auras"
	L["CancelAuraManagerTT"] = "Supprime automatiquement certains bonus hors combat."
	L["InvalidSpell"] = "ID de sort invalide"
	L["EnterSpellID"] = "Entrer l’ID du sort"
	L["CanceledAuras"] = "Auras annulées"
	L["AuraHistory"] = "Historique des auras"
	L["SpellID"] = "l’ID du sort"

	--Widgets - AbandonQuestManager
	L["AbandonQuestManager"] = "Gestionnaire d’abandon de quêtes"
	L["AbandonQuestManagerTT"] = "Abandonne automatiquement certaines quêtes indésirables."
	L["InvalidQuest"] = "ID de quête invalide"
	L["EnterQuestID"] = "Entrer l’ID de quête"
	L["AbandonedQuests"] = "Quêtes abandonnées automatiquement"
	L["QuestHistory"] = "Historique des quêtes"
	L["QuestID"] = "ID de quête : %s"

	--Widgets - OutfitBar
	L["OutfitSoundManager"] = "Gestionnaire de sons d’équipement"
	L["OutfitSoundManagerTT"] = "Configure les sons de mouvement d’équipement pour chaque tenue."
	L["Leather"] = "Cuir"
	L["Chain"] = "Mailles"
	L["Plate"] = "Plaques"
	L["GearLight"] = "Équipement léger"
	L["GearHeavy"] = "Équipement lourd"
	L["BucklesLight"] = "Boucles légères"
	L["BucklesHeavy"] = "Boucles lourdes"
	L["YakRun"] = "Yak en course"
	L["YakWalk"] = "Yak en marche"
	L["GrummleRun"] = "Grumelot en course"
	L["GrummleWalk"] = "Grumelot en marche"
	L["TreasureGoblin"] = "Gobelin au trésor"
	L["SoundS"] = "Son : %s"
	L["Click"] = "Clic : %s"
	L["LeftClick"] = "Clic gauche : %s"
	L["RightClick"] = "Clic droit : %s"
	L["ClickDrag"] = "Cliquer-glisser : %s"
	L["ConfigureSounds"] = "Configurer les sons"
	L["PickUpOutfit"] = "Ramasser la tenue"
	L["OutfitManager"] = "Gestionnaire de tenues"
	L["OutfitManagerTT"] = "Choisissez une tenue à porter et configurez les sons de mouvement d’équipement pouvant être joués pour chaque tenue."
	L["EquipOutfit"] = "Équiper la tenue"
	L["Widget_MinimapRightClick"] = "Clic droit sur la minicarte"
	L["Widget_MinimapRightClickTT"] = "Définir la fonction du clic droit sur la minicarte"
	L["LockAppearance"] = "Verrouiller l’apparence"

	--Widgets - TransmogHistory
	L["UndoTT"] = "Annuler"
	L["RedoTT"] = "Rétablir"
	L["UndoKeybindTT"] = "(Alt-Z / Maj-Z)"
	L["RedoKeybindTT"] = "(Alt-Y / Maj-Y)"
	L["RestoreSessionTT"] = "Restaurer la session précédente"
	L["SheathWeaponTT"] = TRANSMOG_SHEATHE_WEAPON
	L["InvalidWeapoonSheathTT"] = TRANSMOG_SLOT_WARNING_NOTHING_EQUIPPED

	--Widgets - Loot History Visibility
	L["Widget_LootHistoryVisibility"] = "Visibilité de l’historique du butin"
	L["Widget_LootHistoryVisibilityTT"] = "Masque automatiquement l’historique du butin selon l’option sélectionnée."
	L["Widget_LHV_None"] = NONE
	L["Widget_LHV_Solo"] = SOLO
	L["Widget_LHV_NotFull"] = "Groupe non complet"
	L["Widget_LHV_Always"] = ALWAYS

	--Widgets - Hide Tutorials
	L["Widget_HideTutorials"] = "Masquer les tutoriels"
	L["Widget_HideTutorialsTT"] = "Force le masquage des tutoriels pour tout le compte."

	--Widgets - NameplateTargetIndicator
	L["FNP_TargetIndicator"] = "Indicateur de ciblage des plaques de nom alliées"
	L["FNP_TargetIndicatorTT"] = "Affiche une icône sur la plaque de nom d’un joueur allié qui vous cible."
	L["FNP_HeroTalentRing"] = "Anneau de talent héroïque"
	L["FNP_ArtificerEye"] = "Œil d’Artificier"
	L["FNP_LFGEye"] = "Œil LFG"
	L["FNP_DragIcon"] = "Déplacer l’icône par rapport à la plaque de nom"
	L["FNP_IconStyle"] = "Style d’icône"
	L["FNP_IconSize"] = "Taille de l’icône"
	L["FNP_IconColor"] = "Couleur de l’icône"
	L["LC_OpenColorPicker"] = "Clic gauche : Ouvrir le sélecteur de couleur"
	L["RC_OpenDropdown"] = "Clic droit : Paramètres supplémentaires"
	L["ColorOptions"] = "Options de couleur"
	L["CopyColor"] = "Copier la couleur"
	L["PasteColor"] = "Coller la couleur"

	--Widgets - NameplateStatus
	L["FNP_StatusIndicator"] = "Indicateur d’état des barres de nom amicales"
	L["FNP_StatusIndicatorTT"] = "Affiche une icône sur la barre de nom de l’état d’un joueur amical."
	L["FNP_StatusOptions"] = PLAYER_STATUS
	L["FNP_StatusConnection"] = "Connexion (ABS/DND/DC)"
	L["FNP_StatusChromie"] = "Temps de Chromie"
	L["FNP_StatusGroup"] = PARTY_MEMBERS
	L["FNP_StatusGuild"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriend"] = FRIENDS
	L["FNP_StatusIgnored"] = IGNORED
	L["FNP_StatusConnectionDCd"] = "Déconnecté"
	L["FNP_StatusConnectionAway"] = CHAT_MSG_AFK
	L["FNP_StatusConnectionDND"] = DND
	L["FNP_StatusGroupMember"] = GROUP
	L["FNP_StatusGroupAssist"] = RAID_ASSISTANT
	L["FNP_StatusGroupLeader"] = LEADER
	L["FNP_StatusGuildMember"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriendChar"] = FRIENDS .. " - " .. CHARACTER
	L["FNP_StatusFriendAcc"] = FRIENDS .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT
	L["FNP_StatusFriendBNet"] = FRIENDS .. " - " .. BATTLETAG
	L["FNP_StatusIgnoredChar"] = IGNORED .. " - " .. CHARACTER
	L["FNP_StatusIgnoredAcc"] = IGNORED .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT

	--Widgets - Account Ignore List
	L["Widget_AccountIgnoreList"] = "Fenêtre de liste d’ignorés du compte"
	L["Widget_AccountIgnoreListTT"] = "Affiche une fenêtre contenant tous les ignorés enregistrés sur le compte."
	L["AccountIgnoreList"] = "Liste d’ignorés du compte"

	--Widgets - PreyBar
	L["Widget_PreyBar"] = "Indicateurs de progression de proie"
	L["Widget_PreyBarTT"] = "Affiche une progression alternative de proie à côté du widget Chasse à la proie."
	L["PreyBar_Style_Row"] = "Ligne"
	L["PreyBar_Style_Statusbar"] = "Barre d’état"
	L["PreyBar_Position"] = "Position"
	L["PreyBar_PositionTT"] = "De quel côté du widget l’attacher."
	L["PreyBar_Style"] = UNIT_NAMEPLATES_STYLE
	L["PreyBar_Style_Corner"] = RAID_TARGET_4
	L["PreyBar_Position_Top"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_TOP
	L["PreyBar_Position_Bottom"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_BOTTOM
	L["PreyBar_Position_Left"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_LEFT
	L["PreyBar_Position_Right"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_RIGHT
	L["PreyBar_HideBlizzWidget"] = "Masquer le widget de proie de Blizzard"
	L["PreyBar_HideInCombat"] = "Masquer en combat"

	L["EncounterBar"] = HUD_EDIT_MODE_ENCOUNTER_BAR_LABEL

	L["Header_Combat"] = COMBAT_LABEL
	L["Widget_SpellAlerts"] = COMBAT_TEXT_SHOW_REACTIVES_TEXT
	L["Widget_SpellAlertsTT"] = "Filtre des alertes de sorts spécifiques qui apparaissent à l’écran.\n\nNécessite que les alertes de sorts soient activées."

	--Widgets - BlockTrades
	L["Widget_BlockTrades"] = "Bloquer les échanges pendant la transmogrification"
	L["Widget_BlockTradesTT"] = "Bloque tous les échanges tant que la fenêtre de transmogrification est ouverte."
	L["Widget_OutfitLinkOnClose"] = "Lier la tenue à la fermeture de la transmogrification"
	L["Widget_OutfitLinkOnCloseTT"] = "Lie automatiquement la tenue actuellement affichée dans le chat lors de la fermeture de la fenêtre de transmogrification."
	L["Widget_OutfitLinkOnClose_LastViewedOutfit"] = "Dernière tenue consultée : %s"

	--Widgets - MapAmbience
	L["Widget_MapAmbience_QD"] = "Réduire le volume d’ambiance à Quel'danas"
	L["Widget_MapAmbience_QDTT"] = "Réduit le volume d’ambiance à Quel'danas d’environ 25 % de votre volume d’ambiance actuel."

	--Widgets - DamageMeter
	L["Widget_DamageMeter"] = DAMAGE_METER_LABEL
	L["Widget_DamageMeterTT"] = "Applique les paramètres à l’échelle du compte pour la visibilité du compteur de dégâts sur chaque personnage."
	L["Widget_DamageWipe"] = AUTO_RESET_DAMAGE_METER
	L["Widget_DamageWipeTT"] = "Applique les paramètres à l’échelle du compte pour la réinitialisation du compteur de dégâts sur chaque personnage."

	--Widgets - Account-wide settings
	L["Header_ObjectiveTracker"] = HUD_EDIT_MODE_OBJECTIVE_TRACKER_LABEL
	L["Widget_AutoCollapseTracker"] = "Réduire automatiquement le suivi des objectifs"
	L["Widget_AutoCollapseTrackerTT"] = "Réduit automatiquement le suivi des objectifs dans certaines conditions."
	L["Widget_AutoFadeObjectiveTracker"] = "Fondu automatique du suivi des objectifs"
	L["Widget_AutoFadeObjectiveTrackerTT"] = "Applique un fondu automatique au suivi des objectifs dans certaines conditions."
	L["Widget_ACT_RestedArea"] = "Zone de repos"
	L["Widget_ACT_Combat"] = COMBAT
	L["Widget_ACT_PetBattles"] = SHOW_PET_BATTLES_ON_MAP_TEXT
	L["Widget_ACT_Battlegrounds"] = BATTLEFIELDS
	L["Widget_ACT_Arena"] = ARENA
	L["Widget_ACT_Dungeon"] = LFG_TYPE_DUNGEON
	L["Widget_ACT_MPlus"] = PLAYER_DIFFICULTY_MYTHIC_PLUS
	L["Widget_ACT_Raids"] = RAID
	L["Widget_ACT_ScenariosDelves"] = SCENARIOS_PVEFRAME .. "/" .. DELVES_LABEL
	L["Widget_ACT_Housing"] = BINDING_HEADER_HOUSING_SYSTEM

	--Widgets - Delete Confirm
	L["Widget_DeleteConfirm"] = "Remplir le texte de suppression d'objet"
	L["Widget_DeleteConfirmTT"] = string.format("Bouton pour remplir le texte '%s', avec une fonction permettant de supprimer l'objet lors du deuxième clic.", DELETE_ITEM_CONFIRM_STRING)
	L["Widget_DeleteConfirm_ButtonTT"] = string.format("Clic 1 : Remplir le texte '%s'.\n\nClic 2 : Supprimer l'objet.", DELETE_ITEM_CONFIRM_STRING)

	--Widgets - ProfessionToasts
	L["Widget_ProfessionToasts"] = "Notifications de profession"
	L["Widget_ProfessionToastsTT"] = "Affiche une notification en fondu lors de l’augmentation du niveau d’une compétence de profession."
	L["FrameWidth"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_WIDTH
	L["FrameHeight"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_HEIGHT
	L["FontSize"] = FONT_SIZE
	L["FontColor"] = "Couleur de police"
	L["BorderColor"] = EMBLEM_BORDER_COLOR
	L["BackgroundColor"] = "Couleur d’arrière-plan"
	L["BorderStyle"] = "Style de bordure"
	L["BackgroundStyle"] = "Style d’arrière-plan"
	L["SingleLine"] = "Niveau de profession sur une seule ligne"
	L["PlaySound"] = COOLDOWN_VIEWER_SETTINGS_ALERT_MENU_BUTTON_TOOLTIP_PREVIEW
	L["Desaturate"] = "Désaturé"

	L["BorderStyle_housingcontainer"] = "Conteneur de logement"
	L["BorderStyle_shopheader"] = "En-tête de boutique"
	L["BorderStyle_questtracker"] = "Suivi de quête"
	L["BorderStyle_achievementalert"] = "Alerte de haut fait"
	L["BorderStyle_shipmisson"] = "Mission de navire"
	L["BorderStyle_housingitem"] = "Objet de logement"
	L["BorderStyle_artifactlevel"] = "Niveau d'artefact"
	L["BorderStyle_shoptoast"] = "Notification de boutique"
	L["BorderStyle_legioninvasion"] = "Titre d'invasion de la Légion"
	L["BorderStyle_lootroll"] = "Jetin de butin"
	L["BorderStyle_activities"] = "Activités"
	L["BorderStyle_midnightscenariotitle"] = "Titre de scénario Midnight"
	L["BorderStyle_thewarwithinscenariotitle"] = "Titre de scénario The War Within"
	L["BorderStyle_dragonflightscenariotitle"] = "Titre de scénario Dragonflight"
	L["BorderStyle_dragonflightscenarioframe"] = "Cadre de scénario Dragonflight"
	L["BorderStyle_evergreenscenariotitle"] = "Titre de scénario Evergreen"

	-- Professions - official translations
	L["ALCHEMY"] = "Alchimie"
	L["ARCHAEOLOGY"] = "Archéologie"
	L["BLACKSMITHING"] = "Forge"
	L["COOKING"] = "Cuisine"
	L["ENCHANTING"] = "Enchantement"
	L["ENGINEERING"] = "Ingénierie"
	L["FIRST_AID"] = "Secourisme"
	L["FISHING"] = "Pêche"
	L["HERBALISM"] = "Herboristerie"
	L["INSCRIPTION"] = "Calligraphie"
	L["JEWELCRAFTING"] = "Joaillerie"
	L["LEATHERWORKING"] = "Travail du cuir"
	L["MINING"] = "Minage"
	L["SKINNING"] = "Dépeçage"
	L["TAILORING"] = "Couture"

	L["SpecializationArt"] = "Illustration de spécialisation"
	L["MobileIcons"] = "Icône mobile"

	L["MetalChainMaw"] = "Chaîne métallique – Antre"
	L["Wildhammer"] = "Marteau-Hardi"

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Afficher tous les suivis de la minicarte"
	L["CVar_minimapTrackingShowAllTT"] = "Active des options supplémentaires de suivi sur la minicarte."
	L["CVar_weatherDensity"] = "Densité météo"
	L["CVar_weatherDensityTT"] = "Contrôle l’intensité de la météo."
	L["CVar_AutoPushSpellToActionBar"] = "Ajouter automatiquement les sorts aux barres d’action"
	L["CVar_AutoPushSpellToActionBarTT"] = "Détermine si les sorts sont automatiquement placés sur les barres d’action."
	L["CVar_minimapTrackingClosestOnly"] = "Suivi de la minicarte : le plus proche uniquement"
	L["CVar_minimapTrackingClosestOnlyTT"] = "Affiche uniquement l’icône suivie la plus proche pour certains types d’icônes de la minicarte."
	L["CVar_autoDismount"] = "Désarçonner automatiquement (sol)"
	L["CVar_autoDismountTT"] = "Vous fait automatiquement descendre de votre monture terrestre lorsque vous interagissez avec certains objets."

	-- Global Strings
	L["UIScale"] = UI_SCALE
	L["LockFrame"] = LOCK_FRAME
	L["ResetPosition"] = RESET_POSITION
	L["Header_Professions"] = TRADE_SKILLS
	L["Header_Map"] = WORLD_MAP
	L["Header_ActionBar"] = BINDING_HEADER_ACTIONBAR
	L["Header_Chat"] = BINDING_HEADER_CHAT
	L["Header_Misc"] = BINDING_HEADER_MISC
	L["Loading"] = LFG_LIST_LOADING
	L["Remove"] = REMOVE
	L["Add"] = ADD
	L["None"] = NONE
	L["All"] = ALL
	L["Outfit"] = TRANSMOG_OUTFIT_NAME_DEFAULT
	L["AdvancedOptions"] = ADVANCED_OPTIONS
	L["Header_Nameplates"] = NAMEPLATES_LABEL
	L["Header_Screenshot"] = BINDING_NAME_SCREENSHOT

return end

if LOCALE == "itIT" then
	-- Italian translations go here

	L["TOC_Title"] = "Artificer"
	L["TOC_Notes"] = "Un laboratorio personale e una raccolta di modifiche e miglioramenti dell'interfaccia"
	L["SLASH_ARTI1"] = "/artificer" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI2"] = "/arti" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI3"] = "/artificer" -- localized slash command
	L["SLASH_ARTI4"] = "/arti" -- localized slash command
	L["OpenSettings"] = "Apri impostazioni"

	-- Headers
	L["Header_AccountSettings"] = "Impostazioni account"
	L["Header_CVars"] = "Variabili della console (CVars)"

	--Widgets
	L["Widget_FishReelIn"] = "Recupero lenza"
	L["Widget_FishReelInTT"] = "Riproduce un suono quando il lancio di pesca termina."
	L["Widget_ChromieTimeIcon"] = "Icona Tempo di Chromie"
	L["Widget_ChromieTimeIconTT"] = "Mostra un'icona sulla mappa se sei nel Tempo di Chromie (Campagne Viaggi nel Tempo)."
	L["Widget_ChromieTimeIcon_NoCampaign"] = "Nessuna campagna Viaggi nel Tempo attiva."
	L["Widget_HideMacroText"] = "Nascondi testo macro delle barre azione"
	L["Widget_HideMacroTextTT"] = "Nasconde il testo delle macro sui pulsanti delle barre azione."
	L["Widget_ArrowKeyEditbox"] = "Consenti frecce nella chat"
	L["Widget_ArrowKeyEditboxTT"] = "Permette di usare le frecce per muovere il cursore senza premere Alt."
	L["Widget_OutfitIcon"] = "Bordi abiti di trasmogrificazione"
	L["Widget_OutfitIconTT"] = "Mostra bordi sugli abiti di trasmogrificazione nelle barre azione."
	L["Widget_ServerNotifications"] = "Notifiche server come avviso incursione"
	L["Widget_ServerNotificationsTT"] = "Mostra notifiche server (es. riavvii) come avviso incursione."
	L["Widget_OutfitSwapSounds"] = "Suoni cambio abito"
	L["Widget_OutfitSwapSoundsTT"] = "Seleziona quali suoni silenziare durante il cambio abito."
	L["Widget_OSS_Impact"] = "Impatto"
	L["Widget_OSS_STA"] = "Tipo suono A"
	L["Widget_OSS_STB"] = "Tipo suono B"
	L["Widget_OSS_STC"] = "Tipo suono C"
	L["Widget_OSS_STD"] = "Tipo suono D"
	L["Widget_HideCraftingResults"] = "Nascondi risultati creazione"
	L["Widget_HideCraftingResultsTT"] = "Nasconde la finestra dei risultati durante la creazione."
	L["Widget_MovableCurrencyTransfer"] = "Trasferimento valuta spostabile"
	L["Widget_MovableCurrencyTransferTT"] = "Permette di spostare la finestra di trasferimento valuta."
	L["Widget_AddonCompartmentMover"] = "Sposta compartimento addon"
	L["Widget_AddonCompartmentMoverTT"] = "Sposta il compartimento addon sopra il calendario."
	L["Widget_MinimapIcon"] = "Icona minimappa"
	L["Widget_MinimapIconTT"] = "Mostra un'icona cliccabile sulla minimappa per aprire le impostazioni."
	L["Widget_CollapseBuffs"] = "Riduci automaticamente la finestra dei potenziamenti"
	L["Widget_CollapseBuffsTT"] = "Riduce automaticamente la finestra dei potenziamenti predefinita."
	L["Widget_PartySync"] = "Accetta automaticamente Sincronizzazione gruppo"
	L["Widget_PartySyncTT"] = "Accetta automaticamente la sincronizzazione gruppo."
	L["Widget_ChatTooltipVisibility"] = "Anteprima messaggio chat"
	L["Widget_ChatTooltipVisibilityTT"] = "Mostra un tooltip nella casella di testo per visualizzare in anteprima il messaggio in modifica."
	L["CurrentMessage"] = "Messaggio attuale"
	L["Mouseover"] = "Passaggio del mouse"
	L["Widget_HideScreenshotText"] = "Nascondi testo screenshot"
	L["Widget_HideScreenshotTextTT"] = "Nasconde il testo che indica che è stato fatto uno screenshot."
	L["Widget_ScreenshotFormat"] = "Formato screenshot"
	L["Widget_ScreenshotFormatTT"] = "Regola il formato dello screenshot (PNG può rendere trasparenti alcuni cieli)."
	L["Widget_ScreenshotQuality"] = "Qualità screenshot"
	L["Widget_ScreenshotQualityTT"] = "Regola la qualità dello screenshot."
	L["Widget_ScreenshotSizeMultiplier"] = "Risoluzione screenshot"
	L["Widget_ScreenshotSizeMultiplierTT"] = "Regola la risoluzione in base a un moltiplicatore della finestra."
	L["Warning_FileSize"] = "Attenzione: può generare file di grandi dimensioni."
	L["Widget_BlockGuildInvites"] = "Blocca inviti di gilda (account)"
	L["Widget_BlockGuildInvitesTT"] = "Impostazione account per rifiutare automaticamente gli inviti di gilda su tutti i personaggi."

	--Widgets - Account-wide settings
	L["Widget_AutoLoot"] = "Attiva/disattiva raccolta automatica account"
	L["Widget_AutoLootTT"] = "Applica le impostazioni di raccolta automatica a tutto l'account su ogni personaggio."
	L["Widget_PetBattleMapFilter"] = "Attiva/disattiva filtro mappa Pet Battle account"
	L["Widget_PetBattleMapFilterTT"] = "Applica le impostazioni del filtro mappa Pet Battle a tutto l'account."
	L["Widget_cooldownViewerEnabled"] = "Attiva/disattiva Gestore tempi di recupero account"
	L["Widget_cooldownViewerEnabledTT"] = "Applica le impostazioni del Gestore tempi di recupero a tutto l'account."
	L["Account_On"] = "Attivo per tutto l'account"
	L["Account_Off"] = "Disattivo per tutto l'account"

	--Widgets - CancelAura
	L["CancelAuraManager"] = "Gestore rimozione aure"
	L["CancelAuraManagerTT"] = "Rimuove automaticamente alcuni potenziamenti fuori combattimento."
	L["InvalidSpell"] = "ID incantesimo non valido"
	L["EnterSpellID"] = "Inserisci ID incantesimo"
	L["CanceledAuras"] = "Aure rimosse"
	L["AuraHistory"] = "Cronologia aure"
	L["SpellID"] = "ID incantesimo"

	--Widgets - AbandonQuestManager
	L["AbandonQuestManager"] = "Gestore abbandono missioni"
	L["AbandonQuestManagerTT"] = "Abbandona automaticamente missioni indesiderate."
	L["InvalidQuest"] = "ID missione non valido"
	L["EnterQuestID"] = "Inserisci ID missione"
	L["AbandonedQuests"] = "Missioni abbandonate automaticamente"
	L["QuestHistory"] = "Cronologia missioni"
	L["QuestID"] = "ID missione: %s"

	--Widgets - OutfitBar
	L["OutfitSoundManager"] = "Gestore suoni equipaggiamento"
	L["OutfitSoundManagerTT"] = "Configura suoni di movimento dell'equipaggiamento per ogni abito."
	L["Leather"] = "Cuoio"
	L["Chain"] = "Maglia"
	L["Plate"] = "Piastre"
	L["GearLight"] = "Equipaggiamento leggero"
	L["GearHeavy"] = "Equipaggiamento pesante"
	L["BucklesLight"] = "Fibbie leggere"
	L["BucklesHeavy"] = "Fibbie pesanti"
	L["YakRun"] = "Yak in corsa"
	L["YakWalk"] = "Yak in cammino"
	L["GrummleRun"] = "Grumolo in corsa"
	L["GrummleWalk"] = "Grumolo in cammino"
	L["TreasureGoblin"] = "Goblin del tesoro"
	L["SoundS"] = "Suono: %s"
	L["Click"] = "Clic: %s"
	L["LeftClick"] = "Clic sinistro: %s"
	L["RightClick"] = "Clic destro: %s"
	L["ClickDrag"] = "Clic-trascina: %s"
	L["ConfigureSounds"] = "Configura suoni"
	L["PickUpOutfit"] = "Raccogli abito"
	L["OutfitManager"] = "Gestore completi"
	L["OutfitManagerTT"] = "Scegli un completo da indossare e configura i suoni di movimento dell’equipaggiamento che possono essere riprodotti per ogni completo."
	L["EquipOutfit"] = "Indossa completo"
	L["Widget_MinimapRightClick"] = "Clic destro sulla minimappa"
	L["Widget_MinimapRightClickTT"] = "Imposta la funzione del clic destro sulla minimappa"
	L["LockAppearance"] = "Blocco aspetto"

	--Widgets - TransmogHistory
	L["UndoTT"] = "Annulla"
	L["RedoTT"] = "Ripeti"
	L["UndoKeybindTT"] = "(Alt-Z / Maiusc-Z)"
	L["RedoKeybindTT"] = "(Alt-Y / Maiusc-Y)"
	L["RestoreSessionTT"] = "Ripristina sessione precedente"
	L["SheathWeaponTT"] = TRANSMOG_SHEATHE_WEAPON
	L["InvalidWeapoonSheathTT"] = TRANSMOG_SLOT_WARNING_NOTHING_EQUIPPED

	--Widgets - Loot History Visibility
	L["Widget_LootHistoryVisibility"] = "Visibilità cronologia bottino"
	L["Widget_LootHistoryVisibilityTT"] = "Nasconde automaticamente la cronologia del bottino in base all’opzione selezionata."
	L["Widget_LHV_None"] = NONE
	L["Widget_LHV_Solo"] = SOLO
	L["Widget_LHV_NotFull"] = "Gruppo non completo"
	L["Widget_LHV_Always"] = ALWAYS

	--Widgets - Hide Tutorials
	L["Widget_HideTutorials"] = "Nascondi tutorial"
	L["Widget_HideTutorialsTT"] = "Forza la disattivazione dei tutorial per l’intero account."

	--Widgets - NameplateTargetIndicator
	L["FNP_TargetIndicator"] = "Indicatore bersaglio targhe amichevoli"
	L["FNP_TargetIndicatorTT"] = "Mostra un’icona sulla targhetta di un giocatore amichevole che ti sta bersagliando."
	L["FNP_HeroTalentRing"] = "Anello Talenti Eroici"
	L["FNP_ArtificerEye"] = "Occhio dell’Artificiere"
	L["FNP_LFGEye"] = "Occhio LFG"
	L["FNP_DragIcon"] = "Trascina icona relativa alla targhetta"
	L["FNP_IconStyle"] = "Stile icona"
	L["FNP_IconSize"] = "Dimensione icona"
	L["FNP_IconColor"] = "Colore icona"
	L["LC_OpenColorPicker"] = "Clic sinistro: Apri selettore colore"
	L["RC_OpenDropdown"] = "Clic destro: Impostazioni aggiuntive"
	L["ColorOptions"] = "Opzioni colore"
	L["CopyColor"] = "Copia colore"
	L["PasteColor"] = "Incolla colore"

	--Widgets - NameplateStatus
	L["FNP_StatusIndicator"] = "Indicatore di stato delle barre dei nomi amichevoli"
	L["FNP_StatusIndicatorTT"] = "Mostra un'icona sulla barra del nome dello stato di un giocatore amichevole."
	L["FNP_StatusOptions"] = PLAYER_STATUS
	L["FNP_StatusConnection"] = "Connessione (AFK/DND/DC)"
	L["FNP_StatusChromie"] = "Tempo di Cromie"
	L["FNP_StatusGroup"] = PARTY_MEMBERS
	L["FNP_StatusGuild"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriend"] = FRIENDS
	L["FNP_StatusIgnored"] = IGNORED
	L["FNP_StatusConnectionDCd"] = "Disconnesso"
	L["FNP_StatusConnectionAway"] = CHAT_MSG_AFK
	L["FNP_StatusConnectionDND"] = DND
	L["FNP_StatusGroupMember"] = GROUP
	L["FNP_StatusGroupAssist"] = RAID_ASSISTANT
	L["FNP_StatusGroupLeader"] = LEADER
	L["FNP_StatusGuildMember"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriendChar"] = FRIENDS .. " - " .. CHARACTER
	L["FNP_StatusFriendAcc"] = FRIENDS .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT
	L["FNP_StatusFriendBNet"] = FRIENDS .. " - " .. BATTLETAG
	L["FNP_StatusIgnoredChar"] = IGNORED .. " - " .. CHARACTER
	L["FNP_StatusIgnoredAcc"] = IGNORED .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT

	--Widgets - Account Ignore List
	L["Widget_AccountIgnoreList"] = "Finestra lista ignorati account"
	L["Widget_AccountIgnoreListTT"] = "Mostra una finestra contenente tutti gli ignorati registrati nell'account."
	L["AccountIgnoreList"] = "Lista ignorati account"

	--Widgets - PreyBar
	L["Widget_PreyBar"] = "Indicatori progresso preda"
	L["Widget_PreyBarTT"] = "Mostra un progresso alternativo della preda accanto al widget Caccia alla preda."
	L["PreyBar_Style_Row"] = "Riga"
	L["PreyBar_Style_Statusbar"] = "Barra di stato"
	L["PreyBar_Position"] = "Posizione"
	L["PreyBar_PositionTT"] = "A quale lato del widget agganciarlo."
	L["PreyBar_Style"] = UNIT_NAMEPLATES_STYLE
	L["PreyBar_Style_Corner"] = RAID_TARGET_4
	L["PreyBar_Position_Top"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_TOP
	L["PreyBar_Position_Bottom"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_BOTTOM
	L["PreyBar_Position_Left"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_LEFT
	L["PreyBar_Position_Right"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_RIGHT
	L["PreyBar_HideBlizzWidget"] = "Nascondi widget preda di Blizzard"
	L["PreyBar_HideInCombat"] = "Nascondi in combattimento"

	L["EncounterBar"] = HUD_EDIT_MODE_ENCOUNTER_BAR_LABEL

	L["Header_Combat"] = COMBAT_LABEL
	L["Widget_SpellAlerts"] = COMBAT_TEXT_SHOW_REACTIVES_TEXT
	L["Widget_SpellAlertsTT"] = "Filtra specifici avvisi di incantesimi che appaiono sullo schermo.\n\nRichiede che gli avvisi degli incantesimi siano attivati."

	--Widgets - BlockTrades
	L["Widget_BlockTrades"] = "Blocca gli scambi durante la trasmogrificazione"
	L["Widget_BlockTradesTT"] = "Blocca tutti gli scambi mentre la finestra di trasmogrificazione è aperta."
	L["Widget_OutfitLinkOnClose"] = "Collega l’equipaggiamento alla chiusura della trasmogrificazione"
	L["Widget_OutfitLinkOnCloseTT"] = "Collega automaticamente in chat l’equipaggiamento attualmente visualizzato alla chiusura della finestra di trasmogrificazione."
	L["Widget_OutfitLinkOnClose_LastViewedOutfit"] = "Ultimo equipaggiamento visualizzato: %s"

	--Widgets - MapAmbience
	L["Widget_MapAmbience_QD"] = "Riduci volume ambientale a Quel'danas"
	L["Widget_MapAmbience_QDTT"] = "Riduce il volume ambientale a Quel'danas di circa il 25% del volume ambientale attuale."

	--Widgets - DamageMeter
	L["Widget_DamageMeter"] = DAMAGE_METER_LABEL
	L["Widget_DamageMeterTT"] = "Applica le impostazioni a livello di account per la visibilità del misuratore dei danni su ogni personaggio."
	L["Widget_DamageWipe"] = AUTO_RESET_DAMAGE_METER
	L["Widget_DamageWipeTT"] = "Applica le impostazioni a livello di account per il ripristino del misuratore dei danni su ogni personaggio."

	--Widgets - Account-wide settings
	L["Header_ObjectiveTracker"] = HUD_EDIT_MODE_OBJECTIVE_TRACKER_LABEL
	L["Widget_AutoCollapseTracker"] = "Comprimi automaticamente il tracciatore obiettivi"
	L["Widget_AutoCollapseTrackerTT"] = "Riduce automaticamente il tracciatore obiettivi in determinate condizioni."
	L["Widget_AutoFadeObjectiveTracker"] = "Dissolvenza automatica tracciatore obiettivi"
	L["Widget_AutoFadeObjectiveTrackerTT"] = "Applica automaticamente una dissolvenza al tracciatore obiettivi in determinate condizioni."
	L["Widget_ACT_RestedArea"] = "Area di riposo"
	L["Widget_ACT_Combat"] = COMBAT
	L["Widget_ACT_PetBattles"] = SHOW_PET_BATTLES_ON_MAP_TEXT
	L["Widget_ACT_Battlegrounds"] = BATTLEFIELDS
	L["Widget_ACT_Arena"] = ARENA
	L["Widget_ACT_Dungeon"] = LFG_TYPE_DUNGEON
	L["Widget_ACT_MPlus"] = PLAYER_DIFFICULTY_MYTHIC_PLUS
	L["Widget_ACT_Raids"] = RAID
	L["Widget_ACT_ScenariosDelves"] = SCENARIOS_PVEFRAME .. "/" .. DELVES_LABEL
	L["Widget_ACT_Housing"] = BINDING_HEADER_HOUSING_SYSTEM

	--Widgets - Delete Confirm
	L["Widget_DeleteConfirm"] = "Compila il testo di eliminazione oggetto"
	L["Widget_DeleteConfirmTT"] = string.format("Pulsante per compilare il testo '%s', con una funzione successiva per eliminare l'oggetto al secondo clic.", DELETE_ITEM_CONFIRM_STRING)
	L["Widget_DeleteConfirm_ButtonTT"] = string.format("Clic 1: Compila il testo '%s'.\n\nClic 2: Elimina oggetto.", DELETE_ITEM_CONFIRM_STRING)

	--Widgets - ProfessionToasts
	L["Widget_ProfessionToasts"] = "Notifiche professioni"
	L["Widget_ProfessionToastsTT"] = "Mostra una notifica in dissolvenza quando una abilità di professione aumenta di livello."
	L["FrameWidth"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_WIDTH
	L["FrameHeight"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_HEIGHT
	L["FontSize"] = FONT_SIZE
	L["FontColor"] = "Colore del carattere"
	L["BorderColor"] = EMBLEM_BORDER_COLOR
	L["BackgroundColor"] = "Colore di sfondo"
	L["BorderStyle"] = "Stile del bordo"
	L["BackgroundStyle"] = "Stile sfondo"
	L["SingleLine"] = "Livello professione su una sola riga"
	L["PlaySound"] = COOLDOWN_VIEWER_SETTINGS_ALERT_MENU_BUTTON_TOOLTIP_PREVIEW
	L["Desaturate"] = "Desaturato"

	L["BorderStyle_housingcontainer"] = "Contenitore abitazione"
	L["BorderStyle_shopheader"] = "Intestazione negozio"
	L["BorderStyle_questtracker"] = "Tracciamento missioni"
	L["BorderStyle_achievementalert"] = "Avviso obiettivo"
	L["BorderStyle_shipmisson"] = "Missione nave"
	L["BorderStyle_housingitem"] = "Oggetto abitazione"
	L["BorderStyle_artifactlevel"] = "Livello artefatto"
	L["BorderStyle_shoptoast"] = "Notifica negozio"
	L["BorderStyle_legioninvasion"] = "Titolo invasione della Legione"
	L["BorderStyle_lootroll"] = "Tiro bottino"
	L["BorderStyle_activities"] = "Attività"
	L["BorderStyle_midnightscenariotitle"] = "Titolo scenario Midnight"
	L["BorderStyle_thewarwithinscenariotitle"] = "Titolo scenario The War Within"
	L["BorderStyle_dragonflightscenariotitle"] = "Titolo scenario Dragonflight"
	L["BorderStyle_dragonflightscenarioframe"] = "Finestra scenario Dragonflight"
	L["BorderStyle_evergreenscenariotitle"] = "Titolo scenario Evergreen"

	-- Professions - official translations
	L["ALCHEMY"] = "Alchimia"
	L["ARCHAEOLOGY"] = "Archeologia"
	L["BLACKSMITHING"] = "Forgiatura"
	L["COOKING"] = "Cucina"
	L["ENCHANTING"] = "Incantamento"
	L["ENGINEERING"] = "Ingegneria"
	L["FIRST_AID"] = "Primo Soccorso"
	L["FISHING"] = "Pesca"
	L["HERBALISM"] = "Erbalismo"
	L["INSCRIPTION"] = "Runografia"
	L["JEWELCRAFTING"] = "Oreficeria"
	L["LEATHERWORKING"] = "Conciatura"
	L["MINING"] = "Estrazione"
	L["SKINNING"] = "Scuoiatura"
	L["TAILORING"] = "Sartoria"

	L["SpecializationArt"] = "Grafica della specializzazione"
	L["MobileIcons"] = "Icona mobile"

	L["MetalChainMaw"] = "Catena metallica – Fauci"
	L["Wildhammer"] = "Granmartello"

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Mostra tutti i tracciamenti minimappa"
	L["CVar_minimapTrackingShowAllTT"] = "Attiva opzioni aggiuntive di tracciamento minimappa."
	L["CVar_weatherDensity"] = "Densità meteo"
	L["CVar_weatherDensityTT"] = "Controlla l'intensità del meteo."
	L["CVar_AutoPushSpellToActionBar"] = "Aggiungi automaticamente incantesimi alle barre azione"
	L["CVar_AutoPushSpellToActionBarTT"] = "Determina se gli incantesimi vengono aggiunti automaticamente alle barre azione."
	L["CVar_minimapTrackingClosestOnly"] = "Tracciamento minimappa: solo il più vicino"
	L["CVar_minimapTrackingClosestOnlyTT"] = "Mostra solo l'icona tracciata più vicina per alcuni tipi di icone della minimappa."
	L["CVar_autoDismount"] = "Smonta automaticamente (terra)"
	L["CVar_autoDismountTT"] = "Ti fa smontare automaticamente dalla cavalcatura terrestre quando interagisci con determinati oggetti."

	-- Global Strings
	L["UIScale"] = UI_SCALE
	L["LockFrame"] = LOCK_FRAME
	L["ResetPosition"] = RESET_POSITION
	L["Header_Professions"] = TRADE_SKILLS
	L["Header_Map"] = WORLD_MAP
	L["Header_ActionBar"] = BINDING_HEADER_ACTIONBAR
	L["Header_Chat"] = BINDING_HEADER_CHAT
	L["Header_Misc"] = BINDING_HEADER_MISC
	L["Loading"] = LFG_LIST_LOADING
	L["Remove"] = REMOVE
	L["Add"] = ADD
	L["None"] = NONE
	L["All"] = ALL
	L["Outfit"] = TRANSMOG_OUTFIT_NAME_DEFAULT
	L["AdvancedOptions"] = ADVANCED_OPTIONS
	L["Header_Nameplates"] = NAMEPLATES_LABEL
	L["Header_Screenshot"] = BINDING_NAME_SCREENSHOT

return end

if LOCALE == "ptBR" then
	-- Brazilian Portuguese translations go here

	L["TOC_Title"] = "Artificer"
	L["TOC_Notes"] = "Uma oficina pessoal e coleção de ajustes e melhorias de interface"
	L["SLASH_ARTI1"] = "/artificer" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI2"] = "/arti" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI3"] = "/artificer" -- localized slash command
	L["SLASH_ARTI4"] = "/arti" -- localized slash command
	L["OpenSettings"] = "Abrir configurações"

	-- Headers
	L["Header_AccountSettings"] = "Configurações da conta"
	L["Header_CVars"] = "Variáveis de console (CVars)"

	--Widgets
	L["Widget_FishReelIn"] = "Recolher linha de pesca"
	L["Widget_FishReelInTT"] = "Reproduz um som quando o lançamento de pesca termina."
	L["Widget_ChromieTimeIcon"] = "Ícone Tempo da Chromie"
	L["Widget_ChromieTimeIconTT"] = "Mostra um ícone no mapa se você estiver no Tempo da Chromie (Campanhas Caminhada Temporal)."
	L["Widget_ChromieTimeIcon_NoCampaign"] = "Nenhuma Campanha de Caminhada Temporal ativa."
	L["Widget_HideMacroText"] = "Ocultar texto de macro das barras de ação"
	L["Widget_HideMacroTextTT"] = "Oculta o texto de macros nos botões das barras de ação."
	L["Widget_ArrowKeyEditbox"] = "Permitir setas no chat"
	L["Widget_ArrowKeyEditboxTT"] = "Permite mover o cursor com as setas sem pressionar Alt."
	L["Widget_OutfitIcon"] = "Bordas de trajes de transmogrificação"
	L["Widget_OutfitIconTT"] = "Exibe bordas em trajes colocados nas barras de ação."
	L["Widget_ServerNotifications"] = "Notificações do servidor como Alerta de Raide"
	L["Widget_ServerNotificationsTT"] = "Exibe notificações do servidor (ex: reinícios) como Alerta de Raide."
	L["Widget_OutfitSwapSounds"] = "Sons de troca de traje"
	L["Widget_OutfitSwapSoundsTT"] = "Selecione quais sons silenciar ao trocar de traje."
	L["Widget_OSS_Impact"] = "Impacto"
	L["Widget_OSS_STA"] = "Tipo de som A"
	L["Widget_OSS_STB"] = "Tipo de som B"
	L["Widget_OSS_STC"] = "Tipo de som C"
	L["Widget_OSS_STD"] = "Tipo de som D"
	L["Widget_HideCraftingResults"] = "Ocultar resultados de criação"
	L["Widget_HideCraftingResultsTT"] = "Oculta a janela de resultados ao criar itens."
	L["Widget_MovableCurrencyTransfer"] = "Transferência de moeda móvel"
	L["Widget_MovableCurrencyTransferTT"] = "Permite mover a janela de transferência de moeda."
	L["Widget_AddonCompartmentMover"] = "Mover compartimento de addons"
	L["Widget_AddonCompartmentMoverTT"] = "Move o compartimento de addons para cima do calendário."
	L["Widget_MinimapIcon"] = "Ícone do minimapa"
	L["Widget_MinimapIconTT"] = "Exibe um ícone clicável no minimapa para abrir as configurações."
	L["Widget_CollapseBuffs"] = "Recolher automaticamente a janela de bônus"
	L["Widget_CollapseBuffsTT"] = "Recolhe automaticamente a janela de bônus padrão."
	L["Widget_PartySync"] = "Aceitar Sincronização de Grupo automaticamente"
	L["Widget_PartySyncTT"] = "Aceita automaticamente a confirmação de Sincronização de Grupo."
	L["Widget_ChatTooltipVisibility"] = "Pré-visualização da mensagem"
	L["Widget_ChatTooltipVisibilityTT"] = "Exibe uma dica na caixa de edição para visualizar a mensagem que está sendo digitada."
	L["CurrentMessage"] = "Mensagem atual"
	L["Mouseover"] = "Ao passar o mouse"
	L["Widget_HideScreenshotText"] = "Ocultar texto de captura"
	L["Widget_HideScreenshotTextTT"] = "Oculta o texto indicando que a captura de tela foi feita."
	L["Widget_ScreenshotFormat"] = "Formato da captura"
	L["Widget_ScreenshotFormatTT"] = "Ajusta o formato da captura (PNG pode deixar alguns céus transparentes)."
	L["Widget_ScreenshotQuality"] = "Qualidade da captura"
	L["Widget_ScreenshotQualityTT"] = "Ajusta a qualidade da captura."
	L["Widget_ScreenshotSizeMultiplier"] = "Resolução da captura"
	L["Widget_ScreenshotSizeMultiplierTT"] = "Ajusta a resolução com base em um multiplicador da janela."
	L["Warning_FileSize"] = "Atenção: isso pode gerar arquivos grandes."
	L["Widget_BlockGuildInvites"] = "Bloquear convites de guilda (conta)"
	L["Widget_BlockGuildInvitesTT"] = "Configuração global para recusar automaticamente convites de guilda em todos os personagens."

	--Widgets - Account-wide settings
	L["Widget_AutoLoot"] = "Alternar Saque Automático da Conta"
	L["Widget_AutoLootTT"] = "Aplica as configurações de saque automático para toda a conta em todos os personagens."
	L["Widget_PetBattleMapFilter"] = "Alternar Filtro de Batalha de Mascotes da Conta"
	L["Widget_PetBattleMapFilterTT"] = "Aplica as configurações do filtro de batalha de mascotes para toda a conta."
	L["Widget_cooldownViewerEnabled"] = "Alternar Gerenciador de Recarga da Conta"
	L["Widget_cooldownViewerEnabledTT"] = "Aplica as configurações do Gerenciador de Recarga para toda a conta."
	L["Account_On"] = "Ativado para toda a conta"
	L["Account_Off"] = "Desativado para toda a conta"

	--Widgets - CancelAura
	L["CancelAuraManager"] = "Gerenciador de cancelamento de auras"
	L["CancelAuraManagerTT"] = "Remove automaticamente certos benefícios fora de combate."
	L["InvalidSpell"] = "ID de feitiço inválido"
	L["EnterSpellID"] = "Inserir ID de feitiço"
	L["CanceledAuras"] = "Auras canceladas"
	L["AuraHistory"] = "Histórico de auras"
	L["SpellID"] = "ID de feitiço"

	--Widgets - AbandonQuestManager
	L["AbandonQuestManager"] = "Gerenciador de abandono de missões"
	L["AbandonQuestManagerTT"] = "Abandona automaticamente missões indesejadas."
	L["InvalidQuest"] = "ID de missão inválido"
	L["EnterQuestID"] = "Inserir ID de missão"
	L["AbandonedQuests"] = "Missões abandonadas automaticamente"
	L["QuestHistory"] = "Histórico de missões"
	L["QuestID"] = "ID da missão: %s"

	--Widgets - OutfitBar
	L["OutfitSoundManager"] = "Gerenciador de sons de equipamento"
	L["OutfitSoundManagerTT"] = "Configura sons de movimento de equipamento por traje."
	L["Leather"] = "Couro"
	L["Chain"] = "Malha"
	L["Plate"] = "Placas"
	L["GearLight"] = "Equipamento leve"
	L["GearHeavy"] = "Equipamento pesado"
	L["BucklesLight"] = "Fivelas leves"
	L["BucklesHeavy"] = "Fivelas pesadas"
	L["YakRun"] = "Yak correndo"
	L["YakWalk"] = "Yak andando"
	L["GrummleRun"] = "Grumelo correndo"
	L["GrummleWalk"] = "Grumelo andando"
	L["TreasureGoblin"] = "Goblin do tesouro"
	L["SoundS"] = "Som: %s"
	L["Click"] = "Clique: %s"
	L["LeftClick"] = "Clique esquerdo: %s"
	L["RightClick"] = "Clique direito: %s"
	L["ClickDrag"] = "Clique-arrastar: %s"
	L["ConfigureSounds"] = "Configurar sons"
	L["PickUpOutfit"] = "Pegar traje"
	L["OutfitManager"] = "Gerenciador de Trajes"
	L["OutfitManagerTT"] = "Escolha um traje para vestir e configure os sons de movimento do equipamento que podem tocar para cada traje."
	L["EquipOutfit"] = "Vestir traje"
	L["Widget_MinimapRightClick"] = "Clique direito no minimapa"
	L["Widget_MinimapRightClickTT"] = "Definir a função do clique direito no minimapa"
	L["LockAppearance"] = "Travar aparência"

	--Widgets - TransmogHistory
	L["UndoTT"] = "Desfazer"
	L["RedoTT"] = "Refazer"
	L["UndoKeybindTT"] = "(Alt-Z / Shift-Z)"
	L["RedoKeybindTT"] = "(Alt-Y / Shift-Y)"
	L["RestoreSessionTT"] = "Restaurar sessão anterior"
	L["SheathWeaponTT"] = TRANSMOG_SHEATHE_WEAPON
	L["InvalidWeapoonSheathTT"] = TRANSMOG_SLOT_WARNING_NOTHING_EQUIPPED

	--Widgets - Loot History Visibility
	L["Widget_LootHistoryVisibility"] = "Visibilidade do histórico de saque"
	L["Widget_LootHistoryVisibilityTT"] = "Oculta automaticamente o histórico de saque com base na opção selecionada."
	L["Widget_LHV_None"] = NONE
	L["Widget_LHV_Solo"] = SOLO
	L["Widget_LHV_NotFull"] = "Grupo incompleto"
	L["Widget_LHV_Always"] = ALWAYS

	--Widgets - Hide Tutorials
	L["Widget_HideTutorials"] = "Ocultar tutoriais"
	L["Widget_HideTutorialsTT"] = "Força a ocultação dos tutoriais para toda a conta."

	--Widgets - NameplateTargetIndicator
	L["FNP_TargetIndicator"] = "Indicador de alvo em placas de nome amigáveis"
	L["FNP_TargetIndicatorTT"] = "Exibe um ícone na placa de nome de um jogador amigável que está mirando em você."
	L["FNP_HeroTalentRing"] = "Anel de Talento Heroico"
	L["FNP_ArtificerEye"] = "Olho do Artífice"
	L["FNP_LFGEye"] = "Olho do LFG"
	L["FNP_DragIcon"] = "Arrastar ícone relativo à placa de nome"
	L["FNP_IconStyle"] = "Estilo do ícone"
	L["FNP_IconSize"] = "Tamanho do ícone"
	L["FNP_IconColor"] = "Cor do ícone"
	L["LC_OpenColorPicker"] = "Clique esquerdo: Abrir seletor de cores"
	L["RC_OpenDropdown"] = "Clique direito: Configurações adicionais"
	L["ColorOptions"] = "Opções de cor"
	L["CopyColor"] = "Copiar cor"
	L["PasteColor"] = "Colar cor"

	--Widgets - NameplateStatus
	L["FNP_StatusIndicator"] = "Indicador de status em placas de nome amigáveis"
	L["FNP_StatusIndicatorTT"] = "Exibe um ícone na placa de nome do status de um jogador amigável."
	L["FNP_StatusOptions"] = PLAYER_STATUS
	L["FNP_StatusConnection"] = "Conexão (AFK/DND/DC)"
	L["FNP_StatusChromie"] = "Tempo da Chromie"
	L["FNP_StatusGroup"] = PARTY_MEMBERS
	L["FNP_StatusGuild"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriend"] = FRIENDS
	L["FNP_StatusIgnored"] = IGNORED
	L["FNP_StatusConnectionDCd"] = "Desconectado"
	L["FNP_StatusConnectionAway"] = CHAT_MSG_AFK
	L["FNP_StatusConnectionDND"] = DND
	L["FNP_StatusGroupMember"] = GROUP
	L["FNP_StatusGroupAssist"] = RAID_ASSISTANT
	L["FNP_StatusGroupLeader"] = LEADER
	L["FNP_StatusGuildMember"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriendChar"] = FRIENDS .. " - " .. CHARACTER
	L["FNP_StatusFriendAcc"] = FRIENDS .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT
	L["FNP_StatusFriendBNet"] = FRIENDS .. " - " .. BATTLETAG
	L["FNP_StatusIgnoredChar"] = IGNORED .. " - " .. CHARACTER
	L["FNP_StatusIgnoredAcc"] = IGNORED .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT

	--Widgets - Account Ignore List
	L["Widget_AccountIgnoreList"] = "Janela da lista de ignorados da conta"
	L["Widget_AccountIgnoreListTT"] = "Exibe uma janela contendo todos os ignorados registrados na conta."
	L["AccountIgnoreList"] = "Lista de ignorados da conta"

	--Widgets - PreyBar
	L["Widget_PreyBar"] = "Indicadores de progresso da presa"
	L["Widget_PreyBarTT"] = "Exibe progresso alternativo da presa ao lado do widget Caçada da Presa."
	L["PreyBar_Style_Row"] = "Linha"
	L["PreyBar_Style_Statusbar"] = "Barra de status"
	L["PreyBar_Position"] = "Posição"
	L["PreyBar_PositionTT"] = "A qual lado do widget anexar."
	L["PreyBar_Style"] = UNIT_NAMEPLATES_STYLE
	L["PreyBar_Style_Corner"] = RAID_TARGET_4
	L["PreyBar_Position_Top"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_TOP
	L["PreyBar_Position_Bottom"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_BOTTOM
	L["PreyBar_Position_Left"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_LEFT
	L["PreyBar_Position_Right"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_RIGHT
	L["PreyBar_HideBlizzWidget"] = "Ocultar widget de presa da Blizzard"
	L["PreyBar_HideInCombat"] = "Ocultar em combate"

	L["EncounterBar"] = HUD_EDIT_MODE_ENCOUNTER_BAR_LABEL

	L["Header_Combat"] = COMBAT_LABEL
	L["Widget_SpellAlerts"] = COMBAT_TEXT_SHOW_REACTIVES_TEXT
	L["Widget_SpellAlertsTT"] = "Filtra alertas de feitiços específicos que aparecem na tela.\n\nRequer que os alertas de feitiços estejam ativados."

	--Widgets - BlockTrades
	L["Widget_BlockTrades"] = "Bloquear trocas durante a transmogrificação"
	L["Widget_BlockTradesTT"] = "Bloqueia todas as trocas enquanto a janela de transmogrificação estiver aberta."
	L["Widget_OutfitLinkOnClose"] = "Vincular traje ao fechar a transmogrificação"
	L["Widget_OutfitLinkOnCloseTT"] = "Vincula automaticamente no chat o traje atualmente visualizado ao fechar a janela de transmogrificação."
	L["Widget_OutfitLinkOnClose_LastViewedOutfit"] = "Último traje visualizado: %s"

	--Widgets - MapAmbience
	L["Widget_MapAmbience_QD"] = "Reduzir volume ambiente em Quel'danas"
	L["Widget_MapAmbience_QDTT"] = "Reduz o volume ambiente em Quel'danas em aproximadamente 25% do volume ambiente atual."

	--Widgets - DamageMeter
	L["Widget_DamageMeter"] = DAMAGE_METER_LABEL
	L["Widget_DamageMeterTT"] = "Aplica configurações de conta para a visibilidade do medidor de dano em todos os personagens."
	L["Widget_DamageWipe"] = AUTO_RESET_DAMAGE_METER
	L["Widget_DamageWipeTT"] = "Aplica configurações de conta para redefinir o medidor de dano em todos os personagens."

	--Widgets - Account-wide settings
	L["Header_ObjectiveTracker"] = HUD_EDIT_MODE_OBJECTIVE_TRACKER_LABEL
	L["Widget_AutoCollapseTracker"] = "Recolher automaticamente o rastreador de objetivos"
	L["Widget_AutoCollapseTrackerTT"] = "Minimiza automaticamente o rastreador de objetivos sob certas condições."
	L["Widget_AutoFadeObjectiveTracker"] = "Esmaecer rastreador de objetivos automaticamente"
	L["Widget_AutoFadeObjectiveTrackerTT"] = "Esmaece automaticamente o rastreador de objetivos sob certas condições."
	L["Widget_ACT_RestedArea"] = "Área de descanso"
	L["Widget_ACT_Combat"] = COMBAT
	L["Widget_ACT_PetBattles"] = SHOW_PET_BATTLES_ON_MAP_TEXT
	L["Widget_ACT_Battlegrounds"] = BATTLEFIELDS
	L["Widget_ACT_Arena"] = ARENA
	L["Widget_ACT_Dungeon"] = LFG_TYPE_DUNGEON
	L["Widget_ACT_MPlus"] = PLAYER_DIFFICULTY_MYTHIC_PLUS
	L["Widget_ACT_Raids"] = RAID
	L["Widget_ACT_ScenariosDelves"] = SCENARIOS_PVEFRAME .. "/" .. DELVES_LABEL
	L["Widget_ACT_Housing"] = BINDING_HEADER_HOUSING_SYSTEM

	--Widgets - Delete Confirm
	L["Widget_DeleteConfirm"] = "Preencher texto de exclusão de item"
	L["Widget_DeleteConfirmTT"] = string.format("Botão para preencher o texto '%s', com função subsequente para excluir o item no segundo clique.", DELETE_ITEM_CONFIRM_STRING)
	L["Widget_DeleteConfirm_ButtonTT"] = string.format("Clique 1: Preencher o texto '%s'.\n\nClique 2: Excluir item.", DELETE_ITEM_CONFIRM_STRING)

	--Widgets - ProfessionToasts
	L["Widget_ProfessionToasts"] = "Notificações de profissão"
	L["Widget_ProfessionToastsTT"] = "Exibe uma notificação com fade ao subir o nível de uma habilidade de profissão."
	L["FrameWidth"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_WIDTH
	L["FrameHeight"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_HEIGHT
	L["FontSize"] = FONT_SIZE
	L["FontColor"] = "Cor da fonte"
	L["BorderColor"] = EMBLEM_BORDER_COLOR
	L["BackgroundColor"] = "Cor de fundo"
	L["BorderStyle"] = "Estilo da borda"
	L["BackgroundStyle"] = "Estilo do fundo"
	L["SingleLine"] = "Nível de profissão em linha única"
	L["PlaySound"] = COOLDOWN_VIEWER_SETTINGS_ALERT_MENU_BUTTON_TOOLTIP_PREVIEW
	L["Desaturate"] = "Dessaturado"

	L["BorderStyle_housingcontainer"] = "Contêiner de habitação"
	L["BorderStyle_shopheader"] = "Cabeçalho da loja"
	L["BorderStyle_questtracker"] = "Rastreador de missões"
	L["BorderStyle_achievementalert"] = "Alerta de conquista"
	L["BorderStyle_shipmisson"] = "Missão de navio"
	L["BorderStyle_housingitem"] = "Item de habitação"
	L["BorderStyle_artifactlevel"] = "Nível do artefato"
	L["BorderStyle_shoptoast"] = "Notificação da loja"
	L["BorderStyle_legioninvasion"] = "Título da invasão da Legião"
	L["BorderStyle_lootroll"] = "Rolagem de saque"
	L["BorderStyle_activities"] = "Atividades"
	L["BorderStyle_midnightscenariotitle"] = "Título de cenário Midnight"
	L["BorderStyle_thewarwithinscenariotitle"] = "Título de cenário The War Within"
	L["BorderStyle_dragonflightscenariotitle"] = "Título de cenário Dragonflight"
	L["BorderStyle_dragonflightscenarioframe"] = "Janela de cenário Dragonflight"
	L["BorderStyle_evergreenscenariotitle"] = "Título de cenário Evergreen"

	-- Professions - official translations
	L["ALCHEMY"] = "Alquimia"
	L["ARCHAEOLOGY"] = "Arqueologia"
	L["BLACKSMITHING"] = "Ferraria"
	L["COOKING"] = "Culinária"
	L["ENCHANTING"] = "Encantamento"
	L["ENGINEERING"] = "Engenharia"
	L["FIRST_AID"] = "Primeiros socorros"
	L["FISHING"] = "Pesca"
	L["HERBALISM"] = "Herborismo"
	L["INSCRIPTION"] = "Escrivania"
	L["JEWELCRAFTING"] = "Joalheria"
	L["LEATHERWORKING"] = "Couraria"
	L["MINING"] = "Mineração"
	L["SKINNING"] = "Esfolamento"
	L["TAILORING"] = "Alfaiataria"

	L["SpecializationArt"] = "Arte da especialização"
	L["MobileIcons"] = "Ícone móvel"

	L["MetalChainMaw"] = "Corrente de metal – Mandíbulas"
	L["Wildhammer"] = "Martelo Feroz"

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Mostrar todos os rastreamentos do minimapa"
	L["CVar_minimapTrackingShowAllTT"] = "Ativa opções adicionais de rastreamento do minimapa."
	L["CVar_weatherDensity"] = "Densidade do clima"
	L["CVar_weatherDensityTT"] = "Controla a intensidade do clima."
	L["CVar_AutoPushSpellToActionBar"] = "Adicionar feitiços automaticamente às barras de ação"
	L["CVar_AutoPushSpellToActionBarTT"] = "Define se feitiços são adicionados automaticamente às barras de ação."
	L["CVar_minimapTrackingClosestOnly"] = "Rastreamento do minimapa: apenas o mais próximo"
	L["CVar_minimapTrackingClosestOnlyTT"] = "Mostra apenas o ícone rastreado mais próximo para certos tipos de ícones do minimapa."
	L["CVar_autoDismount"] = "Desmontar automaticamente (Terrestre)"
	L["CVar_autoDismountTT"] = "Desmonta automaticamente da sua montaria terrestre ao interagir com certos objetos."

	-- Global Strings
	L["UIScale"] = UI_SCALE
	L["LockFrame"] = LOCK_FRAME
	L["ResetPosition"] = RESET_POSITION
	L["Header_Professions"] = TRADE_SKILLS
	L["Header_Map"] = WORLD_MAP
	L["Header_ActionBar"] = BINDING_HEADER_ACTIONBAR
	L["Header_Chat"] = BINDING_HEADER_CHAT
	L["Header_Misc"] = BINDING_HEADER_MISC
	L["Loading"] = LFG_LIST_LOADING
	L["Remove"] = REMOVE
	L["Add"] = ADD
	L["None"] = NONE
	L["All"] = ALL
	L["Outfit"] = TRANSMOG_OUTFIT_NAME_DEFAULT
	L["AdvancedOptions"] = ADVANCED_OPTIONS
	L["Header_Nameplates"] = NAMEPLATES_LABEL
	L["Header_Screenshot"] = BINDING_NAME_SCREENSHOT

-- Note that the EU Portuguese WoW client also
-- uses the Brazilian Portuguese locale code.
return end

if LOCALE == "ruRU" then
	-- Russian translations go here

	L["TOC_Title"] = "ремесленник (Artificer)"
	L["TOC_Notes"] = "Личная мастерская и набор улучшений интерфейса"
	L["SLASH_ARTI1"] = "/artificer" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI2"] = "/arti" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI3"] = "/ремесленник" -- localized slash command
	L["SLASH_ARTI4"] = "/ремесленник" -- localized slash command
	L["OpenSettings"] = "Открыть настройки"

	-- Headers
	L["Header_AccountSettings"] = "Настройки аккаунта"
	L["Header_CVars"] = "Консольные переменные (CVars)"

	--Widgets
	L["Widget_FishReelIn"] = "Подсечка рыбы"
	L["Widget_FishReelInTT"] = "Проигрывает звук, когда заброс удочки завершается."
	L["Widget_ChromieTimeIcon"] = "Значок времени Хроми"
	L["Widget_ChromieTimeIconTT"] = "Показывает значок на карте, если вы находитесь во времени Хроми (кампании путешествий во времени)."
	L["Widget_ChromieTimeIcon_NoCampaign"] = "Сейчас нет активной кампании путешествий во времени."
	L["Widget_HideMacroText"] = "Скрыть текст макросов на панелях"
	L["Widget_HideMacroTextTT"] = "Скрывает текст макросов на кнопках панелей действий."
	L["Widget_ArrowKeyEditbox"] = "Разрешить стрелки в окне чата"
	L["Widget_ArrowKeyEditboxTT"] = "Позволяет перемещать курсор стрелками без нажатия Alt."
	L["Widget_OutfitIcon"] = "Рамки наборов трансмогрификации"
	L["Widget_OutfitIconTT"] = "Показывает рамки наборов трансмогрификации на панелях действий."
	L["Widget_ServerNotifications"] = "Уведомления сервера как предупреждение рейда"
	L["Widget_ServerNotificationsTT"] = "Показывает уведомления сервера (например, перезапуск) как предупреждение рейда."
	L["Widget_OutfitSwapSounds"] = "Звуки смены набора"
	L["Widget_OutfitSwapSoundsTT"] = "Выберите, какие звуки отключать при смене набора."
	L["Widget_OSS_Impact"] = "Удар"
	L["Widget_OSS_STA"] = "Тип звука A"
	L["Widget_OSS_STB"] = "Тип звука B"
	L["Widget_OSS_STC"] = "Тип звука C"
	L["Widget_OSS_STD"] = "Тип звука D"
	L["Widget_HideCraftingResults"] = "Скрыть результаты создания"
	L["Widget_HideCraftingResultsTT"] = "Скрывает окно результатов при создании предметов."
	L["Widget_MovableCurrencyTransfer"] = "Перемещаемое окно перевода валюты"
	L["Widget_MovableCurrencyTransferTT"] = "Позволяет перемещать окно перевода валюты."
	L["Widget_AddonCompartmentMover"] = "Переместить отсек аддонов"
	L["Widget_AddonCompartmentMoverTT"] = "Перемещает отсек аддонов над кнопкой календаря."
	L["Widget_MinimapIcon"] = "Значок миникарты"
	L["Widget_MinimapIconTT"] = "Показывает кликабельный значок на миникарте для открытия настроек."
	L["Widget_CollapseBuffs"] = "Автоматически сворачивать окно эффектов"
	L["Widget_CollapseBuffsTT"] = "Автоматически сворачивает стандартное окно эффектов."
	L["Widget_PartySync"] = "Автоматически принимать синхронизацию группы"
	L["Widget_PartySyncTT"] = "Автоматически принимает подтверждение синхронизации группы."
	L["Widget_ChatTooltipVisibility"] = "Предпросмотр сообщения чата"
	L["Widget_ChatTooltipVisibilityTT"] = "Показывает подсказку в поле ввода для предпросмотра редактируемого сообщения."
	L["CurrentMessage"] = "Текущее сообщение"
	L["Mouseover"] = "При наведении"
	L["Widget_HideScreenshotText"] = "Скрыть текст скриншота"
	L["Widget_HideScreenshotTextTT"] = "Скрывает текст о создании скриншота."
	L["Widget_ScreenshotFormat"] = "Формат скриншота"
	L["Widget_ScreenshotFormatTT"] = "Изменяет формат скриншота (PNG может делать небо прозрачным)."
	L["Widget_ScreenshotQuality"] = "Качество скриншота"
	L["Widget_ScreenshotQualityTT"] = "Изменяет качество скриншота."
	L["Widget_ScreenshotSizeMultiplier"] = "Разрешение скриншота"
	L["Widget_ScreenshotSizeMultiplierTT"] = "Изменяет разрешение на основе множителя окна."
	L["Warning_FileSize"] = "Внимание: это может увеличить размер файла."
	L["Widget_BlockGuildInvites"] = "Блокировать приглашения в гильдию (аккаунт)"
	L["Widget_BlockGuildInvitesTT"] = "Глобальная настройка для автоматического отклонения приглашений в гильдию на всех персонажах."

	--Widgets - Account-wide settings
	L["Widget_AutoLoot"] = "Переключить автосбор добычи для аккаунта"
	L["Widget_AutoLootTT"] = "Применяет настройки автосбора добычи ко всем персонажам аккаунта."
	L["Widget_PetBattleMapFilter"] = "Переключить фильтр карты боёв питомцев для аккаунта"
	L["Widget_PetBattleMapFilterTT"] = "Применяет настройки фильтра карты боёв питомцев ко всем персонажам аккаунта."
	L["Widget_cooldownViewerEnabled"] = "Переключить менеджер восстановления для аккаунта"
	L["Widget_cooldownViewerEnabledTT"] = "Применяет настройки менеджера восстановления ко всем персонажам аккаунта."
	L["Account_On"] = "Включено для всего аккаунта"
	L["Account_Off"] = "Отключено для всего аккаунта"

	--Widgets - CancelAura
	L["CancelAuraManager"] = "Менеджер отмены аур"
	L["CancelAuraManagerTT"] = "Автоматически снимает определённые эффекты вне боя."
	L["InvalidSpell"] = "Неверный ID заклинания"
	L["EnterSpellID"] = "Введите ID заклинания"
	L["CanceledAuras"] = "Снятые ауры"
	L["AuraHistory"] = "История аур"
	L["SpellID"] = "ID заклинания"

	--Widgets - AbandonQuestManager
	L["AbandonQuestManager"] = "Менеджер отмены заданий"
	L["AbandonQuestManagerTT"] = "Автоматически отменяет нежелательные задания."
	L["InvalidQuest"] = "Неверный ID задания"
	L["EnterQuestID"] = "Введите ID задания"
	L["AbandonedQuests"] = "Автоотменённые задания"
	L["QuestHistory"] = "История заданий"
	L["QuestID"] = "ID задания: %s"

	--Widgets - OutfitBar
	L["OutfitSoundManager"] = "Менеджер звуков экипировки"
	L["OutfitSoundManagerTT"] = "Настройка звуков движения экипировки для каждого набора."
	L["Leather"] = "Кожа"
	L["Chain"] = "Кольчуга"
	L["Plate"] = "Латы"
	L["GearLight"] = "Лёгкая экипировка"
	L["GearHeavy"] = "Тяжёлая экипировка"
	L["BucklesLight"] = "Лёгкие пряжки"
	L["BucklesHeavy"] = "Тяжёлые пряжки"
	L["YakRun"] = "Як бежит"
	L["YakWalk"] = "Як идёт"
	L["GrummleRun"] = "Груммль бежит"
	L["GrummleWalk"] = "Груммль идёт"
	L["TreasureGoblin"] = "Гоблин-сокровищник"
	L["SoundS"] = "Звук: %s"
	L["Click"] = "Щелчок: %s"
	L["LeftClick"] = "ЛКМ: %s"
	L["RightClick"] = "ПКМ: %s"
	L["ClickDrag"] = "Клик и перетаскивание: %s"
	L["ConfigureSounds"] = "Настроить звуки"
	L["PickUpOutfit"] = "Взять набор"
	L["OutfitManager"] = "Менеджер нарядов"
	L["OutfitManagerTT"] = "Выберите наряд для экипировки и настройте звуки движения снаряжения, которые могут воспроизводиться для каждого наряда."
	L["EquipOutfit"] = "Надеть наряд"
	L["Widget_MinimapRightClick"] = "Правый клик по миникарте"
	L["Widget_MinimapRightClickTT"] = "Настроить функцию правого клика по миникарте"
	L["LockAppearance"] = "Закрепить внешний вид"

	--Widgets - TransmogHistory
	L["UndoTT"] = "Отменить"
	L["RedoTT"] = "Повторить"
	L["UndoKeybindTT"] = "(Alt-Z / Shift-Z)"
	L["RedoKeybindTT"] = "(Alt-Y / Shift-Y)"
	L["RestoreSessionTT"] = "Восстановить предыдущую сессию"
	L["SheathWeaponTT"] = TRANSMOG_SHEATHE_WEAPON
	L["InvalidWeapoonSheathTT"] = TRANSMOG_SLOT_WARNING_NOTHING_EQUIPPED

	--Widgets - Loot History Visibility
	L["Widget_LootHistoryVisibility"] = "Видимость истории добычи"
	L["Widget_LootHistoryVisibilityTT"] = "Автоматически скрывать историю добычи в зависимости от выбранной опции."
	L["Widget_LHV_None"] = NONE
	L["Widget_LHV_Solo"] = SOLO
	L["Widget_LHV_NotFull"] = "Неполная группа"
	L["Widget_LHV_Always"] = ALWAYS

	--Widgets - Hide Tutorials
	L["Widget_HideTutorials"] = "Скрыть обучение"
	L["Widget_HideTutorialsTT"] = "Принудительно скрывает обучение для всей учетной записи."

	--Widgets - NameplateTargetIndicator
	L["FNP_TargetIndicator"] = "Индикатор цели на дружественных неймплейтах"
	L["FNP_TargetIndicatorTT"] = "Отображает значок на неймплейте дружественного игрока, который нацелился на вас."
	L["FNP_HeroTalentRing"] = "Кольцо героических талантов"
	L["FNP_ArtificerEye"] = "Глаз Артификера"
	L["FNP_LFGEye"] = "Глаз поиска группы"
	L["FNP_DragIcon"] = "Перемещение значка относительно неймплейта"
	L["FNP_IconStyle"] = "Стиль значка"
	L["FNP_IconSize"] = "Размер значка"
	L["FNP_IconColor"] = "Цвет значка"
	L["LC_OpenColorPicker"] = "ЛКМ: Открыть палитру цветов"
	L["RC_OpenDropdown"] = "ПКМ: Дополнительные настройки"
	L["ColorOptions"] = "Параметры цвета"
	L["CopyColor"] = "Копировать цвет"
	L["PasteColor"] = "Вставить цвет"

	--Widgets - NameplateStatus
	L["FNP_StatusIndicator"] = "Индикатор статуса дружественных индикаторов здоровья"
	L["FNP_StatusIndicatorTT"] = "Отображает значок статуса дружественного игрока на индикаторе здоровья."
	L["FNP_StatusOptions"] = PLAYER_STATUS
	L["FNP_StatusConnection"] = "Подключение (AFK/DND/DC)"
	L["FNP_StatusChromie"] = "Время Хроми"
	L["FNP_StatusGroup"] = PARTY_MEMBERS
	L["FNP_StatusGuild"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriend"] = FRIENDS
	L["FNP_StatusIgnored"] = IGNORED
	L["FNP_StatusConnectionDCd"] = "Отключён"
	L["FNP_StatusConnectionAway"] = CHAT_MSG_AFK
	L["FNP_StatusConnectionDND"] = DND
	L["FNP_StatusGroupMember"] = GROUP
	L["FNP_StatusGroupAssist"] = RAID_ASSISTANT
	L["FNP_StatusGroupLeader"] = LEADER
	L["FNP_StatusGuildMember"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriendChar"] = FRIENDS .. " - " .. CHARACTER
	L["FNP_StatusFriendAcc"] = FRIENDS .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT
	L["FNP_StatusFriendBNet"] = FRIENDS .. " - " .. BATTLETAG
	L["FNP_StatusIgnoredChar"] = IGNORED .. " - " .. CHARACTER
	L["FNP_StatusIgnoredAcc"] = IGNORED .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT

	--Widgets - Account Ignore List
	L["Widget_AccountIgnoreList"] = "Окно списка игнорируемых аккаунта"
	L["Widget_AccountIgnoreListTT"] = "Отображает окно со всеми сохранёнными игнорируемыми на аккаунте."
	L["AccountIgnoreList"] = "Список игнорируемых аккаунта"

	--Widgets - PreyBar
	L["Widget_PreyBar"] = "Индикаторы прогресса добычи"
	L["Widget_PreyBarTT"] = "Отображает альтернативный прогресс добычи рядом с виджетом Охота на добычу."
	L["PreyBar_Style_Row"] = "Ряд"
	L["PreyBar_Style_Statusbar"] = "Полоса состояния"
	L["PreyBar_Position"] = "Позиция"
	L["PreyBar_PositionTT"] = "К какой стороне виджета прикрепить."
	L["PreyBar_Style"] = UNIT_NAMEPLATES_STYLE
	L["PreyBar_Style_Corner"] = RAID_TARGET_4
	L["PreyBar_Position_Top"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_TOP
	L["PreyBar_Position_Bottom"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_BOTTOM
	L["PreyBar_Position_Left"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_LEFT
	L["PreyBar_Position_Right"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_RIGHT
	L["PreyBar_HideBlizzWidget"] = "Скрыть виджет добычи Blizzard"
	L["PreyBar_HideInCombat"] = "Скрывать в бою"

	L["EncounterBar"] = HUD_EDIT_MODE_ENCOUNTER_BAR_LABEL

	L["Header_Combat"] = COMBAT_LABEL
	L["Widget_SpellAlerts"] = COMBAT_TEXT_SHOW_REACTIVES_TEXT
	L["Widget_SpellAlertsTT"] = "Фильтрует определённые оповещения о заклинаниях, появляющиеся на экране.\n\nТребуется включить оповещения о заклинаниях."

	--Widgets - BlockTrades
	L["Widget_BlockTrades"] = "Блокировать обмен во время трансмогрификации"
	L["Widget_BlockTradesTT"] = "Блокирует любой обмен, пока открыто окно трансмогрификации."
	L["Widget_OutfitLinkOnClose"] = "Ссылка на комплект при закрытии трансмогрификации"
	L["Widget_OutfitLinkOnCloseTT"] = "Автоматически отправляет в чат ссылку на текущий просматриваемый комплект при закрытии окна трансмогрификации."
	L["Widget_OutfitLinkOnClose_LastViewedOutfit"] = "Последний просмотренный комплект: %s"

	--Widgets - MapAmbience
	L["Widget_MapAmbience_QD"] = "Снизить громкость окружения в Кель'Данасе"
	L["Widget_MapAmbience_QDTT"] = "Снижает громкость окружения в Кель'Данасе примерно на 25% от текущего уровня громкости окружения."

	--Widgets - DamageMeter
	L["Widget_DamageMeter"] = DAMAGE_METER_LABEL
	L["Widget_DamageMeterTT"] = "Применяет общие для аккаунта настройки видимости счётчика урона для каждого персонажа."
	L["Widget_DamageWipe"] = AUTO_RESET_DAMAGE_METER
	L["Widget_DamageWipeTT"] = "Применяет общие для аккаунта настройки сброса счётчика урона для каждого персонажа."

	--Widgets - Account-wide settings
	L["Header_ObjectiveTracker"] = HUD_EDIT_MODE_OBJECTIVE_TRACKER_LABEL
	L["Widget_AutoCollapseTracker"] = "Автоматически сворачивать отслеживание задач"
	L["Widget_AutoCollapseTrackerTT"] = "Автоматически сворачивает отслеживание задач при определённых условиях."
	L["Widget_AutoFadeObjectiveTracker"] = "Автозатухание отслеживания задач"
	L["Widget_AutoFadeObjectiveTrackerTT"] = "Автоматически затемняет отслеживание задач при определённых условиях."
	L["Widget_ACT_RestedArea"] = "Зона отдыха"
	L["Widget_ACT_Combat"] = COMBAT
	L["Widget_ACT_PetBattles"] = SHOW_PET_BATTLES_ON_MAP_TEXT
	L["Widget_ACT_Battlegrounds"] = BATTLEFIELDS
	L["Widget_ACT_Arena"] = ARENA
	L["Widget_ACT_Dungeon"] = LFG_TYPE_DUNGEON
	L["Widget_ACT_MPlus"] = PLAYER_DIFFICULTY_MYTHIC_PLUS
	L["Widget_ACT_Raids"] = RAID
	L["Widget_ACT_ScenariosDelves"] = SCENARIOS_PVEFRAME .. "/" .. DELVES_LABEL
	L["Widget_ACT_Housing"] = BINDING_HEADER_HOUSING_SYSTEM

	--Widgets - Delete Confirm
	L["Widget_DeleteConfirm"] = "Заполнить текст удаления предмета"
	L["Widget_DeleteConfirmTT"] = string.format("Кнопка для заполнения текста '%s' с последующей функцией удаления предмета при втором нажатии.", DELETE_ITEM_CONFIRM_STRING)
	L["Widget_DeleteConfirm_ButtonTT"] = string.format("Нажатие 1: Заполнить текст '%s'.\n\nНажатие 2: Удалить предмет.", DELETE_ITEM_CONFIRM_STRING)

	--Widgets - ProfessionToasts
	L["Widget_ProfessionToasts"] = "Уведомления профессий"
	L["Widget_ProfessionToastsTT"] = "Показывает плавно появляющееся уведомление при повышении уровня навыка профессии."
	L["FrameWidth"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_WIDTH
	L["FrameHeight"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_HEIGHT
	L["FontSize"] = FONT_SIZE
	L["FontColor"] = "Цвет шрифта"
	L["BorderColor"] = EMBLEM_BORDER_COLOR
	L["BackgroundColor"] = "Цвет фона"
	L["BorderStyle"] = "Стиль рамки"
	L["BackgroundStyle"] = "Стиль фона"
	L["SingleLine"] = "Уровень профессии в одну строку"
	L["PlaySound"] = COOLDOWN_VIEWER_SETTINGS_ALERT_MENU_BUTTON_TOOLTIP_PREVIEW
	L["Desaturate"] = "Обесцвеченный"

	L["BorderStyle_housingcontainer"] = "Контейнер жилья"
	L["BorderStyle_shopheader"] = "Заголовок магазина"
	L["BorderStyle_questtracker"] = "Отслеживание заданий"
	L["BorderStyle_achievementalert"] = "Уведомление о достижении"
	L["BorderStyle_shipmisson"] = "Миссия корабля"
	L["BorderStyle_housingitem"] = "Предмет жилья"
	L["BorderStyle_artifactlevel"] = "Уровень артефакта"
	L["BorderStyle_shoptoast"] = "Уведомление магазина"
	L["BorderStyle_legioninvasion"] = "Заголовок вторжения Легиона"
	L["BorderStyle_lootroll"] = "Бросок добычи"
	L["BorderStyle_activities"] = "Активности"
	L["BorderStyle_midnightscenariotitle"] = "Заголовок сценария Midnight"
	L["BorderStyle_thewarwithinscenariotitle"] = "Заголовок сценария The War Within"
	L["BorderStyle_dragonflightscenariotitle"] = "Заголовок сценария Dragonflight"
	L["BorderStyle_dragonflightscenarioframe"] = "Окно сценария Dragonflight"
	L["BorderStyle_evergreenscenariotitle"] = "Заголовок сценария Evergreen"

	-- Professions - official translations
	L["ALCHEMY"] = "Алхимия"
	L["ARCHAEOLOGY"] = "Археология"
	L["BLACKSMITHING"] = "Кузнечное дело"
	L["COOKING"] = "Кулинария"
	L["ENCHANTING"] = "Наложение чар"
	L["ENGINEERING"] = "Инженерное дело"
	L["FIRST_AID"] = "Первая помощь"
	L["FISHING"] = "Рыбная ловля"
	L["HERBALISM"] = "Травничество"
	L["INSCRIPTION"] = "Начертание"
	L["JEWELCRAFTING"] = "Ювелирное дело"
	L["LEATHERWORKING"] = "Кожевничество"
	L["MINING"] = "Горное дело"
	L["SKINNING"] = "Снятие шкур"
	L["TAILORING"] = "Портняжное дело"

	L["SpecializationArt"] = "Иллюстрация специализации"
	L["MobileIcons"] = "Мобильная иконка"

	L["MetalChainMaw"] = "Металлическая цепь — Утроба"
	L["Wildhammer"] = "Громовой Молот"

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Показать все отслеживания миникарты"
	L["CVar_minimapTrackingShowAllTT"] = "Включает дополнительные параметры отслеживания миникарты."
	L["CVar_weatherDensity"] = "Плотность погоды"
	L["CVar_weatherDensityTT"] = "Управляет интенсивностью погодных эффектов."
	L["CVar_AutoPushSpellToActionBar"] = "Автоматически добавлять заклинания на панели"
	L["CVar_AutoPushSpellToActionBarTT"] = "Определяет, будут ли заклинания автоматически добавляться на панели действий."
	L["CVar_minimapTrackingClosestOnly"] = "Отслеживание на миникарте: только ближайшее"
	L["CVar_minimapTrackingClosestOnlyTT"] = "Показывает только ближайший отслеживаемый значок для некоторых типов значков миникарты."
	L["CVar_autoDismount"] = "Автоматическое спешивание (на земле)"
	L["CVar_autoDismountTT"] = "Автоматически спешивает вас с наземного средства передвижения при взаимодействии с некоторыми объектами."

	-- Global Strings
	L["UIScale"] = UI_SCALE
	L["LockFrame"] = LOCK_FRAME
	L["ResetPosition"] = RESET_POSITION
	L["Header_Professions"] = TRADE_SKILLS
	L["Header_Map"] = WORLD_MAP
	L["Header_ActionBar"] = BINDING_HEADER_ACTIONBAR
	L["Header_Chat"] = BINDING_HEADER_CHAT
	L["Header_Misc"] = BINDING_HEADER_MISC
	L["Loading"] = LFG_LIST_LOADING
	L["Remove"] = REMOVE
	L["Add"] = ADD
	L["None"] = NONE
	L["All"] = ALL
	L["Outfit"] = TRANSMOG_OUTFIT_NAME_DEFAULT
	L["AdvancedOptions"] = ADVANCED_OPTIONS
	L["Header_Nameplates"] = NAMEPLATES_LABEL
	L["Header_Screenshot"] = BINDING_NAME_SCREENSHOT

return end

if LOCALE == "koKR" then
	-- Korean translations go here

	L["TOC_Title"] = "기술자 (Artificer)"
	L["TOC_Notes"] = "개인 작업실과 UI 조정 모음"
	L["SLASH_ARTI1"] = "/artificer" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI2"] = "/arti" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI3"] = "/기술자" -- localized slash command
	L["SLASH_ARTI4"] = "/기술자" -- localized slash command
	L["OpenSettings"] = "설정 열기"

	-- Headers
	L["Header_AccountSettings"] = "계정 설정"
	L["Header_CVars"] = "콘솔 변수 (CVars)"

	--Widgets
	L["Widget_FishReelIn"] = "낚싯줄 감기"
	L["Widget_FishReelInTT"] = "낚시 시전이 끝나면 소리를 재생합니다."
	L["Widget_ChromieTimeIcon"] = "크로미 시간 아이콘"
	L["Widget_ChromieTimeIconTT"] = "크로미 시간(시간여행 캠페인) 상태일 때 지도에 아이콘을 표시합니다."
	L["Widget_ChromieTimeIcon_NoCampaign"] = "현재 활성화된 시간여행 캠페인이 없습니다."
	L["Widget_HideMacroText"] = "행동 단축바 매크로 텍스트 숨기기"
	L["Widget_HideMacroTextTT"] = "행동 단축바 버튼의 매크로 텍스트를 숨깁니다."
	L["Widget_ArrowKeyEditbox"] = "채팅 입력창 화살표 키 허용"
	L["Widget_ArrowKeyEditboxTT"] = "Alt 없이 화살표 키로 커서를 이동할 수 있습니다."
	L["Widget_OutfitIcon"] = "형상변환 의상 테두리"
	L["Widget_OutfitIconTT"] = "행동 단축바의 형상변환 의상에 테두리를 표시합니다."
	L["Widget_ServerNotifications"] = "서버 알림 공격대 경보 표시"
	L["Widget_ServerNotificationsTT"] = "서버 알림(예: 서버 재시작)을 공격대 경보로 표시합니다."
	L["Widget_OutfitSwapSounds"] = "의상 변경 소리"
	L["Widget_OutfitSwapSoundsTT"] = "의상 변경 시 음소거할 소리를 선택합니다."
	L["Widget_OSS_Impact"] = "충돌"
	L["Widget_OSS_STA"] = "소리 유형 A"
	L["Widget_OSS_STB"] = "소리 유형 B"
	L["Widget_OSS_STC"] = "소리 유형 C"
	L["Widget_OSS_STD"] = "소리 유형 D"
	L["Widget_HideCraftingResults"] = "제작 결과 숨기기"
	L["Widget_HideCraftingResultsTT"] = "전문기술 제작 시 결과 창을 숨깁니다."
	L["Widget_MovableCurrencyTransfer"] = "화폐 이동 창 이동 가능"
	L["Widget_MovableCurrencyTransferTT"] = "화폐 이동 창을 이동할 수 있습니다."
	L["Widget_AddonCompartmentMover"] = "애드온 보관함 위치 이동"
	L["Widget_AddonCompartmentMoverTT"] = "애드온 보관함을 달력 버튼 위로 이동합니다."
	L["Widget_MinimapIcon"] = "미니맵 아이콘"
	L["Widget_MinimapIconTT"] = "설정을 열 수 있는 미니맵 아이콘을 표시합니다."
	L["Widget_CollapseBuffs"] = "버프 창 자동 축소"
	L["Widget_CollapseBuffsTT"] = "기본 버프 창을 자동으로 축소합니다."
	L["Widget_PartySync"] = "파티 동기화 자동 수락"
	L["Widget_PartySyncTT"] = "파티 동기화 확인을 자동으로 수락합니다."
	L["Widget_ChatTooltipVisibility"] = "채팅 메시지 미리보기"
	L["Widget_ChatTooltipVisibilityTT"] = "입력창에 툴팁을 표시하여 현재 작성 중인 메시지를 미리 봅니다."
	L["CurrentMessage"] = "현재 메시지"
	L["Mouseover"] = "마우스 오버"
	L["Widget_HideScreenshotText"] = "스크린샷 텍스트 숨기기"
	L["Widget_HideScreenshotTextTT"] = "스크린샷 촬영 메시지를 숨깁니다."
	L["Widget_ScreenshotFormat"] = "스크린샷 형식"
	L["Widget_ScreenshotFormatTT"] = "스크린샷 형식을 조정합니다 (PNG는 일부 하늘을 투명하게 만들 수 있음)."
	L["Widget_ScreenshotQuality"] = "스크린샷 품질"
	L["Widget_ScreenshotQualityTT"] = "스크린샷 품질을 조정합니다."
	L["Widget_ScreenshotSizeMultiplier"] = "스크린샷 해상도"
	L["Widget_ScreenshotSizeMultiplierTT"] = "창 크기 배율에 따라 해상도를 조정합니다."
	L["Warning_FileSize"] = "주의: 파일 크기가 커질 수 있습니다."
	L["Widget_BlockGuildInvites"] = "길드 초대 차단 (계정)"
	L["Widget_BlockGuildInvitesTT"] = "모든 캐릭터에서 길드 초대를 자동 거절하는 계정 설정입니다."

	--Widgets - Account-wide settings
	L["Widget_AutoLoot"] = "계정 자동 전리품 전환"
	L["Widget_AutoLootTT"] = "모든 캐릭터에 계정 전체 자동 전리품 설정을 적용합니다."
	L["Widget_PetBattleMapFilter"] = "계정 애완동물 대전 지도 필터 전환"
	L["Widget_PetBattleMapFilterTT"] = "모든 캐릭터에 계정 전체 애완동물 대전 지도 필터 설정을 적용합니다."
	L["Widget_cooldownViewerEnabled"] = "계정 재사용 대기시간 관리자 전환"
	L["Widget_cooldownViewerEnabledTT"] = "모든 캐릭터에 계정 전체 재사용 대기시간 관리자 설정을 적용합니다."
	L["Account_On"] = "계정 전체 활성화"
	L["Account_Off"] = "계정 전체 비활성화"

	--Widgets - CancelAura
	L["CancelAuraManager"] = "오라 해제 관리자"
	L["CancelAuraManagerTT"] = "전투 중이 아닐 때 특정 강화 효과를 자동으로 제거합니다."
	L["InvalidSpell"] = "잘못된 주문 ID"
	L["EnterSpellID"] = "주문 ID 입력"
	L["CanceledAuras"] = "해제된 오라"
	L["AuraHistory"] = "오라 기록"
	L["SpellID"] = "주문 ID"

	--Widgets - AbandonQuestManager
	L["AbandonQuestManager"] = "퀘스트 포기 관리자"
	L["AbandonQuestManagerTT"] = "원하지 않는 퀘스트를 자동으로 포기합니다."
	L["InvalidQuest"] = "잘못된 퀘스트 ID"
	L["EnterQuestID"] = "퀘스트 ID 입력"
	L["AbandonedQuests"] = "자동 포기 퀘스트"
	L["QuestHistory"] = "퀘스트 기록"
	L["QuestID"] = "퀘스트 ID: %s"

	--Widgets - OutfitBar
	L["OutfitSoundManager"] = "장비 소리 관리자"
	L["OutfitSoundManagerTT"] = "의상별 장비 움직임 소리를 설정합니다."
	L["Leather"] = "가죽"
	L["Chain"] = "사슬"
	L["Plate"] = "판금"
	L["GearLight"] = "가벼운 장비"
	L["GearHeavy"] = "무거운 장비"
	L["BucklesLight"] = "가벼운 버클"
	L["BucklesHeavy"] = "무거운 버클"
	L["YakRun"] = "야크 달리기"
	L["YakWalk"] = "야크 걷기"
	L["GrummleRun"] = "그럼블 달리기"
	L["GrummleWalk"] = "그럼블 걷기"
	L["TreasureGoblin"] = "보물 고블린"
	L["SoundS"] = "소리: %s"
	L["Click"] = "클릭: %s"
	L["LeftClick"] = "왼쪽 클릭: %s"
	L["RightClick"] = "오른쪽 클릭: %s"
	L["ClickDrag"] = "클릭 후 드래그: %s"
	L["ConfigureSounds"] = "소리 설정"
	L["PickUpOutfit"] = "의상 집기"
	L["OutfitManager"] = "의상 관리"
	L["OutfitManagerTT"] = "착용할 의상을 선택하고 각 의상에 대해 재생될 수 있는 장비 움직임 소리를 설정합니다."
	L["EquipOutfit"] = "의상 착용"
	L["Widget_MinimapRightClick"] = "미니맵 오른쪽 클릭"
	L["Widget_MinimapRightClickTT"] = "미니맵 오른쪽 클릭 기능 설정"
	L["LockAppearance"] = "형상 고정"

	--Widgets - TransmogHistory
	L["UndoTT"] = "실행 취소"
	L["RedoTT"] = "다시 실행"
	L["UndoKeybindTT"] = "(Alt-Z / Shift-Z)"
	L["RedoKeybindTT"] = "(Alt-Y / Shift-Y)"
	L["RestoreSessionTT"] = "이전 세션 복원"
	L["SheathWeaponTT"] = TRANSMOG_SHEATHE_WEAPON
	L["InvalidWeapoonSheathTT"] = TRANSMOG_SLOT_WARNING_NOTHING_EQUIPPED

	--Widgets - Loot History Visibility
	L["Widget_LootHistoryVisibility"] = "전리품 기록 표시"
	L["Widget_LootHistoryVisibilityTT"] = "선택한 옵션에 따라 전리품 기록을 자동으로 숨깁니다."
	L["Widget_LHV_None"] = NONE
	L["Widget_LHV_Solo"] = SOLO
	L["Widget_LHV_NotFull"] = "전체 인원 아님"
	L["Widget_LHV_Always"] = ALWAYS

	--Widgets - Hide Tutorials
	L["Widget_HideTutorials"] = "튜토리얼 숨기기"
	L["Widget_HideTutorialsTT"] = "계정 전체에서 튜토리얼을 숨기도록 강제합니다."

	--Widgets - NameplateTargetIndicator
	L["FNP_TargetIndicator"] = "아군 이름표 대상 표시기"
	L["FNP_TargetIndicatorTT"] = "당신을 대상으로 하는 아군 플레이어의 이름표에 아이콘을 표시합니다."
	L["FNP_HeroTalentRing"] = "영웅 특성 반지"
	L["FNP_ArtificerEye"] = "아티피서의 눈"
	L["FNP_LFGEye"] = "파티 찾기 눈"
	L["FNP_DragIcon"] = "이름표 기준 아이콘 드래그"
	L["FNP_IconStyle"] = "아이콘 스타일"
	L["FNP_IconSize"] = "아이콘 크기"
	L["FNP_IconColor"] = "아이콘 색상"
	L["LC_OpenColorPicker"] = "좌클릭: 색상 선택기 열기"
	L["RC_OpenDropdown"] = "우클릭: 추가 설정"
	L["ColorOptions"] = "색상 옵션"
	L["CopyColor"] = "색상 복사"
	L["PasteColor"] = "색상 붙여넣기"

	--Widgets - NameplateStatus
	L["FNP_StatusIndicator"] = "아군 이름표 상태 표시기"
	L["FNP_StatusIndicatorTT"] = "아군 플레이어 상태의 이름표에 아이콘을 표시합니다."
	L["FNP_StatusOptions"] = PLAYER_STATUS
	L["FNP_StatusConnection"] = "접속 상태 (자리비움/방해 금지/접속 종료)"
	L["FNP_StatusChromie"] = "크로미의 시간"
	L["FNP_StatusGroup"] = PARTY_MEMBERS
	L["FNP_StatusGuild"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriend"] = FRIENDS
	L["FNP_StatusIgnored"] = IGNORED
	L["FNP_StatusConnectionDCd"] = "접속 종료"
	L["FNP_StatusConnectionAway"] = CHAT_MSG_AFK
	L["FNP_StatusConnectionDND"] = DND
	L["FNP_StatusGroupMember"] = GROUP
	L["FNP_StatusGroupAssist"] = RAID_ASSISTANT
	L["FNP_StatusGroupLeader"] = LEADER
	L["FNP_StatusGuildMember"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriendChar"] = FRIENDS .. " - " .. CHARACTER
	L["FNP_StatusFriendAcc"] = FRIENDS .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT
	L["FNP_StatusFriendBNet"] = FRIENDS .. " - " .. BATTLETAG
	L["FNP_StatusIgnoredChar"] = IGNORED .. " - " .. CHARACTER
	L["FNP_StatusIgnoredAcc"] = IGNORED .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT

	--Widgets - Account Ignore List
	L["Widget_AccountIgnoreList"] = "계정 차단 목록 창"
	L["Widget_AccountIgnoreListTT"] = "계정에 기록된 모든 차단 목록을 포함한 창을 표시합니다."
	L["AccountIgnoreList"] = "계정 차단 목록"

	--Widgets - PreyBar
	L["Widget_PreyBar"] = "먹이 진행 표시기"
	L["Widget_PreyBarTT"] = "먹이 사냥 위젯 옆에 대체 먹이 진행 상황을 표시합니다."
	L["PreyBar_Style_Row"] = "행"
	L["PreyBar_Style_Statusbar"] = "상태 바"
	L["PreyBar_Position"] = "위치"
	L["PreyBar_PositionTT"] = "위젯의 어느 쪽에 부착할지 선택합니다."
	L["PreyBar_Style"] = UNIT_NAMEPLATES_STYLE
	L["PreyBar_Style_Corner"] = RAID_TARGET_4
	L["PreyBar_Position_Top"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_TOP
	L["PreyBar_Position_Bottom"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_BOTTOM
	L["PreyBar_Position_Left"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_LEFT
	L["PreyBar_Position_Right"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_RIGHT
	L["PreyBar_HideBlizzWidget"] = "블리자드 사냥감 위젯 숨기기"
	L["PreyBar_HideInCombat"] = "전투 중 숨기기"

	L["EncounterBar"] = HUD_EDIT_MODE_ENCOUNTER_BAR_LABEL

	L["Header_Combat"] = COMBAT_LABEL
	L["Widget_SpellAlerts"] = COMBAT_TEXT_SHOW_REACTIVES_TEXT
	L["Widget_SpellAlertsTT"] = "화면에 표시되는 특정 주문 알림을 필터링합니다.\n\n주문 알림이 활성화되어 있어야 합니다."

	--Widgets - BlockTrades
	L["Widget_BlockTrades"] = "형상변환 중 거래 차단"
	L["Widget_BlockTradesTT"] = "형상변환 창이 열려 있는 동안 모든 거래를 차단합니다."
	L["Widget_OutfitLinkOnClose"] = "형상변환 닫기 시 의상 링크"
	L["Widget_OutfitLinkOnCloseTT"] = "형상변환 창을 닫을 때 현재 보고 있는 의상을 채팅에 자동으로 링크합니다."
	L["Widget_OutfitLinkOnClose_LastViewedOutfit"] = "마지막으로 본 의상: %s"

	--Widgets - MapAmbience
	L["Widget_MapAmbience_QD"] = "쿠엘다나스 환경음 감소"
	L["Widget_MapAmbience_QDTT"] = "쿠엘다나스의 환경음 볼륨을 현재 환경음 볼륨의 약 25%만큼 줄입니다."

	--Widgets - DamageMeter
	L["Widget_DamageMeter"] = DAMAGE_METER_LABEL
	L["Widget_DamageMeterTT"] = "모든 캐릭터에 대해 피해 미터 표시 여부를 계정 전체 설정으로 적용합니다."
	L["Widget_DamageWipe"] = AUTO_RESET_DAMAGE_METER
	L["Widget_DamageWipeTT"] = "모든 캐릭터에 대해 피해 미터 초기화 설정을 계정 전체 설정으로 적용합니다."

	--Widgets - Account-wide settings
	L["Header_ObjectiveTracker"] = HUD_EDIT_MODE_OBJECTIVE_TRACKER_LABEL
	L["Widget_AutoCollapseTracker"] = "목표 추적 자동 축소"
	L["Widget_AutoCollapseTrackerTT"] = "특정 조건에서 목표 추적을 자동으로 최소화합니다."
	L["Widget_AutoFadeObjectiveTracker"] = "목표 추적기 자동 페이드"
	L["Widget_AutoFadeObjectiveTrackerTT"] = "특정 조건에서 목표 추적기를 자동으로 흐리게 합니다."
	L["Widget_ACT_RestedArea"] = "휴식 지역"
	L["Widget_ACT_Combat"] = COMBAT
	L["Widget_ACT_PetBattles"] = SHOW_PET_BATTLES_ON_MAP_TEXT
	L["Widget_ACT_Battlegrounds"] = BATTLEFIELDS
	L["Widget_ACT_Arena"] = ARENA
	L["Widget_ACT_Dungeon"] = LFG_TYPE_DUNGEON
	L["Widget_ACT_MPlus"] = PLAYER_DIFFICULTY_MYTHIC_PLUS
	L["Widget_ACT_Raids"] = RAID
	L["Widget_ACT_ScenariosDelves"] = SCENARIOS_PVEFRAME .. "/" .. DELVES_LABEL
	L["Widget_ACT_Housing"] = BINDING_HEADER_HOUSING_SYSTEM

	--Widgets - Delete Confirm
	L["Widget_DeleteConfirm"] = "아이템 삭제 텍스트 채우기"
	L["Widget_DeleteConfirmTT"] = string.format("'%s' 텍스트를 채우는 버튼이며, 두 번째 클릭 시 아이템을 삭제합니다.", DELETE_ITEM_CONFIRM_STRING)
	L["Widget_DeleteConfirm_ButtonTT"] = string.format("클릭 1: '%s' 텍스트 채우기.\n\n클릭 2: 아이템 삭제.", DELETE_ITEM_CONFIRM_STRING)

	--Widgets - ProfessionToasts
	L["Widget_ProfessionToasts"] = "전문 기술 알림"
	L["Widget_ProfessionToastsTT"] = "전문 기술 숙련도가 상승할 때 페이드 인 알림을 표시합니다."
	L["FrameWidth"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_WIDTH
	L["FrameHeight"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_HEIGHT
	L["FontSize"] = FONT_SIZE
	L["FontColor"] = "글자 색상"
	L["BorderColor"] = EMBLEM_BORDER_COLOR
	L["BackgroundColor"] = "배경 색상"
	L["BorderStyle"] = "테두리 스타일"
	L["BackgroundStyle"] = "배경 스타일"
	L["SingleLine"] = "단일 줄 전문 기술 레벨"
	L["PlaySound"] = COOLDOWN_VIEWER_SETTINGS_ALERT_MENU_BUTTON_TOOLTIP_PREVIEW
	L["Desaturate"] = "탈채색"

	L["BorderStyle_housingcontainer"] = "하우징 컨테이너"
	L["BorderStyle_shopheader"] = "상점 헤더"
	L["BorderStyle_questtracker"] = "퀘스트 추적기"
	L["BorderStyle_achievementalert"] = "업적 알림"
	L["BorderStyle_shipmisson"] = "함선 임무"
	L["BorderStyle_housingitem"] = "하우징 아이템"
	L["BorderStyle_artifactlevel"] = "유물 레벨"
	L["BorderStyle_shoptoast"] = "상점 알림"
	L["BorderStyle_legioninvasion"] = "군단 침공 제목"
	L["BorderStyle_lootroll"] = "전리품 주사위"
	L["BorderStyle_activities"] = "활동"
	L["BorderStyle_midnightscenariotitle"] = "Midnight 시나리오 제목"
	L["BorderStyle_thewarwithinscenariotitle"] = "The War Within 시나리오 제목"
	L["BorderStyle_dragonflightscenariotitle"] = "Dragonflight 시나리오 제목"
	L["BorderStyle_dragonflightscenarioframe"] = "Dragonflight 시나리오 창"
	L["BorderStyle_evergreenscenariotitle"] = "Evergreen 시나리오 제목"

	-- Professions - official translations
	L["ALCHEMY"] = "연금술"
	L["ARCHAEOLOGY"] = "고고학"
	L["BLACKSMITHING"] = "대장기술"
	L["COOKING"] = "요리"
	L["ENCHANTING"] = "마법부여"
	L["ENGINEERING"] = "기계공학"
	L["FIRST_AID"] = "응급치료"
	L["FISHING"] = "낚시"
	L["HERBALISM"] = "약초채집"
	L["INSCRIPTION"] = "주문각인"
	L["JEWELCRAFTING"] = "보석세공"
	L["LEATHERWORKING"] = "가죽세공"
	L["MINING"] = "채광"
	L["SKINNING"] = "무두질"
	L["TAILORING"] = "재봉술"

	L["SpecializationArt"] = "전문화 아트"
	L["MobileIcons"] = "모바일 아이콘"

	L["MetalChainMaw"] = "금속 사슬 - 나락"
	L["Wildhammer"] = "와일드해머"

	--CVars
	L["CVar_minimapTrackingShowAll"] = "미니맵 추적 모두 표시"
	L["CVar_minimapTrackingShowAllTT"] = "추가 미니맵 추적 옵션을 활성화합니다."
	L["CVar_weatherDensity"] = "날씨 밀도"
	L["CVar_weatherDensityTT"] = "날씨 효과 강도를 조절합니다."
	L["CVar_AutoPushSpellToActionBar"] = "주문 자동 행동 단축바 추가"
	L["CVar_AutoPushSpellToActionBarTT"] = "주문을 행동 단축바에 자동으로 추가할지 설정합니다."
	L["CVar_minimapTrackingClosestOnly"] = "미니맵 추적: 가장 가까운 것만"
	L["CVar_minimapTrackingClosestOnlyTT"] = "일부 미니맵 아이콘 유형에 대해 가장 가까운 추적 아이콘만 표시합니다."
	L["CVar_autoDismount"] = "자동 탈것 해제 (지상)"
	L["CVar_autoDismountTT"] = "특정 대상과 상호작용할 때 지상 탈것에서 자동으로 내립니다."

	-- Global Strings
	L["UIScale"] = UI_SCALE
	L["LockFrame"] = LOCK_FRAME
	L["ResetPosition"] = RESET_POSITION
	L["Header_Professions"] = TRADE_SKILLS
	L["Header_Map"] = WORLD_MAP
	L["Header_ActionBar"] = BINDING_HEADER_ACTIONBAR
	L["Header_Chat"] = BINDING_HEADER_CHAT
	L["Header_Misc"] = BINDING_HEADER_MISC
	L["Loading"] = LFG_LIST_LOADING
	L["Remove"] = REMOVE
	L["Add"] = ADD
	L["None"] = NONE
	L["All"] = ALL
	L["Outfit"] = TRANSMOG_OUTFIT_NAME_DEFAULT
	L["AdvancedOptions"] = ADVANCED_OPTIONS
	L["Header_Nameplates"] = NAMEPLATES_LABEL
	L["Header_Screenshot"] = BINDING_NAME_SCREENSHOT

return end

if LOCALE == "zhCN" then
	-- Simplified Chinese translations go here

	L["TOC_Title"] = "工匠 (Artificer)"
	L["TOC_Notes"] = "个人工作室以及一系列界面调整和优化"
	L["SLASH_ARTI1"] = "/artificer" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI2"] = "/arti" -- english slash command - *Do Not Localize*
	L["SLASH_ARTI3"] = "/技师" -- localized slash command
	L["SLASH_ARTI4"] = "/技师" -- localized slash command
	L["OpenSettings"] = "打开设置"

	-- Headers
	L["Header_AccountSettings"] = "账号设置"
	L["Header_CVars"] = "控制台变量 (CVars)"

	--Widgets
	L["Widget_FishReelIn"] = "收线提示"
	L["Widget_FishReelInTT"] = "当钓鱼投掷完成时播放收线音效。"
	L["Widget_ChromieTimeIcon"] = "克罗米时间图标"
	L["Widget_ChromieTimeIconTT"] = "在地图上显示图标，标示你是否处于克罗米时间（时光漫游活动）。"
	L["Widget_ChromieTimeIcon_NoCampaign"] = "当前没有激活的时光漫游活动。"
	L["Widget_HideMacroText"] = "隐藏动作条宏文本"
	L["Widget_HideMacroTextTT"] = "隐藏动作条按钮上的宏文本。"
	L["Widget_ArrowKeyEditbox"] = "聊天输入框允许使用方向键"
	L["Widget_ArrowKeyEditboxTT"] = "允许使用方向键在聊天输入框中移动光标，无需按Alt。"
	L["Widget_OutfitIcon"] = "幻化套装边框"
	L["Widget_OutfitIconTT"] = "在动作条按钮上显示套装的边框。"
	L["Widget_ServerNotifications"] = "服务器通知作为团队警告"
	L["Widget_ServerNotificationsTT"] = "以团队警告形式显示服务器通知（如服务器重启）。"
	L["Widget_OutfitSwapSounds"] = "套装切换音效"
	L["Widget_OutfitSwapSoundsTT"] = "选择在套装切换时要静音的音效。"
	L["Widget_OSS_Impact"] = "冲击"
	L["Widget_OSS_STA"] = "音效类型 A"
	L["Widget_OSS_STB"] = "音效类型 B"
	L["Widget_OSS_STC"] = "音效类型 C"
	L["Widget_OSS_STD"] = "音效类型 D"
	L["Widget_HideCraftingResults"] = "隐藏制作结果"
	L["Widget_HideCraftingResultsTT"] = "打开专业技能界面制作物品时隐藏制作结果窗口。"
	L["Widget_MovableCurrencyTransfer"] = "可移动货币转移窗口"
	L["Widget_MovableCurrencyTransferTT"] = "允许移动货币转移窗口。"
	L["Widget_AddonCompartmentMover"] = "移动插件仓库框架"
	L["Widget_AddonCompartmentMoverTT"] = "将插件仓库框架移动到日历按钮顶部，而不是底部。"
	L["Widget_MinimapIcon"] = "小地图图标"
	L["Widget_MinimapIconTT"] = "在小地图显示可点击图标以打开设置。"
	L["Widget_CollapseBuffs"] = "自动折叠增益框体"
	L["Widget_CollapseBuffsTT"] = "自动折叠默认的增益框体。"
	L["Widget_PartySync"] = "自动接受队伍同步"
	L["Widget_PartySyncTT"] = "在出现队伍同步确认时自动接受。"
	L["Widget_ChatTooltipVisibility"] = "聊天消息预览"
	L["Widget_ChatTooltipVisibilityTT"] = "在输入框显示提示，以预览当前正在编辑的聊天消息。"
	L["CurrentMessage"] = "当前消息"
	L["Mouseover"] = "鼠标悬停"
	L["Widget_HideScreenshotText"] = "隐藏截图文本"
	L["Widget_HideScreenshotTextTT"] = "隐藏“已截取屏幕截图”的提示文本。"
	L["Widget_ScreenshotFormat"] = "截图格式"
	L["Widget_ScreenshotFormatTT"] = "调整截图格式（PNG可能会使部分天空透明）。"
	L["Widget_ScreenshotQuality"] = "截图质量"
	L["Widget_ScreenshotQualityTT"] = "调整截图质量。"
	L["Widget_ScreenshotSizeMultiplier"] = "截图分辨率"
	L["Widget_ScreenshotSizeMultiplierTT"] = "根据窗口倍率调整截图分辨率。"
	L["Warning_FileSize"] = "注意：可能会导致文件较大。"
	L["Widget_BlockGuildInvites"] = "屏蔽公会邀请（账号）"
	L["Widget_BlockGuildInvitesTT"] = "账号范围设置，自动拒绝所有角色的公会邀请。"

	--Widgets - Account-wide settings
	L["Widget_AutoLoot"] = "账号自动拾取切换"
	L["Widget_AutoLootTT"] = "在所有角色上强制应用账号级自动拾取设置。"
	L["Widget_PetBattleMapFilter"] = "账号宠物对战地图过滤切换"
	L["Widget_PetBattleMapFilterTT"] = "在所有角色上强制应用账号级宠物对战地图过滤设置。"
	L["Widget_cooldownViewerEnabled"] = "账号冷却管理器切换"
	L["Widget_cooldownViewerEnabledTT"] = "在所有角色上强制应用账号级冷却管理器设置。"
	L["Account_On"] = "账号范围已启用"
	L["Account_Off"] = "账号范围已禁用"

	--Widgets - CancelAura
	L["CancelAuraManager"] = "光环取消管理器"
	L["CancelAuraManagerTT"] = "在脱战状态下自动移除特定增益效果。"
	L["InvalidSpell"] = "无效的法术 ID"
	L["EnterSpellID"] = "输入法术 ID"
	L["CanceledAuras"] = "已取消光环"
	L["AuraHistory"] = "光环历史"
	L["SpellID"] = "法术 ID"

	--Widgets - AbandonQuestManager
	L["AbandonQuestManager"] = "任务放弃管理器"
	L["AbandonQuestManagerTT"] = "自动放弃不想接受的特定任务。"
	L["InvalidQuest"] = "无效的任务 ID"
	L["EnterQuestID"] = "输入任务 ID"
	L["AbandonedQuests"] = "自动放弃的任务"
	L["QuestHistory"] = "任务历史"
	L["QuestID"] = "任务 ID: %s"

	--Widgets - OutfitBar
	L["OutfitSoundManager"] = "套装音效管理器"
	L["OutfitSoundManagerTT"] = "配置每套装备的移动音效。"
	L["Leather"] = "皮甲"
	L["Chain"] = "锁甲"
	L["Plate"] = "板甲"
	L["GearLight"] = "轻型装备"
	L["GearHeavy"] = "重型装备"
	L["BucklesLight"] = "轻型扣环"
	L["BucklesHeavy"] = "重型扣环"
	L["YakRun"] = "牦牛奔跑"
	L["YakWalk"] = "牦牛行走"
	L["GrummleRun"] = "格鲁姆尔奔跑"
	L["GrummleWalk"] = "格鲁姆尔行走"
	L["TreasureGoblin"] = "宝藏哥布林"
	L["SoundS"] = "音效: %s"
	L["Click"] = "点击: %s"
	L["LeftClick"] = "左键点击: %s"
	L["RightClick"] = "右键点击: %s"
	L["ClickDrag"] = "点击拖动: %s"
	L["ConfigureSounds"] = "配置音效"
	L["PickUpOutfit"] = "拾取套装"
	L["OutfitManager"] = "套装管理"
	L["OutfitManagerTT"] = "选择要穿戴的套装，并为每个套装配置可播放的装备移动音效。"
	L["EquipOutfit"] = "穿戴套装"
	L["Widget_MinimapRightClick"] = "小地图右键"
	L["Widget_MinimapRightClickTT"] = "设置小地图右键功能"
	L["LockAppearance"] = "锁定外观"

	--Widgets - TransmogHistory
	L["UndoTT"] = "撤销"
	L["RedoTT"] = "重做"
	L["UndoKeybindTT"] = "(Alt-Z / Shift-Z)"
	L["RedoKeybindTT"] = "(Alt-Y / Shift-Y)"
	L["RestoreSessionTT"] = "恢复上一次会话"
	L["SheathWeaponTT"] = TRANSMOG_SHEATHE_WEAPON
	L["InvalidWeapoonSheathTT"] = TRANSMOG_SLOT_WARNING_NOTHING_EQUIPPED

	--Widgets - Loot History Visibility
	L["Widget_LootHistoryVisibility"] = "拾取记录可见性"
	L["Widget_LootHistoryVisibilityTT"] = "根据所选选项自动隐藏拾取记录。"
	L["Widget_LHV_None"] = NONE
	L["Widget_LHV_Solo"] = SOLO
	L["Widget_LHV_NotFull"] = "非满队伍"
	L["Widget_LHV_Always"] = ALWAYS

	--Widgets - Hide Tutorials
	L["Widget_HideTutorials"] = "隐藏教程"
	L["Widget_HideTutorialsTT"] = "在整个账号范围内强制隐藏教程。"

	--Widgets - NameplateTargetIndicator
	L["FNP_TargetIndicator"] = "友方姓名板目标指示器"
	L["FNP_TargetIndicatorTT"] = "在正在以你为目标的友方玩家姓名板上显示图标。"
	L["FNP_HeroTalentRing"] = "英雄天赋光环"
	L["FNP_ArtificerEye"] = "工匠之眼"
	L["FNP_LFGEye"] = "寻求组队之眼"
	L["FNP_DragIcon"] = "相对于姓名板拖动图标"
	L["FNP_IconStyle"] = "图标样式"
	L["FNP_IconSize"] = "图标大小"
	L["FNP_IconColor"] = "图标颜色"
	L["LC_OpenColorPicker"] = "左键：打开颜色选择器"
	L["RC_OpenDropdown"] = "右键：更多设置"
	L["ColorOptions"] = "颜色选项"
	L["CopyColor"] = "复制颜色"
	L["PasteColor"] = "粘贴颜色"

	--Widgets - NameplateStatus
	L["FNP_StatusIndicator"] = "友方姓名板状态指示器"
	L["FNP_StatusIndicatorTT"] = "在友方玩家状态的姓名板上显示一个图标。"
	L["FNP_StatusOptions"] = PLAYER_STATUS
	L["FNP_StatusConnection"] = "连接状态（AFK/DND/DC）"
	L["FNP_StatusChromie"] = "克罗米时间"
	L["FNP_StatusGroup"] = PARTY_MEMBERS
	L["FNP_StatusGuild"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriend"] = FRIENDS
	L["FNP_StatusIgnored"] = IGNORED
	L["FNP_StatusConnectionDCd"] = "已断开连接"
	L["FNP_StatusConnectionAway"] = CHAT_MSG_AFK
	L["FNP_StatusConnectionDND"] = DND
	L["FNP_StatusGroupMember"] = GROUP
	L["FNP_StatusGroupAssist"] = RAID_ASSISTANT
	L["FNP_StatusGroupLeader"] = LEADER
	L["FNP_StatusGuildMember"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriendChar"] = FRIENDS .. " - " .. CHARACTER
	L["FNP_StatusFriendAcc"] = FRIENDS .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT
	L["FNP_StatusFriendBNet"] = FRIENDS .. " - " .. BATTLETAG
	L["FNP_StatusIgnoredChar"] = IGNORED .. " - " .. CHARACTER
	L["FNP_StatusIgnoredAcc"] = IGNORED .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT

	--Widgets - Account Ignore List
	L["Widget_AccountIgnoreList"] = "账号忽略列表窗口"
	L["Widget_AccountIgnoreListTT"] = "显示一个包含账号所有已记录忽略对象的窗口。"
	L["AccountIgnoreList"] = "账号忽略列表"

	--Widgets - PreyBar
	L["Widget_PreyBar"] = "猎物进度指示器"
	L["Widget_PreyBarTT"] = "在猎物狩猎组件旁显示替代的猎物进度。"
	L["PreyBar_Style_Row"] = "行"
	L["PreyBar_Style_Statusbar"] = "状态条"
	L["PreyBar_Position"] = "位置"
	L["PreyBar_PositionTT"] = "附加到组件的哪一侧。"
	L["PreyBar_Style"] = UNIT_NAMEPLATES_STYLE
	L["PreyBar_Style_Corner"] = RAID_TARGET_4
	L["PreyBar_Position_Top"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_TOP
	L["PreyBar_Position_Bottom"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_BOTTOM
	L["PreyBar_Position_Left"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_LEFT
	L["PreyBar_Position_Right"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_RIGHT
	L["PreyBar_HideBlizzWidget"] = "隐藏暴雪猎物组件"
	L["PreyBar_HideInCombat"] = "战斗中隐藏"

	L["EncounterBar"] = HUD_EDIT_MODE_ENCOUNTER_BAR_LABEL

	L["Header_Combat"] = COMBAT_LABEL
	L["Widget_SpellAlerts"] = COMBAT_TEXT_SHOW_REACTIVES_TEXT
	L["Widget_SpellAlertsTT"] = "筛选屏幕上显示的特定法术提示。\n\n需要启用法术提示。"

	--Widgets - BlockTrades
	L["Widget_BlockTrades"] = "幻化期间阻止交易"
	L["Widget_BlockTradesTT"] = "在幻化界面打开时阻止所有交易。"
	L["Widget_OutfitLinkOnClose"] = "关闭幻化时链接外观"
	L["Widget_OutfitLinkOnCloseTT"] = "关闭幻化窗口时，自动将当前查看的外观链接到聊天。"
	L["Widget_OutfitLinkOnClose_LastViewedOutfit"] = "上次查看的外观：%s"

	--Widgets - MapAmbience
	L["Widget_MapAmbience_QD"] = "降低奎尔丹纳斯环境音量"
	L["Widget_MapAmbience_QDTT"] = "将奎尔丹纳斯的环境音量降低约当前环境音量的25%。"

	--Widgets - DamageMeter
	L["Widget_DamageMeter"] = DAMAGE_METER_LABEL
	L["Widget_DamageMeterTT"] = "为每个角色强制应用账户范围的伤害统计可见性设置。"
	L["Widget_DamageWipe"] = AUTO_RESET_DAMAGE_METER
	L["Widget_DamageWipeTT"] = "为每个角色强制应用账户范围的伤害统计重置设置。"

	--Widgets - Account-wide settings
	L["Header_ObjectiveTracker"] = HUD_EDIT_MODE_OBJECTIVE_TRACKER_LABEL
	L["Widget_AutoCollapseTracker"] = "自动折叠目标追踪"
	L["Widget_AutoCollapseTrackerTT"] = "在特定条件下自动最小化目标追踪。"
	L["Widget_AutoFadeObjectiveTracker"] = "目标追踪自动淡出"
	L["Widget_AutoFadeObjectiveTrackerTT"] = "在特定条件下自动淡出目标追踪。"
	L["Widget_ACT_RestedArea"] = "休息区域"
	L["Widget_ACT_Combat"] = COMBAT
	L["Widget_ACT_PetBattles"] = SHOW_PET_BATTLES_ON_MAP_TEXT
	L["Widget_ACT_Battlegrounds"] = BATTLEFIELDS
	L["Widget_ACT_Arena"] = ARENA
	L["Widget_ACT_Dungeon"] = LFG_TYPE_DUNGEON
	L["Widget_ACT_MPlus"] = PLAYER_DIFFICULTY_MYTHIC_PLUS
	L["Widget_ACT_Raids"] = RAID
	L["Widget_ACT_ScenariosDelves"] = SCENARIOS_PVEFRAME .. "/" .. DELVES_LABEL
	L["Widget_ACT_Housing"] = BINDING_HEADER_HOUSING_SYSTEM

	--Widgets - Delete Confirm
	L["Widget_DeleteConfirm"] = "填充物品删除文本"
	L["Widget_DeleteConfirmTT"] = string.format("用于填充“%s”文本的按钮，并在第二次点击时删除该物品。", DELETE_ITEM_CONFIRM_STRING)
	L["Widget_DeleteConfirm_ButtonTT"] = string.format("点击1：填充“%s”文本。\n\n点击2：删除物品。", DELETE_ITEM_CONFIRM_STRING)

	--Widgets - ProfessionToasts
	L["Widget_ProfessionToasts"] = "专业技能提示"
	L["Widget_ProfessionToastsTT"] = "当专业技能等级提升时显示淡入提示通知。"
	L["FrameWidth"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_WIDTH
	L["FrameHeight"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_HEIGHT
	L["FontSize"] = FONT_SIZE
	L["FontColor"] = "字体颜色"
	L["BorderColor"] = EMBLEM_BORDER_COLOR
	L["BackgroundColor"] = "背景颜色"
	L["BorderStyle"] = "边框样式"
	L["BackgroundStyle"] = "背景样式"
	L["SingleLine"] = "单行专业等级"
	L["PlaySound"] = COOLDOWN_VIEWER_SETTINGS_ALERT_MENU_BUTTON_TOOLTIP_PREVIEW
	L["Desaturate"] = "去饱和"

	L["BorderStyle_housingcontainer"] = "房屋容器"
	L["BorderStyle_shopheader"] = "商店标题"
	L["BorderStyle_questtracker"] = "任务追踪"
	L["BorderStyle_achievementalert"] = "成就提示"
	L["BorderStyle_shipmisson"] = "舰船任务"
	L["BorderStyle_housingitem"] = "房屋物品"
	L["BorderStyle_artifactlevel"] = "神器等级"
	L["BorderStyle_shoptoast"] = "商店提示"
	L["BorderStyle_legioninvasion"] = "军团入侵标题"
	L["BorderStyle_lootroll"] = "拾取掷骰"
	L["BorderStyle_activities"] = "活动"
	L["BorderStyle_midnightscenariotitle"] = "Midnight 场景标题"
	L["BorderStyle_thewarwithinscenariotitle"] = "地心之战场景标题"
	L["BorderStyle_dragonflightscenariotitle"] = "巨龙时代场景标题"
	L["BorderStyle_dragonflightscenarioframe"] = "巨龙时代场景框架"
	L["BorderStyle_evergreenscenariotitle"] = "Evergreen 场景标题"

	-- Professions - official translations
	L["ALCHEMY"] = "炼金术"
	L["ARCHAEOLOGY"] = "考古学"
	L["BLACKSMITHING"] = "锻造"
	L["COOKING"] = "烹饪"
	L["ENCHANTING"] = "附魔"
	L["ENGINEERING"] = "工程学"
	L["FIRST_AID"] = "急救"
	L["FISHING"] = "钓鱼"
	L["HERBALISM"] = "草药学"
	L["INSCRIPTION"] = "铭文"
	L["JEWELCRAFTING"] = "珠宝加工"
	L["LEATHERWORKING"] = "制皮"
	L["MINING"] = "采矿"
	L["SKINNING"] = "剥皮"
	L["TAILORING"] = "裁缝"

	L["SpecializationArt"] = "专精艺术"
	L["MobileIcons"] = "移动图标"

	L["MetalChainMaw"] = "金属锁链 - 噬渊"
	L["Wildhammer"] = "蛮锤"

	--CVars
	L["CVar_minimapTrackingShowAll"] = "显示所有小地图追踪"
	L["CVar_minimapTrackingShowAllTT"] = "切换额外的小地图追踪选项。"
	L["CVar_weatherDensity"] = "天气密度"
	L["CVar_weatherDensityTT"] = "控制天气密度/强度。"
	L["CVar_AutoPushSpellToActionBar"] = "自动将法术加入动作条"
	L["CVar_AutoPushSpellToActionBarTT"] = "是否自动将法术放置在动作条上。"
	L["CVar_minimapTrackingClosestOnly"] = "小地图追踪：仅最近目标"
	L["CVar_minimapTrackingClosestOnlyTT"] = "对于某些小地图图标类型，仅显示最近的追踪图标。"
	L["CVar_autoDismount"] = "自动下坐骑（地面）"
	L["CVar_autoDismountTT"] = "与某些对象互动时会自动从地面坐骑上下来。"

	-- Global Strings
	L["UIScale"] = UI_SCALE
	L["LockFrame"] = LOCK_FRAME
	L["ResetPosition"] = RESET_POSITION
	L["Header_Professions"] = TRADE_SKILLS
	L["Header_Map"] = WORLD_MAP
	L["Header_ActionBar"] = BINDING_HEADER_ACTIONBAR
	L["Header_Chat"] = BINDING_HEADER_CHAT
	L["Header_Misc"] = BINDING_HEADER_MISC
	L["Loading"] = LFG_LIST_LOADING
	L["Remove"] = REMOVE
	L["Add"] = ADD
	L["None"] = NONE
	L["All"] = ALL
	L["Outfit"] = TRANSMOG_OUTFIT_NAME_DEFAULT
	L["AdvancedOptions"] = ADVANCED_OPTIONS
	L["Header_Nameplates"] = NAMEPLATES_LABEL
	L["Header_Screenshot"] = BINDING_NAME_SCREENSHOT

return end

if LOCALE == "zhTW" then
	-- Traditional Chinese translations go here

	L["TOC_Title"] = "技師 (Artificer)"
	L["TOC_Notes"] = "個人工作室以及一系列介面調整與優化"
	L["SLASH_ARTI3"] = "/技師" -- localized slash command
	L["SLASH_ARTI4"] = "/技師" -- localized slash command
	L["OpenSettings"] = "打開設定"

	-- Headers
	L["Header_AccountSettings"] = "帳號設定"
	L["Header_CVars"] = "控制台變數 (CVars)"

	--Widgets
	L["Widget_FishReelIn"] = "收線提示"
	L["Widget_FishReelInTT"] = "當釣魚投擲完成時播放收線音效。"
	L["Widget_ChromieTimeIcon"] = "克羅米時間圖示"
	L["Widget_ChromieTimeIconTT"] = "在地圖上顯示圖示，標示你是否處於克羅米時間（時光漫遊活動）。"
	L["Widget_ChromieTimeIcon_NoCampaign"] = "目前沒有啟動的時光漫遊活動。"
	L["Widget_HideMacroText"] = "隱藏動作條巨集文字"
	L["Widget_HideMacroTextTT"] = "隱藏動作條按鈕上的巨集文字。"
	L["Widget_ArrowKeyEditbox"] = "聊天輸入框允許使用方向鍵"
	L["Widget_ArrowKeyEditboxTT"] = "允許使用方向鍵在聊天輸入框中移動光標，無需按 Alt。"
	L["Widget_OutfitIcon"] = "幻化套裝邊框"
	L["Widget_OutfitIconTT"] = "在動作條按鈕上顯示套裝邊框。"
	L["Widget_ServerNotifications"] = "伺服器通知作為團隊警告"
	L["Widget_ServerNotificationsTT"] = "以團隊警告形式顯示伺服器通知（如伺服器重啟）。"
	L["Widget_OutfitSwapSounds"] = "套裝切換音效"
	L["Widget_OutfitSwapSoundsTT"] = "選擇在套裝切換時要靜音的音效。"
	L["Widget_OSS_Impact"] = "衝擊"
	L["Widget_OSS_STA"] = "音效類型 A"
	L["Widget_OSS_STB"] = "音效類型 B"
	L["Widget_OSS_STC"] = "音效類型 C"
	L["Widget_OSS_STD"] = "音效類型 D"
	L["Widget_HideCraftingResults"] = "隱藏製作結果"
	L["Widget_HideCraftingResultsTT"] = "打開專業技能界面製作物品時隱藏製作結果視窗。"
	L["Widget_MovableCurrencyTransfer"] = "可移動貨幣轉移視窗"
	L["Widget_MovableCurrencyTransferTT"] = "允許移動貨幣轉移視窗。"
	L["Widget_AddonCompartmentMover"] = "移動插件倉庫框架"
	L["Widget_AddonCompartmentMoverTT"] = "將插件倉庫框架移動到日曆按鈕上方，而非底部。"
	L["Widget_MinimapIcon"] = "小地圖圖示"
	L["Widget_MinimapIconTT"] = "在小地圖顯示可點擊圖示以開啟設定。"
	L["Widget_CollapseBuffs"] = "自動收合增益框架"
	L["Widget_CollapseBuffsTT"] = "自動收合預設的增益框架。"
	L["Widget_PartySync"] = "自動接受隊伍同步"
	L["Widget_PartySyncTT"] = "在出現隊伍同步確認時自動接受。"
	L["Widget_ChatTooltipVisibility"] = "聊天訊息預覽"
	L["Widget_ChatTooltipVisibilityTT"] = "在輸入框顯示提示，以預覽目前正在編輯的聊天訊息。"
	L["CurrentMessage"] = "目前訊息"
	L["Mouseover"] = "滑鼠懸停"
	L["Widget_HideScreenshotText"] = "隱藏截圖文字"
	L["Widget_HideScreenshotTextTT"] = "隱藏「已擷取螢幕截圖」的提示文字。"
	L["Widget_ScreenshotFormat"] = "截圖格式"
	L["Widget_ScreenshotFormatTT"] = "調整截圖格式（PNG可能會使部分天空透明）。"
	L["Widget_ScreenshotQuality"] = "截圖品質"
	L["Widget_ScreenshotQualityTT"] = "調整截圖品質。"
	L["Widget_ScreenshotSizeMultiplier"] = "截圖解析度"
	L["Widget_ScreenshotSizeMultiplierTT"] = "根據視窗倍率調整解析度。"
	L["Warning_FileSize"] = "注意：可能會導致檔案較大。"
	L["Widget_BlockGuildInvites"] = "封鎖公會邀請（帳號）"
	L["Widget_BlockGuildInvitesTT"] = "帳號設定，自動拒絕所有角色的公會邀請。"

	--Widgets - Account-wide settings
	L["Widget_AutoLoot"] = "帳號自動拾取切換"
	L["Widget_AutoLootTT"] = "在所有角色上強制套用帳號層級的自動拾取設定。"
	L["Widget_PetBattleMapFilter"] = "帳號寵物對戰地圖過濾切換"
	L["Widget_PetBattleMapFilterTT"] = "在所有角色上強制套用帳號層級的寵物對戰地圖過濾設定。"
	L["Widget_cooldownViewerEnabled"] = "帳號冷卻管理器切換"
	L["Widget_cooldownViewerEnabledTT"] = "在所有角色上強制套用帳號層級的冷卻管理器設定。"
	L["Account_On"] = "帳號範圍已啟用"
	L["Account_Off"] = "帳號範圍已停用"

	--Widgets - CancelAura
	L["CancelAuraManager"] = "光環取消管理器"
	L["CancelAuraManagerTT"] = "在脫戰狀態下自動移除特定增益效果。"
	L["InvalidSpell"] = "無效法術 ID"
	L["EnterSpellID"] = "輸入法術 ID"
	L["CanceledAuras"] = "已取消光環"
	L["AuraHistory"] = "光環歷史"
	L["SpellID"] = "法術 ID"

	--Widgets - AbandonQuestManager
	L["AbandonQuestManager"] = "任務放棄管理器"
	L["AbandonQuestManagerTT"] = "自動放棄不想接受的特定任務。"
	L["InvalidQuest"] = "無效任務 ID"
	L["EnterQuestID"] = "輸入任務 ID"
	L["AbandonedQuests"] = "自動放棄任務"
	L["QuestHistory"] = "任務歷史"
	L["QuestID"] = "任務 ID: %s"

	--Widgets - OutfitBar
	L["OutfitSoundManager"] = "套裝音效管理器"
	L["OutfitSoundManagerTT"] = "設定每套裝備的移動音效。"
	L["Leather"] = "皮甲"
	L["Chain"] = "鎖甲"
	L["Plate"] = "板甲"
	L["GearLight"] = "輕型裝備"
	L["GearHeavy"] = "重型裝備"
	L["BucklesLight"] = "輕型扣環"
	L["BucklesHeavy"] = "重型扣環"
	L["YakRun"] = "犛牛奔跑"
	L["YakWalk"] = "犛牛行走"
	L["GrummleRun"] = "格魯姆奔跑"
	L["GrummleWalk"] = "格魯姆行走"
	L["TreasureGoblin"] = "寶藏哥布林"
	L["SoundS"] = "音效: %s"
	L["Click"] = "點擊: %s"
	L["LeftClick"] = "左鍵點擊: %s"
	L["RightClick"] = "右鍵點擊: %s"
	L["ClickDrag"] = "點擊拖動: %s"
	L["ConfigureSounds"] = "設定音效"
	L["PickUpOutfit"] = "拾取套裝"
	L["OutfitManager"] = "套裝管理"
	L["OutfitManagerTT"] = "選擇要穿戴的套裝，並為每個套裝設定可播放的裝備移動音效。"
	L["EquipOutfit"] = "穿戴套裝"
	L["Widget_MinimapRightClick"] = "小地圖右鍵"
	L["Widget_MinimapRightClickTT"] = "設定小地圖右鍵功能"
	L["LockAppearance"] = "鎖定外觀"

	--Widgets - TransmogHistory
	L["UndoTT"] = "復原"
	L["RedoTT"] = "重做"
	L["UndoKeybindTT"] = "(Alt-Z / Shift-Z)"
	L["RedoKeybindTT"] = "(Alt-Y / Shift-Y)"
	L["RestoreSessionTT"] = "還原上一個工作階段"
	L["SheathWeaponTT"] = TRANSMOG_SHEATHE_WEAPON
	L["InvalidWeapoonSheathTT"] = TRANSMOG_SLOT_WARNING_NOTHING_EQUIPPED

	--Widgets - Loot History Visibility
	L["Widget_LootHistoryVisibility"] = "拾取紀錄可見性"
	L["Widget_LootHistoryVisibilityTT"] = "根據所選選項自動隱藏拾取紀錄。"
	L["Widget_LHV_None"] = NONE
	L["Widget_LHV_Solo"] = SOLO
	L["Widget_LHV_NotFull"] = "非滿隊伍"
	L["Widget_LHV_Always"] = ALWAYS

	--Widgets - Hide Tutorials
	L["Widget_HideTutorials"] = "Ocultar tutoriales"
	L["Widget_HideTutorialsTT"] = "Fuerza la ocultación de los tutoriales en toda la cuenta."

	--Widgets - NameplateTargetIndicator
	L["FNP_TargetIndicator"] = "友方姓名板目標指示器"
	L["FNP_TargetIndicatorTT"] = "在正在以你為目標的友方玩家姓名板上顯示圖示。"
	L["FNP_HeroTalentRing"] = "英雄天賦光環"
	L["FNP_ArtificerEye"] = "工匠之眼"
	L["FNP_LFGEye"] = "尋求組隊之眼"
	L["FNP_DragIcon"] = "相對於姓名板拖動圖示"
	L["FNP_IconStyle"] = "圖示樣式"
	L["FNP_IconSize"] = "圖示大小"
	L["FNP_IconColor"] = "圖示顏色"
	L["LC_OpenColorPicker"] = "左鍵：開啟顏色選擇器"
	L["RC_OpenDropdown"] = "右鍵：其他設定"
	L["ColorOptions"] = "顏色選項"
	L["CopyColor"] = "複製顏色"
	L["PasteColor"] = "貼上顏色"

	--Widgets - NameplateStatus
	L["FNP_StatusIndicator"] = "友方名條狀態指示器"
	L["FNP_StatusIndicatorTT"] = "在友方玩家狀態的名條上顯示圖示。"
	L["FNP_StatusOptions"] = PLAYER_STATUS
	L["FNP_StatusConnection"] = "連線狀態（AFK/DND/DC）"
	L["FNP_StatusChromie"] = "克羅米時間"
	L["FNP_StatusGroup"] = PARTY_MEMBERS
	L["FNP_StatusGuild"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriend"] = FRIENDS
	L["FNP_StatusIgnored"] = IGNORED
	L["FNP_StatusConnectionDCd"] = "已斷線"
	L["FNP_StatusConnectionAway"] = CHAT_MSG_AFK
	L["FNP_StatusConnectionDND"] = DND
	L["FNP_StatusGroupMember"] = GROUP
	L["FNP_StatusGroupAssist"] = RAID_ASSISTANT
	L["FNP_StatusGroupLeader"] = LEADER
	L["FNP_StatusGuildMember"] = LFG_LIST_GUILD_MEMBER
	L["FNP_StatusFriendChar"] = FRIENDS .. " - " .. CHARACTER
	L["FNP_StatusFriendAcc"] = FRIENDS .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT
	L["FNP_StatusFriendBNet"] = FRIENDS .. " - " .. BATTLETAG
	L["FNP_StatusIgnoredChar"] = IGNORED .. " - " .. CHARACTER
	L["FNP_StatusIgnoredAcc"] = IGNORED .. " - " .. REPUTATION_SORT_TYPE_ACCOUNT

	--Widgets - Account Ignore List
	L["Widget_AccountIgnoreList"] = "帳號忽略清單視窗"
	L["Widget_AccountIgnoreListTT"] = "顯示包含帳號所有已記錄忽略對象的視窗。"
	L["AccountIgnoreList"] = "帳號忽略清單"

	--Widgets - PreyBar
	L["Widget_PreyBar"] = "獵物進度指示器"
	L["Widget_PreyBarTT"] = "在獵物狩獵元件旁顯示替代的獵物進度。"
	L["PreyBar_Style_Row"] = "列"
	L["PreyBar_Style_Statusbar"] = "狀態列"
	L["PreyBar_Position"] = "位置"
	L["PreyBar_PositionTT"] = "附加到元件的哪一側。"
	L["PreyBar_Style"] = UNIT_NAMEPLATES_STYLE
	L["PreyBar_Style_Corner"] = RAID_TARGET_4
	L["PreyBar_Position_Top"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_TOP
	L["PreyBar_Position_Bottom"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_BOTTOM
	L["PreyBar_Position_Left"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_LEFT
	L["PreyBar_Position_Right"] = HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_ICON_DIRECTION_RIGHT
	L["PreyBar_HideBlizzWidget"] = "隱藏暴雪獵物元件"
	L["PreyBar_HideInCombat"] = "戰鬥中隱藏"

	L["EncounterBar"] = HUD_EDIT_MODE_ENCOUNTER_BAR_LABEL

	L["Header_Combat"] = COMBAT_LABEL
	L["Widget_SpellAlerts"] = COMBAT_TEXT_SHOW_REACTIVES_TEXT
	L["Widget_SpellAlertsTT"] = "篩選螢幕上顯示的特定法術提示。\n\n需要啟用法術提示。"

	--Widgets - BlockTrades
	L["Widget_BlockTrades"] = "幻化期間阻止交易"
	L["Widget_BlockTradesTT"] = "在幻化視窗開啟時阻止所有交易。"
	L["Widget_OutfitLinkOnClose"] = "關閉幻化時連結外觀"
	L["Widget_OutfitLinkOnCloseTT"] = "關閉幻化視窗時，自動將目前檢視的外觀連結到聊天。"
	L["Widget_OutfitLinkOnClose_LastViewedOutfit"] = "上次檢視的外觀：%s"

	--Widgets - MapAmbience
	L["Widget_MapAmbience_QD"] = "降低奎爾達納斯環境音量"
	L["Widget_MapAmbience_QDTT"] = "將奎爾達納斯的環境音量降低約目前環境音量的25%。"

	--Widgets - DamageMeter
	L["Widget_DamageMeter"] = DAMAGE_METER_LABEL
	L["Widget_DamageMeterTT"] = "為每個角色強制套用帳號範圍的傷害統計顯示設定。"
	L["Widget_DamageWipe"] = AUTO_RESET_DAMAGE_METER
	L["Widget_DamageWipeTT"] = "為每個角色強制套用帳號範圍的傷害統計重置設定。"

	--Widgets - Account-wide settings
	L["Header_ObjectiveTracker"] = HUD_EDIT_MODE_OBJECTIVE_TRACKER_LABEL
	L["Widget_AutoCollapseTracker"] = "自動收合目標追蹤"
	L["Widget_AutoCollapseTrackerTT"] = "在特定條件下自動最小化目標追蹤。"
	L["Widget_AutoFadeObjectiveTracker"] = "目標追蹤自動淡出"
	L["Widget_AutoFadeObjectiveTrackerTT"] = "在特定條件下自動淡出目標追蹤。"
	L["Widget_ACT_RestedArea"] = "休息區域"
	L["Widget_ACT_Combat"] = COMBAT
	L["Widget_ACT_PetBattles"] = SHOW_PET_BATTLES_ON_MAP_TEXT
	L["Widget_ACT_Battlegrounds"] = BATTLEFIELDS
	L["Widget_ACT_Arena"] = ARENA
	L["Widget_ACT_Dungeon"] = LFG_TYPE_DUNGEON
	L["Widget_ACT_MPlus"] = PLAYER_DIFFICULTY_MYTHIC_PLUS
	L["Widget_ACT_Raids"] = RAID
	L["Widget_ACT_ScenariosDelves"] = SCENARIOS_PVEFRAME .. "/" .. DELVES_LABEL
	L["Widget_ACT_Housing"] = BINDING_HEADER_HOUSING_SYSTEM

	--Widgets - Delete Confirm
	L["Widget_DeleteConfirm"] = "填入物品刪除文字"
	L["Widget_DeleteConfirmTT"] = string.format("用於填入「%s」文字的按鈕，並在第二次點擊時刪除該物品。", DELETE_ITEM_CONFIRM_STRING)
	L["Widget_DeleteConfirm_ButtonTT"] = string.format("點擊1：填入「%s」文字。\n\n點擊2：刪除物品。", DELETE_ITEM_CONFIRM_STRING)

	--Widgets - ProfessionToasts
	L["Widget_ProfessionToasts"] = "專業技能提示"
	L["Widget_ProfessionToastsTT"] = "當專業技能等級提升時顯示淡入提示通知。"
	L["FrameWidth"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_WIDTH
	L["FrameHeight"] = HUD_EDIT_MODE_SETTING_DAMAGE_METER_FRAME_HEIGHT
	L["FontSize"] = FONT_SIZE
	L["FontColor"] = "字體顏色"
	L["BorderColor"] = EMBLEM_BORDER_COLOR
	L["BackgroundColor"] = "背景顏色"
	L["BorderStyle"] = "邊框樣式"
	L["BackgroundStyle"] = "背景樣式"
	L["SingleLine"] = "單行專業等級"
	L["PlaySound"] = COOLDOWN_VIEWER_SETTINGS_ALERT_MENU_BUTTON_TOOLTIP_PREVIEW
	L["Desaturate"] = "降低飽和度"

	L["BorderStyle_housingcontainer"] = "房屋容器"
	L["BorderStyle_shopheader"] = "商店標題"
	L["BorderStyle_questtracker"] = "任務追蹤"
	L["BorderStyle_achievementalert"] = "成就提示"
	L["BorderStyle_shipmisson"] = "艦船任務"
	L["BorderStyle_housingitem"] = "房屋物品"
	L["BorderStyle_artifactlevel"] = "神器等級"
	L["BorderStyle_shoptoast"] = "商店提示"
	L["BorderStyle_legioninvasion"] = "軍團入侵標題"
	L["BorderStyle_lootroll"] = "拾取擲骰"
	L["BorderStyle_activities"] = "活動"
	L["BorderStyle_midnightscenariotitle"] = "Midnight 情境標題"
	L["BorderStyle_thewarwithinscenariotitle"] = "地心之戰情境標題"
	L["BorderStyle_dragonflightscenariotitle"] = "巨龍崛起情境標題"
	L["BorderStyle_dragonflightscenarioframe"] = "巨龍崛起情境框架"
	L["BorderStyle_evergreenscenariotitle"] = "Evergreen 情境標題"

	-- Professions - official translations
	L["ALCHEMY"] = "鍊金術"
	L["ARCHAEOLOGY"] = "考古學"
	L["BLACKSMITHING"] = "鍛造"
	L["COOKING"] = "烹飪"
	L["ENCHANTING"] = "附魔"
	L["ENGINEERING"] = "工程學"
	L["FIRST_AID"] = "急救"
	L["FISHING"] = "釣魚"
	L["HERBALISM"] = "草藥學"
	L["INSCRIPTION"] = "銘文學"
	L["JEWELCRAFTING"] = "珠寶設計"
	L["LEATHERWORKING"] = "製皮"
	L["MINING"] = "採礦"
	L["SKINNING"] = "剝皮"
	L["TAILORING"] = "裁縫"

	L["SpecializationArt"] = "專精美術"
	L["MobileIcons"] = "行動圖示"

	L["MetalChainMaw"] = "金屬鎖鏈 - 噬淵"
	L["Wildhammer"] = "蠻錘"

	--CVars
	L["CVar_minimapTrackingShowAll"] = "顯示所有小地圖追蹤"
	L["CVar_minimapTrackingShowAllTT"] = "切換額外的小地圖追蹤選項。"
	L["CVar_weatherDensity"] = "天氣密度"
	L["CVar_weatherDensityTT"] = "控制天氣密度/強度。"
	L["CVar_AutoPushSpellToActionBar"] = "自動將法術加入動作條"
	L["CVar_AutoPushSpellToActionBarTT"] = "是否自動將法術放置在動作條上。"
	L["CVar_minimapTrackingClosestOnly"] = "小地圖追蹤：僅最近目標"
	L["CVar_minimapTrackingClosestOnlyTT"] = "對於某些小地圖圖示類型，只顯示最近的追蹤圖示。"
	L["CVar_autoDismount"] = "自動下坐騎（地面）"
	L["CVar_autoDismountTT"] = "與某些物件互動時會自動從地面坐騎上下來。"

	-- Global Strings
	L["UIScale"] = UI_SCALE
	L["LockFrame"] = LOCK_FRAME
	L["ResetPosition"] = RESET_POSITION
	L["Header_Professions"] = TRADE_SKILLS
	L["Header_Map"] = WORLD_MAP
	L["Header_ActionBar"] = BINDING_HEADER_ACTIONBAR
	L["Header_Chat"] = BINDING_HEADER_CHAT
	L["Header_Misc"] = BINDING_HEADER_MISC
	L["Loading"] = LFG_LIST_LOADING
	L["Remove"] = REMOVE
	L["Add"] = ADD
	L["None"] = NONE
	L["All"] = ALL
	L["Outfit"] = TRANSMOG_OUTFIT_NAME_DEFAULT
	L["AdvancedOptions"] = ADVANCED_OPTIONS
	L["Header_Nameplates"] = NAMEPLATES_LABEL
	L["Header_Screenshot"] = BINDING_NAME_SCREENSHOT

return end
