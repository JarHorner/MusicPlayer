
local challengeModeActive = C_ChallengeMode.IsChallengeModeActive()

if (challengeModeActive) then

    local activeKeystoneLevel = C_ChallengeMode.GetActiveKeystoneInfo()
    local weeklyRewardLevel, endOfRunRewardLevel = C_MythicPlus.GetRewardLevelForDifficultyLevel(activeKeystoneLevel)

    StaticPopupDialogs["KEY_STARTED"] = {
        text = "Completion will give " .. endOfRunRewardLevel .. " ilvl end of run, " .. weeklyRewardLevel .. " weekly" ,
        button1 = "Ok",
        timeout = 10,
        whileDead = true,
        hideOnEscape = true,
    }
    
    StaticPopup_Show("KEY_STARTED", activeKeystoneLevel)
end