[Full Changelog & Previous Releases](https://github.com/keyboardturner/Artificer/releases)

# 0.2.8

Added options to toggle the Selection Circle based on various target conditions, such as friendly NPC, self, interactable, or hiding with the UI.

Added options to toggle the "Self Highlight" under certain conditions, such as Battleground, Raid, Dungeon, as well as only in Combat.

Slightly reworked how CVars are ordered

# 0.2.7a

cancel outfit sounds when on a fishing raft (WIP)
 - this will be affected by lag so it may not work if your ping is super high idk

# 0.2.7

Added several new outfit sounds:
 - Mole Mount
 - Brutosaur Mount
 - Chain Gauntlet
 - Bone Shuffle
 - Metal Lantern
 - Arathi Lynx
 - Fishing Rod

Added a new tab to the Outfit Manager that allows adjusting swimming sounds. It utilizes the same tech/functions as the Outfit Sounds.

Updated the new player experience tutorial functionalities for the "Hide Tutorial" Setting as in 12.1.0 some functionality for it is apparently removed.

# 0.2.6a

Added several color pickers to the Professions Book and a few checkbox options to toggle icons in the Advanced Settings

# 0.2.6

Added option/fix to battle.net toast popups ignoring the blizz settings (usually called "Show Toast Window" in default settings).

# 0.2.5

Added a Professions Book overhaul feature:
 - Completely restyled the Professions Book appearance to be akin to modern interface frames
 - Added Enchant Timers for things like fishing bait
 - Temp Enchant items such as fishing bait will automatically open the Professions Book frame
 - Added profession item slots accessible in place of where the spell icons were
 - The profession icon is now a clickable button that opens the journal
 - A variety of profession spells have been added to associated profession flyout menus which can be dragged to action buttons

Some of the settings UI received updates to bring it up to par with the Weather addon settings UI
 - Headers are now displayed when searching
 - A border/background is now placed in the settings scroll container
 - The size has been slightly adjusted to be wider

# 0.2.4

12.0.7 toc update

# 0.2.3

Added a frequency slider to the Outfit Manager sounds selection

Fixed the LFD Queue frame background being a little too stretchy sometimes when a timewalking dungeon isn't selected by default

### Addon Dev notes

Added an API `Artificer_API.RegisterFoleySound(self, soundDef)` to allow addons to add their own sounds to the outfit manager selection
 - full example:
 ```
EventUtil.ContinueOnAddOnLoaded("Artificer", function()
	if Artificer_API and Artificer_API.RegisterFoleySound then

		do
			local success, err = Artificer_API:RegisterFoleySound({
				key = "ArtiFS_mFootSmallDirt",
				name = "mFoot Small Dirt",
				icon = "Interface\\Icons\\Spell_quicksand",
				volume = 0.50,
				sounds = { -- File ID or path
					540099,
					540128,
					540136,
					540201,
					540227,
				}
			});
			
			if not success then print("Registration failed:", err); end
		end
		
	end
end);
 ```

# 0.2.2b

Fix to Krowi WorldMapButtons library being "missing"

# 0.2.2

Added Looking For Group UI tweaks:
 - Added background textures depending on the selection in the LFG UI, such as Legion Timewalking having a Legion background
 - Added tooltips indicating the currently queued dungeon to the queue status eye, queue button, and dropdown

Adjusted the nameplate status priority to be character > bnet > account

# 0.2.1

Adjustments to the Artificer Nameplate Status/Target icons:
 - Added dropdown option align-grow the status buttons along the center, left-to-right, and right-to-left
 - Added centering lines for vertical/horizontal
 - Adjusted the Artificer nameplate option window to be larger
 - Made the color pickers into a scrollable list (there's enough of them that it warrants it at this point)
 - Changed the dummy nameplate to be more reflective that it's the nameplate boundaries and not the nameplate healthbar itself (the vast amount of nameplate addons makes this pretty difficult to do)

# 0.2.0

Added a potential extra fix to the Underlight Angler (needs feedback because i could only click it once and i accidentally did before finishing)

Kill outfit foley noises in vehicles

# 0.1.9

Added Nameplate Status icon options - Nameplates can now show various statuses on nameplates such as Away, Busy, Disconnected, Group, Guild, Friend, and Ignored
 - Each Option comes with a color picker

Added an additional attached window to the Ignored frame that displays the data of Ignore Lists across all characters, as well as character-specific Friend Lists.
 - Friend/Ignore character data can be deleted for cases where characters are deleted and no longer retrievable
 - Nameplate Status icons can additionally benefit from the account-wide friend and ignore list, indicated by a small warband campfire in the top right of the status icon

Fixed a missing slash command for zhTW localization

Fixed the Quel'Danas Ambience slider to no longer always force the ambience volume down to ~25% (adjust to 100% to keep it the same volume as other zones)

Adjusted some visibility logic in the Prey Bar

Adjusted some of the functionality of the Nameplate Target icon to facilitate a separated function in NameplateRodeo for other nameplate plugins to use

Adjusted how some data is saved and utilizes default values, no longer saving some data into an empty duplicated void


# 0.1.8a

Fixed secret taint issue with GetUnitSpeed (seriously who was abusing GetUnitSpeed to circumvent API restrictions)
 - as a result, the speed multiplier rate will stay static under combat restrictions

# 0.1.8

12.0.5 toc update

Added transmog undo/redo and outfit restoration buttons

Added transmog sheath buttons

# 0.1.7

Added dropdown menu to toggle Spell Alert frames per spell (Requires Spell Alerts to be enabled)

Made some adjustments to some code to avoid taint issues
 - The option to collapse the Objective Tracker has been redesigned. The functionality is no longer to collapse the objective tracker, as it appears to (somehow?????) cause taint issues. Instead, the Objective Tracker will fade out/in under the specific conditions instead.
 - The prey bar widget has received some adjustments to avoid modification if the widget frames are protected as an extra precaution. It wasn't exactly the cause of taint, but better safe than sorry as the addon was "hiding" the click frame

Changed the Chromie Time button to now use Krowi_WorldMapButtons library. It should play nicer with other addons that use this lib to display the little buttons on the map filter.

# 0.1.6a

Testing Krowi_WorldMapButtons library packager integration

# 0.1.6

Added options to auto collapse the Objective Tracker under certain conditions, such as delves, raid, and rested area.

Added option to display a "Delete Good Item" delete button - clicking once fills editbox with "DELETE", clicking a second time deletes the item.

Yeet all secret values when trying to display profession toasts. Stop trying to level professions during dungeon/raid combat, you fiends

# 0.1.5

Added an option to block guild invites account-wide

Added options for screenshots:
 - Hide Screenshot Text
 - Adjust the Screenshot file format (png, jpg, tga)
 - Adjust screenshot quality
 - Change screenshot resolution (x0.5, x1, x2)

 Added a new feature for chat message preview and character counter tooltip on the chat frame edit box, with options to disable, show only on mouseover (default), and show always.

# 0.1.4b

Attempted fix to prey bar sometimes being completely empty despite having progress (there's also some weird behavior while grouped sometimes that happens to the default blizz UI)

# 0.1.4a

Adjusted prey progress bar frame levels (should no longer be beneath the action bar and such)

# 0.1.4

Added options for account wide settings for Damage Meter visibility and Auto-Reset Damage Meter

Added options to hide Blizz's prey widget and hide the prey widget + progress bar in combat

# 0.1.3c

Added outfit sound effect to play upon initiating a jump

Changed the outfit sounds to not play a sound while shapeshifted (except shadowform)

Fixed German client not properly showing the Profession notification toasts (note: this is a weird issue in blizz's global strings, it probably shouldn't be how it is)

# 0.1.3b

Adjusted some profession level sounds for Inscription and Jewelcrafting.

# 0.1.3a

Added in toast notifications for the Lumberjack achievements as they're similar to gathering professions

# 0.1.3

Added Profession Toasts widget, displaying a notification and playing a sound upon gaining a skill point in a profession.
 - Comes with customization for frame width/height, font size, font color, background color, border color, background style, border style

 Added 2 new assignable transmog outfit sounds: Metal Chain Maw and Wildhammer

 Added CVar option for Auto Dismount (ground)

 Fixed missing localization entries for minimapTrackingClosestOnly CVar

# 0.1.2

Added option to automatically link your outfit in chat upon the transmog window being closed

# 0.1.1

Fix party sync automation option which caused an error for the one who engages party sync

# 0.1.0

Added option to automatically adjust Quel'Danas ambience volume to lower the Sunwell ambience sounds

Added CVar option to toggle "Minimap Tracking Closest Only"

Fixed a minor catastrophic issue that could potentially blow up slider variables if multiple sliders were present

Fixed other small cataclysmic issue where Block Trades file was not included in the toc file

# 0.0.9

Added a Prey progress bar indicator
- this comes in a few different styles and positions

Added an option to block trades while the transmog frame is open

Adjusted the dummy nameplate target indicator scaling slightly

# 0.0.8

Added ability to equip outfits from the Outfit Manager (previously named Outfit Sound Manager)
 - this comes at the slight detriment to some druids not having one of their skyriding action bar slots due to action bar button limitations

Added a Loot History Visibility option to hide the loot history frame under certain conditions

Added option to hide tutorials

Fixed the Paint Bot aura IDs in the presets for the Cancel Aura Manager

# 0.0.7

Temporarily removed the option to collapse the buff frame, as it caused unavoidable random errant taint issues

# 0.0.6

Bug fixes / adjustments to Nameplate Target indicator, CancelAuras, and Collapse Buff Button options.

# 0.0.5

Added new Nameplates option:
 - Friendly Nameplate Target Indicator: Displays an icon on the nameplate of a friendly player targeting you. Currently available with 3 style options, a size slider, and color picker.

# 0.0.4

Added new option to automatically collapse the Buff bar button (this was insanely prone to taint in almost every other iteration, it has the stability of tert-Butyllithium left alone in a room of air)

Reworked the "Account Settings" checkboxes into dropdown menus. These now consist of 3 options: None, Account-wide on, and Account-wide off.

Auto loot should no longer be enabled account wide by default.

# 0.0.3

Fix to Arrow Keys in Chat Editbox - now affects all chat windows, not just the main one

# 0.0.2

Check for secret value in CancelAuras

# 0.0.1

Release version:

Added the following options:
 - Fish Reel In
 - Hide Crafting Results
 - Chromie Time Icon
 - Hide Action Button Macro Text
 - Transmog Outfit Borders
 - Allow Arrow Keys in Chat Editbox
 - Server Notification Raid Warnings
 - Move Addon Compartment Frame
 - Minimap Icon
 - Automatically Accept Party Sync
 - Movable Currency Transfer
 - Outfit Swap Sounds
 - Account Auto Loot
 - Account Pet Battle Map Filter
 - Account Cooldown Manager Enabled
 - Show All Minimap Trackables
 - Weather Density
 - Auto Push Spells to Action Bars

Added the following features:
 - Cancel Aura Manager
 - Abandon Quest Manager
 - Outfit Sound Manager