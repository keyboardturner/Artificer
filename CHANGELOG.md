[Full Changelog & Previous Releases](https://github.com/keyboardturner/Artificer/releases)

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