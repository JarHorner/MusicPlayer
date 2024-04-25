local MPLT = MPLT

lootPopup = CreateFrame("Frame")

-- Shows a popup when a key begins showing the different loot you will receive from it
local function ShowKeyLevelLoot()
    if SavedVariables.popupDisabled == false then
        local activeKeystoneLevel = C_ChallengeMode.GetActiveKeystoneInfo()
        if activeKeystoneLevel <= 10 then
            local endOfRunRewardLevel = lootTableData[activeKeystoneLevel][1] .. " | " .. lootTableData[activeKeystoneLevel][2]
            local weeklyRewardLevel = lootTableData[activeKeystoneLevel][3] .. " | " .. lootTableData[activeKeystoneLevel][4]
        else
            local endOfRunRewardLevel = lootTableData[10][1] .. " | " .. lootTableData[10][2]
            local weeklyRewardLevel = lootTableData[10][3] .. " | " .. lootTableData[10][4]
        end
            
        StaticPopupDialogs["KEY_STARTED"] = {
            text = MPLT["Popup Text 1"] .. endOfRunRewardLevel .. MPLT["Popup Text 2"] .. weeklyRewardLevel .. MPLT["Popup Text 3"] ,
            button1 = MPLT["Popup Button"],
            timeout = SavedVariables.popupTime,
            whileDead = true,
            hideOnEscape = true,
        }
        
        StaticPopup_Show("KEY_STARTED", activeKeystoneLevel)
    end
end

-- the event that creates the popup
local function ShowLootPopup(self, event, ...)
	ShowKeyLevelLoot()
end

-- the registered event is triggered upon starting a key
lootPopup:RegisterEvent("CHALLENGE_MODE_START")
lootPopup:SetScript("OnEvent", ShowLootPopup)