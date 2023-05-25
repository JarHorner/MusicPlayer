local addonData = {
    iconHidden = false,
    xPos = 10,
    yPos = 10,

    -- Add more variables as needed
}

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
    print("grabbing addon info " .. addon)
    if addon == "MythicPlusLootTable" then
        MythicPlusLootTableData = MythicPlusLootTableData or addonData
    end
end)

frame:RegisterEvent("PLAYER_LOGOUT")
frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGOUT" then
        MythicPlusLootTableData = addonData
    end
end)

print("Should get here")
print(MythicPlusLootTableData.xPos)
