local addonData = {
    iconHidden = false,
    xPos = -74.246212024588,
    yPos = -74.246212024587,
}

-- Event handler for ADDON_LOADED
local function OnAddonLoaded(self, event, addonName)
    if addonName == "MythicPlusLootTable" then
        print('This addon exists')

        -- Check if SavedVariables exist, if it does not, the default data will be saved
        SavedVariables = SavedVariables or addonData

        -- ensures the icon is hidden based on iconHidden value
        if SavedVariables.iconHidden then
            lootTableIcon:Hide()
        else
            lootTableIcon:Show()
        end
        -- ensures the checkbox is properly shown based on iconHidden value
        toggleCheckbox:SetChecked(SavedVariables.iconHidden)

        -- lootTableIcon:SetPoint("CENTER", Minimap, "CENTER", SavedVariables.xPos, SavedVariables.yPos)
        print(SavedVariables.xPos .. " " .. SavedVariables.yPos)

        -- Unregister the event
        self:UnregisterEvent("ADDON_LOADED")
    end
end

-- Register the ADDON_LOADED event
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", OnAddonLoaded)

