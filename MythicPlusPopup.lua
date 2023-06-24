

lootPopup = CreateFrame("Frame")

-- Shows a popup when a key begins showing the different loot you will receive from it
local function ShowKeyLevelLoot()
    local activeKeystoneLevel = C_ChallengeMode.GetActiveKeystoneInfo()
    local weeklyRewardLevel, endOfRunRewardLevel = C_MythicPlus.GetRewardLevelForDifficultyLevel(activeKeystoneLevel)

    StaticPopupDialogs["KEY_STARTED"] = {
        text = "Completion will give " .. endOfRunRewardLevel .. " end of run, " .. weeklyRewardLevel .. " weekly" ,
        button1 = "Ok",
        timeout = SavedVariables.popupTime,
        whileDead = true,
        hideOnEscape = true,
    }
    
    StaticPopup_Show("KEY_STARTED", activeKeystoneLevel)
end

-- the event that creates the popup
local function ShowLootPopup(self, event, ...)
	ShowKeyLevelLoot()
end

-- the registered event is triggered upon starting a key
lootPopup:RegisterEvent("CHALLENGE_MODE_START")
lootPopup:SetScript("OnEvent", ShowLootPopup)