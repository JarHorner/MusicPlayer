
local keyLevels = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}


SLASH_CHECKLOOT1 = "/cl"


local function checkLootHandler()

    local isMythicPlusActive = C_MythicPlus.IsMythicPlusActive()
    if (isMythicPlusActive) then
        print("In M+")
    else
        print("Not M+")
    end
    local challengeModeActive = C_ChallengeMode.IsChallengeModeActive()
    if (challengeModeActive) then
        print("In challenge")
    else
        print("Not challenge")
    end


    -- for i = 2, 20, 1 do
    --     local weeklyRewardLevel, endOfRunRewardLevel = C_MythicPlus.GetRewardLevelForDifficultyLevel(i)
    --     print("Key level: " .. i .. " weekly reward = " .. weeklyRewardLevel .. " End of run reward = " .. endOfRunRewardLevel)
    -- end
end

SlashCmdList["CHECKLOOT"] = checkLootHandler
