local AddonName, MPLT = ...
local L = MPLT.L

lootPopup = CreateFrame("Frame")

-- Shows a popup when a key begins showing the different loot you will receive from it
local function ShowKeyLevelLoot()
    if SavedVariables.popupDisabled == false then
        local activeKeystoneLevel = C_ChallengeMode.GetActiveKeystoneInfo()
        local weeklyRewardLevel, endOfRunRewardLevel = C_MythicPlus.GetRewardLevelForDifficultyLevel(activeKeystoneLevel)
    
        StaticPopupDialogs["KEY_STARTED"] = {
            text = L["Popup Text 1"] .. endOfRunRewardLevel .. L["Popup Text 2"] .. weeklyRewardLevel .. L["Popup Text 3"] ,
            button1 = L["Popup Button"],
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