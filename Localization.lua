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

	--Widgets - Account-wide settings
	L["Widget_AutoLoot"] = "Account Auto Loot Toggle"
	L["Widget_AutoLootTT"] = "Enforces account-wide settings for Auto Loot on every character."
	L["Widget_PetBattleMapFilter"] = "Account Pet Battle Map Filter Toggle"
	L["Widget_PetBattleMapFilterTT"] = "Enforces account-wide settings for Pet Battle Map Filter on every character."
	L["Widget_cooldownViewerEnabled"] = "Account Cooldown Manager Toggle"
	L["Widget_cooldownViewerEnabledTT"] = "Enforces account-wide settings for the Cooldown Manager on every character."
	L["Account_On"] = "Account-Wide Enabled"
	L["Account_Off"] = "Account-Wide Disabled"

	--Widgets - CancelAura
	L["CancelAuraManager"] = "Cancel Aura Manager"
	L["CancelAuraManagerTT"] = "Automatically remove specific buffs out of combat."
	L["InvalidSpell"] = "Invalid Spell ID"
	L["EnterSpellID"] = "Enter Spell ID"
	L["CanceledAuras"] = "Canceled Auras"
	L["AuraHistory"] = "Aura History"

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

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Show All Minimap Trackables"
	L["CVar_minimapTrackingShowAllTT"] = "Toggle additional minimap tracking options."
	L["CVar_weatherDensity"] = "Weather Density"
	L["CVar_weatherDensityTT"] = "Control the weather density / intensity."
	L["CVar_AutoPushSpellToActionBar"] = "Auto Push Spells to Action Bars"
	L["CVar_AutoPushSpellToActionBarTT"] = "Whether spells should automatically be placed on your action bars."

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

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Mostrar todo en el minimapa"
	L["CVar_minimapTrackingShowAllTT"] = "Activa opciones adicionales del minimapa."
	L["CVar_weatherDensity"] = "Densidad del clima"
	L["CVar_weatherDensityTT"] = "Controla la intensidad del clima."
	L["CVar_AutoPushSpellToActionBar"] = "Añadir hechizos automáticamente"
	L["CVar_AutoPushSpellToActionBarTT"] = "Coloca hechizos automáticamente en las barras."

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

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Mostrar todo en el minimapa"
	L["CVar_minimapTrackingShowAllTT"] = "Activa opciones adicionales del minimapa."
	L["CVar_weatherDensity"] = "Densidad del clima"
	L["CVar_weatherDensityTT"] = "Controla la intensidad del clima."
	L["CVar_AutoPushSpellToActionBar"] = "Añadir hechizos automáticamente"
	L["CVar_AutoPushSpellToActionBarTT"] = "Coloca hechizos automáticamente en las barras."

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

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Alle Minikarten-Verfolgungen anzeigen"
	L["CVar_minimapTrackingShowAllTT"] = "Aktiviert zusätzliche Minikarten-Verfolgungsoptionen."
	L["CVar_weatherDensity"] = "Wetterdichte"
	L["CVar_weatherDensityTT"] = "Steuert die Intensität des Wetters."
	L["CVar_AutoPushSpellToActionBar"] = "Zauber automatisch auf Aktionsleisten platzieren"
	L["CVar_AutoPushSpellToActionBarTT"] = "Legt fest, ob Zauber automatisch auf Aktionsleisten platziert werden."

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

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Afficher tous les suivis de la minicarte"
	L["CVar_minimapTrackingShowAllTT"] = "Active des options supplémentaires de suivi sur la minicarte."
	L["CVar_weatherDensity"] = "Densité météo"
	L["CVar_weatherDensityTT"] = "Contrôle l’intensité de la météo."
	L["CVar_AutoPushSpellToActionBar"] = "Ajouter automatiquement les sorts aux barres d’action"
	L["CVar_AutoPushSpellToActionBarTT"] = "Détermine si les sorts sont automatiquement placés sur les barres d’action."

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

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Mostra tutti i tracciamenti minimappa"
	L["CVar_minimapTrackingShowAllTT"] = "Attiva opzioni aggiuntive di tracciamento minimappa."
	L["CVar_weatherDensity"] = "Densità meteo"
	L["CVar_weatherDensityTT"] = "Controlla l'intensità del meteo."
	L["CVar_AutoPushSpellToActionBar"] = "Aggiungi automaticamente incantesimi alle barre azione"
	L["CVar_AutoPushSpellToActionBarTT"] = "Determina se gli incantesimi vengono aggiunti automaticamente alle barre azione."

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

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Mostrar todos os rastreamentos do minimapa"
	L["CVar_minimapTrackingShowAllTT"] = "Ativa opções adicionais de rastreamento do minimapa."
	L["CVar_weatherDensity"] = "Densidade do clima"
	L["CVar_weatherDensityTT"] = "Controla a intensidade do clima."
	L["CVar_AutoPushSpellToActionBar"] = "Adicionar feitiços automaticamente às barras de ação"
	L["CVar_AutoPushSpellToActionBarTT"] = "Define se feitiços são adicionados automaticamente às barras de ação."

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

	--CVars
	L["CVar_minimapTrackingShowAll"] = "Показать все отслеживания миникарты"
	L["CVar_minimapTrackingShowAllTT"] = "Включает дополнительные параметры отслеживания миникарты."
	L["CVar_weatherDensity"] = "Плотность погоды"
	L["CVar_weatherDensityTT"] = "Управляет интенсивностью погодных эффектов."
	L["CVar_AutoPushSpellToActionBar"] = "Автоматически добавлять заклинания на панели"
	L["CVar_AutoPushSpellToActionBarTT"] = "Определяет, будут ли заклинания автоматически добавляться на панели действий."

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

	--CVars
	L["CVar_minimapTrackingShowAll"] = "미니맵 추적 모두 표시"
	L["CVar_minimapTrackingShowAllTT"] = "추가 미니맵 추적 옵션을 활성화합니다."
	L["CVar_weatherDensity"] = "날씨 밀도"
	L["CVar_weatherDensityTT"] = "날씨 효과 강도를 조절합니다."
	L["CVar_AutoPushSpellToActionBar"] = "주문 자동 행동 단축바 추가"
	L["CVar_AutoPushSpellToActionBarTT"] = "주문을 행동 단축바에 자동으로 추가할지 설정합니다."

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

	--CVars
	L["CVar_minimapTrackingShowAll"] = "显示所有小地图追踪"
	L["CVar_minimapTrackingShowAllTT"] = "切换额外的小地图追踪选项。"
	L["CVar_weatherDensity"] = "天气密度"
	L["CVar_weatherDensityTT"] = "控制天气密度/强度。"
	L["CVar_AutoPushSpellToActionBar"] = "自动将法术加入动作条"
	L["CVar_AutoPushSpellToActionBarTT"] = "是否自动将法术放置在动作条上。"

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

	--CVars
	L["CVar_minimapTrackingShowAll"] = "顯示所有小地圖追蹤"
	L["CVar_minimapTrackingShowAllTT"] = "切換額外的小地圖追蹤選項。"
	L["CVar_weatherDensity"] = "天氣密度"
	L["CVar_weatherDensityTT"] = "控制天氣密度/強度。"
	L["CVar_AutoPushSpellToActionBar"] = "自動將法術加入動作條"
	L["CVar_AutoPushSpellToActionBarTT"] = "是否自動將法術放置在動作條上。"

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

return end
