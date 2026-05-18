local UnderlightFix = CreateFrame("Frame");
UnderlightFix:RegisterEvent("ADDON_LOADED");
UnderlightFix:SetScript("OnEvent", function(self, event, addonName)
	if addonName == "Blizzard_ArtifactUI" then
		
		--[[
		does this voodoo magic part work? i have no idea
		i accidentally clicked the power in the middle of the frame and i only had 1 chance to test it
		]]
		hooksecurefunc(ArtifactFrame.PerksTab, "RefreshPowers", function(self)
			if C_ArtifactUI.GetArtifactItemID() == 133755 then
				
				if self.DisabledFrame then 
					self.DisabledFrame:Hide();
				end
				
				if self.TitleContainer then
					self.TitleContainer.ArtifactName:Show();
					self.TitleContainer.ArtifactPower:Show();
					self.TitleContainer.Background:Show();
				end

				if self.Model then
					self.Model:SetDesaturation(0);
					self.Model:SetParticlesEnabled(true);
				end
				
				if self.powerIDToPowerButton then
					for powerID, powerButton in pairs(self.powerIDToPowerButton) do
						powerButton:Show();
						powerButton:SetLinksEnabled(not powerButton:IsFinal());
						
						if not powerButton.underlightFixed then
							powerButton:HookScript("OnClick", function()
								if C_ArtifactUI.GetArtifactItemID() == 133755 then
									C_ArtifactUI.AddPower(powerID);
								end
							end)
							powerButton.underlightFixed = true;
						end
					end
				end
			end
		end)
		
		hooksecurefunc(ArtifactFrame.PerksTab, "RefreshDependencies", function(self)
			if C_ArtifactUI.GetArtifactItemID() == 133755 then
				local artInfo = C_ArtifactUI.GetArtifactArtInfo();
				if artInfo and self.DependencyLines then
					for i = 1, self.numUsedLines or 0 do
						local line = self.DependencyLines[i];
						if line then
							line:SetConnectedColor(artInfo.barConnectedColor);
							line:SetDisconnectedColor(artInfo.barDisconnectedColor);
						end
					end
				end
			end
		end)
		
		self:UnregisterEvent("ADDON_LOADED");

		local UnderlightVisualAnchor = CreateFrame("Button", "UnderlightCenterAnchor", ArtifactFrame.PerksTab);
		UnderlightVisualAnchor:SetSize(56, 56);
		UnderlightVisualAnchor:SetPoint("CENTER", ArtifactFrame.PerksTab, "CENTER", -16, 27);
		UnderlightVisualAnchor:SetFrameLevel(1550);

		local anchorTex = UnderlightVisualAnchor:CreateTexture(nil, "OVERLAY", nil, 0);
		anchorTex:SetAllPoints();
		anchorTex:SetTexture("Interface\\Icons\\spell_shaman_tidalwaves");


		UnderlightVisualAnchor.mask = UnderlightVisualAnchor:CreateMaskTexture();
		UnderlightVisualAnchor.mask:SetAllPoints(anchorTex);
		UnderlightVisualAnchor.mask:SetTexture("Interface\\CHARACTERFRAME\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE");
		anchorTex:AddMaskTexture(UnderlightVisualAnchor.mask);

		local highlight = UnderlightVisualAnchor:CreateTexture(nil, "HIGHLIGHT", nil, 1);
		highlight:SetAllPoints();
		highlight:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");
		highlight:SetBlendMode("ADD");

		local pulseGroup = anchorTex:CreateAnimationGroup();
		pulseGroup:SetLooping("REPEAT");

		local fadeOut = pulseGroup:CreateAnimation("Alpha");
		fadeOut:SetFromAlpha(1.0);
		fadeOut:SetToAlpha(0.4);
		fadeOut:SetDuration(0.8);
		fadeOut:SetSmoothing("IN_OUT");
		fadeOut:SetOrder(1);

		local fadeIn = pulseGroup:CreateAnimation("Alpha");
		fadeIn:SetFromAlpha(0.4);
		fadeIn:SetToAlpha(1.0);
		fadeIn:SetDuration(0.8);
		fadeIn:SetSmoothing("IN_OUT");
		fadeIn:SetOrder(2);

		pulseGroup:Play();

		UnderlightVisualAnchor:SetScript("OnClick", function()
			if C_ArtifactUI.GetArtifactItemID() == 133755 then
				local centerPowerID = 1021;
				C_ArtifactUI.AddPower(centerPowerID);
			end
		end)

		UnderlightVisualAnchor:RegisterEvent("ARTIFACT_UPDATE");
		UnderlightVisualAnchor:RegisterEvent("ARTIFACT_XP_UPDATE");
		UnderlightVisualAnchor:SetScript("OnEvent", function(self)
			if C_ArtifactUI.GetArtifactItemID() == 133755 then
				if C_ArtifactUI.GetTotalPurchasedRanks() > 0 then
					self:Hide();
				else
					self:Show();
				end
			else
				self:Hide();
			end
		end)
	end
end)