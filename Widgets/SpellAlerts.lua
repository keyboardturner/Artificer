local addonName, Artificer = ...;

Artificer.SpellCategories = {
	[1] = { -- Warrior
		5302, 199854, 209697, 224324, 
	},
	
	[2] = { -- Paladin
		54149, 85416, 223819, 231843, 267345,
		267346, 281178, 402916, 406086, 408458,
		453433, 458213, 
	},
	
	[3] = { -- Hunter
		88843, 185204, 189249, 194594, 270436,
		270437, 459859, 470488, 470492, 471878,
		472324, 472325, 
	},
	
	[4] = { -- Rogue
		121153, 195627, 340584, 1269163, 
	},
	
	[5] = { -- Priest
		114255, 128654, 198069, 231403, 282297,
		336009, 336269, 373183, 375981, 391401,
		409129, 1262766, 1287613,
	},
	
	[6] = { -- Death Knight
		51124, 59052, 81141, 81340, 438833,
		461135, 1264568, 
	},
	
	[7] = { -- Shaman
		77762, 174928, 187890, 188653, 189797,
		190057, 288675, 384088, 384669, 386374,
		467442, 
	},
	
	[8] = { -- Mage
		44544, 48107, 48108, 126084, 159517,
		190446, 269651, 276743, 383874, 383883,
		451038, 1277009, 1277420, 1277421, 1277422,
		1277422, 
	},
	
	[9] = { -- Warlock
		159609, 264173, 264571, 334320, 334463,
		1260279, 
	},
	
	[10] = { -- Monk
		116768, 124274, 124275, 159407, 242581,
		443112, 446334, 1270990, 
	},
	
	[11] = { -- Druid
		16870, 93622, 135286, 135700, 157228,
		189877, 211160, 213708, 1272376, 
	},
	
	[12] = { -- Demon Hunter
		390195, 1238495, 1256302, 1270476, 
	},
	
	[13] = { -- Evoker
		359618, 361519, 369299, 392268, 394552,
		443176,

	},
	--[[
	[14] = { -- Adventurer
		371924, 371952, 
	},
	]]
}


local f = CreateFrame("Frame")

f:RegisterEvent("PLAYER_LOGIN")

f:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		if SpellActivationOverlayFrame then
			local original_ShowAllOverlays = SpellActivationOverlayFrame.ShowAllOverlays;

			SpellActivationOverlayFrame.ShowAllOverlays = function(self, spellID, texturePath, locationType, scale, r, g, b)
				local filters = Artificer_DB and Artificer_DB.Widgets and Artificer_DB.Widgets.FilteredOverlays;

				if filters and filters[spellID] == false then
					return;
				end

				original_ShowAllOverlays(self, spellID, texturePath, locationType, scale, r, g, b);
			end
		end
	end
end)