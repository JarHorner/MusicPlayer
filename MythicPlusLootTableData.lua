local addonData = {
    iconHidden = false,
    popupDisabled = false,
    xPos = -74.246212024588,
    yPos = -74.246212024587,
    popupTime = 5,
    tableScale = 1,
    tooltipHidden = false,
    tablePoint = "LEFT",
    tableRelativePoint = "LEFT",
    tableX = 0,
    tableY = 0,
}

-- a hard-coded loot table data because the API call to get these values does not work properly when loading addon
lootTableData = {{0, "", 0, ""},
                        {496, MPLT["Upgrade Track Champion"] .. " 2/8", 509, MPLT["Upgrade Track Hero"] .. " 2/6"},
                        {499, MPLT["Upgrade Track Champion"] .. " 3/8", 509, MPLT["Upgrade Track Hero"] .. " 2/6"},
                        {499, MPLT["Upgrade Track Champion"] .. " 3/8", 512, MPLT["Upgrade Track Hero"] .. " 3/6"},
                        {502, MPLT["Upgrade Track Champion"] .. " 4/8", 512, MPLT["Upgrade Track Hero"] .. " 3/6"},
                        {502, MPLT["Upgrade Track Champion"] .. " 4/8", 515, MPLT["Upgrade Track Hero"] .. " 4/6"},
                        {506, MPLT["Upgrade Track Hero"] .. " 1/6", 515, MPLT["Upgrade Track Hero"] .. " 4/6"},
                        {506, MPLT["Upgrade Track Hero"] .. " 1/6", 519, MPLT["Upgrade Track Myth"] .. " 1/4"},
                        {509, MPLT["Upgrade Track Hero"] .. " 2/6", 519, MPLT["Upgrade Track Myth"] .. " 1/4"},
                        {509, MPLT["Upgrade Track Hero"] .. " 2/6", 522, MPLT["Upgrade Track Myth"] .. " 2/4"}}

SavedVariables = SavedVariables or addonData

-- Event handler thats triggers when the addon has finished loading and based on the SavedVariables, changes values
local function OnAddonLoaded(self, event, addonName)
    if addonName == "MythicPlusLootTable" then

        -- Check if SavedVariables exist, if it does not, the default data will be saved
        SavedVariables = SavedVariables or addonData

        -- ensures the icon is hidden based on iconHidden value
        if SavedVariables.iconHidden then
            lootTableIcon:Hide()
        else
            lootTableIcon:Show()
        end
        -- ensures the checkbox's are properly shown based on values
        toggleIconCheckbox:SetChecked(SavedVariables.iconHidden)
        togglePopupCheckbox:SetChecked(SavedVariables.popupDisabled)
        toggleTooltipCheckbox:SetChecked(SavedVariables.tooltipHidden)

        if not SavedVariables.tooltipHidden then
            TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem)
        end

        myTable:SetPoint(SavedVariables.tablePoint, nil, SavedVariables.tableRelativePoint, SavedVariables.tableX, SavedVariables.tableY)

        -- sets the size of the loot table
        ChangeTableScale(SavedVariables.tableScale)
        UIDropDownMenu_SetSelectedValue(tableSizeDropdown, SavedVariables.tableScale)

        -- sets the icon to the saved point around the minimap
        lootTableIcon:SetPoint("CENTER", Minimap, "CENTER", SavedVariables.xPos, SavedVariables.yPos)

        -- set value for for the popup time
        popupTimer:SetValue(SavedVariables.popupTime)

        -- Unregister the event
        self:UnregisterEvent("ADDON_LOADED")
    end
end

function ResetSavedVariables()
    SavedVariables = addonData
end

-- Registering the ADDON_LOADED event
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", OnAddonLoaded)

